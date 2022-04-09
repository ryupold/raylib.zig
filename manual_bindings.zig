//! This file contains manual binding definitions for structs & functions.
//! When the generator ecounters one of this function- or struct names, it is skipped.
//! 
//! In these cases it is not decidable for the binding generator how the 
//! function arguments need to be interpreted (e.g.: pointer to one or many elements)

const r = struct {
    usingnamespace @import("structs.zig");
    usingnamespace @import("enums.zig");
};

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub fn TraceLog(
    logLevel: i32,
    text: []const u8,
) void {
    TraceLog(
        @intCast(c_int, logLevel),
        @ptrCast([*c]const u8, text),
    );
}
