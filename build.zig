const std = @import("std");

const raylibSrc = "raylib/src/";

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    //--- parse raylib and generate JSONs for all signatures --------------------------------------
    const jsons = b.step("jsons", "generate raylib jsons");
    const raylib_parser_build = b.addExecutable("raylib_parser", "raylib_parser.zig");
    raylib_parser_build.addCSourceFile("raylib/parser/raylib_parser.c", &.{});
    raylib_parser_build.setTarget(target);
    raylib_parser_build.setBuildMode(mode);
    raylib_parser_build.linkLibC();

    const raylib_H = raylib_parser_build.run();
    raylib_H.addArgs(&.{
        "-i", raylibSrc ++ "raylib.h",
        "-o", "raylib.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&raylib_H.step);
    const raymath_H = raylib_parser_build.run();
    raymath_H.addArgs(&.{
        "-i", raylibSrc ++ "raymath.h",
        "-o", "raymath.json",
        "-f", "JSON",
        "-d", "RMAPI",
    });
    jsons.dependOn(&raymath_H.step);
    const raygui_H = raylib_parser_build.run();
    raygui_H.addArgs(&.{
        "-i", raylibSrc ++ "extras/raygui.h",
        "-o", "raygui.json",
        "-f", "JSON",
        "-d", "RAYGUIAPI",
    });
    jsons.dependOn(&raygui_H.step);

    //--- Generate bindings -----------------------------------------------------------------------
    const bindings = b.step("bindings", "generate raylib zig bindings");
    const generateZig = b.addExecutable("generate", "generate.zig");
    const fmt = b.addFmt(&.{
        "structs.zig",
        "enums.zig",
        // "functions.zig",
    });
    fmt.step.dependOn(&generateZig.run().step);
    // bindings.dependOn(&generateZig.run().step);
    bindings.dependOn(&fmt.step);

    //--- just build raylib_parser.exe ------------------------------------------------------------
    const raylib_parser_install = b.step("raylib_parser", "build ./zig-out/bin/raylib_parser.exe");
    const generateBindings_install = b.addInstallArtifact(raylib_parser_build);
    raylib_parser_install.dependOn(&generateBindings_install.step);
}
