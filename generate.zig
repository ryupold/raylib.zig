const std = @import("std");
const fs = std.fs;
const json = std.json;

/// max files size
const memoryConstrain: usize = 1024 * 1024 * 1024; // 1 GiB
const manualMappingFile = "manual_mapping.json";
const jsonFiles: []const []const u8 = &.{
    "raylib.json",
    "raymath.json",
    "raygui.json",
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        if (gpa.deinit()) {
            std.log.err("memory leak detected", .{});
        }
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const jsonData = try fs.cwd().readFileAlloc(allocator, jsonFiles[0], memoryConstrain);
    defer allocator.free(jsonData);

    var stream = json.TokenStream.init(jsonData);
    const res = try json.parse(BindingJson, &stream, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });
    defer json.parseFree(BindingJson, res, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });

    const manualMappingData = try fs.cwd().readFileAlloc(allocator, manualMappingFile, memoryConstrain);
    defer allocator.free(manualMappingData);
    stream = json.TokenStream.init(manualMappingData);
    const manualMapping = try json.parse(ManualMapping, &stream, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });
    defer json.parseFree(ManualMapping, manualMapping, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });

    std.log.info("correctly parsed\n", .{});

    try writeStructs(arena.allocator(), "structs.zig", res.structs);
    try writeEnums("enums.zig", res.enums);
    try writeFunctions(arena.allocator(), "functions.zig", res.functions, manualMapping);
}

fn writeFunctions(allocator: std.mem.Allocator, path: []const u8, functions: []const JsonFunction, manualMapping: ManualMapping) !void {
    var file = try fs.cwd().createFile(path, .{});
    defer file.close();

    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (functions) |func| {
        //ignore everything in 'manual_mapping.json'
        if (manualMapping.ignoreFunction(func.name)) continue;

        defer fba.reset();

        //--- signature -------------------------
        try file.writeAll(
            try std.fmt.allocPrint(
                fba.allocator(),
                "\n/// {s}\npub fn {s} (\n",
                .{ func.description, func.name },
            ),
        );

        if (func.params) |params| {
            for (params) |param| {
                const t = try mapCType(allocator, param.@"type");
                const z = try mapToIdiomatic(allocator, t);

                //TODO: the only variadic parameters are for text formatting (use zig for that)
                if (std.mem.eql(u8, t, "...")) continue;

                try file.writeAll(try std.fmt.allocPrint(fba.allocator(), "{s}: {s},\n", .{
                    param.name,
                    z,
                }));
            }
        }

        const returnTypeCIsh = try mapCType(allocator, func.returnType);
        const returnType = try mapToIdiomatic(allocator, returnTypeCIsh);

        try file.writeAll(
            try std.fmt.allocPrint(
                fba.allocator(),
                ") {s} {{\n",
                .{returnType},
            ),
        );

        //--- body ------------------------------

        try file.writeAll("\n}\n");
    }

    std.log.info("generated {s}", .{path});
}

fn writeStructs(allocator: std.mem.Allocator, path: []const u8, structs: []const JsonStruct) !void {
    var file = try fs.cwd().createFile(path, .{});
    defer file.close();

    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (structs) |s| {
        defer fba.reset();

        try file.writeAll(
            try std.fmt.allocPrint(
                fba.allocator(),
                "\n/// {s}\npub const {s} = extern struct {{\n",
                .{ s.description, s.name },
            ),
        );

        for (s.fields) |field| {
            const name = nameContainsArraySize(field.name);
            const arrayPrefix = name.sizeAsString orelse "";
            const t = try mapCType(allocator, field.@"type");

            try file.writeAll(try std.fmt.allocPrint(fba.allocator(), "/// {s}\n\t{s}: {s}{s},\n", .{
                field.description,
                name.name,
                arrayPrefix,
                t,
            }));
        }

        try file.writeAll("\n};\n");
    }

    std.log.info("generated {s}", .{path});
}

fn writeEnums(path: []const u8, enums: []const JsonEnum) !void {
    var file = try fs.cwd().createFile(path, .{});
    defer file.close();

    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (enums) |s| {
        defer fba.reset();

        try file.writeAll(
            try std.fmt.allocPrint(
                fba.allocator(),
                "\n/// {s}\npub const {s} = enum(c_int) {{\n",
                .{ s.description, s.name },
            ),
        );

        for (s.values) |value| {
            try file.writeAll(try std.fmt.allocPrint(fba.allocator(), "/// {s}\n{s} = {d},\n", .{
                value.description,
                value.name,
                value.value,
            }));
        }

        try file.writeAll("\n};\n");
    }

    std.log.info("generated {s}", .{path});
}

/// return (non-idiomatic) zig type for c type
fn mapCType(allocator: std.mem.Allocator, cType: []const u8) ![]const u8 {
    const cTypeMap = std.ComptimeStringMap([]const u8, .{
        .{ "float", "f32" },
        .{ "float *", "[*c]f32" },
        .{ "int", "c_int" },
        .{ "int *", "[*c]c_int" },
        .{ "long", "c_long" },
        .{ "const int *", "[*c]c_int" },
        .{ "unsigned int", "c_uint" },
        .{ "unsigned int *", "[*c]c_uint" },
        .{ "unsigned short *", "[*c]c_ushort" },
        .{ "void *", "*anyopaque" },
        .{ "const void *", "*anyopaque" },
        .{ "unsigned char", "u8" },
        .{ "unsigned char *", "[*c]const u8" },
        .{ "const char *", "[*c]const u8" },
        .{ "const unsigned char *", "[*c]const u8" },
        .{ "char", "u8" },
        .{ "char *", "[*c]const u8" },
    });
    if (cTypeMap.get(cType)) |mapping| {
        return mapping;
    }

    if (std.mem.endsWith(u8, cType, "**")) {
        std.log.err("{s} is pointer to pointer and should be mapped manually", .{cType});
        return error.PointerToPointer;
    }

    if (std.mem.endsWith(u8, cType, "*")) {
        return try std.fmt.allocPrint(allocator, "[*c]{s}", .{cType[0 .. cType.len - 1]});
    }

    return cType;
}

/// map from c style zig type to idomatic zig type
/// a
fn mapToIdiomatic(allocator: std.mem.Allocator, cIshZigType: []const u8) ![]const u8 {
    const typeMap = std.ComptimeStringMap([]const u8, .{
        .{ "[*c]f32", "[]f32" },
        .{ "c_int", "i32" },
        .{ "[*c]c_int", "[]i32" },
        .{ "c_long", "i64" },
        .{ "[*c]c_int", "[]i32" },
        .{ "c_uint", "u32" },
        .{ "[*c]c_uint", "[]u32" },
        .{ "[*c]c_ushort", "[]u16" },
        .{ "[*c]const u8", "[]const u8" },
        .{ "[*c]const [*c]const u8", "[]const []const u8" },
    });

    if (typeMap.get(cIshZigType)) |primitive| return primitive;

    if (std.mem.startsWith(u8, cIshZigType, "[*c]const [*c]")) {
        // return try std.fmt.allocPrint(allocator, "*{s}", .{cIshZigType[4..]});
        std.log.err("{s} is pointer to pointer and should be mapped manually", .{cIshZigType});
        return error.PointerToPointer;
    }

    if (std.mem.startsWith(u8, cIshZigType, "[*c]")) {
        return try std.fmt.allocPrint(allocator, "*{s}", .{cIshZigType[4..]});
    }

    return cIshZigType;
}

/// if a field is an array the length is part of its name so I need to seperate it
/// thanks C ...
fn nameContainsArraySize(name: []const u8) struct {
    name: []const u8,
    sizeAsString: ?[]const u8 = null,
} {
    var openBracket: ?usize = null;
    var closeBracket: ?usize = null;

    for (name) |c, i| {
        switch (c) {
            '[' => openBracket = i,
            ']' => closeBracket = i,
            else => {},
        }
    }

    if (openBracket != null) {
        return .{
            .name = name[0..openBracket.?],
            .sizeAsString = name[openBracket.? .. closeBracket.? + 1],
        };
    } else {
        return .{ .name = name };
    }
}

const ManualMapping = struct {
    excluded_functions: []const []const u8,

    pub fn ignoreFunction(self: @This(), name: []const u8) bool {
        for (self.excluded_functions) |f| {
            if (std.mem.eql(u8, f, name)) return true;
        }
        return false;
    }
};

const BindingJson = struct {
    structs: []const JsonStruct,
    enums: []const JsonEnum,
    defines: []const JsonDefine,
    functions: []const JsonFunction,
};

const JsonStruct = struct {
    name: []const u8,
    description: []const u8,
    fields: []const JsonField,
};

const JsonField = struct {
    name: []const u8,
    description: []const u8,
    @"type": []const u8,
};

const JsonEnum = struct {
    name: []const u8,
    description: []const u8,
    values: []const JsonEnumValue,
};

const JsonEnumValue = struct {
    name: []const u8,
    description: []const u8,
    value: c_int,
};

const JsonFunction = struct {
    name: []const u8,
    description: []const u8,
    returnType: []const u8,
    params: ?[]const JsonFunctionParam = null,
};

const JsonFunctionParam = struct {
    name: []const u8,
    /// TODO: type can also be '...' or some callback function pointer
    @"type": []const u8,
    description: ?[]const u8 = null,
};

const JsonDefine = struct {
    name: []const u8,
    @"type": []const u8,
    value: union(enum) { string: []const u8, number: f32 },
    description: []const u8,
};
