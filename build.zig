const std = @import("std");
const generate = @import("generate.zig");

pub fn build(b: *std.Build) !void {
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
    raylib_parser_build.addCSourceFile(.{ .file = .{ .path = "raylib/parser/raylib_parser.c" }, .flags = &.{} });
    raylib_parser_build.linkLibC();

    //raylib
    const raylib_H = b.addRunArtifact(raylib_parser_build);
    raylib_H.addArgs(&.{
        "-i", raylibSrc ++ "raylib.h",
        "-o", "raylib.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&raylib_H.step);

    //raymath
    const raymath_H = b.addRunArtifact(raylib_parser_build);
    raymath_H.addArgs(&.{
        "-i", raylibSrc ++ "raymath.h",
        "-o", "raymath.json",
        "-f", "JSON",
        "-d", "RMAPI",
    });
    jsons.dependOn(&raymath_H.step);

    //rlgl
    const rlgl_H = b.addRunArtifact(raylib_parser_build);
    rlgl_H.addArgs(&.{
        "-i", raylibSrc ++ "rlgl.h",
        "-o", "rlgl.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&rlgl_H.step);

    //--- Generate intermediate -------------------------------------------------------------------
    const intermediate = b.step("intermediate", "generate intermediate representation of the results from 'zig build parse' (keep custom=true)");
    var intermediateZigStep = b.addRunArtifact(b.addExecutable(.{
        .name = "intermediate",
        .root_source_file = std.build.FileSource.relative("intermediate.zig"),
        .target = target,
    }));
    intermediate.dependOn(&intermediateZigStep.step);

    //--- Generate bindings -----------------------------------------------------------------------
    const bindings = b.step("bindings", "generate bindings in from bindings.json");
    var generateZigStep = b.addRunArtifact(b.addExecutable(.{
        .name = "generate",
        .root_source_file = std.build.FileSource.relative("generate.zig"),
        .target = target,
    }));
    const fmt = b.addFmt(.{ .paths = &.{generate.outputFile} });
    fmt.step.dependOn(&generateZigStep.step);
    bindings.dependOn(&fmt.step);

    //--- just build raylib_parser.exe ------------------------------------------------------------
    const raylib_parser_install = b.step("raylib_parser", "build ./zig-out/bin/raylib_parser.exe");
    const generateBindings_install = b.addInstallArtifact(raylib_parser_build, .{});
    raylib_parser_install.dependOn(&generateBindings_install.step);
}

// above: generate library
// below: linking (use as dependency)

fn current_file() []const u8 {
    return @src().file;
}

const sep = std.fs.path.sep_str;
const cwd = std.fs.path.dirname(current_file()).?;
const dir_raylib = cwd ++ sep ++ "raylib" ++ sep ++ "src";

const raylib_build = @import("raylib/src/build.zig");

fn linkThisLibrary(b: *std.Build, target: std.Target.Query, optimize: std.builtin.Mode) *std.Build.Step.Compile {
    const lib = b.addStaticLibrary(.{ .name = "raylib.zig", .target = b.resolveTargetQuery(target), .optimize = optimize });
    lib.addIncludePath(.{ .path = dir_raylib });
    lib.addIncludePath(.{ .path = cwd });
    lib.linkLibC();
    lib.addCSourceFile(.{ .file = .{ .path = cwd ++ sep ++ "marshal.c" }, .flags = &.{} });
    std.log.info("include '{s}' to {s}", .{ dir_raylib, lib.name });
    std.log.info("include '{s}' to {s}", .{ cwd, lib.name });
    return lib;
}

/// add this package to exe
pub fn addTo(b: *std.Build, exe: *std.Build.Step.Compile, target: std.Target.Query, optimize: std.builtin.Mode, raylibOptions: raylib_build.Options) void {
    exe.root_module.addAnonymousImport("raylib", .{ .root_source_file = .{ .path = cwd ++ sep ++ "raylib.zig" } });
    std.log.info("include '{s}' to {s}", .{ dir_raylib, exe.name });
    std.log.info("include '{s}' to {s}", .{ cwd, exe.name });
    exe.addIncludePath(.{ .path = dir_raylib });
    exe.addIncludePath(.{ .path = cwd });
    const lib = linkThisLibrary(b, target, optimize);
    const lib_raylib = raylib_build.addRaylib(b, b.resolveTargetQuery(target), optimize, raylibOptions) catch |err| std.debug.panic("addRaylib: {any}", .{err});
    exe.linkLibrary(lib_raylib);
    exe.linkLibrary(lib);
    std.log.info("linked raylib.zig", .{});
}

pub fn linkSystemDependencies(exe: *std.build.Step.Compile) void {
    switch (exe.target.getOsTag()) {
        .macos => {
            exe.linkFramework("Foundation");
            exe.linkFramework("Cocoa");
            exe.linkFramework("OpenGL");
            exe.linkFramework("CoreAudio");
            exe.linkFramework("CoreVideo");
            exe.linkFramework("IOKit");
        },
        .linux => {
            exe.addLibraryPath(.{ .path = "/usr/lib" });
            exe.addIncludePath(.{ .path = "/usr/include" });
            exe.linkSystemLibrary("GL");
            exe.linkSystemLibrary("rt");
            exe.linkSystemLibrary("dl");
            exe.linkSystemLibrary("m");
            exe.linkSystemLibrary("X11");
        },
        .freebsd, .openbsd, .netbsd, .dragonfly => {
            exe.linkSystemLibrary("GL");
            exe.linkSystemLibrary("rt");
            exe.linkSystemLibrary("dl");
            exe.linkSystemLibrary("m");
            exe.linkSystemLibrary("X11");
            exe.linkSystemLibrary("Xrandr");
            exe.linkSystemLibrary("Xinerama");
            exe.linkSystemLibrary("Xi");
            exe.linkSystemLibrary("Xxf86vm");
            exe.linkSystemLibrary("Xcursor");
        },
        else => {},
    }

    exe.linkLibC();
}
