const std = @import("std");
const fs = std.fs;
const json = std.json;
const allocPrint = std.fmt.allocPrint;
const mapping = @import("type_mapping.zig");
const intermediate = @import("intermediate.zig");

pub const outputFile = "raylib.zig";
pub const injectFile = "inject.zig";

fn trim(s: []const u8) []const u8 {
    return std.mem.trim(u8, s, &[_]u8{ ' ', '\t', '\n' });
}

pub fn main() !void {
    std.log.info("generating raylib.zig ...", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        if (gpa.deinit() == .leak) {
            std.log.err("memory leak detected", .{});
        }
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const bindingsData = try fs.cwd().readFileAlloc(arena.allocator(), intermediate.bindingsJSON, std.math.maxInt(usize));

    const bindings = try json.parseFromSliceLeaky(mapping.Intermediate, arena.allocator(), bindingsData, .{
        .ignore_unknown_fields = true,
    });

    var file = try fs.cwd().createFile(outputFile, .{});
    defer file.close();

    try file.writeAll("\n\n");

    const inject = try Injections.load(arena.allocator());
    try writeInjections(arena.allocator(), &file, inject);

    try writeFunctions(arena.allocator(), &file, bindings, inject);
    var h = try fs.cwd().createFile("marshal.h", .{});
    defer h.close();
    var c = try fs.cwd().createFile("marshal.c", .{});
    defer c.close();
    const raylib: mapping.CombinedRaylib = try mapping.CombinedRaylib.load(arena.allocator(), intermediate.jsonFiles);
    try writeCFunctions(arena.allocator(), &h, &c, inject, raylib);

    try writeStructs(arena.allocator(), &file, bindings, inject);
    try writeEnums(arena.allocator(), &file, bindings, inject);
    try writeDefines(arena.allocator(), &file, bindings, inject);

    std.log.info("... done", .{});
}

const Injections = struct {
    lines: []const []const u8,
    symbols: []const []const u8,

    pub fn load(allocator: std.mem.Allocator) !@This() {
        var injectZigLines = std.ArrayList([]const u8).init(allocator);
        var symbols = std.ArrayList([]const u8).init(allocator);

        var file = try fs.cwd().openFile(injectFile, .{});
        var reader = file.reader();
        while (try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize))) |line| {
            if (std.mem.indexOf(u8, line, "pub const ")) |startIndex| {
                if (std.mem.indexOf(u8, line, " = extern struct {")) |endIndex| {
                    const s = line["pub const ".len + startIndex .. endIndex];
                    try symbols.append(s);
                    std.log.debug("inject symbol: {s}", .{s});
                } else if (std.mem.indexOf(u8, line, " = packed struct(u32) {")) |endIndex| {
                    const s = line["pub const ".len + startIndex .. endIndex];
                    try symbols.append(s);
                    std.log.debug("inject symbol: {s}", .{s});
                }
            }
            if (std.mem.indexOf(u8, line, "pub fn ")) |startIndex| {
                if (std.mem.indexOf(u8, line, "(")) |endIndex| {
                    const s = line["pub fn ".len + startIndex .. endIndex];
                    try symbols.append(s);
                    std.log.debug("inject symbol: {s}", .{s});
                }
            }
            try injectZigLines.append(line);
        }

        return @This(){
            .lines = try injectZigLines.toOwnedSlice(),
            .symbols = try symbols.toOwnedSlice(),
        };
    }

    pub fn containsSymbol(self: @This(), name: []const u8) bool {
        for (self.symbols) |s| {
            if (eql(s, name)) return true;
        }
        return false;
    }
};

fn writeFunctions(
    allocator: std.mem.Allocator,
    file: *fs.File,
    bindings: mapping.Intermediate,
    inject: Injections,
) !void {
    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (bindings.functions) |func| {
        if (inject.containsSymbol(func.name)) continue;
        defer fba.reset();

        //--- signature -------------------------
        const funcDescription: []const u8 = func.description orelse "";
        try file.writeAll(
            try allocPrint(
                allocator,
                "\n/// {s}\npub fn {s} (\n",
                .{ funcDescription, func.name },
            ),
        );

        for (func.params) |param| {
            if (param.description) |description| {
                try file.writeAll(try allocPrint(
                    allocator,
                    "/// {s}\n",
                    .{description},
                ));
            }
            try file.writeAll(try allocPrint(
                allocator,
                "{s}: {s},\n",
                .{ param.name, param.typ },
            ));
        }

        if (func.custom) {
            try file.writeAll(
                try allocPrint(
                    allocator,
                    ") {s} {{\n",
                    .{func.returnType},
                ),
            );
        } else if (isPointer(func.returnType)) {
            if (eql("u8", (stripType(func.returnType)))) {
                try file.writeAll(
                    try allocPrint(
                        allocator,
                        ") [*:0]const {s} {{\n",
                        .{stripType(func.returnType)},
                    ),
                );
            } else {
                try file.writeAll(
                    try allocPrint(
                        allocator,
                        ") {s} {{\n",
                        .{func.returnType},
                    ),
                );
            }
        } else {
            try file.writeAll(
                try allocPrint(
                    allocator,
                    ") {s} {{\n",
                    .{func.returnType},
                ),
            );
        }
        const returnTypeIsVoid = eql(func.returnType, "void");

        //--- body ------------------------------
        if (isPointer(func.returnType)) {
            try file.writeAll(try allocPrint(allocator, "return @ptrCast({s},\n", .{func.returnType}));
        } else if (isPrimitiveOrPointer(func.returnType)) {
            try file.writeAll("return ");
        } else if (!returnTypeIsVoid) {
            try file.writeAll(try allocPrint(allocator, "var out: {s} = undefined;\n", .{func.returnType}));
        }
        try file.writeAll(try allocPrint(allocator, "raylib.m{s}(\n", .{func.name}));

        if (!isPrimitiveOrPointer(func.returnType)) {
            if (bindings.containsStruct(stripType(func.returnType))) {
                try file.writeAll(try allocPrint(allocator, "@ptrCast([*c]raylib.{s}, &out),\n", .{func.returnType}));
            } else if (!returnTypeIsVoid) {
                try file.writeAll(try allocPrint(allocator, "@ptrCast([*c]{s}, &out),\n", .{func.returnType}));
            }
        }

        for (func.params) |param| {
            if (isFunctionPointer(param.typ)) {
                try file.writeAll(try allocPrint(allocator, "@ptrCast({s}),\n", .{param.name}));
            } else if (bindings.containsStruct(stripType(param.typ)) and isPointer(param.typ)) {
                try file.writeAll(try allocPrint(allocator, "@intToPtr([*c]raylib.{s}, @ptrToInt({s})),\n", .{ stripType(param.typ), param.name }));
            } else if (bindings.containsEnum(param.typ)) {
                try file.writeAll(try allocPrint(allocator, "@enumToInt({s}),\n", .{param.name}));
            } else if (bindings.containsStruct(stripType(param.typ))) {
                try file.writeAll(try allocPrint(allocator, "@intToPtr([*c]raylib.{s}, @ptrToInt(&{s})),\n", .{ stripType(param.typ), param.name }));
            } else if (isPointer(param.typ)) {
                if (std.mem.endsWith(u8, param.typ, "anyopaque")) {
                    try file.writeAll(try allocPrint(allocator, "{s},\n", .{param.name}));
                } else if (isConst(param.typ)) {
                    try file.writeAll(try allocPrint(allocator, "@intToPtr([*c]const {s}, @ptrToInt({s})),\n", .{ stripType(param.typ), param.name }));
                } else {
                    try file.writeAll(try allocPrint(allocator, "@ptrCast([*c]{s}, {s}),\n", .{ stripType(param.typ), param.name }));
                }
            } else {
                try file.writeAll(try allocPrint(allocator, "{s},\n", .{param.name}));
            }
        }

        if (isPointer(func.returnType)) {
            try file.writeAll("),\n);\n");
        } else {
            try file.writeAll(");\n");
        }

        if (!isPrimitiveOrPointer(func.returnType) and !returnTypeIsVoid) {
            try file.writeAll("return out;\n");
        }

        try file.writeAll("}\n");
    }

    std.log.info("generated functions", .{});
}

/// write: RETURN NAME(PARAMS...)
/// or: void NAME(RETURN*, PARAMS...)
fn writeCSignature(
    allocator: std.mem.Allocator,
    file: *fs.File,
    func: mapping.RaylibFunction,
) !void {
    const returnType = func.returnType;

    //return directly
    if (mapping.isPrimitiveOrPointer(returnType)) {
        try file.writeAll(try allocPrint(allocator, "{s} m{s}(", .{ returnType, func.name }));
        if (func.params == null or func.params.?.len == 0) {
            try file.writeAll("void");
        }
    }
    //wrap return type and put as first function parameter
    else {
        try file.writeAll(try allocPrint(allocator, "void m{s}({s} *out", .{ func.name, returnType }));
        if (func.params != null and func.params.?.len > 0) {
            try file.writeAll(", ");
        }
    }

    if (func.params) |params| {
        for (params, 0..) |param, i| {
            const paramType = param.type;
            if (mapping.isPrimitiveOrPointer(paramType) or isFunctionPointer(paramType)) {
                try file.writeAll(try allocPrint(allocator, "{s} {s}", .{ paramType, param.name }));
            } else {
                try file.writeAll(try allocPrint(allocator, "{s} *{s}", .{ paramType, param.name }));
            }

            if (i < params.len - 1) {
                try file.writeAll(", ");
            }
        }
    }

    try file.writeAll(")");
}

fn writeCFunctions(
    allocator: std.mem.Allocator,
    h: *fs.File,
    c: *fs.File,
    inject: Injections,
    rl: mapping.CombinedRaylib,
) !void {
    var hInject = try fs.cwd().openFile("inject.h", .{});
    defer hInject.close();
    try h.writeFileAll(hInject, .{});
    var cInject = try fs.cwd().openFile("inject.c", .{});
    defer cInject.close();
    try c.writeFileAll(cInject, .{});

    for (rl.functions.values()) |func| {
        if (inject.containsSymbol(func.name)) continue;

        //--- C-HEADER -----------------------------

        try h.writeAll(try allocPrint(allocator, "// {s}\n", .{func.description}));
        try writeCSignature(allocator, h, func);
        try h.writeAll(";\n\n");

        try writeCSignature(allocator, c, func);
        try c.writeAll("\n{\n");

        //--- C-IMPLEMENT -----------------------------

        if (eql(func.returnType, "void")) {
            try c.writeAll("\t");
        } else if (mapping.isPrimitiveOrPointer(func.returnType)) {
            try c.writeAll("\treturn ");
        } else {
            try c.writeAll("\t*out = ");
        }

        try c.writeAll(
            try allocPrint(
                allocator,
                "{s}(",
                .{func.name},
            ),
        );

        if (func.params) |params| {
            for (params, 0..) |param, i| {
                if (mapping.isPrimitiveOrPointer(param.type) or isFunctionPointer(param.type)) {
                    try c.writeAll(
                        try allocPrint(
                            allocator,
                            "{s}",
                            .{param.name},
                        ),
                    );
                } else {
                    try c.writeAll(
                        try allocPrint(
                            allocator,
                            "*{s}",
                            .{param.name},
                        ),
                    );
                }

                if (i < params.len - 1) {
                    try c.writeAll(", ");
                }
            }
        }

        try c.writeAll(");\n}\n\n");
    }
}

fn writeStructs(
    allocator: std.mem.Allocator,
    file: *fs.File,
    bindings: mapping.Intermediate,
    inject: Injections,
) !void {
    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (bindings.structs) |s| {
        if (inject.containsSymbol(s.name)) continue;
        defer fba.reset();

        try file.writeAll(
            try allocPrint(
                allocator,
                "\n/// {?s}\npub const {s} = extern struct {{\n",
                .{ s.description, s.name },
            ),
        );

        for (s.fields) |field| {
            try file.writeAll(try allocPrint(allocator, "/// {?s}\n\t{s}: {s},\n", .{
                field.description,
                field.name,
                field.typ,
            }));
        }

        try file.writeAll("\n};\n");
    }

    std.log.info("generated structs", .{});
}

fn writeEnums(
    allocator: std.mem.Allocator,
    file: *fs.File,
    bindings: mapping.Intermediate,
    inject: Injections,
) !void {
    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (bindings.enums) |e| {
        if (inject.containsSymbol(e.name)) continue;
        defer fba.reset();

        try file.writeAll(
            try allocPrint(
                allocator,
                "\n/// {?s}\npub const {s} = enum(i32) {{\n",
                .{ e.description, e.name },
            ),
        );

        for (e.values) |value| {
            try file.writeAll(try allocPrint(allocator, "/// {?s}\n{s} = {d},\n", .{
                value.description,
                value.name,
                value.value,
            }));
        }

        try file.writeAll("\n};\n");
    }

    std.log.info("generated enums", .{});
}

fn writeDefines(
    allocator: std.mem.Allocator,
    file: *fs.File,
    bindings: mapping.Intermediate,
    inject: Injections,
) !void {
    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (bindings.defines) |d| {
        if (inject.containsSymbol(d.name)) continue;
        defer fba.reset();

        try file.writeAll(
            try allocPrint(
                allocator,
                "\n/// {?s}\npub const {s}: {s} = {s};\n",
                .{ d.description, d.name, d.typ, d.value },
            ),
        );
    }

    std.log.info("generated defines", .{});
}

fn writeInjections(
    _: std.mem.Allocator,
    file: *fs.File,
    inject: Injections,
) !void {
    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (inject.lines) |line| {
        defer fba.reset();

        try file.writeAll(try allocPrint(fba.allocator(), "{s}\n", .{line}));
    }

    std.log.info("written inject.zig", .{});
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

/// is pointer type
fn isPointer(z: []const u8) bool {
    return pointerOffset(z) > 0;
}

fn isFunctionPointer(z: []const u8) bool {
    return std.mem.indexOf(u8, z, "fn(") != null or std.mem.endsWith(u8, z, "Callback");
}

fn pointerOffset(z: []const u8) usize {
    if (startsWith(z, "*")) return 1;
    if (startsWith(z, "?*")) return 2;
    if (startsWith(z, "[*]")) return 3;
    if (startsWith(z, "?[*]")) return 4;
    if (startsWith(z, "[*c]")) return 4;
    if (startsWith(z, "[*:0]")) return 5;
    if (startsWith(z, "?[*:0]")) return 6;

    return 0;
}

fn isConst(z: []const u8) bool {
    return startsWith(z[pointerOffset(z)..], "const ");
}

fn isVoid(z: []const u8) bool {
    return eql(stripType(z), "void");
}

/// strips const and pointer annotations
/// *const TName -> TName
fn stripType(z: []const u8) []const u8 {
    var name = z[pointerOffset(z)..];
    name = if (startsWith(name, "const ")) name["const ".len..] else name;

    return std.mem.trim(u8, name, " \t\n");
}

/// true if Zig type is primitive or a pointer to anything
/// this means we don't need to wrap it in a pointer
pub fn isPrimitiveOrPointer(z: []const u8) bool {
    const primitiveTypes = std.ComptimeStringMap(void, .{
        // .{ "void", {} }, // zig void is zero sized while C void is >= 1 byte
        .{ "bool", {} },
        .{ "u8", {} },
        .{ "i8", {} },
        .{ "i16", {} },
        .{ "u16", {} },
        .{ "i32", {} },
        .{ "u32", {} },
        .{ "i64", {} },
        .{ "u64", {} },
        .{ "f32", {} },
        .{ "f64", {} },
    });
    return primitiveTypes.has(stripType(z)) or pointerOffset(z) > 0;
}
