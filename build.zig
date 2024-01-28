const std = @import("std");
const builtin = @import("builtin");

const generate = @import("generate.zig");

const emccOutputDir = "zig-out" ++ std.fs.path.sep_str ++ "htmlout" ++ std.fs.path.sep_str;
const emccOutputFile = "index.html";

pub fn setup(app_builder: *std.Build, raylib_zig: *std.Build.Dependency, options: struct {
    name: []const u8,
    src: []const u8,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    custom_entrypoint: ?[]const u8 = null,
    deps: ?[]const std.Build.Module.Import = null,
}) !*std.Build.Step.Compile {
    const this_builder = raylib_zig.builder;
    const raylib = this_builder.dependency("raylib", .{
        .target = options.target,
        .optimize = options.optimize,
    });

    const module = app_builder.createModule(.{
        .root_source_file = .{.path = raylib_zig.path("raylib.zig").getPath(this_builder)},
        .target = options.target,
        .optimize = options.optimize,
    });
    module.addIncludePath(.{
        .path = try this_builder.build_root.join(app_builder.allocator, &.{"."})
    });
    module.addIncludePath(raylib.path("src"));
    module.addCSourceFiles(.{
        .files = &.{
            raylib_zig.path("marshal.c").getPath(this_builder),
        },
        .flags = &.{}
    });
    module.linkLibrary(raylib.artifact("raylib"));
    module.link_libc = true;

    var compile: *std.Build.Step.Compile = undefined;
    switch (options.target.result.os.tag) {
        .emscripten => {
            if (app_builder.sysroot == null) {
                @panic("Pass '--sysroot \"$EMSDK/upstream/emscripten\"'");
            }
            const cache_include = try std.fs.path.join(app_builder.allocator, &.{ app_builder.sysroot.?, "cache", "sysroot", "include" });
            module.addIncludePath(.{ .path = cache_include });

            compile = app_builder.addStaticLibrary(.{
                .name = options.name,
                .root_source_file = .{.path = options.src},
                .target = options.target,
                .optimize = options.optimize,
            });
            // There are some symbols that need to be defined in C.
            // const webhack_c_file_step = b.addWriteFiles();
            // const webhack_c_file = webhack_c_file_step.add("webhack.c", webhack_c);
            // exe_lib.addCSourceFile(.{ .file = webhack_c_file, .flags = &[_][]u8{} });
            // Since it's creating a static library, the symbols raylib uses to webgl
            // and glfw don't need to be linked by emscripten yet.
            // exe_lib.step.dependOn(&webhack_c_file_step.step);
            // const exe_lib = compileForEmscripten(b, ex.name, ex.path, target, optimize);
            compile.root_module.addImport("raylib", module);
            // exe_lib.addModule("raylib-math", raylib_math);
            // const raylib_artifact = getArtifact(b, target, optimize);

            // Note that raylib itself isn't actually added to the exe_lib
            // output file, so it also needs to be linked with emscripten.
            // exe_lib.linkLibrary(raylib_artifact);
            const link_step = try linkWithEmscripten(app_builder, &.{ compile });
            // link_step.addArg("--embed-file");
            // link_step.addArg("resources/");
            app_builder.getInstallStep().dependOn(&link_step.step);

            // const run_step = try emscriptenRunStep(b);
            // run_step.step.dependOn(&link_step.step);
            // const run_option = b.step(ex.name, ex.desc);
            // run_option.dependOn(&run_step.step);
        },
        else => {
            compile = app_builder.addExecutable(.{
                .name = options.name,
                .root_source_file = .{.path = options.src},
                .target = options.target,
                .optimize = options.optimize,
            });
            compile.root_module.addImport("raylib", module);
        }
    }
    return compile;
}

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });

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
    const path_raylib_H = try b.allocator.dupe(u8, raylib.path("src/raylib.h").getPath(b));
    raylib_H.addArgs(&.{
        "-i", path_raylib_H,
        "-o", "raylib.json",
        "-f", "JSON",
        "-d", "RLAPI",
    });
    jsons.dependOn(&raylib_H.step);

    //raymath
    const raymath_H = b.addRunArtifact(raylib_parser_build);
    const path_raymath_H = try b.allocator.dupe(u8, raylib.path("src/raymath.h").getPath(b));
    raymath_H.addArgs(&.{
        "-i", path_raymath_H,
        "-o", "raymath.json",
        "-f", "JSON",
        "-d", "RMAPI",
    });
    jsons.dependOn(&raymath_H.step);

    //rlgl
    const rlgl_H = b.addRunArtifact(raylib_parser_build);
    const path_rlgl_H = try b.allocator.dupe(u8, raylib.path("src/rlgl.h").getPath(b));
    rlgl_H.addArgs(&.{
        "-i", path_rlgl_H,
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

// Links a set of items together using emscripten.
//
// Will accept objects and static libraries as items to link. As for files to
// include, it is recomended to have a single resources directory and just pass
// the entire directory instead of passing every file individually. The entire
// path given will be the path to read the file within the program. So, if
// "resources/image.png" is passed, your program will use "resources/image.png"
// as the path to load the file.
//
// TODO: Test if shared libraries are accepted, I don't remember if emcc can
//       link a shared library with a project or not.
// TODO: Add a parameter that allows a custom output directory.
fn linkWithEmscripten(
    b: *std.Build,
    itemsToLink: []const *std.Build.Step.Compile,
) !*std.Build.Step.Run {
    const emcc_exe = switch (builtin.os.tag) {
        .windows => "emcc.bat",
        else => "emcc",
    };
    const emcc_exe_path = try std.fmt.allocPrint(b.allocator, "{s}" ++ std.fs.path.sep_str ++ "{s}", .{
        b.sysroot.?, emcc_exe
    });

    // Create the output directory because emcc can't do it.
    const mkdir_command = b.addSystemCommand(&.{ "mkdir", "-p", emccOutputDir });

    // Actually link everything together.
    const emcc_command = switch (builtin.os.tag) {
        .windows => b.addSystemCommand(&.{"cmd", "/C", emcc_exe_path}),
        else => b.addSystemCommand(&.{emcc_exe_path}),
    };

    for (itemsToLink) |item| {
        emcc_command.addFileArg(item.getEmittedBin());
        emcc_command.step.dependOn(&item.step);
    }
    // This puts the file in zig-out/htmlout/index.html.
    emcc_command.step.dependOn(&mkdir_command.step);
    emcc_command.addArgs(&[_][]const u8{
        "-o",
        emccOutputDir ++ emccOutputFile,
        "-sFULL-ES3=1",
        "-sUSE_GLFW=3",
        "-sASYNCIFY",
        "-O3",
        "--emrun",
    });
    return emcc_command;
}
