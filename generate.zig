const std = @import("std");
const fs = std.fs;
const json = std.json;

/// max files size
const memoryConstrain: usize = 1024 * 1024 * 1024; // 1 GiB
const excludesFile = "excludes.json";
const jsonFiles: []const []const u8 = &.{
    "raylib.json",
    "raymath.json",
    "raygui.json",
};
var alreadyProcessed: std.StringArrayHashMap(void) = undefined;

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

    alreadyProcessed = std.StringArrayHashMap(void).init(allocator);
    defer alreadyProcessed.deinit();

    const excludesData = try fs.cwd().readFileAlloc(allocator, excludesFile, memoryConstrain);
    defer allocator.free(excludesData);
    var stream = json.TokenStream.init(excludesData);
    const excludes = try json.parse(Excludes, &stream, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });
    defer json.parseFree(Excludes, excludes, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });

    var manuals = try getManualBindings(allocator);
    defer manuals.deinit();

    var functions: []const JsonFunction = &[_]JsonFunction{};
    var enums: []const JsonEnum = &[_]JsonEnum{};
    var structs: []const JsonStruct = &[_]JsonStruct{};
    //parse json files
    for (jsonFiles) |jsonFile| {
        const jsonData = try fs.cwd().readFileAlloc(allocator, jsonFile, memoryConstrain);
        defer allocator.free(jsonData);

        stream = json.TokenStream.init(jsonData);
        const bindingJson = try json.parse(BindingJson, &stream, .{
            .allocator = arena.allocator(),
            .ignore_unknown_fields = true,
        });

        functions = try std.mem.concat(arena.allocator(), JsonFunction, &.{ functions, bindingJson.functions });
        enums = try std.mem.concat(arena.allocator(), JsonEnum, &.{ enums, bindingJson.enums });
        structs = try std.mem.concat(arena.allocator(), JsonStruct, &.{ structs, bindingJson.structs });
    }

    try writeStructs(arena.allocator(), "structs.zig", structs);
    try writeEnums("enums.zig", enums);
    try writeFunctions(arena.allocator(), "functions.zig", functions, excludes, manuals);
}

fn writeFunctions(allocator: std.mem.Allocator, path: []const u8, functions: []const JsonFunction, excludes: Excludes, manuals: Manuals) !void {
    var file = try fs.cwd().createFile(path, .{});
    defer file.close();

    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    //--- imports -------------------------------
    try file.writeAll(
        try std.fmt.allocPrint(fba.allocator(),
            \\const raylib = @cImport({{
            \\    @cInclude("raylib/src/raylib.h");
            \\}});
            \\
            \\usingnamespace @import("structs.zig");
            \\usingnamespace @import("enums.zig");
            \\
        , .{}),
    );

    for (functions) |func| {
        //ignore everything in 'manual_mapping.json'
        if (excludes.ignoreFunction(func.name)) continue;
        if (manuals.containsFunction(func.name)) continue;
        if (alreadyProcessed.contains(func.name)) continue;

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
                const cIsh = try mapCType(allocator, param.@"type");
                const idiomatic = try mapToIdiomatic(allocator, cIsh);

                try file.writeAll(try std.fmt.allocPrint(
                    fba.allocator(),
                    "{s}: {s},\n",
                    .{ param.name, idiomatic },
                ));
            }
        }

        const returnTypeCIsh = try mapCType(allocator, func.returnType);
        const returnType = try mapToIdiomatic(allocator, returnTypeCIsh);
        const isVoid = eql(returnType, "void");
        _ = isVoid;

        try file.writeAll(
            try std.fmt.allocPrint(
                fba.allocator(),
                ") {s} {{\n",
                .{returnType},
            ),
        );

        //--- body ------------------------------
        if (!isVoid) {
            try file.writeAll(try std.fmt.allocPrint(fba.allocator(), "return ", .{}));
        }
        try file.writeAll(try std.fmt.allocPrint(fba.allocator(), "raylib.{s}(\n", .{func.name}));

        if (func.params) |params| {
            for (params) |param| {
                const cIsh = try mapCType(allocator, param.@"type");
                const idiomatic = try mapToIdiomatic(allocator, cIsh);

                if (startsWith(cIsh, "[*c]")) { //is pointer
                    if (startsWith(idiomatic, "[]")) {
                        try file.writeAll(try std.fmt.allocPrint(
                            fba.allocator(),
                            "@ptrCast({s}, {s}.ptr)",
                            .{ cIsh, param.name },
                        ));
                    } else {
                        try file.writeAll(try std.fmt.allocPrint(
                            fba.allocator(),
                            "@ptrCast({s}, {s})",
                            .{ cIsh, param.name },
                        ));
                    }
                } else if (eql(cIsh, "c_int") or eql(cIsh, "c_uint") or eql(cIsh, "c_short") or eql(cIsh, "c_ushort") or eql(cIsh, "c_long") or eql(cIsh, "c_ulong")) { //is int
                    try file.writeAll(try std.fmt.allocPrint(
                        fba.allocator(),
                        "@intCast({s}, {s})",
                        .{ cIsh, param.name },
                    ));
                } else { //pass as value
                    try file.writeAll(try std.fmt.allocPrint(
                        fba.allocator(),
                        "{s}",
                        .{param.name},
                    ));
                }
                //comma & newline
                try file.writeAll(",\n");
            }
        }
        try file.writeAll(");\n}\n");

        try alreadyProcessed.putNoClobber(func.name, {});
    }

    std.log.info("generated {s}", .{path});
}

fn writeStructs(allocator: std.mem.Allocator, path: []const u8, structs: []const JsonStruct) !void {
    var file = try fs.cwd().createFile(path, .{});
    defer file.close();

    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (structs) |s| {
        if (alreadyProcessed.contains(s.name)) continue;

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
            const cIsh = try mapCType(allocator, field.@"type");
            const idiomatic = try mapToIdiomatic(allocator, cIsh);

            try file.writeAll(try std.fmt.allocPrint(fba.allocator(), "/// {s}\n\t{s}: {s}{s},\n", .{
                field.description,
                name.name,
                arrayPrefix,
                idiomatic,
            }));
        }

        try file.writeAll("\n};\n");
        try alreadyProcessed.putNoClobber(s.name, {});
    }

    std.log.info("generated {s}", .{path});
}

fn writeEnums(path: []const u8, enums: []const JsonEnum) !void {
    var file = try fs.cwd().createFile(path, .{});
    defer file.close();

    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (enums) |e| {
        if (alreadyProcessed.contains(e.name)) continue;
        defer fba.reset();

        try file.writeAll(
            try std.fmt.allocPrint(
                fba.allocator(),
                "\n/// {s}\npub const {s} = enum(c_int) {{\n",
                .{ e.description, e.name },
            ),
        );

        for (e.values) |value| {
            try file.writeAll(try std.fmt.allocPrint(fba.allocator(), "/// {s}\n{s} = {d},\n", .{
                value.description,
                value.name,
                value.value,
            }));
        }

        try file.writeAll("\n};\n");
        try alreadyProcessed.putNoClobber(e.name, {});
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
        .{ "const int *", "[*c]c_int" },
        .{ "unsigned int", "c_uint" },
        .{ "unsigned int *", "[*c]c_uint" },
        .{ "unsigned short", "c_ushort" },
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

    if (endsWith(cType, "**")) {
        return try std.fmt.allocPrint(allocator, "[*c][*c] {s}", .{cType[0 .. cType.len - 2]});
    }

    if (endsWith(cType, "*")) {
        return try std.fmt.allocPrint(allocator, "[*c]{s}", .{cType[0 .. cType.len - 1]});
    }

    return cType;
}

/// map from c style zig type to idiomatic zig type
fn mapToIdiomatic(allocator: std.mem.Allocator, cIshZigType: []const u8) ![]const u8 {
    const typeMap = std.ComptimeStringMap([]const u8, .{
        .{ "[*c]f32", "[]f32" },
        .{ "c_int", "i32" },
        .{ "[*c]c_int", "[]i32" },
        .{ "c_long", "i64" },
        .{ "[*c]c_int", "[]i32" },
        .{ "c_uint", "u32" },
        .{ "[*c]c_uint", "[]u32" },
        .{ "c_ushort", "u16" },
        .{ "c_short", "i16" },
        .{ "[*c]c_ushort", "[]u16" },
        .{ "[*c]const u8", "[]const u8" },
        .{ "[*c]const [*c]const u8", "[]const []const u8" },
    });

    if (typeMap.get(cIshZigType)) |primitive| return primitive;

    if (startsWith(cIshZigType, "[*c][*c]")) {
        // return try std.fmt.allocPrint(allocator, "*{s}", .{cIshZigType[4..]});
        return cIshZigType;
    }

    if (startsWith(cIshZigType, "[*c]")) {
        // return cIshZigType;
        return try std.fmt.allocPrint(allocator, "*{s}", .{cIshZigType[4..]});
    }

    if (startsWith(cIshZigType, "const ")) {
        // return cIshZigType;
        return try std.fmt.allocPrint(allocator, "{s}", .{cIshZigType[6..]});
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

const Manuals = struct {
    allocator: std.mem.Allocator,
    structs: []const []const u8,
    functions: []const []const u8,

    pub fn deinit(self: *@This()) void {
        for (self.structs) |s| {
            self.allocator.free(s);
        }
        self.allocator.free(self.structs);

        for (self.functions) |f| {
            self.allocator.free(f);
        }
        self.allocator.free(self.functions);
    }

    pub fn containsFunction(self: @This(), name: []const u8) bool {
        for (self.functions) |f| {
            if (eql(f, name)) return true;
        }
        return false;
    }
    pub fn containsStruct(self: @This(), name: []const u8) bool {
        for (self.structs) |f| {
            if (eql(f, name)) return true;
        }
        return false;
    }
};

/// call .deinit() when done, to release all allocated names
fn getManualBindings(allocator: std.mem.Allocator) !Manuals {
    //manual_bindings.zig
    var file = try fs.cwd().openFile("manual_bindings.zig", .{});
    defer file.close();

    var buf = std.io.bufferedReader(file.reader());
    var reader = buf.reader();

    var structs = std.ArrayList([]const u8).init(allocator);
    var functions = std.ArrayList([]const u8).init(allocator);

    var name = std.ArrayList(u8).init(allocator);
    defer name.deinit();

    while (try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', memoryConstrain)) |line| {
        defer allocator.free(line);

        //functions
        if (std.mem.indexOf(u8, line, "pub fn ")) |start| {
            if (std.mem.indexOf(u8, line, "(")) |end| {
                var i: usize = start + "pub fn ".len;
                while (i < end) : (i += 1) {
                    if (line[i] != ' ') try name.append(line[i]);
                }
                const functionName = name.toOwnedSlice();
                std.log.info("manually mapped function: {s}", .{functionName});
                try functions.append(functionName);
            }
        }

        //structs
        if (std.mem.containsAtLeast(u8, line, 1, " = struct")) {
            if (std.mem.indexOf(u8, line, "pub const ")) |start| {
                if (std.mem.indexOf(u8, line, " = struct")) |end| {
                    var i: usize = start + "pub const ".len;
                    while (i < end) : (i += 1) {
                        if (line[i] != ' ') try name.append(line[i]);
                    }
                    const structName = name.toOwnedSlice();
                    std.log.info("manually mapped struct: {s}", .{structName});
                    try structs.append(structName);
                }
            }
        }
    }

    return Manuals{
        .allocator = allocator,
        .structs = structs.toOwnedSlice(),
        .functions = functions.toOwnedSlice(),
    };
}

const Excludes = struct {
    excluded_functions: []const []const u8,

    pub fn ignoreFunction(self: @This(), name: []const u8) bool {
        for (self.excluded_functions) |f| {
            if (eql(f, name)) return true;
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
    @"type": []const u8,
    description: ?[]const u8 = null,
};

const JsonDefine = struct {
    name: []const u8,
    @"type": []const u8,
    value: union(enum) { string: []const u8, number: f32 },
    description: []const u8,
};

fn eql(a: []const u8, b: []const u8) bool {
    return std.mem.eql(u8, a, b);
}

fn startsWith(haystack: []const u8, needle: []const u8) bool {
    return std.mem.startsWith(u8, haystack, needle);
}

fn endsWith(haystack: []const u8, needle: []const u8) bool {
    return std.mem.endsWith(u8, haystack, needle);
}
