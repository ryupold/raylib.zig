# raylib.zig
Idomatic [raylib](https://www.raylib.com/) bindings for [Zig](https://ziglang.org/)

## supported APIs
- [x] RLAPI (raylib.h)
  - [ ] Color constants
- [x] RMAPI (raymath.h)
- [x] RAYGUIAPI (extras/raygui.h)
- [ ] PHYSACDEF (extras/physac.h)

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