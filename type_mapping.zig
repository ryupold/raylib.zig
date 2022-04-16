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
    imports: []const []const u8,
    functions: []Function,
    enums: []Enum,
    structs: []Struct,

    pub fn loadCustoms(allocator: Allocator, jsonFile: []const u8) !@This() {
        var enums = std.ArrayList(Enum).init(allocator);
        var structs = std.ArrayList(Struct).init(allocator);
        var functions = std.ArrayList(Function).init(allocator);

        const jsonData = try std.fs.cwd().readFileAlloc(allocator, jsonFile, memoryConstrain);
        defer allocator.free(jsonData);

        var stream = json.TokenStream.init(jsonData);
        const bindingJson: Intermediate = try json.parse(Intermediate, &stream, .{
            .allocator = allocator,
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

        return @This(){
            .imports = bindingJson.imports,
            .enums = enums.toOwnedSlice(),
            .structs = structs.toOwnedSlice(),
            .functions = functions.toOwnedSlice(),
        };
    }

    pub fn addNonCustom(self: *@This(), allocator: Allocator, rlJson: CombinedRaylib) !void {
        var enums = std.ArrayList(Enum).init(allocator);
        try enums.appendSlice(self.enums);
        var structs = std.ArrayList(Struct).init(allocator);
        try structs.appendSlice(self.structs);
        var functions = std.ArrayList(Function).init(allocator);
        try functions.appendSlice(self.functions);

        outer: for (rlJson.enums.values()) |e| {
            const name = if (alias.get(e.name)) |n| n else e.name;
            for (enums.items) |added| {
                if (eql(added.name, name)) {
                    std.log.debug("{s} is customized", .{name});
                    continue :outer;
                }
            }

            try enums.append(try parseRaylibEnum(allocator, e));
        }
        outer: for (rlJson.structs.values()) |s| {
            const name = if (alias.get(s.name)) |n| n else s.name;
            for (structs.items) |added| {
                if (eql(added.name, name)) {
                    std.log.debug("{s} is customized", .{name});
                    continue :outer;
                }
            }
            try structs.append(try parseRaylibStruct(allocator, s));
        }
        for (rlJson.defines.values()) |_| {}

        outer: for (rlJson.functions.values()) |f| {
            for (functions.items) |added| {
                if (eql(added.name, f.name)) {
                    std.log.debug("{s} is customized", .{f.name});
                    continue :outer;
                }
            }
            try functions.append(try parseRaylibFunction(allocator, f));
        }

        self.enums = enums.toOwnedSlice();
        self.structs = structs.toOwnedSlice();
        self.functions = functions.toOwnedSlice();
    }

    pub fn containsStruct(self: @This(), name: []const u8) bool {
        for(self.structs) |s| {
            if(eql(s.name, name)) return true;
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
            const t = try toZig(allocator, p.@"type");
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
        .params = args.toOwnedSlice(),
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
        var typ = try toZig(allocator, field.@"type");
        if (getArraySize(field.name)) |size| {
            typ = try std.fmt.allocPrint(allocator, "[{d}]{s}", .{ size, typ });
        }

        const name = getNameWithoutArrayNotation(field.name);

        try fields.append(.{
            .name = name,
            .typ = typ,
            .description = field.description,
        });
    }

    return Struct{
        .name = if (alias.get(s.name)) |a| a else s.name,
        .fields = fields.toOwnedSlice(),
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
        .values = values.toOwnedSlice(),
        .description = e.description,
    };
}

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

pub fn getArraySize(name: []const u8) ?usize {
    if (std.mem.indexOf(u8, name, "[")) |open| {
        if (std.mem.indexOf(u8, name, "]")) |close| {
            return std.fmt.parseInt(usize, name[open + 1 .. close], 10) catch null;
        }
    }
    return null;
}
test "getArraySize" {
    const expectEqual = std.testing.expectEqual;

    try expectEqual(@as(?usize, 4), getArraySize("this[4]"));
    try expectEqual(@as(?usize, 44), getArraySize("is[44]"));
    try expectEqual(@as(?usize, 123456), getArraySize("a[123456]"));
    try expectEqual(@as(?usize, 1), getArraySize("test[1] "));
    try expectEqual(@as(?usize, null), getArraySize("foo[]"));
    try expectEqual(@as(?usize, null), getArraySize("bar"));
    try expectEqual(@as(?usize, null), getArraySize("foo["));
    try expectEqual(@as(?usize, null), getArraySize("bar]"));
    try expectEqual(@as(?usize, 42), getArraySize(" lol this is ok[42] "));
}

pub fn getNameWithoutArrayNotation(name: []const u8) []const u8 {
    if (std.mem.indexOf(u8, name, "[")) |open| {
        return name[0..open];
    }
    return name;
}

fn toZig(allocator: Allocator, c: []const u8) ![]const u8 {
    if (fixedMapping.get(c)) |fixed| {
        return fixed;
    }

    const consT = if (isConst(c)) "const " else "";
    const pointeR = if (isPointer(c)) "[*]" else "";
    const stripped = stripType(c);

    const name = if (raylibToZigType.get(stripped)) |primitive| primitive else stripped;

    return try fmt(allocator, "{s}{s}{s}", .{ pointeR, consT, name });
}
test "toZig" {
    var arena = std.heap.ArenaAllocator.init(talloc);
    defer arena.deinit();
    const a = arena.allocator();

    try expectEqualStrings("i32", try toZig(a, "int"));
    try expectEqualStrings("const i32", try toZig(a, "const int"));
    try expectEqualStrings("[*]Vector2", try toZig(a, "Vector2 *"));
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
    .{ "float", "f32" },
    .{ "double", "f64" },
});

const fixedMapping = std.ComptimeStringMap([]const u8, .{
    .{ "void *", "*anyopaque" },
    .{ "const void *", "*anyopaque" },
    .{ "const unsigned char *", "[*:0]const u8" },
    .{ "const char *", "[*:0]const u8" },
    .{ "const char **", "[*]const [*:0]const u8" },
    .{ "rAudioBuffer *", "*anyopaque" },
    .{ "rAudioProcessor *", "*anyopaque" },
});

//--- Raylib parser JSONs -------------------------------------------------------------------------

const alias = std.ComptimeStringMap([]const u8, .{
    .{ "Camera", "Camera3D" },
    .{ "Texture", "Texture2D" },
    .{ "TextureCubemap", "Texture2D" },
    .{ "RenderTexture", "RenderTexture2D" },
    .{ "GuiStyle", "u32" },
    .{ "Quaternion", "Vector4" },
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
            const jsonData = try std.fs.cwd().readFileAlloc(allocator, jsonFile, memoryConstrain);
            defer allocator.free(jsonData);

            var stream = json.TokenStream.init(jsonData);
            const bindingJson: RaylibJson = try json.parse(RaylibJson, &stream, .{
                .allocator = allocator,
                .ignore_unknown_fields = true,
            });

            for (bindingJson.structs) |s| {
                try structs.put(s.name, s);
            }

            for (bindingJson.enums) |e| {
                try enums.put(e.name, e);
            }

            for (bindingJson.defines) |d| {
                try defines.put(d.name, d);
            }

            for (bindingJson.functions) |f| {
                try functions.put(f.name, f);
            }
        }

        return @This(){
            .structs = structs,
            .enums = enums,
            .defines = defines,
            .functions = functions,
        };
    }

    pub fn deinit(self: *@This()) void {
        self.structs.deinit();
        self.enums.deinit();
        self.defines.deinit();
        self.functions.deinit();
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
            .functions = functions.toOwnedSlice(),
            .enums = enums.toOwnedSlice(),
            .structs = structs.toOwnedSlice(),
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

const RaylibStruct = struct {
    name: []const u8,
    description: []const u8,
    fields: []RaylibField,
};

const RaylibField = struct {
    name: []const u8,
    description: []const u8,
    @"type": []const u8,
};

const RaylibEnum = struct {
    name: []const u8,
    description: []const u8,
    values: []const RaylibEnumValue,
};

const RaylibEnumValue = struct {
    name: []const u8,
    description: []const u8,
    value: c_int,
};

const RaylibFunction = struct {
    name: []const u8,
    description: []const u8,
    returnType: []const u8,
    params: ?[]const RaylibFunctionParam = null,
};

const RaylibFunctionParam = struct {
    name: []const u8,
    @"type": []const u8,
    description: ?[]const u8 = null,
};

const RaylibDefine = struct {
    name: []const u8,
    @"type": []const u8,
    value: union(enum) { string: []const u8, number: f32 },
    description: []const u8,
};

//--- Helpers -------------------------------------------------------------------------------------

fn eql(a: []const u8, b: []const u8) bool {
    return std.mem.eql(u8, a, b);
}

fn startsWith(haystack: []const u8, needle: []const u8) bool {
    return std.mem.startsWith(u8, haystack, needle);
}

fn endsWith(haystack: []const u8, needle: []const u8) bool {
    return std.mem.endsWith(u8, haystack, needle);
}
