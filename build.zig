const std = @import("std");
const generate = @import("generate.zig");

pub fn build(b: *std.build.Builder) !void {
    const raylibSrc = "raylib/src/";
    
    const target = b.standardTargetOptions(.{});

    //--- parse raylib and generate JSONs for all signatures --------------------------------------
    const jsons = b.step("parse", "parse raylib headers and generate raylib jsons");
    const raylib_parser_build = b.addExecutable("raylib_parser", "raylib_parser.zig");
    raylib_parser_build.addCSourceFile("raylib/parser/raylib_parser.c", &.{});
    raylib_parser_build.setTarget(target);
    raylib_parser_build.setBuildMode(.ReleaseFast);
    raylib_parser_build.linkLibC();

    //raylib
    const raylib_H = raylib_parser_build.run();
    raylib_H.addArgs(&.{
        "-i", raylibSrc ++ "raylib.h",
        "-o", "raylib.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&raylib_H.step);
    
    //raymath
    const raymath_H = raylib_parser_build.run();
    raymath_H.addArgs(&.{
        "-i", raylibSrc ++ "raymath.h",
        "-o", "raymath.json",
        "-f", "JSON",
        "-d", "RMAPI",
    });
    jsons.dependOn(&raymath_H.step);
    
    //rlgl
    const rlgl_H = raylib_parser_build.run();
    rlgl_H.addArgs(&.{
        "-i", raylibSrc ++ "rlgl.h",
        "-o", "rlgl.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&rlgl_H.step);

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

// above: generate library
// below: linking (use as dependency)

fn current_file() []const u8 {
    return @src().file;
}

const cwd = std.fs.path.dirname(current_file()).?;
const sep = std.fs.path.sep_str;
const dir_raylib = cwd ++ sep ++ "raylib/src";

pub fn library(b: *std.build.Builder) *std.build.LibExeObjStep {
    const exe = b.addStaticLibrary("raylib-zig", null);
    exe.addIncludePath(dir_raylib);
    exe.addIncludePath(cwd);
    exe.linkLibC();
    exe.addCSourceFile(cwd ++ sep ++ "marshal.c", &.{});
    exe.addObjectFile(dir_raylib ++ sep ++ "libraylib.a");
    
    const cmd_make = b.addSystemCommand(&.{"make"});
    cmd_make.cwd = dir_raylib;
    cmd_make.expected_exit_code = 0;
    exe.step.dependOn(&cmd_make.step);

    return exe;
}

pub fn link(b: *std.build.Builder, exe: *std.build.LibExeObjStep) void {
    exe.addPackagePath("raylib", cwd ++ sep ++ "raylib.zig");
    exe.addIncludePath(dir_raylib);
    exe.addIncludePath(cwd);
    const lib = library(b);
    exe.linkLibrary(lib);
}
