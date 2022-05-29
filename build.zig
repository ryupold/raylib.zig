const std = @import("std");
const generate = @import("generate.zig");

const raylibSrc = "raylib/src/";

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    //--- parse raylib and generate JSONs for all signatures --------------------------------------
    const jsons = b.step("parse", "parse raylib headers and generate raylib jsons");
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
    const rlgl_H = raylib_parser_build.run();
    rlgl_H.addArgs(&.{
        "-i", raylibSrc ++ "rlgl.h",
        "-o", "rlgl.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&rlgl_H.step);
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
    const physac = raylib_parser_build.run();
    physac.addArgs(&.{
        "-i", raylibSrc ++ "extras/physac.h",
        "-o", "physac.json",
        "-f", "JSON",
        "-d", "PHYSACDEF",
    });
    jsons.dependOn(&physac.step);

    //--- Generate intermediate -------------------------------------------------------------------
    const intermediate = b.step("intermediate", "generate intermediate representation of the results from 'zig build parse' (keep custom=true)");
    const intermediateZig = b.addExecutable("intermediate", "intermediate.zig");
    intermediate.dependOn(&intermediateZig.run().step);

    //--- Generate bindings -----------------------------------------------------------------------
    const bindings = b.step("bindings", "generate bindings in from bindings.json");
    const generateZig = b.addExecutable("generate", "generate.zig");
    const fmt = b.addFmt(&.{
        generate.outputFile,
    });
    fmt.step.dependOn(&generateZig.run().step);
    bindings.dependOn(&fmt.step);

    //--- just build raylib_parser.exe ------------------------------------------------------------
    const raylib_parser_install = b.step("raylib_parser", "build ./zig-out/bin/raylib_parser.exe");
    const generateBindings_install = b.addInstallArtifact(raylib_parser_build);
    raylib_parser_install.dependOn(&generateBindings_install.step);
}
