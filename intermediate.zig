const std = @import("std");
const fs = std.fs;
const mapping = @import("type_mapping.zig");
const json = std.json;
const allocPrint = std.fmt.allocPrint;

fn trim(s: []const u8) []const u8 {
    return std.mem.trim(u8, s, &[_]u8{ ' ', '\t', '\n' });
}

/// max files size
const memoryConstrain: usize = 1024 * 1024 * 1024; // 1 GiB
const excludesFile = "excludes.json";
const jsonFiles: []const []const u8 = &.{
    "raylib.json",
    "raymath.json",
    "raygui.json",
};
const bindingsJSON = "bindings.json";

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

    // const excludesData = try fs.cwd().readFileAlloc(allocator, excludesFile, memoryConstrain);
    // defer allocator.free(excludesData);
    // var stream = json.TokenStream.init(excludesData);
    // const excludes = try json.parse(Excludes, &stream, .{
    //     .allocator = allocator,
    //     .ignore_unknown_fields = true,
    // });
    // defer json.parseFree(Excludes, excludes, .{
    //     .allocator = allocator,
    //     .ignore_unknown_fields = true,
    // });

    const raylib: mapping.CombinedRaylib = try mapping.CombinedRaylib.load(arena.allocator(), jsonFiles);
    const customs: mapping.Intermediate = try mapping.Intermediate.loadCustoms(arena.allocator(), bindingsJSON) catch |err| Catch: {
        std.log.warn("could not open {s}: {?}\n", .{ bindingsJSON, err });
        break :Catch mapping.Intermediate{
            .types = &[_]mapping.Type{},
            .functions = &[_]mapping.Function{},
        };
    };

    const bindings = try raylib.toIntermediate(arena.allocator(), customs.types);

    var file = try fs.cwd().createFile(bindingsJSON, .{});
    defer file.close();

    try json.stringify(bindings, .{ .emit_null_optional_fields = false }, file.writer());
}
