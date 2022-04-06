const std = @import("std");

const raylibSrc = "raylib/src/";

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    //--- Generate bindings -----------------------------------------------------------------------
    const bindings = b.step("bindings", "generate raylib bindings");
    const generateBindings = b.addExecutable("raylib_parser", "raylib_parser.zig");
    generateBindings.addCSourceFile("raylib/parser/raylib_parser.c", &.{});
    generateBindings.setTarget(target);
    generateBindings.setBuildMode(mode);
    generateBindings.linkLibC();

    const raylib_H = generateBindings.run();
    raylib_H.addArgs(&.{
        "-i", raylibSrc++"raylib.h",
        "-o", "raylib.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    bindings.dependOn(&raylib_H.step);
    const raymath_H = generateBindings.run();
    raymath_H.addArgs(&.{
        "-i", raylibSrc++"raymath.h",
        "-o", "raymath.json",
        "-f", "JSON",
        "-d", "RMAPI",
    });
    bindings.dependOn(&raymath_H.step);
    const raygui_H = generateBindings.run();
    raygui_H.addArgs(&.{
        "-i", raylibSrc++"extras/raygui.h",
        "-o", "raygui.json",
        "-f", "JSON",
        "-d", "RAYGUIAPI",
    });
    bindings.dependOn(&raygui_H.step);

    //--- just build raylib_parser.exe ------------------------------------------------------------
    const raylib_parser_install = b.step("raylib_parser", "build ./zig-out/bin/raylib_parser.exe");
    const generateBindings_install = b.addInstallArtifact(generateBindings);
    raylib_parser_install.dependOn(&generateBindings_install.step);
}
