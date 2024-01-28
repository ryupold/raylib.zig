![logo](logo.png)

# raylib.zig
Idiomatic [raylib](https://www.raylib.com/) (5.1-dev) bindings for [Zig](https://ziglang.org/) (master).

[Example Usage](#usage)

Additional infos and WebGL examples [here](https://github.com/ryupold/examples-raylib.zig).

## supported platforms
- Windows
- macOS
- Linux
- HTML5/WebGL (emscripten)

## supported APIs
- [x] RLAPI (raylib.h)
- [x] RLAPI (rlgl.h)
- [x] RMAPI (raymath.h)
- [x] Constants
  - [x] int, float, string
  - [x] Colors
  - [x] Versions

For [raygui](https://github.com/raysan5/raygui) bindings see: https://github.com/ryupold/raygui.zig

## <a id="usage">usage</a>

Add this as a dependency to your `build.zig.zon`
```zig
.{
    .name = "example",
    .version = "1.0.0",
    .paths = ...,
    .dependencies = .{
        .raylib_zig = .{
            .url = "https://github.com/ryupold/raylib.zig/archive/<commit>.tar.gz",
            .hash = "<hash>",
        },
    },
}
```

Then add the following setup to your `build.zig`:
```zig
const std = @import("std");

const raylib_zig_build = @import("raylib_zig");

pub fn build(b: *std.Build) !void
{
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_zig = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
    });
    const compile = try raylib_zig_build.setup(b, raylib_zig, .{
        .name = "example",
        .src = "src/main.zig",
        .target = target,
        .optimize = optimize,
        .createRunStep = true,
    });
    b.installArtifact(compile);
}
```

and import in main.zig:
```zig
const raylib = @import("raylib");

pub fn main() void {
    raylib.SetConfigFlags(raylib.ConfigFlags{ .FLAG_WINDOW_RESIZABLE = true });
    raylib.InitWindow(800, 800, "hello world!");
    raylib.SetTargetFPS(60);

    defer raylib.CloseWindow();

    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();
        defer raylib.EndDrawing();

        raylib.ClearBackground(raylib.BLACK);
        raylib.DrawFPS(10, 10);

        raylib.DrawText("hello world!", 100, 100, 20, raylib.YELLOW);
    }
}
```

### WASM / emscripten builds

Download and install the [emscripten SDK](https://emscripten.org/docs/getting_started/downloads.html), and then add the flags `-Dtarget=wasm32-emscripten` and `--sysroot <emscripten-sdk-path>/upstream/emscripten` to the zig build.

## custom definitions
An easy way to fix binding mistakes is to edit them in `bindings.json` and setting the custom flag to true. This way the binding will not be overriden when calling `zig build intermediate`. 
Additionally you can add custom definitions into `inject.zig, inject.h, inject.c` these files will be prepended accordingly.

## disclaimer
I have NOT tested most of the generated functions, so there might be bugs. Especially when it comes to pointers as it is not decidable (for the generator) what a pointer to C means. Could be single item, array, sentinel terminated and/or nullable. If you run into crashes using one of the functions or types in `raylib.zig` feel free to [create an issue](https://github.com/ryupold/raylib.zig/issues) and I will look into it.

## memory
Some of the functions may return pointers to memory allocated within raylib.
Usually there will be a corresponding Unload/Free function to dispose it. You cannot use a Zig allocator to free that:

```zig
const data = LoadFileData("test.png");
defer UnloadFileData(data);

// using data...
```

## generate bindings 
for current raylib source (submodule)

```sh
zig build parse # create JSON files with raylib_parser
zig build intermediate # generate bindings.json (keeps definitions with custom=true)
zig build bindings # write all intermediate bindings to raylib.zig
```

For easier diffing and to follow changes to the raylib repository I commit also the generated json files.

## build raylib_parser (executable)
If you want to build the raylib_parser executable without a C compiler.
```sh
zig build raylib_parser
```

you can then find the executable in `./zig-out/bin/`
