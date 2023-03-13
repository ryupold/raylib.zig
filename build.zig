const std = @import("std");
const generate = @import("generate.zig");

pub fn build(b: *std.build.Builder) !void {
    const raylibSrc = "raylib/src/";

    const target = b.standardTargetOptions(.{});

    //--- parse raylib and generate JSONs for all signatures --------------------------------------
    const jsons = b.step("parse", "parse raylib headers and generate raylib jsons");
    const raylib_parser_build = b.addExecutable(.{
        .name = "raylib_parser",
        .root_source_file = std.build.FileSource.relative("raylib_parser.zig"),
        .target = target,
        .optimize = .ReleaseFast,
    });
    raylib_parser_build.addCSourceFile("raylib/parser/raylib_parser.c", &.{});
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
    const intermediateZig = b.addExecutable(.{
        .name = "intermediate",
        .root_source_file = std.build.FileSource.relative("intermediate.zig"),
        .target = target,
    });
    intermediate.dependOn(&intermediateZig.run().step);

    //--- Generate bindings -----------------------------------------------------------------------
    const bindings = b.step("bindings", "generate bindings in from bindings.json");
    const generateZig = b.addExecutable(.{
        .name = "generate",
        .root_source_file = std.build.FileSource.relative("generate.zig"),
        .target = target,
    });
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

const raylib_build = @import("raylib/src/build.zig");

fn linkThisLibrary(b: *std.build.Builder, target: std.zig.CrossTarget, optimize: std.builtin.Mode) *std.build.LibExeObjStep {
    const exe = b.addStaticLibrary(.{ .name = "raylib-zig", .target = target, .optimize = optimize });
    exe.addIncludePath(dir_raylib);
    exe.addIncludePath(cwd);
    exe.linkLibC();
    exe.addCSourceFile(cwd ++ sep ++ "marshal.c", &.{});
    // const lib_raylib = raylib_build.addRaylib(b, target);
    // exe.linkLibrary(lib_raylib);

    return exe;
}

/// add this package to exe
pub fn addTo(b: *std.build.Builder, exe: *std.build.LibExeObjStep, target: std.zig.CrossTarget, optimize: std.builtin.Mode) void {
    exe.addAnonymousModule("raylib", .{ .source_file = .{ .path = cwd ++ sep ++ "raylib.zig" } });
    exe.addIncludePath(dir_raylib);
    exe.addIncludePath(cwd);
    const lib = linkThisLibrary(b, target, optimize);
    const lib_raylib = raylib_build.addRaylib(b, target, optimize);
    exe.linkLibrary(lib_raylib);
    exe.linkLibrary(lib);
}
