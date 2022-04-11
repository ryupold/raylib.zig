//! Strategy:
//! 1. generate raylib JSONs
//! 2. combine in a union RaylibJson
//! 3. convert to intermediate representation 
//! 4. read adjusted intermediate JSONs
//! 5. generate raylib.zig // wrap paramters and pass them to marshall versions of the raylib functions
//! 6. generate marshall.c // unwrap parameters from zig function and call the actual raylib function
//! 7. generate marshall.h // C signatures for all marshalled functions

const std = @import("std");
const Allocator = std.mem.Allocator;
const fmt = std.fmt.allocPrint;
const talloc = std.testing.allocator;
const expect = std.testing.expect;
const expectEqualStrings = std.testing.expectEqualStrings;

//--- Intermediate Format -------------------------------------------------------------------------

pub const Intermediate = struct {
    functions: []Function,
    types: []Type,
};

pub const Function = struct {
    allocator: std.mem.Allocator,
    name: []const u8,
    params: []FunctionParameter,
    returnType: Type,
    description: ?[]const u8 = null,

    pub fn zigSignature(_: std.mem.Allocator) []const u8 {
        unreachable; //TODO: pub fn {{NAME}} ({{PARAMS}}) {{RETURN}}
    }

    pub fn callNativeFunction(_: std.mem.Allocator) []const u8 {
        unreachable; //TODO depends on the return type (void, primitive, struct, enum)
    }

    pub fn convertReturnType(_: std.mem.Allocator) []const u8 {
        unreachable; //TODO depends on the return type (void, primitive, struct, enum)
    }

    pub fn cSignature(_: std.mem.Allocator) []const u8 {
        unreachable; //TODO {{RETURN}} {{NAME}}({{PARAMS}})
    }

    pub fn callRaylibFunction(_: std.mem.Allocator) []const u8 {
        unreachable; //TODO depends on the return type and parameters
    }
};

pub const FunctionParameter = struct {
    name: []const u8,
    typ: Type,
    description: ?[]const u8 = null,

    pub fn inZigSignature(
        _: std.mem.Allocator,
    ) []const u8 {
        unreachable; //TODO
    }
};

pub const Type = struct {
    /// idiomatic zig representation
    zig: []const u8,

    /// cish type for marshalling
    cish: []const u8,

    /// is a struct defined in raylib (Vector2, Matrix, etc.)
    isStruct: bool = false,

    /// is an enum defined in raylib (ConfigFlags, KeyboardKey, etc.)
    isEnum: bool = false,

    /// is a pointer (unsigned char *, Vector2 *, etc.)
    isPointer: bool = false,

    /// is a const pointer (const char *, const GlyphInfo *, etc.)
    isConst: bool = false,

    /// is void return type or void pointer (void, void *, const void *)
    isVoid: bool = false,

    /// optional documentation
    description: ?[]const u8 = null,
};

fn parseType(allocator: Allocator, typeName: []const u8) !Type {
    _ = allocator;
    _ = typeName;
    unreachable; //TODO
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

const c2zig = std.ComptimeStringMap([]const u8, .{
    .{ "", "" },
});

//--- Raylib parser JSONs -------------------------------------------------------------------------

const alias = std.ComptimeStringMap([]const u8, .{
    .{ "Camera", "Camera3D" },
    .{ "Texture", "Texture2D" },
});

const RaylibJson = struct {
    structs: []RaylibStruct = &[_]RaylibStruct{},
    enums: []RaylibEnum = &[_]RaylibEnum{},
    defines: []RaylibDefine = &[_]RaylibDefine{},
    functions: []RaylibFunction = &[_]RaylibFunction{},

    pub fn toIntermediate(self: @This()) Intermediate {
        _ = self;
        unreachable; //TODO
    }

    fn containsStruct(self: @This(), name: []const u8) bool {
        for (self.structs) |s| {
            if (eql(s.name, name)) return true;
        }
        return false;
    }

    fn containsEnum(self: @This(), name: []const u8) bool {
        for (self.enums) |e| {
            if (eql(e.name, name)) return true;
        }
        return false;
    }

    fn containsFunction(self: @This(), name: []const u8) bool {
        for (self.functions) |f| {
            if (eql(f.name, name)) return true;
        }
        return false;
    }
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

    pub fn toIntermediate(self: @This(), allocator: Allocator) FunctionParameter {
        return .{
            .name = self.name,
            .typ = parseType(allocator, self.@"type"),
        };
    }

    test "'unsigned char *' becomes '[:0]u8'" {
        var rlFuncParam = RaylibFunctionParam{ .@"type" = "unsigned char *", .name = "test" };
        var sut = rlFuncParam.toIntermediate();

        try expectEqualStrings("test", sut.name);

        try expect(!sut.isConst);
        try expect(!sut.isEnum);
        try expect(sut.isPointer);
        try expect(!sut.isStruct);
        try expect(!sut.isVoid);

        try expectEqualStrings("[:0]u8", sut.zig);
    }
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
