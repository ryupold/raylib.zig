//! run 'zig build jsons' to generate bindings for raylib
//! run 'zig build raylib_parser' to build the raylib_parser.exe

/// this needs to be here so the zig compiler won't complain that there is no entry point
/// but actually we are using main() of 'raylib/src/parser/raylib_parser.c'
pub extern fn main() c_int;
