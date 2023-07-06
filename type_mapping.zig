//! Strategy:
//! 1. generate raylib JSONs
//! 2. combine in a union RaylibJson
//! 3. convert to intermediate representation
//! 4. read adjusted intermediate JSONs
//! 5. generate raylib.zig // wrap paramters and pass them to marshall versions of the raylib functions
//! 6. generate marshall.c // unwrap parameters from zig function and call the actual raylib function
//! 7. generate marshall.h // C signatures for all marshalled functions

const std = @import("std");
const json = std.json;
const memoryConstrain: usize = 1024 * 1024 * 1024; // 1 GiB
const Allocator = std.mem.Allocator;
const fmt = std.fmt.allocPrint;
const talloc = std.testing.allocator;
const expect = std.testing.expect;
const expectEqualStrings = std.testing.expectEqualStrings;

//--- Intermediate Format -------------------------------------------------------------------------

pub const Intermediate = struct {
    functions: []Function,
    enums: []Enum,
    structs: []Struct,
    defines: []Define,

    pub fn loadCustoms(allocator: Allocator, jsonFile: []const u8) !@This() {
        var enums = std.ArrayList(Enum).init(allocator);
        var structs = std.ArrayList(Struct).init(allocator);
        var functions = std.ArrayList(Function).init(allocator);
        var defines = std.ArrayList(Define).init(allocator);

        const jsonData = try std.fs.cwd().readFileAlloc(allocator, jsonFile, memoryConstrain);

        const bindingJson = try json.parseFromSliceLeaky(Intermediate, allocator, jsonData, .{
            .ignore_unknown_fields = true,
        });

        for (bindingJson.enums) |t| {
            if (t.custom) {
                try enums.append(t);
            }
        }

        for (bindingJson.structs) |t| {
            if (t.custom) {
                try structs.append(t);
            }
        }

        for (bindingJson.functions) |f| {
            if (f.custom) {
                try functions.append(f);
            }
        }

        for (bindingJson.defines) |f| {
            if (f.custom) {
                try defines.append(f);
            }
        }

        return @This(){
            .enums = try enums.toOwnedSlice(),
            .structs = try structs.toOwnedSlice(),
            .functions = try functions.toOwnedSlice(),
            .defines = try defines.toOwnedSlice(),
        };
    }

    pub fn addNonCustom(self: *@This(), allocator: Allocator, rlJson: CombinedRaylib) !void {
        var enums = std.ArrayList(Enum).init(allocator);
        try enums.appendSlice(self.enums);
        var structs = std.ArrayList(Struct).init(allocator);
        try structs.appendSlice(self.structs);
        var functions = std.ArrayList(Function).init(allocator);
        try functions.appendSlice(self.functions);
        var defines = std.ArrayList(Define).init(allocator);
        try defines.appendSlice(self.defines);

        outer: for (rlJson.defines.values(), 0..) |d, i| {
            for (defines.items) |added| {
                if (eql(added.name, d.name)) {
                    std.log.debug("{s} is customized", .{d.name});
                    continue :outer;
                }
            }
            const define = parseRaylibDefine(allocator, d) orelse continue :outer;

            if (i < defines.items.len) {
                try defines.insert(i, define);
            } else {
                try defines.append(define);
            }
        }
        outer: for (rlJson.enums.values(), 0..) |e, i| {
            const name = if (alias.get(e.name)) |n| n else e.name;
            for (enums.items) |added| {
                if (eql(added.name, name)) {
                    std.log.debug("{s} is customized", .{name});
                    continue :outer;
                }
            }

            if (i < enums.items.len) {
                try enums.insert(i, try parseRaylibEnum(allocator, e));
            } else {
                try enums.append(try parseRaylibEnum(allocator, e));
            }
        }
        outer: for (rlJson.structs.values(), 0..) |s, i| {
            const name = if (alias.get(s.name)) |n| n else s.name;
            for (structs.items) |added| {
                if (eql(added.name, name)) {
                    std.log.debug("{s} is customized", .{name});
                    continue :outer;
                }
            }
            if (i < structs.items.len) {
                try structs.insert(i, try parseRaylibStruct(allocator, s));
            } else {
                try structs.append(try parseRaylibStruct(allocator, s));
            }
        }
        for (rlJson.defines.values()) |_| {}

        outer: for (rlJson.functions.values(), 0..) |f, i| {
            for (functions.items) |added| {
                if (eql(added.name, f.name)) {
                    std.log.debug("{s} is customized", .{f.name});
                    continue :outer;
                }
            }
            if (i < functions.items.len) {
                try functions.insert(i, try parseRaylibFunction(allocator, f));
            } else {
                try functions.append(try parseRaylibFunction(allocator, f));
            }
        }

        self.enums = try enums.toOwnedSlice();
        self.structs = try structs.toOwnedSlice();
        self.functions = try functions.toOwnedSlice();
        self.defines = try defines.toOwnedSlice();
    }

    pub fn containsStruct(self: @This(), name: []const u8) bool {
        for (self.structs) |s| {
            if (eql(s.name, name)) return true;
        }
        return false;
    }

    pub fn containsEnum(self: @This(), name: []const u8) bool {
        for (self.enums) |e| {
            if (eql(e.name, name)) return true;
        }
        return false;
    }

    pub fn containsDefine(self: @This(), name: []const u8) bool {
        for (self.defines) |d| {
            if (eql(d.name, name)) return true;
        }
        return false;
    }
};

pub const Function = struct {
    name: []const u8,
    params: []FunctionParameter,
    returnType: []const u8,
    description: ?[]const u8 = null,
    custom: bool = false,
};

pub const FunctionParameter = struct {
    name: []const u8,
    typ: []const u8,
    description: ?[]const u8 = null,
};

pub fn parseRaylibFunction(allocator: Allocator, func: RaylibFunction) !Function {
    var args = std.ArrayList(FunctionParameter).init(allocator);
    if (func.params) |params| {
        for (params) |p| {
            const t = try toZig(allocator, p.type);

            try args.append(.{
                .name = p.name,
                .typ = t,
                .description = p.description,
            });
        }
    }

    const returnType = try toZig(allocator, func.returnType);

    return Function{
        .name = func.name,
        .params = try args.toOwnedSlice(),
        .returnType = returnType,
        .description = func.description,
    };
}

pub const Struct = struct {
    name: []const u8,
    fields: []const StructField,
    description: ?[]const u8 = null,
    custom: bool = false,
};

pub const StructField = struct {
    name: []const u8,
    typ: []const u8,
    description: ?[]const u8 = null,
};

pub fn parseRaylibStruct(allocator: Allocator, s: RaylibStruct) !Struct {
    var fields = std.ArrayList(StructField).init(allocator);
    for (s.fields) |field| {
        var typ = try toZig(allocator, getTypeWithoutArrayNotation(field.type));

        if (getArraySize(field.type)) |size| {
            typ = try std.fmt.allocPrint(allocator, "[{d}]{s}", .{ size, typ });
        }

        try fields.append(.{
            .name = field.name,
            .typ = typ,
            .description = field.description,
        });
    }

    return Struct{
        .name = if (alias.get(s.name)) |a| a else s.name,
        .fields = try fields.toOwnedSlice(),
        .description = s.description,
    };
}

pub const Define = struct {
    name: []const u8,
    typ: []const u8,
    value: []const u8,
    description: ?[]const u8 = null,
    custom: bool = false,
};

pub fn parseRaylibDefine(allocator: Allocator, s: RaylibDefine) ?Define {
    var typ: []const u8 = undefined;
    var value: []const u8 = undefined;

    if (eql("INT", s.type)) {
        typ = "i32";
        value = std.fmt.allocPrint(allocator, "{s}", .{s.value}) catch return null;
    } else if (eql("LONG", s.type)) {
        typ = "i64";
        value = std.fmt.allocPrint(allocator, "{s}", .{s.value}) catch return null;
    } else if (eql("FLOAT", s.type)) {
        typ = "f32";
        value = std.fmt.allocPrint(allocator, "{s}", .{s.value}) catch return null;
    } else if (eql("DOUBLE", s.type)) {
        typ = "f64";
        value = std.fmt.allocPrint(allocator, "{s}", .{s.value}) catch return null;
    } else if (eql("STRING", s.type)) {
        typ = "[]const u8";
        value = std.fmt.allocPrint(allocator, "\"{s}\"", .{s.value}) catch return null;
    } else if (eql("COLOR", s.type)) {
        typ = "Color";
        std.debug.assert(startsWith(s.value, "CLITERAL(Color){"));
        std.debug.assert(endsWith(s.value, "}"));

        const componentString = s.value["CLITERAL(Color){".len .. s.value.len - 1];
        var spliterator = std.mem.split(u8, componentString, ",");
        var r = spliterator.next() orelse return null;
        r = std.mem.trim(u8, r, " \t\r\n");
        var g = spliterator.next() orelse return null;
        g = std.mem.trim(u8, g, " \t\r\n");
        var b = spliterator.next() orelse return null;
        b = std.mem.trim(u8, b, " \t\r\n");
        var a = spliterator.next() orelse return null;
        a = std.mem.trim(u8, a, " \t\r\n");
        value = std.fmt.allocPrint(allocator, ".{{.r={s}, .g={s}, .b={s}, .a={s}}}", .{ r, g, b, a }) catch return null;
    } else {
        return null;
    }

    return Define{
        .name = s.name,
        .typ = typ,
        .value = value,
        .description = s.description,
    };
}

pub const Enum = struct {
    name: []const u8,
    values: []const EnumValue,
    description: ?[]const u8 = null,
    custom: bool = false,
};

pub const EnumValue = struct {
    name: []const u8,
    value: c_int,
    description: ?[]const u8 = null,
};

pub fn parseRaylibEnum(allocator: Allocator, e: RaylibEnum) !Enum {
    var values = std.ArrayList(EnumValue).init(allocator);
    for (e.values) |value| {
        try values.append(.{
            .name = value.name,
            .value = value.value,
            .description = value.description,
        });
    }

    return Enum{
        .name = e.name,
        .values = try values.toOwnedSlice(),
        .description = e.description,
    };
}

/// is c const type
pub fn isConst(c: []const u8) bool {
    return startsWith(c, "const ");
}
test "isConst" {
    try expect(!isConst("char *"));
    try expect(!isConst("unsigned char *"));
    try expect(isConst("const unsigned char *"));
    try expect(isConst("const unsigned int *"));
    try expect(isConst("const void *"));
    try expect(!isConst("Vector2 *"));
    try expect(!isConst("Vector2"));
    try expect(!isConst("int"));
}

/// is c pointer type
pub fn isPointer(c: []const u8) bool {
    return endsWith(c, "*");
}
test "isPointer" {
    try expect(isPointer("char *"));
    try expect(isPointer("unsigned char *"));
    try expect(isPointer("const unsigned char *"));
    try expect(isPointer("const unsigned int *"));
    try expect(isPointer("Vector2 *"));
    try expect(!isPointer("Vector2"));
    try expect(!isPointer("int"));
}

pub fn isPointerToPointer(c: []const u8) bool {
    return endsWith(c, "**");
}
test "isPointerToPointer" {
    try expect(!isPointerToPointer("char *"));
    try expect(!isPointerToPointer("unsigned char *"));
    try expect(isPointerToPointer("const unsigned char **"));
    try expect(isPointerToPointer("const unsigned int **"));
    try expect(isPointerToPointer("Vector2 **"));
    try expect(!isPointerToPointer("Vector2*"));
    try expect(!isPointerToPointer("int"));
}

pub fn isVoid(c: []const u8) bool {
    return eql(stripType(c), "void");
}
test "isVoid" {
    try expect(!isVoid("char *"));
    try expect(!isVoid("unsigned char *"));
    try expect(!isVoid("const unsigned char *"));
    try expect(isVoid("const void *"));
    try expect(isVoid("void *"));
    try expect(isVoid("void"));
    try expect(isVoid("void **"));
}

/// strips const and pointer annotations
/// const TName * -> TName
pub fn stripType(c: []const u8) []const u8 {
    var name = if (isConst(c)) c["const ".len..] else c;
    name = if (isPointer(name)) name[0 .. name.len - 1] else name;
    // double pointer?
    name = if (isPointer(name)) name[0 .. name.len - 1] else name;
    name = std.mem.trim(u8, name, " \t\n");
    if (alias.get(name)) |ali| {
        name = ali;
    }
    return name;
}
test "stripType" {
    try expectEqualStrings("void", stripType("const void *"));
    try expectEqualStrings("unsinged int", stripType("unsinged int *"));
    try expectEqualStrings("Vector2", stripType("const Vector2 *"));
}

pub fn getArraySize(typ: []const u8) ?usize {
    if (std.mem.indexOf(u8, typ, "[")) |open| {
        if (std.mem.indexOf(u8, typ, "]")) |close| {
            return std.fmt.parseInt(usize, typ[open + 1 .. close], 10) catch null;
        }
    }
    return null;
}
test "getArraySize" {
    const expectEqual = std.testing.expectEqual;

    try expectEqual(@as(?usize, 4), getArraySize("float[4]"));
    try expectEqual(@as(?usize, 44), getArraySize("int[44]"));
    try expectEqual(@as(?usize, 123456), getArraySize("a[123456]"));
    try expectEqual(@as(?usize, 1), getArraySize("test[1] "));
    try expectEqual(@as(?usize, null), getArraySize("foo[]"));
    try expectEqual(@as(?usize, null), getArraySize("bar"));
    try expectEqual(@as(?usize, null), getArraySize("foo["));
    try expectEqual(@as(?usize, null), getArraySize("bar]"));
    try expectEqual(@as(?usize, 42), getArraySize(" lol this is ok[42] "));
}

pub fn getTypeWithoutArrayNotation(typ: []const u8) []const u8 {
    if (std.mem.indexOf(u8, typ, "[")) |open| {
        return typ[0..open];
    }
    return typ;
}

fn toZig(allocator: Allocator, c: []const u8) ![]const u8 {
    if (fixedMapping.get(c)) |fixed| {
        return fixed;
    }

    const consT = if (isConst(c)) "const " else "";
    const pointeR = if (isPointer(c)) "?[*]" else "";
    const stripped = stripType(c);

    const name = if (raylibToZigType.get(stripped)) |primitive| primitive else stripped;

    if (isPointer(c)) {
        return try fmt(allocator, "{s}{s}{s}", .{ pointeR, consT, name });
    }
    return name;
}
test "toZig" {
    var arena = std.heap.ArenaAllocator.init(talloc);
    defer arena.deinit();
    const a = arena.allocator();

    try expectEqualStrings("i32", try toZig(a, "int"));
    try expectEqualStrings("const i32", try toZig(a, "const int"));
    try expectEqualStrings("?[*]Vector2", try toZig(a, "Vector2 *"));
}

const raylibToZigType = std.ComptimeStringMap([]const u8, .{
    .{ "void", "void" },
    .{ "bool", "bool" },
    .{ "char", "u8" },
    .{ "unsigned char", "u8" },
    .{ "short", "i16" },
    .{ "unsigned short", "u16" },
    .{ "int", "i32" },
    .{ "unsigned int", "u32" },
    .{ "long", "i64" },
    .{ "unsigned long", "u64" },
    .{ "unsigned long long", "u64" },
    .{ "float", "f32" },
    .{ "double", "f64" },
});

const fixedMapping = std.ComptimeStringMap([]const u8, .{
    .{ "void *", "*anyopaque" },
    .{ "const void *", "*const anyopaque" },
    .{ "const unsigned char *", "[*:0]const u8" },
    .{ "const char *", "[*:0]const u8" },
    .{ "const char **", "[*]const [*:0]const u8" },
    .{ "char **", "[*][*:0]u8" },
    .{ "rAudioBuffer *", "*anyopaque" },
    .{ "rAudioProcessor *", "*anyopaque" },
    .{ "Image *", "*Image" },
});

//--- Raylib parser JSONs -------------------------------------------------------------------------

const alias = std.ComptimeStringMap([]const u8, .{
    .{ "Camera", "Camera3D" },
    .{ "Texture", "Texture2D" },
    .{ "TextureCubemap", "Texture2D" },
    .{ "RenderTexture", "RenderTexture2D" },
    .{ "GuiStyle", "u32" },
    .{ "Quaternion", "Vector4" },
    .{ "PhysicsBody", "*PhysicsBodyData" },
});

const cAlias = std.ComptimeStringMap([]const u8, .{
    .{ "Camera", "Camera3D" },
    .{ "Texture", "Texture2D" },
    .{ "TextureCubemap", "Texture2D" },
    .{ "RenderTexture", "RenderTexture2D" },
    .{ "Quaternion", "Vector4" },
    .{ "PhysicsBody", "PhysicsBodyData *" },
});

pub const CombinedRaylib = struct {
    structs: std.StringArrayHashMap(RaylibStruct),
    enums: std.StringArrayHashMap(RaylibEnum),
    defines: std.StringArrayHashMap(RaylibDefine),
    functions: std.StringArrayHashMap(RaylibFunction),

    pub fn load(allocator: Allocator, jsonFiles: []const []const u8) !@This() {
        var structs = std.StringArrayHashMap(RaylibStruct).init(allocator);
        var enums = std.StringArrayHashMap(RaylibEnum).init(allocator);
        var defines = std.StringArrayHashMap(RaylibDefine).init(allocator);
        var functions = std.StringArrayHashMap(RaylibFunction).init(allocator);

        for (jsonFiles) |jsonFile| {
            std.log.info("parsing {s}", .{jsonFile});
            const jsonData = try std.fs.cwd().readFileAlloc(allocator, jsonFile, memoryConstrain);

            const bindingJson = try json.parseFromSliceLeaky(RaylibJson, allocator, jsonData, .{
                .ignore_unknown_fields = true,
                .duplicate_field_behavior = .use_last,
            });

            for (bindingJson.structs) |*s| {
                for (s.fields) |*f| {
                    f.type = cAlias.get(f.type) orelse f.type;
                }
                try structs.put(s.name, s.*);
            }

            for (bindingJson.enums) |e| {
                try enums.put(e.name, e);
            }

            for (bindingJson.defines) |d| {
                try defines.put(d.name, d);
            }

            for (bindingJson.functions) |*f| {
                f.returnType = cAlias.get(f.returnType) orelse f.returnType;
                if (f.params) |params| {
                    for (params) |*p| {
                        p.type = cAlias.get(p.type) orelse p.type;
                    }
                }
                try functions.put(f.name, f.*);
            }
        }

        return @This(){
            .structs = structs,
            .enums = enums,
            .defines = defines,
            .functions = functions,
        };
    }

    pub fn toIntermediate(self: @This(), allocator: Allocator, customs: Intermediate) !Intermediate {
        var functions = std.ArrayList(Function).init(allocator);
        var enums = std.ArrayList(Enum).init(allocator);
        var structs = std.ArrayList(Struct).init(allocator);

        enums: for (self.enums.values()) |e| {
            for (customs.enums) |tt| {
                if (eql(tt.name, e.name)) break :enums;
            }
            try enums.append(try parseRaylibEnum(allocator, e));
        }
        structs: for (self.structs.values()) |s| {
            for (customs.structs) |tt| {
                if (eql(tt.name, s.name)) break :structs;
            }
            try structs.append(try parseRaylibStruct(allocator, s, customs));
        }
        for (self.defines.values()) |_| {}

        funcs: for (self.functions.values()) |f| {
            for (customs.functions) |ff| {
                if (eql(ff.name, f.name)) break :funcs;
            }
            try functions.append(try parseRaylibFunction(allocator, f, customs.types));
        }

        return Intermediate{
            .functions = try functions.toOwnedSlice(),
            .enums = try enums.toOwnedSlice(),
            .structs = try structs.toOwnedSlice(),
        };
    }

    fn containsStruct(self: @This(), name: []const u8) bool {
        return self.structs.contains(name);
    }

    fn containsEnum(self: @This(), name: []const u8) bool {
        return self.enums.contains(name);
    }

    fn containsFunction(self: @This(), name: []const u8) bool {
        return self.functions.contains(name);
    }
};

const RaylibJson = struct {
    structs: []RaylibStruct,
    enums: []RaylibEnum,
    defines: []RaylibDefine,
    functions: []RaylibFunction,
};

pub const RaylibStruct = struct {
    name: []const u8,
    description: []const u8,
    fields: []RaylibField,
};

pub const RaylibField = struct {
    name: []const u8,
    description: []const u8,
    type: []const u8,
};

pub const RaylibEnum = struct {
    name: []const u8,
    description: []const u8,
    values: []RaylibEnumValue,
};

pub const RaylibEnumValue = struct {
    name: []const u8,
    description: []const u8,
    value: c_int,
};

pub const RaylibFunction = struct {
    name: []const u8,
    description: []const u8,
    returnType: []const u8,
    params: ?[]RaylibFunctionParam = null,
};

pub const RaylibFunctionParam = struct {
    name: []const u8,
    type: []const u8,
    description: ?[]const u8 = null,
};

pub const RaylibDefine = struct {
    name: []const u8,
    type: []const u8,
    value: []const u8,
    description: ?[]const u8 = null,
};

//--- Helpers -------------------------------------------------------------------------------------

/// true if C type is primitive or a pointer to anything
/// this means we don't need to wrap it in a pointer
pub fn isPrimitiveOrPointer(c: []const u8) bool {
    const primitiveTypes = std.ComptimeStringMap(void, .{
        .{ "void", {} },
        .{ "bool", {} },
        .{ "char", {} },
        .{ "unsigned char", {} },
        .{ "short", {} },
        .{ "unsigned short", {} },
        .{ "int", {} },
        .{ "unsigned int", {} },
        .{ "long", {} },
        .{ "unsigned long", {} },
        .{ "unsigned long long", {} },
        .{ "float", {} },
        .{ "double", {} },
    });
    return primitiveTypes.has(stripType(c)) or endsWith(c, "*");
}

fn eql(a: []const u8, b: []const u8) bool {
    return std.mem.eql(u8, a, b);
}

fn startsWith(haystack: []const u8, needle: []const u8) bool {
    return std.mem.startsWith(u8, haystack, needle);
}

fn endsWith(haystack: []const u8, needle: []const u8) bool {
    return std.mem.endsWith(u8, haystack, needle);
}
