const std = @import("std");
const generate = @import("generate.zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_raylib = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });

    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = general_purpose_allocator.deinit();

    const gpa = general_purpose_allocator.allocator();

    const raylib_dir = lib_raylib.builder.build_root.path.?;
    const raylib_src = try std.fs.path.join(gpa, &.{ raylib_dir, "src" });
    defer gpa.free(raylib_src);

    //--- parse raylib and generate JSONs for all signatures --------------------------------------
    const jsons = b.step("parse", "parse raylib headers and generate raylib jsons");
    const raylib_parser_build = b.addExecutable(.{
        .name = "raylib_parser",
        .root_source_file = std.build.FileSource.relative("raylib_parser.zig"),
        .target = target,
        .optimize = .ReleaseFast,
    });

    const raylib_parser_c_path = try std.fs.path.join(gpa, &.{ raylib_dir, "parser", "raylib_parser.c" });
    defer gpa.free(raylib_parser_c_path);

    raylib_parser_build.addCSourceFile(raylib_parser_c_path, &.{});
    raylib_parser_build.linkLibC();

    //raylib
    const raylib_h_path = try std.fs.path.join(gpa, &.{ raylib_src, "raylib.h" });
    defer gpa.free(raylib_h_path);

    const raylib_H = b.addRunArtifact(raylib_parser_build);
    raylib_H.addArgs(&.{
        "-i", raylib_h_path,
        "-o", "raylib.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&raylib_H.step);

    //raymath
    const raymath_h_path = try std.fs.path.join(gpa, &.{ raylib_src, "raymath.h" });
    defer gpa.free(raymath_h_path);

    const raymath_H = b.addRunArtifact(raylib_parser_build);
    raymath_H.addArgs(&.{
        "-i", raymath_h_path,
        "-o", "raymath.json",
        "-f", "JSON",
        "-d", "RMAPI",
    });
    jsons.dependOn(&raymath_H.step);

    //rlgl
    const rlgl_h_path = try std.fs.path.join(gpa, &.{ raylib_src, "rlgl.h" });
    defer gpa.free(rlgl_h_path);

    const rlgl_H = b.addRunArtifact(raylib_parser_build);
    rlgl_H.addArgs(&.{
        "-i", rlgl_h_path,
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
    const generateBindings_install = b.addInstallArtifact(raylib_parser_build);
    raylib_parser_install.dependOn(&generateBindings_install.step);

    b.installArtifact(lib_raylib.artifact("raylib"));
}

// above: generate library
// below: linking (use as dependency)

fn current_file() []const u8 {
    return @src().file;
}

const cwd = std.fs.path.dirname(current_file()).?;
const sep = std.fs.path.sep_str;
const dir_raylib = cwd ++ sep ++ "raylib/src";

fn linkThisLibrary(b: *std.Build, target: std.zig.CrossTarget, optimize: std.builtin.Mode) *std.build.LibExeObjStep {
    const exe = b.addStaticLibrary(.{ .name = "raylib-zig", .target = target, .optimize = optimize });
    exe.addIncludePath(dir_raylib);
    exe.addIncludePath(cwd);
    exe.linkLibC();
    exe.addCSourceFile(cwd ++ sep ++ "marshal.c", &.{});

    return exe;
}

/// add this package to exe
pub fn addTo(b: *std.Build, exe: *std.build.LibExeObjStep, target: std.zig.CrossTarget, optimize: std.builtin.Mode) void {
    const lib_raylib = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });

    exe.addAnonymousModule("raylib", .{ .source_file = .{ .path = cwd ++ sep ++ "raylib.zig" } });
    exe.addIncludePath(dir_raylib);
    exe.addIncludePath(cwd);
    const lib = linkThisLibrary(b, target, optimize);
    exe.linkLibrary(lib_raylib.artifact("raylib"));
    exe.linkLibrary(lib);
}
