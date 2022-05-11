const std = @import("std");
const raylib = @cImport({
    @cDefine("RAYMATH_IMPLEMENTATION", {});
    @cInclude("raylib.h");
    @cInclude("raymath.h");
    @cInclude("marshal.h");
});

//--- structs -------------------------------------------------------------------------------------

/// Transform, vectex transformation data
pub const Transform = extern struct {
    /// Translation
    translation: Vector3,
    /// Rotation
    rotation: Vector4,
    /// Scale
    scale: Vector3,
};

/// Matrix, 4x4 components, column major, OpenGL style, right handed
pub const Matrix = extern struct {
    /// Matrix first row (4 components) [m0, m4, m8, m12]
    m0: f32,
    m4: f32,
    m8: f32,
    m12: f32,
    /// Matrix second row (4 components) [m1, m5, m9, m13]
    m1: f32,
    m5: f32,
    m9: f32,
    m13: f32,
    /// Matrix third row (4 components) [m2, m6, m10, m14]
    m2: f32,
    m6: f32,
    m10: f32,
    m14: f32,
    /// Matrix fourth row (4 components) [m3, m7, m11, m15]
    m3: f32,
    m7: f32,
    m11: f32,
    m15: f32,

    pub fn zero() @This() {
        return @This(){
            .m0 = 0,
            .m1 = 0,
            .m2 = 0,
            .m3 = 0,
            .m4 = 0,
            .m5 = 0,
            .m6 = 0,
            .m7 = 0,
            .m8 = 0,
            .m8 = 0,
            .m9 = 0,
            .m10 = 0,
            .m11 = 0,
            .m12 = 0,
            .m13 = 0,
            .m14 = 0,
            .m15 = 0,
        };
    }

    pub fn identity() @This() {
        return MatrixIdentity();
    }
};

pub const Rectangle = extern struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,

    pub fn toI32(self: @This()) Rectangle {
        return .{
            .x = @floatToInt(i32, self.x),
            .y = @floatToInt(i32, self.y),
            .width = @floatToInt(i32, self.width),
            .height = @floatToInt(i32, self.height),
        };
    }

    pub fn pos(self: @This()) Vector2 {
        return .{
            .x = self.x,
            .y = self.y,
        };
    }
};

pub const RectangleI = extern struct {
    x: i32,
    y: i32,
    width: i32,
    height: i32,

    pub fn toF32(self: @This()) Rectangle {
        return .{
            .x = @intToFloat(f32, self.x),
            .y = @intToFloat(f32, self.y),
            .width = @intToFloat(f32, self.width),
            .height = @intToFloat(f32, self.height),
        };
    }

    pub fn pos(self: @This()) Vector2i {
        return .{
            .x = self.x,
            .y = self.y,
        };
    }
};

pub const Vector2 = extern struct {
    x: f32 = 0,
    y: f32 = 0,

    pub fn zero() @This() {
        return .{ .x = 0, .y = 0 };
    }

    pub fn setZero(self: *@This()) void {
        self.x = 0;
        self.y = 0;
    }

    pub fn one() @This() {
        return @This(){ .x = 1, .y = 1 };
    }

    pub fn neg(self: @This()) @This() {
        return @This(){ .x = -self.x, .y = -self.y };
    }

    pub fn length2(self: @This()) f32 {
        var sum = self.x * self.x;
        sum += self.y * self.y;
        return sum;
    }

    pub fn length(self: @This()) f32 {
        return std.math.sqrt(self.length2());
    }

    pub fn distanceTo(self: @This(), other: @This()) f32 {
        return self.sub(other).length();
    }

    pub fn distanceToSquared(self: @This(), other: @This()) f32 {
        return self.sub(other).length2();
    }

    pub fn normalize(self: @This()) @This() {
        const l = self.length();
        if (l == 0.0) return @This().zero();
        return self.scale(1.0 / l);
    }

    pub fn scale(self: @This(), factor: f32) @This() {
        return @This(){
            .x = self.x * factor,
            .y = self.y * factor,
        };
    }

    pub fn add(self: @This(), other: @This()) @This() {
        return @This(){
            .x = self.x + other.x,
            .y = self.y + other.y,
        };
    }

    pub fn addSet(self: *@This(), other: @This()) void {
        self.x += other.x;
        self.y += other.y;
    }

    pub fn sub(self: @This(), other: @This()) @This() {
        return @This(){
            .x = self.x - other.x,
            .y = self.y - other.y,
        };
    }

    pub fn lerp(self: @This(), other: @This(), t: f32) @This() {
        return self.scale(1 - t).add(other.scale(t));
    }

    pub fn randomInUnitCircle(rng: std.rand.Random) @This() {
        return .{ .x = randomF32(rng, -1, 1), .y = randomF32(rng, -1, 1) };
    }

    pub fn randomOnUnitCircle(rng: std.rand.Random) @This() {
        return randomInUnitCircle(rng).normalize();
    }

    pub fn clampX(self: @This(), minX: f32, maxX: f32) @This() {
        return .{
            .x = std.math.clamp(self.x, minX, maxX),
            .y = self.y,
        };
    }
    pub fn clampY(self: @This(), minY: f32, maxY: f32) @This() {
        return .{
            .x = self.x,
            .y = std.math.clamp(self.y, minY, maxY),
        };
    }

    pub fn int(self: @This()) Vector2i {
        return .{ .x = @floatToInt(i32, self.x), .y = @floatToInt(i32, self.y) };
    }

    pub fn rotate(self: @This(), angle: f32) @This() {
        return Vector2Rotate(self, angle);
    }
};

pub const Vector2i = extern struct {
    x: i32 = 0,
    y: i32 = 0,

    pub fn float(self: @This()) Vector2 {
        return .{ .x = @intToFloat(f32, self.x), .y = @intToFloat(f32, self.y) };
    }
};

pub const Vector3 = extern struct {
    x: f32 = 0,
    y: f32 = 0,
    z: f32 = 0,

    pub fn new(x: f32, y: f32, z: f32) @This() {
        return @This(){ .x = x, .y = y, .z = z };
    }

    pub fn zero() @This() {
        return @This(){ .x = 0, .y = 0, .z = 0 };
    }

    pub fn one() @This() {
        return @This(){ .x = 1, .y = 1, .z = 1 };
    }

    pub fn length2(self: @This()) f32 {
        var sum = self.x * self.x;
        sum += self.y * self.y;
        sum += self.z * self.z;
        return sum;
    }

    pub fn length(self: @This()) f32 {
        return std.math.sqrt(self.length2());
    }

    pub fn normalize(self: @This()) @This() {
        const l = self.length();
        if (l == 0.0) return @This().zero();
        return self.scale(1.0 / l);
    }

    pub fn scale(self: @This(), factor: f32) @This() {
        return @This(){
            .x = self.x * factor,
            .y = self.y * factor,
            .z = self.z * factor,
        };
    }

    pub fn add(self: @This(), other: @This()) @This() {
        return @This(){
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
        };
    }
    pub fn sub(self: @This(), other: @This()) @This() {
        return @This(){
            .x = self.x - other.x,
            .y = self.y - other.y,
            .z = self.z - other.z,
        };
    }

    pub fn lerp(self: @This(), other: @This(), t: f32) @This() {
        return self.scale(1 - t).add(other.scale(t));
    }

    pub fn forward() @This() {
        return @This().new(0, 0, 1);
    }
};

pub const Vector4 = extern struct {
    x: f32 = 0,
    y: f32 = 0,
    z: f32 = 0,
    w: f32 = 0,

    pub fn zero() @This() {
        return @This(){ .x = 0, .y = 0, .z = 0 };
    }

    pub fn one() @This() {
        return @This(){ .x = 1, .y = 1, .z = 1 };
    }

    pub fn length2(self: @This()) f32 {
        var sum = self.x * self.x;
        sum += self.y * self.y;
        sum += self.z * self.z;
        sum += self.w * self.w;
        return sum;
    }

    pub fn length(self: @This()) f32 {
        return std.math.sqrt(self.length2());
    }

    pub fn normalize(self: @This()) @This() {
        const l = self.length();
        if (l == 0.0) return @This().zero();
        return self.scale(1.0 / l);
    }

    pub fn scale(self: @This(), factor: f32) @This() {
        return @This(){
            .x = self.x * factor,
            .y = self.y * factor,
            .z = self.z * factor,
            .w = self.w * factor,
        };
    }

    pub fn add(self: @This(), other: @This()) @This() {
        return @This(){
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
            .w = self.w + other.w,
        };
    }
    pub fn sub(self: @This(), other: @This()) @This() {
        return @This(){
            .x = self.x - other.x,
            .y = self.y - other.y,
            .z = self.z - other.z,
            .w = self.w - other.w,
        };
    }

    pub fn lerp(self: @This(), other: @This(), t: f32) @This() {
        return self.scale(1 - t).add(other.scale(t));
    }

    pub fn toColor(self: @This()) Color {
        return .{
            .r = @floatToInt(u8, std.math.clamp(self.x * 255, 0, 255)),
            .g = @floatToInt(u8, std.math.clamp(self.y * 255, 0, 255)),
            .b = @floatToInt(u8, std.math.clamp(self.z * 255, 0, 255)),
            .a = @floatToInt(u8, std.math.clamp(self.w * 255, 0, 255)),
        };
    }

    pub fn fromAngleAxis(axis: Vector3, angle: f32) @This() {
        return QuaternionFromAxisAngle(axis, angle);
    }
};

/// Color type, RGBA (32bit)
pub const Color = extern struct {
    r: u8 = 0,
    g: u8 = 0,
    b: u8 = 0,
    a: u8 = 255,

    pub fn set(self: @This(), c: struct {
        r: ?u8 = null,
        g: ?u8 = null,
        b: ?u8 = null,
        a: ?u8 = null,
    }) Color {
        return .{
            .r = if (c.r) |_r| _r else self.r,
            .g = if (c.g) |_g| _g else self.g,
            .b = if (c.b) |_b| _b else self.b,
            .a = if (c.a) |_a| _a else self.a,
        };
    }

    pub fn lerp(self: @This(), other: @This(), t: f32) @This() {
        return self.toVector4().lerp(other.toVector4(), t).toColor();
    }

    pub fn toVector4(self: @This()) Vector4 {
        return .{
            .x = @intToFloat(f32, self.r) / 255.0,
            .y = @intToFloat(f32, self.g) / 255.0,
            .z = @intToFloat(f32, self.b) / 255.0,
            .w = @intToFloat(f32, self.a) / 255.0,
        };
    }
};

/// Camera2D, defines position/orientation in 2d space
pub const Camera2D = extern struct {
    /// Camera offset (displacement from target)
    offset: Vector2 = Vector2.zero(),
    /// Camera target (rotation and zoom origin)
    target: Vector2,
    /// Camera rotation in degrees
    rotation: f32 = 0,
    /// Camera zoom (scaling), should be 1.0f by default
    zoom: f32 = 1,
};

pub const MATERIAL_MAP_DIFFUSE = @intCast(usize, @enumToInt(MaterialMapIndex.MATERIAL_MAP_ALBEDO));
pub const MATERIAL_MAP_SPECULAR = @intCast(usize, @enumToInt(MaterialMapIndex.MATERIAL_MAP_METALNESS));

//--- callbacks -----------------------------------------------------------------------------------

/// Logging: Redirect trace log messages
pub const TraceLogCallback = fn (logLevel: c_int, text: [*c]const u8, args: ?*anyopaque) callconv(.C) void;

/// FileIO: Load binary data
pub const LoadFileDataCallback = fn (fileName: [*c]const u8, bytesRead: [*c]c_uint) callconv(.C) [*c]u8;

/// FileIO: Save binary data
pub const SaveFileDataCallback = fn (fileName: [*c]const u8, data: ?*anyopaque, bytesToWrite: c_uint) callconv(.C) bool;

/// FileIO: Load text data
pub const LoadFileTextCallback = fn (fileName: [*c]const u8) callconv(.C) [*c]u8;

/// FileIO: Save text data
pub const SaveFileTextCallback = fn (fileName: [*c]const u8, text: [*c]const u8) callconv(.C) bool;

/// Audio Loading and Playing Functions (Module: audio)
pub const AudioCallback = fn (bufferData: ?*anyopaque, frames: u32) callconv(.C) void;

//--- utils ---------------------------------------------------------------------------------------

pub fn randomF32(rng: std.rand.Random, min: f32, max: f32) f32 {
    return rng.float(f32) * (max - min) + min;
}

//--- functions -----------------------------------------------------------------------------------

/// Setup init configuration flags (view FLAGS)
pub fn SetConfigFlags(
    flags: ConfigFlags,
) void {
    raylib.SetConfigFlags(
        @intCast(u32, @enumToInt(flags)),
    );
}

/// Load file data as byte array (read)
pub fn LoadFileData(fileName: [*:0]const u8) ![]const u8 {
    var bytesRead: u32 = undefined;
    const data = raylib.LoadFileData(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        @ptrCast([*c]u32, &bytesRead),
    );

    if (data == null) return error.FileNotFound;

    return data[0..bytesRead];
}

/// Unload file data allocated by LoadFileData()
pub fn UnloadFileData(
    data: []const u8,
) void {
    raylib.UnloadFileData(
        @intToPtr([*c]u8, @ptrToInt(data.ptr)),
    );
}

/// Load style from file (.rgs)
pub fn LoadGuiStyle(_: [*:0]const u8) u32 {
    @panic("LoadGuiStyle is not implemented");
    //return raylib.LoadGuiStyle(fileName);
}

/// Unload style
pub fn UnloadGuiStyle(_: u32) void {
    @panic("UnloadGuiStyle is not implemented");
    // raylib.UnloadGuiStyle(style);
}

/// Set custom trace log
pub fn SetTraceLogCallback(
    _: TraceLogCallback,
) void {
    @panic("use log.zig for that");
}

/// Text Box control with multiple lines
pub fn GuiTextBoxMulti(_: Rectangle, _: [*]u8, _: i32, _: bool) bool {
    @panic("this gets translated wrong with cImport");
}

/// List View with extended parameters
pub fn GuiListViewEx(
    _: Rectangle,
    _: [*]const [*:0]const u8,
    _: i32,
    _: [*]i32,
    _: [*]i32,
    _: i32,
) i32 {
    @panic("TODO: link with raygui somehow");
}

/// Generate image font atlas using chars info
pub fn GenImageFontAtlas(
    chars: [*]const GlyphInfo,
    recs: [*]const [*]const Rectangle,
    glyphCount: i32,
    fontSize: i32,
    padding: i32,
    packMethod: i32,
) Image {
    var out: Image = undefined;
    mGenImageFontAtlas(
        @ptrCast([*c]raylib.Image, &out),
        @ptrCast([*c]raylib.GlyphInfo, chars),
        @ptrCast([*c][*c]raylib.Rectangle, recs),
        glyphCount,
        fontSize,
        padding,
        packMethod,
    );
    return out;
}
export fn mGenImageFontAtlas(
    out: [*c]raylib.Image,
    chars: [*c]raylib.GlyphInfo,
    recs: [*c][*c]raylib.Rectangle,
    glyphCount: i32,
    fontSize: i32,
    padding: i32,
    packMethod: i32,
) void {
    out.* = raylib.GenImageFontAtlas(
        chars,
        recs,
        glyphCount,
        fontSize,
        padding,
        packMethod,
    );
}

/// Get dropped files names (memory should be freed)
pub fn GetDroppedFiles(
    count: [*]i32,
) [*]const [*]const u8 {
    return @ptrCast(
        [*]u8,
        mGetDroppedFiles(
            @ptrCast([*c]i32, count),
        ),
    );
}
export fn mGetDroppedFiles(
    count: [*c]i32,
) [*c]const [*c]const u8 {
    return raylib.GetDroppedFiles(
        count,
    );
}

/// Get filenames in a directory path (memory should be freed)
pub fn GetDirectoryFiles(
    dirPath: [*:0]const u8,
    count: [*]i32,
) [*]const [*]const u8 {
    return @ptrCast(
        [*]u8,
        mGetDirectoryFiles(
            @ptrCast([*c]u8, dirPath),
            @ptrCast([*c]i32, count),
        ),
    );
}
export fn mGetDirectoryFiles(
    dirPath: [*c]u8,
    count: [*c]i32,
) [*c]const [*c]const u8 {
    return raylib.GetDirectoryFiles(
        dirPath,
        count,
    );
}

/// Get native window handle
pub fn GetWindowHandle() ?*anyopaque {
    return raylib.GetWindowHandle();
}

/// Internal memory allocator
pub fn MemAlloc(
    size: i32,
) ?*anyopaque {
    return raylib.MemAlloc(size);
}

/// Internal memory reallocator
pub fn MemRealloc(
    ptr: ?*anyopaque,
    size: i32,
) ?*anyopaque {
    return raylib.MemRealloc(ptr, size);
}

/// Internal memory free
pub fn MemFree(
    ptr: ?*anyopaque,
) void {
    raylib.MemFree(ptr);
}

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub fn TraceLog(
    logLevel: i32,
    text: [*:0]const u8,
) void {
    raylib.TraceLog(logLevel, text);
}

/// Text formatting with variables (sprintf() style)
/// caller owns memory
pub fn TextFormat(allocator: std.mem.Allocator, comptime fmt: []const u8, args: anytype) std.fmt.AllocPrintError![*:0]const u8 {
    return (try std.fmt.allocPrintZ(allocator, fmt, args)).ptr;
}

/// Split text into multiple strings
pub fn TextSplit(allocator: std.mem.Allocator, text: []const u8, delimiter: []const u8, count: i32) ![]const []const u8 {
    var list = std.ArrayList([]const u8).init(allocator);
    var it = std.mem.split(u8, text, delimiter);
    var i = 0;
    var n = 0;
    while (it.next()) |slice| : (i += 1) {
        if (i >= count) {
            break;
        }

        try list.append(slice);
        n += slice.len;
    }
    if (n < text.len) {
        try list.append(text[n..]);
    }
    return list.toOwnedSlice();
}

/// Join text strings with delimiter
pub fn TextJoin(allocator: std.mem.Allocator, textList: []const []const u8, delimiter: []const u8) ![:0]const u8 {
    return (try std.mem.joinZ(allocator, delimiter, textList)).ptr;
}

/// Append text at specific position and move cursor!
pub fn TextAppend(allocator: std.mem.Allocator, text: []const u8, append: []const u8, position: i32) std.fmt.AllocPrintError![:0]u8 {
    return (try std.fmt.allocPrintZ(allocator, "{s}{s}{s}", .{
        text[0..position],
        append,
        text[position..],
    })).ptr;
}

//--- RAYGUI --------------------------------------------------------------------------------------

pub fn textAlignPixelOffset(h: i32) i32 {
    return h % 2;
}

fn bitCheck(a: u32, b: u32) bool {
    var r: u32 = undefined;
    _ = @shlWithOverflow(u32, 1, @truncate(u5, b), &r);
    return (a & (r)) != 0;
}

/// Draw selected icon using rectangles pixel-by-pixel
pub fn GuiDrawIcon(
    icon: guiIconName,
    posX: i32,
    posY: i32,
    pixelSize: i32,
    color: Color,
) void {
    const iconId = @enumToInt(icon);

    var i: i32 = 0;
    var y: i32 = 0;
    while (i < RICON_SIZE * RICON_SIZE / 32) : (i += 1) {
        var k: u32 = 0;
        while (k < 32) : (k += 1) {
            if (bitCheck(raylib.guiIcons[@intCast(usize, iconId * RICON_DATA_ELEMENTS + i)], k)) {
                _ = DrawRectangle(
                    posX + @intCast(i32, k % RICON_SIZE) * pixelSize,
                    posY + y * pixelSize,
                    pixelSize,
                    pixelSize,
                    color,
                );
            }

            if ((k == 15) or (k == 31)) {
                y += 1;
            }
        }
    }
}

/// Draw button with icon centered
pub fn GuiDrawIconButton(bounds: Rectangle, icon: guiIconName, iconTint: Color) bool {
    const pressed = GuiButton(bounds, "");
    GuiDrawIcon(
        icon,
        @floatToInt(i32, bounds.x + bounds.width / 2 - @intToFloat(f32, RICON_SIZE) / 2),
        @floatToInt(i32, bounds.y + (bounds.height / 2) - @intToFloat(f32, RICON_SIZE) / 2),
        1,
        iconTint,
    );
    return pressed;
}

//--- PHYSAC --------------------------------------------------------------------------------------

/// Returns a physics body of the bodies pool at a specific index
pub fn GetPhysicsBody(
    index: i32,
) ?*PhysicsBodyData {
    return @ptrCast(?*PhysicsBodyData, raylib.GetPhysicsBody(
        index,
    ));
}
