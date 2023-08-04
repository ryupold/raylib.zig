const std = @import("std");
const fs = std.fs;
const mapping = @import("type_mapping.zig");
const json = std.json;

pub const jsonFiles: []const []const u8 = &.{
    "raylib.json",
    "rlgl.json",
    "raymath.json",
};
pub const bindingsJSON = "bindings.json";

pub fn main() !void {
    std.log.info("updating bindings.json ...", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        if (gpa.deinit() == .leak) {
            std.log.err("memory leak detected", .{});
        }
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const raylib: mapping.CombinedRaylib = try mapping.CombinedRaylib.load(arena.allocator(), jsonFiles);

    var bindings: mapping.Intermediate = mapping.Intermediate.loadCustoms(arena.allocator(), bindingsJSON) catch |err| Catch: {
        std.log.warn("could not open {s}: {?}\n", .{ bindingsJSON, err });
        break :Catch mapping.Intermediate{
            .enums = &[_]mapping.Enum{},
            .structs = &[_]mapping.Struct{},
            .functions = &[_]mapping.Function{},
            .defines = &[_]mapping.Define{},
        };
    };

    try bindings.addNonCustom(arena.allocator(), raylib);

    var file = try fs.cwd().createFile(bindingsJSON, .{});
    defer file.close();

    try json.stringify(bindings, .{
        .emit_null_optional_fields = false,
        .whitespace = .indent_2,
    }, file.writer());

    std.log.info("... done", .{});
}
