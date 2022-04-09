# raylib.zig
Idomatic [raylib](https://www.raylib.com/) (4.0) bindings for [Zig](https://ziglang.org/) (0.9.1)

## supported APIs
- [x] RLAPI (raylib.h)
- [x] RMAPI (raymath.h)
- [x] RAYGUIAPI (extras/raygui.h)
- [ ] PHYSACDEF (extras/physac.h)
- [ ] Constants
  - [ ] Colors
  - [ ] Versions
  - [ ] GUI dimensions

## usage

The easy way would be adding this as submodule directly in your source folder.
Thats what I do until there is an official package manager for Zig.

```sh
cd $YOUR_SRC_FOLDER
git submodule add --recursive https://github.com/ryupold/raylib.zig raylib
```

Then @import raylib.zig
```zig
const raylib = @import("raylib/raylib.zig");
```

## disclaimer
I haven't tested nearly all generated functions, so there might be bugs. Especially when it comes to pointers as it is not decidable (for the generator) what a pointer to C means. Could be single item, array, sentinel terminated and/or nullable. If you run into crashes using one of the functions or types in `raylib.zig` feel free to [create an issue](https://github.com/ryupold/raylib.zig/issues) and I will look into it.

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
zig build jsons # generate JSON files with raylib_parser
zig build bindings # generate Zig bindings
```

## usage

```zig
const raylib = @import("./raylib.zig");
```

## build raylib_parser (executable)

```sh
zig build raylib_parser
```

you can then find the executable in `./zig-out/bin/`