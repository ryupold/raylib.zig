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
    types: []Type,

    pub fn loadCustoms(allocator: Allocator, jsonFile: []const u8) !@This() {
        var types = std.ArrayList(Type).init(allocator);
        var functions = std.ArrayList(Function).init(allocator);

        const jsonData = try std.fs.cwd().readFileAlloc(allocator, jsonFile, memoryConstrain);
        defer allocator.free(jsonData);

        var stream = json.TokenStream.init(jsonData);
        const bindingJson: Intermediate = try json.parse(Intermediate, &stream, .{
            .allocator = allocator,
            .ignore_unknown_fields = true,
        });

        for (bindingJson.types) |t| {
            if (t.custom) {
                try types.append(t);
            }
        }

        for (bindingJson.functions) |f| {
            if (f.custom) {
                try functions.append(f);
            }
        }

        return @This(){
            .allocator = allocator,
            .types = types.toOwnedSlice(),
            .functions = functions.toOwnedSlice(),
        };
    }
};

pub const Function = struct {
    name: []const u8,
    params: []FunctionParameter,
    returnType: Type,
    description: ?[]const u8 = null,
    custom: bool = false,

    pub fn zigSignature(_: Allocator) []const u8 {
        unreachable; //TODO: pub fn {{NAME}} ({{PARAMS}}) {{RETURN}}
    }

    pub fn callNativeFunction(_: Allocator) []const u8 {
        unreachable; //TODO depends on the return type (void, primitive, struct, enum)
    }

    pub fn convertReturnType(_: Allocator) []const u8 {
        unreachable; //TODO depends on the return type (void, primitive, struct, enum)
    }

    pub fn cSignature(_: Allocator) []const u8 {
        unreachable; //TODO {{RETURN}} {{NAME}}({{PARAMS}})
    }

    pub fn callRaylibFunction(_: Allocator) []const u8 {
        unreachable; //TODO depends on the return type and parameters
    }
};

pub fn parseRaylibFunction(allocator: Allocator, func: RaylibFunction, raylibTypes: []const Type) !Function {
    var args = std.ArrayList(FunctionParameter).init(allocator);
    for (func.params) |p| {
        const t = try parseType(allocator, p.typ, raylibTypes);
        try args.append(.{
            .name = p.name,
            .typ = t,
            .description = p.description,
        });
    }

    return .{
        .name = func.name,
        .params = args.toOwnedSlice(),
        .description = func.description,
    };
}

pub const FunctionParameter = struct {
    name: []const u8,
    typ: Type,
    description: ?[]const u8 = null,
    custom: bool = false,
};

pub const StructField = struct {
    name: []const u8,
    typ: Type,
    description: ?[]const u8 = null,
    custom: bool = false,
};

pub const EnumValue = struct {
    name: []const u8,
    value: c_int,
    description: ?[]const u8 = null,
    custom: bool = false,
};

/// fat type, holding infos of type
pub const Type = struct {
    /// mapping was edited so it will not be cleaned up after load
    custom: bool = false,

    /// idiomatic zig representation in zig signature
    zig: []const u8,

    /// c-ish type for marshalling
    c: []const u8,

    /// is a struct defined in raylib (Vector2, Matrix, etc.)
    isStruct: bool = false,

    /// is an enum defined in raylib (ConfigFlags, BlendMode, etc.)
    isEnum: bool = false,

    /// is an array with defined length
    isArray: bool = false,

    /// is void return type or void pointer (void, void *, const void *)
    isVoid: bool = false,

    /// is a pointer (unsigned char *, Vector2 *, etc.)
    isPointer: bool = false,

    /// is a const pointer (const char *, const GlyphInfo *, etc.)
    isConst: bool = false,

    /// optional documentation
    description: ?[]const u8 = null,

    /// struct fields
    fields: ?[]StructField = null,

    /// enum values
    values: ?[]EnumValue = null,
};

pub fn parseRaylibStruct(allocator: Allocator, s: RaylibStruct) !Type {
    var fields = std.ArrayList(StructField).init(allocator);
    for (s.fields) |field| {
        try fields.append(.{
            .name = field.name,
            .typ = field.@"type",
            .description = field.description,
        });
    }

    var t: Type = .{
        .c = s.name,
        .zig = s.name,
        .isStruct = true,
        .fields = fields.toOwnedSlice(),
    };

    return t;
}

pub fn parseRaylibEnum(allocator: Allocator, e: RaylibEnum) !Type {
    var values = std.ArrayList(EnumValue).init(allocator);
    for (e.values) |value| {
        try values.append(.{
            .name = value.name,
            .typ = value.value,
            .description = value.description,
        });
    }

    var t: Type = .{
        .c = e.name,
        .zig = e.name,
        .isEnum = true,
        .values = values.toOwnedSlice(),
    };

    return t;
}

fn parseType(allocator: Allocator, t: []const u8, raylibTypes: []const Type) !Type {
    if (fixedMapping.get(t)) |fixed| return fixed;

    const isConst = startsWith(t, "const ");
    const isPointer = endsWith(t, "*");

    const ptrS = if (isPointer) "[*c]" else "";
    const constS = if (isPointer and isConst) "const " else "";
    var name = if (isConst) t["const ".len..];
    name = if (isPointer) t[0 .. t.len - 1];
    name = std.mem.trim(u8, name, " \t\n");
    const isVoid = eql(name, "void");

    //TODO: handle double pointer
    std.debug.assert(name[name.len - 1] != '*');

    for (raylibTypes) |rlType| {
        const c = try fmt(allocator, "{s}{s}{s}", .{ ptrS, constS, name });
        const zig = try fmt(allocator, "{s}{s}{s}", .{ ptrS, constS, name });
        if (eql(rlType.name, name)) {
            var typ = rlType;
            typ.c = c;
            typ.zig = zig;
            typ.isConst = isConst;
            typ.isPointer = isPointer;
            return typ;
        }
    }

    if (raylibToZigType.get(name)) |primitive| {
        const c = try fmt(allocator, "{s}{s}{s}", .{ ptrS, constS, primitive });
        const zig = try fmt(allocator, "{s}{s}{s}", .{ ptrS, constS, primitive });

        return .{
            .c = c,
            .zig = zig,
            .isVoid = isVoid,
        };
    }
}

test "'int' becomes 'i32'" {
    const sut: Type = try parseType(talloc, "int");

    try expect(!sut.isConst);
    try expect(!sut.isEnum);
    try expect(sut.isPointer);
    try expect(!sut.isStruct);
    try expect(!sut.isVoid);

    try expectEqualStrings("i32", sut.zig);
}

test "'unsigned char *' becomes '[:0]u8'" {
    const sut: Type = try parseType(talloc, "unsigned char *");

    try expect(!sut.isConst);
    try expect(!sut.isEnum);
    try expect(sut.isPointer);
    try expect(!sut.isStruct);
    try expect(!sut.isVoid);

    try expectEqualStrings("[:0]u8", sut.zig);
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

const fixedMapping = std.ComptimeStringMap(Type, .{
    .{ "void *", Type{
        .c = "*anyopaque",
        .zig = "*anyopaque",
        .isPointer = true,
        .isVoid = true,
    } },
    .{ "const void *", Type{
        .c = "*anyopaque",
        .zig = "*anyopaque",
        .isPointer = true,
        .isVoid = true,
        .isConst = true,
    } },
    .{ "const unsigned char *", Type{
        .c = "[*:0]const u8",
        .zig = "[*:0]const u8",
        .isPointer = true,
        .isConst = true,
    } },
    .{ "const char *", Type{
        .c = "[*:0]const u8",
        .zig = "[*:0]const u8",
        .isPointer = true,
        .isConst = true,
    } },
    .{ "const char **", Type{
        .c = "[*]const [*:0]const u8",
        .zig = "[*]const [*:0]const u8",
        .isPointer = true,
    } },
    .{ "rAudioBuffer *", Type{
        .c = "*anyopaque",
        .zig = "*anyopaque",
        .isPointer = true,
    } },
    .{ "rAudioProcessor *", Type{
        .c = "*anyopaque",
        .zig = "*anyopaque",
        .isPointer = true,
    } },
});

//--- Raylib parser JSONs -------------------------------------------------------------------------

const alias = std.ComptimeStringMap([]const u8, .{
    .{ "Camera", "Camera3D" },
    .{ "Texture", "Texture2D" },
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
        var types = std.ArrayList(Type).init(allocator);

        enums: for (self.enums.values()) |e| {
            for (customs.types) |tt| {
                if (eql(tt.name, e.name)) break :enums;
            }
            try types.append(parseRaylibEnum(allocator, e));
        }
        structs: for (self.structs.values()) |s| {
            for (customs.types) |tt| {
                if (eql(tt.name, s.name)) break :structs;
            }
            try types.append(parseRaylibStruct(allocator, s));
        }
        for (self.defines.values()) |_| {}

        funcs: for (self.functions.values()) |f| {
            for (customs.functions) |ff| {
                if (eql(ff.name, f.name)) break :funcs;
            }
            try functions.append(try parseRaylibFunction(allocator, f, customs.types));
        }

        return .{
            .functions = functions.toOwnedSlice(),
            .types = types.toOwnedSlice(),
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
