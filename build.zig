const std = @import("std");

const generate = @import("generate.zig");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });

    // Set up "raylib_zig" module for use as a dependency.
    const module = b.addModule("raylib_zig", .{
        .root_source_file = .{.path = "raylib.zig"},
        .target = target,
        .optimize = optimize,
    });
    module.addIncludePath(.{
        .path = try b.build_root.join(b.allocator, &[_][]const u8 {"."})
    });
    module.addIncludePath(raylib.path("src"));
    module.addCSourceFiles(.{
        .files = &[_][]const u8{
            try b.build_root.join(b.allocator, &[_][]const u8 {"marshal.c"}),
        },
        .flags = &.{}
    });
    module.linkLibrary(raylib.artifact("raylib"));
    module.link_libc = true;

    // Set up binding generation library & exes.
    //--- parse raylib and generate JSONs for all signatures --------------------------------------
    const jsons = b.step("parse", "parse raylib headers and generate raylib jsons");
    const raylib_parser_build = b.addExecutable(.{
        .name = "raylib_parser",
        .root_source_file = .{.path = "raylib_parser.zig"},
        .target = target,
        .optimize = optimize,
    });
    raylib_parser_build.addCSourceFile(.{
        .file = raylib.path("parser/raylib_parser.c"),
        .flags = &.{}
    });
    raylib_parser_build.linkLibC();

    //raylib
    const raylib_H = b.addRunArtifact(raylib_parser_build);
    raylib_H.addArgs(&.{
        "-i", raylib.path("src/raylib.h").getPath(b),
        "-o", "raylib.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&raylib_H.step);

    //raymath
    const raymath_H = b.addRunArtifact(raylib_parser_build);
    raymath_H.addArgs(&.{
        "-i", raylib.path("src/raymath.h").getPath(b),
        "-o", "raymath.json",
        "-f", "JSON",
        "-d", "RMAPI",
    });
    jsons.dependOn(&raymath_H.step);

    //rlgl
    const rlgl_H = b.addRunArtifact(raylib_parser_build);
    rlgl_H.addArgs(&.{
        "-i", raylib.path("src/rlgl.h").getPath(b),
        "-o", "rlgl.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&rlgl_H.step);

    //--- Generate intermediate -------------------------------------------------------------------
    const intermediate = b.step("intermediate", "generate intermediate representation of the results from 'zig build parse' (keep custom=true)");
    var intermediateZigStep = b.addRunArtifact(b.addExecutable(.{
        .name = "intermediate",
        .root_source_file = .{.path = "intermediate.zig"},
        .target = target,
    }));
    intermediate.dependOn(&intermediateZigStep.step);

    //--- Generate bindings -----------------------------------------------------------------------
    const bindings = b.step("bindings", "generate bindings in from bindings.json");
    var generateZigStep = b.addRunArtifact(b.addExecutable(.{
        .name = "generate",
        .root_source_file = .{.path = "generate.zig"},
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
