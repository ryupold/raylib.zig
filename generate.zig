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
        if (gpa.deinit()) {
            std.log.err("memory leak detected", .{});
        }
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const bindingsData = try fs.cwd().readFileAlloc(allocator, intermediate.bindingsJSON, std.math.maxInt(usize));
    defer allocator.free(bindingsData);
    var stream = json.TokenStream.init(bindingsData);
    const bindings = try json.parse(mapping.Intermediate, &stream, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });
    defer json.parseFree(mapping.Intermediate, bindings, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });

    var file = try fs.cwd().createFile(outputFile, .{});
    defer file.close();

    try file.writeAll("\n\n");

    const inject = try Injections.load(arena.allocator());
    try writeImports(arena.allocator(), &file, bindings);
    try writeFunctions(arena.allocator(), &file, bindings, inject);
    try writeStructs(arena.allocator(), &file, bindings, inject);
    try writeEnums(arena.allocator(), &file, bindings, inject);
    try writeInjections(arena.allocator(), &file, inject);

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
                }
            }
            try injectZigLines.append(line);
        }

        return @This(){
            .lines = injectZigLines.toOwnedSlice(),
            .symbols = symbols.toOwnedSlice(),
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
        try file.writeAll(
            try allocPrint(
                allocator,
                "\n/// {s}\npub fn {s} (\n",
                .{ func.description, func.name },
            ),
        );

        for (func.params) |param| {
            try file.writeAll(try allocPrint(
                allocator,
                //TODO: add description
                "{s}: {s},\n",
                .{ param.name, param.typ },
            ));
        }

        try file.writeAll(
            try allocPrint(
                allocator,
                ") {s} {{\n",
                .{func.returnType},
            ),
        );
        const returnTypeIsVoid = eql(func.returnType, "void");

        //--- body ------------------------------
        if (!returnTypeIsVoid) {
            try file.writeAll(try allocPrint(allocator, "var out: {s} = undefined;\n", .{func.returnType}));
        }
        try file.writeAll(try allocPrint(allocator, "m{s}(\n", .{func.name}));

        if (!returnTypeIsVoid) {
            if (bindings.containsStruct(mapping.stripType(func.returnType))) {
                try file.writeAll(try allocPrint(allocator, "@ptrCast([*c]raylib.{s}, &out),\n", .{func.returnType}));
            } else {
                try file.writeAll(try allocPrint(allocator, "@ptrCast([*c]{s}, &out),\n", .{func.returnType}));
            }
        }

        for (func.params) |param| {
            if (bindings.containsStruct(mapping.stripType(param.typ))) {
                try file.writeAll(try allocPrint(allocator, "@ptrCast([*c]raylib.{s}, &{s}),\n", .{ param.typ, param.name }));
            } else {
                try file.writeAll(try allocPrint(allocator, "{s},\n", .{param.name}));
            }
        }

        try file.writeAll(");\n");

        if (!returnTypeIsVoid) {
            try file.writeAll("return out;\n");
        }

        try file.writeAll("}\n");

        //--- C-ABI -----------------------------

        try file.writeAll(
            try allocPrint(
                allocator,
                "\nexport fn m{s} (\n",
                .{func.name},
            ),
        );

        if (!returnTypeIsVoid) {
            if (bindings.containsStruct(mapping.stripType(func.returnType))) {
                try file.writeAll(try allocPrint(allocator, "out: [*c]raylib.{s},\n", .{func.returnType}));
            } else {
                try file.writeAll(try allocPrint(allocator, "out: [*c]{s},\n", .{func.returnType}));
            }
        }

        for (func.params) |param| {
            var typ = if (mapping.isPointer(param.typ))
                try allocPrint(allocator, "[*c]{s}", .{mapping.stripType(param.typ)})
            else
                param.typ;

            if (bindings.containsStruct(mapping.stripType(param.typ))) {
                typ = try allocPrint(allocator, "[*c]raylib.{s}", .{mapping.stripType(param.typ)});
            }

            try file.writeAll(try allocPrint(
                allocator,
                "{s}: {s},\n",
                .{ param.name, typ },
            ));
        }

        try file.writeAll(
            try allocPrint(
                allocator,
                ") void {{\n",
                .{},
            ),
        );

        if (!returnTypeIsVoid) {
            try file.writeAll("out.* = ");
        }

        try file.writeAll(
            try allocPrint(
                allocator,
                "raylib.{s}(\n",
                .{func.name},
            ),
        );

        for (func.params) |param| {
            if (bindings.containsStruct(mapping.stripType(param.typ))) {
                try file.writeAll(try allocPrint(
                    allocator,
                    "{s}.*,\n",
                    .{param.name},
                ));
            } else {
                try file.writeAll(try allocPrint(
                    allocator,
                    "{s},\n",
                    .{param.name},
                ));
            }
        }

        try file.writeAll(");\n}\n");
    }

    std.log.info("generated functions", .{});
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
                "\n/// {s}\npub const {s} = extern struct {{\n",
                .{ s.description, s.name },
            ),
        );

        for (s.fields) |field| {
            try file.writeAll(try allocPrint(allocator, "/// {s}\n\t{s}: {s},\n", .{
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
                "\n/// {s}\npub const {s} = enum(i32) {{\n",
                .{ e.description, e.name },
            ),
        );

        for (e.values) |value| {
            try file.writeAll(try allocPrint(allocator, "/// {s}\n{s} = {d},\n", .{
                value.description,
                value.name,
                value.value,
            }));
        }

        try file.writeAll("\n};\n");
    }

    std.log.info("generated enums", .{});
}

fn writeImports(
    _: std.mem.Allocator,
    file: *fs.File,
    bindings: mapping.Intermediate,
) !void {
    var buf: [51200]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);

    for (bindings.imports) |import| {
        defer fba.reset();

        try file.writeAll(try allocPrint(fba.allocator(), "{s}\n", .{import}));
    }

    try file.writeAll("\n");

    std.log.info("appended inject.zig", .{});
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

    std.log.info("appended inject.zig", .{});
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
