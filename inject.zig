const std = @import("std");
const raylib = @cImport({
    @cInclude("raylib.h");

    @cDefine("GRAPHICS_API_OPENGL_11", {});
    // @cDefine("RLGL_IMPLEMENTATION", {});
    @cInclude("rlgl.h");

    @cDefine("RAYMATH_IMPLEMENTATION", {});
    @cInclude("raymath.h");

    @cInclude("marshal.h");
});

//--- structs -------------------------------------------------------------------------------------

/// System/Window config flags
pub const ConfigFlags = packed struct(u32) {
    FLAG_UNKNOWN_1: bool = false, // 0x0001
    /// Set to run program in fullscreen
    FLAG_FULLSCREEN_MODE: bool = false, // 0x0002,
    /// Set to allow resizable window
    FLAG_WINDOW_RESIZABLE: bool = false, // 0x0004,
    /// Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_UNDECORATED: bool = false, // 0x0008,
    /// Set to allow transparent framebuffer
    FLAG_WINDOW_TRANSPARENT: bool = false, // 0x0010,
    /// Set to try enabling MSAA 4X
    FLAG_MSAA_4X_HINT: bool = false, // 0x0020,
    /// Set to try enabling V-Sync on GPU
    FLAG_VSYNC_HINT: bool = false, // 0x0040,
    /// Set to hide window
    FLAG_WINDOW_HIDDEN: bool = false, // 0x0080,
    /// Set to allow windows running while minimized
    FLAG_WINDOW_ALWAYS_RUN: bool = false, // 0x0100,
    /// Set to minimize window (iconify)
    FLAG_WINDOW_MINIMIZED: bool = false, // 0x0200,
    /// Set to maximize window (expanded to monitor)
    FLAG_WINDOW_MAXIMIZED: bool = false, // 0x0400,
    /// Set to window non focused
    FLAG_WINDOW_UNFOCUSED: bool = false, // 0x0800,
    /// Set to window always on top
    FLAG_WINDOW_TOPMOST: bool = false, // 0x1000,
    /// Set to support HighDPI
    FLAG_WINDOW_HIGHDPI: bool = false, // 0x2000,
    /// Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    FLAG_WINDOW_MOUSE_PASSTHROUGH: bool = false, // 0x4000,
    FLAG_UNKNOWN_2: bool = false, // 0x8000
    /// Set to try enabling interlaced video format (for V3D)
    FLAG_INTERLACED_HINT: bool = false, // 0x10000
    FLAG_PADDING: u15 = 0, // 0xFFFE0000
};

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
    x: f32 = 0,
    y: f32 = 0,
    width: f32 = 0,
    height: f32 = 0,

    pub fn toI32(self: @This()) RectangleI {
        return .{
            .x = @as(i32, @intFromFloat(self.x)),
            .y = @as(i32, @intFromFloat(self.y)),
            .width = @as(i32, @intFromFloat(self.width)),
            .height = @as(i32, @intFromFloat(self.height)),
        };
    }

    pub fn pos(self: @This()) Vector2 {
        return .{
            .x = self.x,
            .y = self.y,
        };
    }

    pub fn size(self: @This()) Vector2 {
        return .{
            .x = self.width,
            .y = self.height,
        };
    }

    pub fn topLeft(self: @This()) Vector2 {
        return .{
            .x = self.x,
            .y = self.y,
        };
    }

    pub fn topCenter(self: @This()) Vector2 {
        return .{
            .x = self.x + self.width / 2,
            .y = self.y,
        };
    }

    pub fn topRight(self: @This()) Vector2 {
        return .{
            .x = self.x + self.width,
            .y = self.y,
        };
    }

    pub fn centerLeft(self: @This()) Vector2 {
        return .{
            .x = self.x,
            .y = self.y + self.height / 2,
        };
    }

    pub fn center(self: @This()) Vector2 {
        return .{
            .x = self.x + self.width / 2,
            .y = self.y + self.height / 2,
        };
    }

    pub fn centerRight(self: @This()) Vector2 {
        return .{
            .x = self.x + self.width,
            .y = self.y + self.height / 2,
        };
    }

    pub fn bottomLeft(self: @This()) Vector2 {
        return .{
            .x = self.x + 0,
            .y = self.y + self.height,
        };
    }

    pub fn bottomCenter(self: @This()) Vector2 {
        return .{
            .x = self.x + self.width / 2,
            .y = self.y + self.height,
        };
    }

    pub fn bottomRight(self: @This()) Vector2 {
        return .{
            .x = self.x + self.width,
            .y = self.y + self.height,
        };
    }

    pub fn area(self: @This()) f32 {
        return self.width * self.height;
    }

    pub fn include(self: @This(), other: @This()) @This() {
        return self.includePoint(other.topLeft()).includePoint(other.bottomRight());
    }

    pub fn includePoint(self: @This(), point: Vector2) @This() {
        const minX = @min(self.x, point.x);
        const minY = @min(self.y, point.y);
        const maxX = @max(self.x + self.width, point.x);
        const maxY = @max(self.y + self.height, point.y);

        return .{
            .x = minX,
            .y = minY,
            .width = maxX - minX,
            .height = maxY - minY,
        };
    }
};

pub const RectangleI = extern struct {
    x: i32 = 0,
    y: i32 = 0,
    width: i32 = 0,
    height: i32 = 0,

    pub fn toF32(self: @This()) Rectangle {
        return .{
            .x = @as(f32, @floatFromInt(self.x)),
            .y = @as(f32, @floatFromInt(self.y)),
            .width = @as(f32, @floatFromInt(self.width)),
            .height = @as(f32, @floatFromInt(self.height)),
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

    /// same as add but assign result directly to this
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
        return randomOnUnitCircle(rng).scale(randomF32(rng, 0, 1));
    }

    pub fn randomOnUnitCircle(rng: std.rand.Random) @This() {
        return (Vector2{ .x = 1 }).rotate(randomF32(rng, -PI, PI));
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
        return .{ .x = @as(i32, @intFromFloat(self.x)), .y = @as(i32, @intFromFloat(self.y)) };
    }

    /// Cross product
    pub fn cross(self: @This(), other: @This()) f32 {
        return self.x * other.y - self.y * other.x;
    }

    /// Dot product.
    pub fn dot(self: @This(), other: @This()) f32 {
        return self.x * other.x + self.y * other.y;
    }

    pub fn rotate(self: @This(), a: f32) @This() {
        return Vector2Rotate(self, a);
    }

    pub fn fromAngle(a: f32) @This() {
        return Vector2Rotate(.{ .x = 1 }, a);
    }

    pub fn angle(this: @This()) f32 {
        const zeroRotation: Vector2 = .{ .x = 1, .y = 0 };
        if (this.x == zeroRotation.x and this.y == zeroRotation.y) return 0;

        const c = zeroRotation.cross(this);
        const d = zeroRotation.dot(this);
        return std.math.atan2(f32, c, d);
    }

    pub fn xy0(self: @This()) Vector3 {
        return .{ .x = self.x, .y = self.y };
    }

    pub fn x0z(self: @This()) Vector3 {
        return .{ .x = self.x, .z = self.y };
    }

    pub fn set(self: @This(), setter: struct { x: ?f32 = null, y: ?f32 = null }) Vector2 {
        var copy = self;
        if (setter.x) |x| copy.x = x;
        if (setter.y) |y| copy.y = y;
        return copy;
    }
};

pub const Vector2i = extern struct {
    x: i32 = 0,
    y: i32 = 0,

    pub fn float(self: @This()) Vector2 {
        return .{ .x = @as(f32, @floatFromInt(self.x)), .y = @as(f32, @floatFromInt(self.y)) };
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

    pub fn neg(this: @This()) @This() {
        return .{
            .x = -this.x,
            .y = -this.y,
            .z = -this.z,
        };
    }

    pub fn lerp(self: @This(), other: @This(), t: f32) @This() {
        return self.scale(1 - t).add(other.scale(t));
    }

    pub fn forward() @This() {
        return @This().new(0, 0, 1);
    }

    pub fn rotate(self: @This(), quaternion: Vector4) @This() {
        return Vector3RotateByQuaternion(self, quaternion);
    }

    pub fn angleBetween(self: @This(), other: Vector3) f32 {
        return Vector3Angle(self, other);
        // return std.math.acos(self.dot(other) / (self.length() * other.length()));
    }

    /// Dot product.
    pub fn dot(self: @This(), other: @This()) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }

    pub fn xy(self: @This()) Vector2 {
        return .{ .x = self.x, .y = self.y };
    }

    pub fn set(self: @This(), setter: struct { x: ?f32 = null, y: ?f32 = null, z: ?f32 = null }) Vector3 {
        var copy = self;
        if (setter.x) |x| copy.x = x;
        if (setter.y) |y| copy.y = y;
        if (setter.z) |z| copy.z = z;
        return copy;
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
            .r = @as(u8, @intFromFloat(std.math.clamp(self.x * 255, 0, 255))),
            .g = @as(u8, @intFromFloat(std.math.clamp(self.y * 255, 0, 255))),
            .b = @as(u8, @intFromFloat(std.math.clamp(self.z * 255, 0, 255))),
            .a = @as(u8, @intFromFloat(std.math.clamp(self.w * 255, 0, 255))),
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

    pub const ColorChangeConfig = struct {
        r: ?u8 = null,
        g: ?u8 = null,
        b: ?u8 = null,
        a: ?u8 = null,
    };

    pub fn set(self: @This(), c: ColorChangeConfig) Color {
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

    pub fn lerpA(self: @This(), targetAlpha: u8, t: f32) @This() {
        var copy = self;
        const a = @as(f32, @floatFromInt(self.a));
        copy.a = @as(u8, @intFromFloat(a * (1 - t) + @as(f32, @floatFromInt(targetAlpha)) * t));
        return copy;
    }

    pub fn toVector4(self: @This()) Vector4 {
        return .{
            .x = @as(f32, @floatFromInt(self.r)) / 255.0,
            .y = @as(f32, @floatFromInt(self.g)) / 255.0,
            .z = @as(f32, @floatFromInt(self.b)) / 255.0,
            .w = @as(f32, @floatFromInt(self.a)) / 255.0,
        };
    }

    /// negate color (keep alpha)
    pub fn neg(self: @This()) @This() {
        return .{
            .r = 255 - self.r,
            .g = 255 - self.g,
            .b = 255 - self.b,
            .a = self.a,
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

pub const MATERIAL_MAP_DIFFUSE = @as(usize, @intCast(@intFromEnum(MaterialMapIndex.MATERIAL_MAP_ALBEDO)));
pub const MATERIAL_MAP_SPECULAR = @as(usize, @intCast(@intFromEnum(MaterialMapIndex.MATERIAL_MAP_METALNESS)));

//--- callbacks -----------------------------------------------------------------------------------

/// Logging: Redirect trace log messages
pub const TraceLogCallback = *const fn (logLevel: c_int, text: [*c]const u8, args: ?*anyopaque) void;

/// FileIO: Load binary data
pub const LoadFileDataCallback = *const fn (fileName: [*c]const u8, bytesRead: [*c]c_uint) [*c]u8;

/// FileIO: Save binary data
pub const SaveFileDataCallback = *const fn (fileName: [*c]const u8, data: ?*anyopaque, bytesToWrite: c_uint) bool;

/// FileIO: Load text data
pub const LoadFileTextCallback = *const fn (fileName: [*c]const u8) [*c]u8;

/// FileIO: Save text data
pub const SaveFileTextCallback = *const fn (fileName: [*c]const u8, text: [*c]const u8) bool;

/// Audio Loading and Playing Functions (Module: audio)
pub const AudioCallback = *const fn (bufferData: ?*anyopaque, frames: u32) void;

//--- utils ---------------------------------------------------------------------------------------

// Camera global state context data [56 bytes]
pub const CameraData = extern struct {
    /// Current camera mode
    mode: u32,
    /// Camera distance from position to target
    targetDistance: f32,
    /// Player eyes position from ground (in meters)
    playerEyesPosition: f32,
    /// Camera angle in plane XZ
    angle: Vector2,
    /// Previous mouse position
    previousMousePosition: Vector2,

    // Camera movement control keys

    /// Move controls (CAMERA_FIRST_PERSON)
    moveControl: i32[6],
    /// Smooth zoom control key
    smoothZoomControl: i32,
    /// Alternative control key
    altControl: i32,
    /// Pan view control key
    panControl: i32,
};

pub fn randomF32(rng: std.rand.Random, min: f32, max: f32) f32 {
    return rng.float(f32) * (max - min) + min;
}

//--- functions -----------------------------------------------------------------------------------

/// Setup init configuration flags (view FLAGS)
pub fn SetConfigFlags(
    flags: ConfigFlags,
) void {
    raylib.SetConfigFlags(@as(c_uint, @bitCast(flags)));
}

/// Load file data as byte array (read)
pub fn LoadFileData(fileName: [*:0]const u8) ![]const u8 {
    var bytesRead: u32 = undefined;
    const data = raylib.LoadFileData(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        @as([*c]c_int, @ptrCast(&bytesRead)),
    );

    if (data == null) return error.FileNotFound;

    return data[0..bytesRead];
}

/// Unload file data allocated by LoadFileData()
pub fn UnloadFileData(
    data: []const u8,
) void {
    raylib.UnloadFileData(
        @as([*c]u8, @ptrFromInt(@intFromPtr(data.ptr))),
    );
}

/// Set custom trace log
pub fn SetTraceLogCallback(
    _: TraceLogCallback,
) void {
    @panic("use log.zig for that");
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
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]raylib.GlyphInfo, @ptrCast(chars)),
        @as([*c][*c]raylib.Rectangle, @ptrCast(recs)),
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

//--- RLGL ----------------------------------------------------------------------------------------

pub const DEG2RAD: f32 = PI / 180;
pub const RAD2DEG: f32 = 180 / PI;

///
pub const rlglData = extern struct {
    /// Current render batch
    currentBatch: ?*rlRenderBatch,
    /// Default internal render batch
    defaultBatch: rlRenderBatch,

    pub const State = extern struct {
        /// Current active render batch vertex counter (generic, used for all batches)
        vertexCounter: i32,
        /// Current active texture coordinate X (added on glVertex*())
        texcoordx: f32,
        /// Current active texture coordinate Y (added on glVertex*())
        texcoordy: f32,
        /// Current active normal X (added on glVertex*())
        normalx: f32,
        /// Current active normal Y (added on glVertex*())
        normaly: f32,
        /// Current active normal Z (added on glVertex*())
        normalz: f32,
        /// Current active color R (added on glVertex*())
        colorr: u8,
        /// Current active color G (added on glVertex*())
        colorg: u8,
        /// Current active color B (added on glVertex*())
        colorb: u8,
        /// Current active color A (added on glVertex*())
        colora: u8,
        /// Current matrix mode
        currentMatrixMode: i32,
        /// Current matrix pointer
        currentMatrix: ?*Matrix,
        /// Default modelview matrix
        modelview: Matrix,
        /// Default projection matrix
        projection: Matrix,
        /// Transform matrix to be used with rlTranslate, rlRotate, rlScale
        transform: Matrix,
        /// Require transform matrix application to current draw-call vertex (if required)
        transformRequired: bool,
        /// Matrix stack for push/pop
        stack: [RL_MAX_MATRIX_STACK_SIZE]Matrix,
        /// Matrix stack counter
        stackCounter: i32,
        /// Default texture used on shapes/poly drawing (required by shader)
        defaultTextureId: u32,
        /// Active texture ids to be enabled on batch drawing (0 active by default)
        activeTextureId: [RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS]u32,
        /// Default vertex shader id (used by default shader program)
        defaultVShaderId: u32,
        /// Default fragment shader id (used by default shader program)
        defaultFShaderId: u32,
        /// Default shader program id, supports vertex color and diffuse texture
        defaultShaderId: u32,
        /// Default shader locations pointer to be used on rendering
        defaultShaderLocs: [*]i32,
        /// Current shader id to be used on rendering (by default, defaultShaderId)
        currentShaderId: u32,
        /// Current shader locations pointer to be used on rendering (by default, defaultShaderLocs)
        currentShaderLocs: [*]i32,
        /// Stereo rendering flag
        stereoRender: bool,
        /// VR stereo rendering eyes projection matrices
        projectionStereo: [2]Matrix,
        /// VR stereo rendering eyes view offset matrices
        viewOffsetStereo: [2]Matrix,
        /// Blending mode active
        currentBlendMode: i32,
        /// Blending source factor
        glBlendSrcFactor: i32,
        /// Blending destination factor
        glBlendDstFactor: i32,
        /// Blending equation
        glBlendEquation: i32,
        /// Current framebuffer width
        framebufferWidth: i32,
        /// Current framebuffer height
        framebufferHeight: i32,
    };

    pub const ExtSupported = extern struct {
        /// VAO support (OpenGL ES2 could not support VAO extension) (GL_ARB_vertex_array_object)
        vao: bool,
        /// Instancing supported (GL_ANGLE_instanced_arrays, GL_EXT_draw_instanced + GL_EXT_instanced_arrays)
        instancing: bool,
        /// NPOT textures full support (GL_ARB_texture_non_power_of_two, GL_OES_texture_npot)
        texNPOT: bool,
        /// Depth textures supported (GL_ARB_depth_texture, GL_WEBGL_depth_texture, GL_OES_depth_texture)
        texDepth: bool,
        /// float textures support (32 bit per channel) (GL_OES_texture_float)
        texFloat32: bool,
        /// DDS texture compression support (GL_EXT_texture_compression_s3tc, GL_WEBGL_compressed_texture_s3tc, GL_WEBKIT_WEBGL_compressed_texture_s3tc)
        texCompDXT: bool,
        /// ETC1 texture compression support (GL_OES_compressed_ETC1_RGB8_texture, GL_WEBGL_compressed_texture_etc1)
        texCompETC1: bool,
        /// ETC2/EAC texture compression support (GL_ARB_ES3_compatibility)
        texCompETC2: bool,
        /// PVR texture compression support (GL_IMG_texture_compression_pvrtc)
        texCompPVRT: bool,
        /// ASTC texture compression support (GL_KHR_texture_compression_astc_hdr, GL_KHR_texture_compression_astc_ldr)
        texCompASTC: bool,
        /// Clamp mirror wrap mode supported (GL_EXT_texture_mirror_clamp)
        texMirrorClamp: bool,
        /// Anisotropic texture filtering support (GL_EXT_texture_filter_anisotropic)
        texAnisoFilter: bool,
        /// Compute shaders support (GL_ARB_compute_shader)
        computeShader: bool,
        /// Shader storage buffer object support (GL_ARB_shader_storage_buffer_object)
        ssbo: bool,
        /// Maximum anisotropy level supported (minimum is 2.0f)
        maxAnisotropyLevel: f32,
        /// Maximum bits for depth component
        maxDepthBits: i32,
    };
};

/// Enable attribute state pointer
pub fn rlEnableStatePointer(
    vertexAttribType: i32,
    buffer: *anyopaque,
) void {
    raylib.rlEnableStatePointer(
        vertexAttribType,
        @as([*c]anyopaque, @ptrCast(buffer)),
    );
}

/// Disable attribute state pointer
pub fn rlDisableStatePointer(
    vertexAttribType: i32,
) void {
    raylib.rlDisableStatePointer(
        vertexAttribType,
    );
}

/// Get the last gamepad button pressed
pub fn GetGamepadButtonPressed() ?GamepadButton {
    if (raylib.GetGamepadButtonPressed() == -1) return null;

    return @as(GamepadButton, @enumFromInt(raylib.GetGamepadButtonPressed()));
}
