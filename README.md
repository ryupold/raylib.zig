# raylib.zig
Idomatic [raylib](https://www.raylib.com/) bindings for [Zig](https://ziglang.org/)

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