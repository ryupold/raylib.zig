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

/// Initialize window and OpenGL context
pub fn InitWindow(
    width: i32,
    height: i32,
    title: [*:0]const u8,
) void {
    raylib.mInitWindow(
        width,
        height,
        @as([*c]const u8, @ptrFromInt(@intFromPtr(title))),
    );
}

/// Close window and unload OpenGL context
pub fn CloseWindow() void {
    raylib.mCloseWindow();
}

/// Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
pub fn WindowShouldClose() bool {
    return raylib.mWindowShouldClose();
}

/// Check if window has been initialized successfully
pub fn IsWindowReady() bool {
    return raylib.mIsWindowReady();
}

/// Check if window is currently fullscreen
pub fn IsWindowFullscreen() bool {
    return raylib.mIsWindowFullscreen();
}

/// Check if window is currently hidden (only PLATFORM_DESKTOP)
pub fn IsWindowHidden() bool {
    return raylib.mIsWindowHidden();
}

/// Check if window is currently minimized (only PLATFORM_DESKTOP)
pub fn IsWindowMinimized() bool {
    return raylib.mIsWindowMinimized();
}

/// Check if window is currently maximized (only PLATFORM_DESKTOP)
pub fn IsWindowMaximized() bool {
    return raylib.mIsWindowMaximized();
}

/// Check if window is currently focused (only PLATFORM_DESKTOP)
pub fn IsWindowFocused() bool {
    return raylib.mIsWindowFocused();
}

/// Check if window has been resized last frame
pub fn IsWindowResized() bool {
    return raylib.mIsWindowResized();
}

/// Check if one specific window flag is enabled
pub fn IsWindowState(
    flag: u32,
) bool {
    return raylib.mIsWindowState(
        flag,
    );
}

/// Set window configuration state using flags (only PLATFORM_DESKTOP)
pub fn SetWindowState(
    flags: u32,
) void {
    raylib.mSetWindowState(
        flags,
    );
}

/// Clear window configuration state flags
pub fn ClearWindowState(
    flags: u32,
) void {
    raylib.mClearWindowState(
        flags,
    );
}

/// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
pub fn ToggleFullscreen() void {
    raylib.mToggleFullscreen();
}

/// Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
pub fn ToggleBorderlessWindowed() void {
    raylib.mToggleBorderlessWindowed();
}

/// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
pub fn MaximizeWindow() void {
    raylib.mMaximizeWindow();
}

/// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
pub fn MinimizeWindow() void {
    raylib.mMinimizeWindow();
}

/// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
pub fn RestoreWindow() void {
    raylib.mRestoreWindow();
}

/// Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
pub fn SetWindowIcon(
    image: Image,
) void {
    raylib.mSetWindowIcon(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
    );
}

/// Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
pub fn SetWindowIcons(
    images: *Image,
    count: i32,
) void {
    raylib.mSetWindowIcons(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(images))),
        count,
    );
}

/// Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
pub fn SetWindowTitle(
    title: [*:0]const u8,
) void {
    raylib.mSetWindowTitle(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(title))),
    );
}

/// Set window position on screen (only PLATFORM_DESKTOP)
pub fn SetWindowPosition(
    x: i32,
    y: i32,
) void {
    raylib.mSetWindowPosition(
        x,
        y,
    );
}

/// Set monitor for the current window
pub fn SetWindowMonitor(
    monitor: i32,
) void {
    raylib.mSetWindowMonitor(
        monitor,
    );
}

/// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub fn SetWindowMinSize(
    width: i32,
    height: i32,
) void {
    raylib.mSetWindowMinSize(
        width,
        height,
    );
}

/// Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
pub fn SetWindowMaxSize(
    width: i32,
    height: i32,
) void {
    raylib.mSetWindowMaxSize(
        width,
        height,
    );
}

/// Set window dimensions
pub fn SetWindowSize(
    width: i32,
    height: i32,
) void {
    raylib.mSetWindowSize(
        width,
        height,
    );
}

/// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
pub fn SetWindowOpacity(
    opacity: f32,
) void {
    raylib.mSetWindowOpacity(
        opacity,
    );
}

/// Set window focused (only PLATFORM_DESKTOP)
pub fn SetWindowFocused() void {
    raylib.mSetWindowFocused();
}

/// Get current screen width
pub fn GetScreenWidth() i32 {
    return raylib.mGetScreenWidth();
}

/// Get current screen height
pub fn GetScreenHeight() i32 {
    return raylib.mGetScreenHeight();
}

/// Get current render width (it considers HiDPI)
pub fn GetRenderWidth() i32 {
    return raylib.mGetRenderWidth();
}

/// Get current render height (it considers HiDPI)
pub fn GetRenderHeight() i32 {
    return raylib.mGetRenderHeight();
}

/// Get number of connected monitors
pub fn GetMonitorCount() i32 {
    return raylib.mGetMonitorCount();
}

/// Get current connected monitor
pub fn GetCurrentMonitor() i32 {
    return raylib.mGetCurrentMonitor();
}

/// Get specified monitor position
pub fn GetMonitorPosition(
    monitor: i32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetMonitorPosition(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        monitor,
    );
    return out;
}

/// Get specified monitor width (current video mode used by monitor)
pub fn GetMonitorWidth(
    monitor: i32,
) i32 {
    return raylib.mGetMonitorWidth(
        monitor,
    );
}

/// Get specified monitor height (current video mode used by monitor)
pub fn GetMonitorHeight(
    monitor: i32,
) i32 {
    return raylib.mGetMonitorHeight(
        monitor,
    );
}

/// Get specified monitor physical width in millimetres
pub fn GetMonitorPhysicalWidth(
    monitor: i32,
) i32 {
    return raylib.mGetMonitorPhysicalWidth(
        monitor,
    );
}

/// Get specified monitor physical height in millimetres
pub fn GetMonitorPhysicalHeight(
    monitor: i32,
) i32 {
    return raylib.mGetMonitorPhysicalHeight(
        monitor,
    );
}

/// Get specified monitor refresh rate
pub fn GetMonitorRefreshRate(
    monitor: i32,
) i32 {
    return raylib.mGetMonitorRefreshRate(
        monitor,
    );
}

/// Get window position XY on monitor
pub fn GetWindowPosition() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetWindowPosition(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

/// Get window scale DPI factor
pub fn GetWindowScaleDPI() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetWindowScaleDPI(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

/// Get the human-readable, UTF-8 encoded name of the specified monitor
pub fn GetMonitorName(
    monitor: i32,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetMonitorName(
            monitor,
        )),
    );
}

/// Set clipboard text content
pub fn SetClipboardText(
    text: [*:0]const u8,
) void {
    raylib.mSetClipboardText(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
    );
}

/// Get clipboard text content
pub fn GetClipboardText() [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetClipboardText()),
    );
}

/// Enable waiting for events on EndDrawing(), no automatic event polling
pub fn EnableEventWaiting() void {
    raylib.mEnableEventWaiting();
}

/// Disable waiting for events on EndDrawing(), automatic events polling
pub fn DisableEventWaiting() void {
    raylib.mDisableEventWaiting();
}

/// Shows cursor
pub fn ShowCursor() void {
    raylib.mShowCursor();
}

/// Hides cursor
pub fn HideCursor() void {
    raylib.mHideCursor();
}

/// Check if cursor is not visible
pub fn IsCursorHidden() bool {
    return raylib.mIsCursorHidden();
}

/// Enables cursor (unlock cursor)
pub fn EnableCursor() void {
    raylib.mEnableCursor();
}

/// Disables cursor (lock cursor)
pub fn DisableCursor() void {
    raylib.mDisableCursor();
}

/// Check if cursor is on the screen
pub fn IsCursorOnScreen() bool {
    return raylib.mIsCursorOnScreen();
}

/// Set background color (framebuffer clear color)
pub fn ClearBackground(
    color: Color,
) void {
    raylib.mClearBackground(
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Setup canvas (framebuffer) to start drawing
pub fn BeginDrawing() void {
    raylib.mBeginDrawing();
}

/// End canvas drawing and swap buffers (double buffering)
pub fn EndDrawing() void {
    raylib.mEndDrawing();
}

/// Begin 2D mode with custom camera (2D)
pub fn BeginMode2D(
    camera: Camera2D,
) void {
    raylib.mBeginMode2D(
        @as([*c]raylib.Camera2D, @ptrFromInt(@intFromPtr(&camera))),
    );
}

/// Ends 2D mode with custom camera
pub fn EndMode2D() void {
    raylib.mEndMode2D();
}

/// Begin 3D mode with custom camera (3D)
pub fn BeginMode3D(
    camera: Camera3D,
) void {
    raylib.mBeginMode3D(
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
    );
}

/// Ends 3D mode and returns to default 2D orthographic mode
pub fn EndMode3D() void {
    raylib.mEndMode3D();
}

/// Begin drawing to render texture
pub fn BeginTextureMode(
    target: RenderTexture2D,
) void {
    raylib.mBeginTextureMode(
        @as([*c]raylib.RenderTexture2D, @ptrFromInt(@intFromPtr(&target))),
    );
}

/// Ends drawing to render texture
pub fn EndTextureMode() void {
    raylib.mEndTextureMode();
}

/// Begin custom shader drawing
pub fn BeginShaderMode(
    shader: Shader,
) void {
    raylib.mBeginShaderMode(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
    );
}

/// End custom shader drawing (use default shader)
pub fn EndShaderMode() void {
    raylib.mEndShaderMode();
}

/// Begin blending mode (alpha, additive, multiplied, subtract, custom)
pub fn BeginBlendMode(
    mode: i32,
) void {
    raylib.mBeginBlendMode(
        mode,
    );
}

/// End blending mode (reset to default: alpha blending)
pub fn EndBlendMode() void {
    raylib.mEndBlendMode();
}

/// Begin scissor mode (define screen area for following drawing)
pub fn BeginScissorMode(
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {
    raylib.mBeginScissorMode(
        x,
        y,
        width,
        height,
    );
}

/// End scissor mode
pub fn EndScissorMode() void {
    raylib.mEndScissorMode();
}

/// Begin stereo rendering (requires VR simulator)
pub fn BeginVrStereoMode(
    config: VrStereoConfig,
) void {
    raylib.mBeginVrStereoMode(
        @as([*c]raylib.VrStereoConfig, @ptrFromInt(@intFromPtr(&config))),
    );
}

/// End stereo rendering (requires VR simulator)
pub fn EndVrStereoMode() void {
    raylib.mEndVrStereoMode();
}

/// Load VR stereo config for VR simulator device parameters
pub fn LoadVrStereoConfig(
    device: VrDeviceInfo,
) VrStereoConfig {
    var out: VrStereoConfig = undefined;
    raylib.mLoadVrStereoConfig(
        @as([*c]raylib.VrStereoConfig, @ptrCast(&out)),
        @as([*c]raylib.VrDeviceInfo, @ptrFromInt(@intFromPtr(&device))),
    );
    return out;
}

/// Unload VR stereo config
pub fn UnloadVrStereoConfig(
    config: VrStereoConfig,
) void {
    raylib.mUnloadVrStereoConfig(
        @as([*c]raylib.VrStereoConfig, @ptrFromInt(@intFromPtr(&config))),
    );
}

/// Load shader from files and bind default locations
pub fn LoadShader(
    vsFileName: [*:0]const u8,
    fsFileName: [*:0]const u8,
) Shader {
    var out: Shader = undefined;
    raylib.mLoadShader(
        @as([*c]raylib.Shader, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(vsFileName))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fsFileName))),
    );
    return out;
}

/// Load shader from code strings and bind default locations
pub fn LoadShaderFromMemory(
    vsCode: [*:0]const u8,
    fsCode: [*:0]const u8,
) Shader {
    var out: Shader = undefined;
    raylib.mLoadShaderFromMemory(
        @as([*c]raylib.Shader, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(vsCode))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fsCode))),
    );
    return out;
}

/// Check if a shader is ready
pub fn IsShaderReady(
    shader: Shader,
) bool {
    return raylib.mIsShaderReady(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
    );
}

/// Get shader uniform location
pub fn GetShaderLocation(
    shader: Shader,
    uniformName: [*:0]const u8,
) i32 {
    return raylib.mGetShaderLocation(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(uniformName))),
    );
}

/// Get shader attribute location
pub fn GetShaderLocationAttrib(
    shader: Shader,
    attribName: [*:0]const u8,
) i32 {
    return raylib.mGetShaderLocationAttrib(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(attribName))),
    );
}

/// Set shader uniform value
pub fn SetShaderValue(
    shader: Shader,
    locIndex: i32,
    value: *const anyopaque,
    uniformType: ShaderUniformDataType,
) void {
    raylib.mSetShaderValue(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
        locIndex,
        value,
        @intFromEnum(uniformType),
    );
}

/// Set shader uniform value vector
pub fn SetShaderValueV(
    shader: Shader,
    locIndex: i32,
    value: *const anyopaque,
    uniformType: i32,
    count: i32,
) void {
    raylib.mSetShaderValueV(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
        locIndex,
        value,
        uniformType,
        count,
    );
}

/// Set shader uniform value (matrix 4x4)
pub fn SetShaderValueMatrix(
    shader: Shader,
    locIndex: i32,
    mat: Matrix,
) void {
    raylib.mSetShaderValueMatrix(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
        locIndex,
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
}

/// Set shader uniform value for texture (sampler2d)
pub fn SetShaderValueTexture(
    shader: Shader,
    locIndex: i32,
    texture: Texture2D,
) void {
    raylib.mSetShaderValueTexture(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
        locIndex,
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
    );
}

/// Unload shader from GPU memory (VRAM)
pub fn UnloadShader(
    shader: Shader,
) void {
    raylib.mUnloadShader(
        @as([*c]raylib.Shader, @ptrFromInt(@intFromPtr(&shader))),
    );
}

/// Get a ray trace from mouse position
pub fn GetMouseRay(
    mousePosition: Vector2,
    camera: Camera3D,
) Ray {
    var out: Ray = undefined;
    raylib.mGetMouseRay(
        @as([*c]raylib.Ray, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&mousePosition))),
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
    );
    return out;
}

/// Get camera transform matrix (view matrix)
pub fn GetCameraMatrix(
    camera: Camera3D,
) Matrix {
    var out: Matrix = undefined;
    raylib.mGetCameraMatrix(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
    );
    return out;
}

/// Get camera 2d transform matrix
pub fn GetCameraMatrix2D(
    camera: Camera2D,
) Matrix {
    var out: Matrix = undefined;
    raylib.mGetCameraMatrix2D(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Camera2D, @ptrFromInt(@intFromPtr(&camera))),
    );
    return out;
}

/// Get the screen space position for a 3d world space position
pub fn GetWorldToScreen(
    position: Vector3,
    camera: Camera3D,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetWorldToScreen(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
    );
    return out;
}

/// Get the world space position for a 2d camera screen space position
pub fn GetScreenToWorld2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetScreenToWorld2D(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Camera2D, @ptrFromInt(@intFromPtr(&camera))),
    );
    return out;
}

/// Get size position for a 3d world space position
pub fn GetWorldToScreenEx(
    position: Vector3,
    camera: Camera3D,
    width: i32,
    height: i32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetWorldToScreenEx(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
        width,
        height,
    );
    return out;
}

/// Get the screen space position for a 2d camera world space position
pub fn GetWorldToScreen2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetWorldToScreen2D(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Camera2D, @ptrFromInt(@intFromPtr(&camera))),
    );
    return out;
}

/// Set target FPS (maximum)
pub fn SetTargetFPS(
    fps: i32,
) void {
    raylib.mSetTargetFPS(
        fps,
    );
}

/// Get time in seconds for last frame drawn (delta time)
pub fn GetFrameTime() f32 {
    return raylib.mGetFrameTime();
}

/// Get elapsed time in seconds since InitWindow()
pub fn GetTime() f64 {
    return raylib.mGetTime();
}

/// Get current FPS
pub fn GetFPS() i32 {
    return raylib.mGetFPS();
}

/// Swap back buffer with front buffer (screen drawing)
pub fn SwapScreenBuffer() void {
    raylib.mSwapScreenBuffer();
}

/// Register all input events
pub fn PollInputEvents() void {
    raylib.mPollInputEvents();
}

/// Wait for some time (halt program execution)
pub fn WaitTime(
    seconds: f64,
) void {
    raylib.mWaitTime(
        seconds,
    );
}

/// Set the seed for the random number generator
pub fn SetRandomSeed(
    seed: u32,
) void {
    raylib.mSetRandomSeed(
        seed,
    );
}

/// Get a random value between min and max (both included)
pub fn GetRandomValue(
    min: i32,
    max: i32,
) i32 {
    return raylib.mGetRandomValue(
        min,
        max,
    );
}

/// Load random values sequence, no values repeated
pub fn LoadRandomSequence(
    count: u32,
    min: i32,
    max: i32,
) ?[*]i32 {
    return @as(
        ?[*]i32,
        @ptrCast(raylib.mLoadRandomSequence(
            count,
            min,
            max,
        )),
    );
}

/// Unload random values sequence
pub fn UnloadRandomSequence(
    sequence: ?[*]i32,
) void {
    raylib.mUnloadRandomSequence(
        @as([*c]i32, @ptrCast(sequence)),
    );
}

/// Takes a screenshot of current screen (filename extension defines format)
pub fn TakeScreenshot(
    fileName: [*:0]const u8,
) void {
    raylib.mTakeScreenshot(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Open URL with default system browser (if available)
pub fn OpenURL(
    url: [*:0]const u8,
) void {
    raylib.mOpenURL(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(url))),
    );
}

/// Set the current threshold (minimum) log level
pub fn SetTraceLogLevel(
    logLevel: i32,
) void {
    raylib.mSetTraceLogLevel(
        logLevel,
    );
}

/// Set custom file binary data loader
pub fn SetLoadFileDataCallback(
    callback: LoadFileDataCallback,
) void {
    raylib.mSetLoadFileDataCallback(
        @ptrCast(callback),
    );
}

/// Set custom file binary data saver
pub fn SetSaveFileDataCallback(
    callback: SaveFileDataCallback,
) void {
    raylib.mSetSaveFileDataCallback(
        @ptrCast(callback),
    );
}

/// Set custom file text data loader
pub fn SetLoadFileTextCallback(
    callback: LoadFileTextCallback,
) void {
    raylib.mSetLoadFileTextCallback(
        @ptrCast(callback),
    );
}

/// Set custom file text data saver
pub fn SetSaveFileTextCallback(
    callback: SaveFileTextCallback,
) void {
    raylib.mSetSaveFileTextCallback(
        @ptrCast(callback),
    );
}

/// Save data to file from byte array (write), returns true on success
pub fn SaveFileData(
    fileName: [*:0]const u8,
    data: *anyopaque,
    dataSize: i32,
) bool {
    return raylib.mSaveFileData(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        data,
        dataSize,
    );
}

/// Export data to code (.h), returns true on success
pub fn ExportDataAsCode(
    data: [*:0]const u8,
    dataSize: i32,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportDataAsCode(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(data))),
        dataSize,
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Load text data from file (read), returns a '\0' terminated string
pub fn LoadFileText(
    fileName: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mLoadFileText(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        )),
    );
}

/// Unload file text data allocated by LoadFileText()
pub fn UnloadFileText(
    text: ?[*]u8,
) void {
    raylib.mUnloadFileText(
        @as([*c]u8, @ptrCast(text)),
    );
}

/// Save text data to file (write), string must be '\0' terminated, returns true on success
pub fn SaveFileText(
    fileName: [*:0]const u8,
    text: ?[*]u8,
) bool {
    return raylib.mSaveFileText(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        @as([*c]u8, @ptrCast(text)),
    );
}

/// Check if file exists
pub fn FileExists(
    fileName: [*:0]const u8,
) bool {
    return raylib.mFileExists(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Check if a directory path exists
pub fn DirectoryExists(
    dirPath: [*:0]const u8,
) bool {
    return raylib.mDirectoryExists(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(dirPath))),
    );
}

/// Check file extension (including point: .png, .wav)
pub fn IsFileExtension(
    fileName: [*:0]const u8,
    ext: [*:0]const u8,
) bool {
    return raylib.mIsFileExtension(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(ext))),
    );
}

/// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub fn GetFileLength(
    fileName: [*:0]const u8,
) i32 {
    return raylib.mGetFileLength(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Get pointer to extension for a filename string (includes dot: '.png')
pub fn GetFileExtension(
    fileName: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetFileExtension(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        )),
    );
}

/// Get pointer to filename for a path string
pub fn GetFileName(
    filePath: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetFileName(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(filePath))),
        )),
    );
}

/// Get filename string without extension (uses static string)
pub fn GetFileNameWithoutExt(
    filePath: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetFileNameWithoutExt(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(filePath))),
        )),
    );
}

/// Get full path for a given fileName with path (uses static string)
pub fn GetDirectoryPath(
    filePath: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetDirectoryPath(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(filePath))),
        )),
    );
}

/// Get previous directory path for a given path (uses static string)
pub fn GetPrevDirectoryPath(
    dirPath: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetPrevDirectoryPath(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(dirPath))),
        )),
    );
}

/// Get current working directory (uses static string)
pub fn GetWorkingDirectory() [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetWorkingDirectory()),
    );
}

/// Get the directory of the running application (uses static string)
pub fn GetApplicationDirectory() [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetApplicationDirectory()),
    );
}

/// Change working directory, return true on success
pub fn ChangeDirectory(
    dir: [*:0]const u8,
) bool {
    return raylib.mChangeDirectory(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(dir))),
    );
}

/// Check if a given path is a file or a directory
pub fn IsPathFile(
    path: [*:0]const u8,
) bool {
    return raylib.mIsPathFile(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(path))),
    );
}

/// Load directory filepaths
pub fn LoadDirectoryFiles(
    dirPath: [*:0]const u8,
) FilePathList {
    var out: FilePathList = undefined;
    raylib.mLoadDirectoryFiles(
        @as([*c]raylib.FilePathList, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(dirPath))),
    );
    return out;
}

/// Load directory filepaths with extension filtering and recursive directory scan
pub fn LoadDirectoryFilesEx(
    basePath: [*:0]const u8,
    filter: [*:0]const u8,
    scanSubdirs: bool,
) FilePathList {
    var out: FilePathList = undefined;
    raylib.mLoadDirectoryFilesEx(
        @as([*c]raylib.FilePathList, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(basePath))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(filter))),
        scanSubdirs,
    );
    return out;
}

/// Unload filepaths
pub fn UnloadDirectoryFiles(
    files: FilePathList,
) void {
    raylib.mUnloadDirectoryFiles(
        @as([*c]raylib.FilePathList, @ptrFromInt(@intFromPtr(&files))),
    );
}

/// Check if a file has been dropped into window
pub fn IsFileDropped() bool {
    return raylib.mIsFileDropped();
}

/// Load dropped filepaths
pub fn LoadDroppedFiles() FilePathList {
    var out: FilePathList = undefined;
    raylib.mLoadDroppedFiles(
        @as([*c]raylib.FilePathList, @ptrCast(&out)),
    );
    return out;
}

/// Unload dropped filepaths
pub fn UnloadDroppedFiles(
    files: FilePathList,
) void {
    raylib.mUnloadDroppedFiles(
        @as([*c]raylib.FilePathList, @ptrFromInt(@intFromPtr(&files))),
    );
}

/// Get file modification time (last write time)
pub fn GetFileModTime(
    fileName: [*:0]const u8,
) i64 {
    return raylib.mGetFileModTime(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Compress data (DEFLATE algorithm), memory must be MemFree()
pub fn CompressData(
    data: [*:0]const u8,
    dataSize: i32,
    compDataSize: ?[*]i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mCompressData(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(data))),
            dataSize,
            @as([*c]i32, @ptrCast(compDataSize)),
        )),
    );
}

/// Decompress data (DEFLATE algorithm), memory must be MemFree()
pub fn DecompressData(
    compData: [*:0]const u8,
    compDataSize: i32,
    dataSize: ?[*]i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mDecompressData(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(compData))),
            compDataSize,
            @as([*c]i32, @ptrCast(dataSize)),
        )),
    );
}

/// Encode data to Base64 string, memory must be MemFree()
pub fn EncodeDataBase64(
    data: [*:0]const u8,
    dataSize: i32,
    outputSize: ?[*]i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mEncodeDataBase64(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(data))),
            dataSize,
            @as([*c]i32, @ptrCast(outputSize)),
        )),
    );
}

/// Decode Base64 string data, memory must be MemFree()
pub fn DecodeDataBase64(
    data: [*:0]const u8,
    outputSize: ?[*]i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mDecodeDataBase64(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(data))),
            @as([*c]i32, @ptrCast(outputSize)),
        )),
    );
}

/// Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
pub fn LoadAutomationEventList(
    fileName: [*:0]const u8,
) AutomationEventList {
    var out: AutomationEventList = undefined;
    raylib.mLoadAutomationEventList(
        @as([*c]raylib.AutomationEventList, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Unload automation events list from file
pub fn UnloadAutomationEventList(
    list: AutomationEventList,
) void {
    raylib.mUnloadAutomationEventList(
        @as([*c]raylib.AutomationEventList, @ptrFromInt(@intFromPtr(&list))),
    );
}

/// Export automation events list as text file
pub fn ExportAutomationEventList(
    list: AutomationEventList,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportAutomationEventList(
        @as([*c]raylib.AutomationEventList, @ptrFromInt(@intFromPtr(&list))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Set automation event list to record to
pub fn SetAutomationEventList(
    list: ?[*]AutomationEventList,
) void {
    raylib.mSetAutomationEventList(
        @as([*c]raylib.AutomationEventList, @ptrFromInt(@intFromPtr(list))),
    );
}

/// Set automation event internal base frame to start recording
pub fn SetAutomationEventBaseFrame(
    frame: i32,
) void {
    raylib.mSetAutomationEventBaseFrame(
        frame,
    );
}

/// Start recording automation events (AutomationEventList must be set)
pub fn StartAutomationEventRecording() void {
    raylib.mStartAutomationEventRecording();
}

/// Stop recording automation events
pub fn StopAutomationEventRecording() void {
    raylib.mStopAutomationEventRecording();
}

/// Play a recorded automation event
pub fn PlayAutomationEvent(
    event: AutomationEvent,
) void {
    raylib.mPlayAutomationEvent(
        @as([*c]raylib.AutomationEvent, @ptrFromInt(@intFromPtr(&event))),
    );
}

/// Check if a key has been pressed once
pub fn IsKeyPressed(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyPressed(
        @intFromEnum(key),
    );
}

/// Check if a key has been pressed again (Only PLATFORM_DESKTOP)
pub fn IsKeyPressedRepeat(
    key: i32,
) bool {
    return raylib.mIsKeyPressedRepeat(
        key,
    );
}

/// Check if a key is being pressed
pub fn IsKeyDown(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyDown(
        @intFromEnum(key),
    );
}

/// Check if a key has been released once
pub fn IsKeyReleased(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyReleased(
        @intFromEnum(key),
    );
}

/// Check if a key is NOT being pressed
pub fn IsKeyUp(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyUp(
        @intFromEnum(key),
    );
}

/// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
pub fn GetKeyPressed() i32 {
    return raylib.mGetKeyPressed();
}

/// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
pub fn GetCharPressed() i32 {
    return raylib.mGetCharPressed();
}

/// Set a custom key to exit program (default is ESC)
pub fn SetExitKey(
    key: KeyboardKey,
) void {
    raylib.mSetExitKey(
        @intFromEnum(key),
    );
}

/// Check if a gamepad is available
pub fn IsGamepadAvailable(
    gamepad: i32,
) bool {
    return raylib.mIsGamepadAvailable(
        gamepad,
    );
}

/// Get gamepad internal name id
pub fn GetGamepadName(
    gamepad: i32,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mGetGamepadName(
            gamepad,
        )),
    );
}

/// Check if a gamepad button has been pressed once
pub fn IsGamepadButtonPressed(
    gamepad: i32,
    button: GamepadButton,
) bool {
    return raylib.mIsGamepadButtonPressed(
        gamepad,
        @intFromEnum(button),
    );
}

/// Check if a gamepad button is being pressed
pub fn IsGamepadButtonDown(
    gamepad: i32,
    button: GamepadButton,
) bool {
    return raylib.mIsGamepadButtonDown(
        gamepad,
        @intFromEnum(button),
    );
}

/// Check if a gamepad button has been released once
pub fn IsGamepadButtonReleased(
    gamepad: i32,
    button: GamepadButton,
) bool {
    return raylib.mIsGamepadButtonReleased(
        gamepad,
        @intFromEnum(button),
    );
}

/// Check if a gamepad button is NOT being pressed
pub fn IsGamepadButtonUp(
    gamepad: i32,
    button: GamepadButton,
) bool {
    return raylib.mIsGamepadButtonUp(
        gamepad,
        @intFromEnum(button),
    );
}

/// Get gamepad axis count for a gamepad
pub fn GetGamepadAxisCount(
    gamepad: i32,
) i32 {
    return raylib.mGetGamepadAxisCount(
        gamepad,
    );
}

/// Get axis movement value for a gamepad axis
pub fn GetGamepadAxisMovement(
    gamepad: i32,
    axis: GamepadAxis,
) f32 {
    return raylib.mGetGamepadAxisMovement(
        gamepad,
        @intFromEnum(axis),
    );
}

/// Set internal gamepad mappings (SDL_GameControllerDB)
pub fn SetGamepadMappings(
    mappings: [*:0]const u8,
) i32 {
    return raylib.mSetGamepadMappings(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(mappings))),
    );
}

/// Check if a mouse button has been pressed once
pub fn IsMouseButtonPressed(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonPressed(
        @intFromEnum(button),
    );
}

/// Check if a mouse button is being pressed
pub fn IsMouseButtonDown(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonDown(
        @intFromEnum(button),
    );
}

/// Check if a mouse button has been released once
pub fn IsMouseButtonReleased(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonReleased(
        @intFromEnum(button),
    );
}

/// Check if a mouse button is NOT being pressed
pub fn IsMouseButtonUp(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonUp(
        @intFromEnum(button),
    );
}

/// Get mouse position X
pub fn GetMouseX() i32 {
    return raylib.mGetMouseX();
}

/// Get mouse position Y
pub fn GetMouseY() i32 {
    return raylib.mGetMouseY();
}

/// Get mouse position XY
pub fn GetMousePosition() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetMousePosition(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

/// Get mouse delta between frames
pub fn GetMouseDelta() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetMouseDelta(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

/// Set mouse position XY
pub fn SetMousePosition(
    x: i32,
    y: i32,
) void {
    raylib.mSetMousePosition(
        x,
        y,
    );
}

/// Set mouse offset
pub fn SetMouseOffset(
    offsetX: i32,
    offsetY: i32,
) void {
    raylib.mSetMouseOffset(
        offsetX,
        offsetY,
    );
}

/// Set mouse scaling
pub fn SetMouseScale(
    scaleX: f32,
    scaleY: f32,
) void {
    raylib.mSetMouseScale(
        scaleX,
        scaleY,
    );
}

/// Get mouse wheel movement for X or Y, whichever is larger
pub fn GetMouseWheelMove() f32 {
    return raylib.mGetMouseWheelMove();
}

/// Get mouse wheel movement for both X and Y
pub fn GetMouseWheelMoveV() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetMouseWheelMoveV(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

/// Set mouse cursor
pub fn SetMouseCursor(
    cursor: MouseCursor,
) void {
    raylib.mSetMouseCursor(
        @intFromEnum(cursor),
    );
}

/// Get touch position X for touch point 0 (relative to screen size)
pub fn GetTouchX() i32 {
    return raylib.mGetTouchX();
}

/// Get touch position Y for touch point 0 (relative to screen size)
pub fn GetTouchY() i32 {
    return raylib.mGetTouchY();
}

/// Get touch position XY for a touch point index (relative to screen size)
pub fn GetTouchPosition(
    index: i32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetTouchPosition(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        index,
    );
    return out;
}

/// Get touch point identifier for given index
pub fn GetTouchPointId(
    index: i32,
) i32 {
    return raylib.mGetTouchPointId(
        index,
    );
}

/// Get number of touch points
pub fn GetTouchPointCount() i32 {
    return raylib.mGetTouchPointCount();
}

/// Enable a set of gestures using flags
pub fn SetGesturesEnabled(
    flags: u32,
) void {
    raylib.mSetGesturesEnabled(
        flags,
    );
}

/// Check if a gesture have been detected
pub fn IsGestureDetected(
    gesture: u32,
) bool {
    return raylib.mIsGestureDetected(
        gesture,
    );
}

/// Get latest detected gesture
pub fn GetGestureDetected() i32 {
    return raylib.mGetGestureDetected();
}

/// Get gesture hold time in milliseconds
pub fn GetGestureHoldDuration() f32 {
    return raylib.mGetGestureHoldDuration();
}

/// Get gesture drag vector
pub fn GetGestureDragVector() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetGestureDragVector(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

/// Get gesture drag angle
pub fn GetGestureDragAngle() f32 {
    return raylib.mGetGestureDragAngle();
}

/// Get gesture pinch delta
pub fn GetGesturePinchVector() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetGesturePinchVector(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

/// Get gesture pinch angle
pub fn GetGesturePinchAngle() f32 {
    return raylib.mGetGesturePinchAngle();
}

/// Update camera position for selected mode
pub fn UpdateCamera(
    camera: *Camera3D,
    mode: CameraMode,
) void {
    raylib.mUpdateCamera(
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(camera))),
        @intFromEnum(mode),
    );
}

/// Update camera movement/rotation
pub fn UpdateCameraPro(
    camera: ?[*]Camera3D,
    movement: Vector3,
    rotation: Vector3,
    zoom: f32,
) void {
    raylib.mUpdateCameraPro(
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(camera))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&movement))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&rotation))),
        zoom,
    );
}

/// Set texture and rectangle to be used on shapes drawing
pub fn SetShapesTexture(
    texture: Texture2D,
    source: Rectangle,
) void {
    raylib.mSetShapesTexture(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&source))),
    );
}

/// Get texture that is used for shapes drawing
pub fn GetShapesTexture() Texture2D {
    var out: Texture2D = undefined;
    raylib.mGetShapesTexture(
        @as([*c]raylib.Texture2D, @ptrCast(&out)),
    );
    return out;
}

/// Get texture source rectangle that is used for shapes drawing
pub fn GetShapesTextureRectangle() Rectangle {
    var out: Rectangle = undefined;
    raylib.mGetShapesTextureRectangle(
        @as([*c]raylib.Rectangle, @ptrCast(&out)),
    );
    return out;
}

/// Draw a pixel
pub fn DrawPixel(
    posX: i32,
    posY: i32,
    color: Color,
) void {
    raylib.mDrawPixel(
        posX,
        posY,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a pixel (Vector version)
pub fn DrawPixelV(
    position: Vector2,
    color: Color,
) void {
    raylib.mDrawPixelV(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a line
pub fn DrawLine(
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: Color,
) void {
    raylib.mDrawLine(
        startPosX,
        startPosY,
        endPosX,
        endPosY,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a line (using gl lines)
pub fn DrawLineV(
    startPos: Vector2,
    endPos: Vector2,
    color: Color,
) void {
    raylib.mDrawLineV(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&endPos))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a line (using triangles/quads)
pub fn DrawLineEx(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawLineEx(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&endPos))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw lines sequence (using gl lines)
pub fn DrawLineStrip(
    points: ?[*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawLineStrip(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw line segment cubic-bezier in-out interpolation
pub fn DrawLineBezier(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawLineBezier(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&endPos))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a color-filled circle
pub fn DrawCircle(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {
    raylib.mDrawCircle(
        centerX,
        centerY,
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a piece of a circle
pub fn DrawCircleSector(
    center: Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {
    raylib.mDrawCircleSector(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
        startAngle,
        endAngle,
        segments,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw circle sector outline
pub fn DrawCircleSectorLines(
    center: Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {
    raylib.mDrawCircleSectorLines(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
        startAngle,
        endAngle,
        segments,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a gradient-filled circle
pub fn DrawCircleGradient(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color1: Color,
    color2: Color,
) void {
    raylib.mDrawCircleGradient(
        centerX,
        centerY,
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color1))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color2))),
    );
}

/// Draw a color-filled circle (Vector version)
pub fn DrawCircleV(
    center: Vector2,
    radius: f32,
    color: Color,
) void {
    raylib.mDrawCircleV(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw circle outline
pub fn DrawCircleLines(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {
    raylib.mDrawCircleLines(
        centerX,
        centerY,
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw circle outline (Vector version)
pub fn DrawCircleLinesV(
    center: Vector2,
    radius: f32,
    color: Color,
) void {
    raylib.mDrawCircleLinesV(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw ellipse
pub fn DrawEllipse(
    centerX: i32,
    centerY: i32,
    radiusH: f32,
    radiusV: f32,
    color: Color,
) void {
    raylib.mDrawEllipse(
        centerX,
        centerY,
        radiusH,
        radiusV,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw ellipse outline
pub fn DrawEllipseLines(
    centerX: i32,
    centerY: i32,
    radiusH: f32,
    radiusV: f32,
    color: Color,
) void {
    raylib.mDrawEllipseLines(
        centerX,
        centerY,
        radiusH,
        radiusV,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw ring
pub fn DrawRing(
    center: Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {
    raylib.mDrawRing(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw ring outline
pub fn DrawRingLines(
    center: Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {
    raylib.mDrawRingLines(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a color-filled rectangle
pub fn DrawRectangle(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {
    raylib.mDrawRectangle(
        posX,
        posY,
        width,
        height,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a color-filled rectangle (Vector version)
pub fn DrawRectangleV(
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    raylib.mDrawRectangleV(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&size))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a color-filled rectangle
pub fn DrawRectangleRec(
    rec: Rectangle,
    color: Color,
) void {
    raylib.mDrawRectangleRec(
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a color-filled rectangle with pro parameters
pub fn DrawRectanglePro(
    rec: Rectangle,
    origin: Vector2,
    rotation: f32,
    color: Color,
) void {
    raylib.mDrawRectanglePro(
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&origin))),
        rotation,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a vertical-gradient-filled rectangle
pub fn DrawRectangleGradientV(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color1: Color,
    color2: Color,
) void {
    raylib.mDrawRectangleGradientV(
        posX,
        posY,
        width,
        height,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color1))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color2))),
    );
}

/// Draw a horizontal-gradient-filled rectangle
pub fn DrawRectangleGradientH(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color1: Color,
    color2: Color,
) void {
    raylib.mDrawRectangleGradientH(
        posX,
        posY,
        width,
        height,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color1))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color2))),
    );
}

/// Draw a gradient-filled rectangle with custom vertex colors
pub fn DrawRectangleGradientEx(
    rec: Rectangle,
    col1: Color,
    col2: Color,
    col3: Color,
    col4: Color,
) void {
    raylib.mDrawRectangleGradientEx(
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&col1))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&col2))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&col3))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&col4))),
    );
}

/// Draw rectangle outline
pub fn DrawRectangleLines(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {
    raylib.mDrawRectangleLines(
        posX,
        posY,
        width,
        height,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw rectangle outline with extended parameters
pub fn DrawRectangleLinesEx(
    rec: Rectangle,
    lineThick: f32,
    color: Color,
) void {
    raylib.mDrawRectangleLinesEx(
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        lineThick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw rectangle with rounded edges
pub fn DrawRectangleRounded(
    rec: Rectangle,
    roundness: f32,
    segments: i32,
    color: Color,
) void {
    raylib.mDrawRectangleRounded(
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        roundness,
        segments,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw rectangle with rounded edges outline
pub fn DrawRectangleRoundedLines(
    rec: Rectangle,
    roundness: f32,
    segments: i32,
    lineThick: f32,
    color: Color,
) void {
    raylib.mDrawRectangleRoundedLines(
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        roundness,
        segments,
        lineThick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {
    raylib.mDrawTriangle(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v3))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw triangle outline (vertex in counter-clockwise order!)
pub fn DrawTriangleLines(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {
    raylib.mDrawTriangleLines(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v3))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a triangle fan defined by points (first vertex is the center)
pub fn DrawTriangleFan(
    points: ?[*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawTriangleFan(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip(
    points: ?[*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawTriangleStrip(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a regular polygon (Vector version)
pub fn DrawPoly(
    center: Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: Color,
) void {
    raylib.mDrawPoly(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        sides,
        radius,
        rotation,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a polygon outline of n sides
pub fn DrawPolyLines(
    center: Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: Color,
) void {
    raylib.mDrawPolyLines(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        sides,
        radius,
        rotation,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a polygon outline of n sides with extended parameters
pub fn DrawPolyLinesEx(
    center: Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    lineThick: f32,
    color: Color,
) void {
    raylib.mDrawPolyLinesEx(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        sides,
        radius,
        rotation,
        lineThick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline: Linear, minimum 2 points
pub fn DrawSplineLinear(
    points: ?[*]Vector2,
    pointCount: i32,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineLinear(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline: B-Spline, minimum 4 points
pub fn DrawSplineBasis(
    points: ?[*]Vector2,
    pointCount: i32,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineBasis(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline: Catmull-Rom, minimum 4 points
pub fn DrawSplineCatmullRom(
    points: ?[*]Vector2,
    pointCount: i32,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineCatmullRom(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
pub fn DrawSplineBezierQuadratic(
    points: ?[*]Vector2,
    pointCount: i32,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineBezierQuadratic(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
pub fn DrawSplineBezierCubic(
    points: ?[*]Vector2,
    pointCount: i32,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineBezierCubic(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline segment: Linear, 2 points
pub fn DrawSplineSegmentLinear(
    p1: Vector2,
    p2: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineSegmentLinear(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p2))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline segment: B-Spline, 4 points
pub fn DrawSplineSegmentBasis(
    p1: Vector2,
    p2: Vector2,
    p3: Vector2,
    p4: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineSegmentBasis(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p3))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p4))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline segment: Catmull-Rom, 4 points
pub fn DrawSplineSegmentCatmullRom(
    p1: Vector2,
    p2: Vector2,
    p3: Vector2,
    p4: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineSegmentCatmullRom(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p3))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p4))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline segment: Quadratic Bezier, 2 points, 1 control point
pub fn DrawSplineSegmentBezierQuadratic(
    p1: Vector2,
    c2: Vector2,
    p3: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineSegmentBezierQuadratic(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&c2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p3))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw spline segment: Cubic Bezier, 2 points, 2 control points
pub fn DrawSplineSegmentBezierCubic(
    p1: Vector2,
    c2: Vector2,
    c3: Vector2,
    p4: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawSplineSegmentBezierCubic(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&c2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&c3))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p4))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Get (evaluate) spline point: Linear
pub fn GetSplinePointLinear(
    startPos: Vector2,
    endPos: Vector2,
    t: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetSplinePointLinear(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&endPos))),
        t,
    );
    return out;
}

/// Get (evaluate) spline point: B-Spline
pub fn GetSplinePointBasis(
    p1: Vector2,
    p2: Vector2,
    p3: Vector2,
    p4: Vector2,
    t: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetSplinePointBasis(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p3))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p4))),
        t,
    );
    return out;
}

/// Get (evaluate) spline point: Catmull-Rom
pub fn GetSplinePointCatmullRom(
    p1: Vector2,
    p2: Vector2,
    p3: Vector2,
    p4: Vector2,
    t: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetSplinePointCatmullRom(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p3))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p4))),
        t,
    );
    return out;
}

/// Get (evaluate) spline point: Quadratic Bezier
pub fn GetSplinePointBezierQuad(
    p1: Vector2,
    c2: Vector2,
    p3: Vector2,
    t: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetSplinePointBezierQuad(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&c2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p3))),
        t,
    );
    return out;
}

/// Get (evaluate) spline point: Cubic Bezier
pub fn GetSplinePointBezierCubic(
    p1: Vector2,
    c2: Vector2,
    c3: Vector2,
    p4: Vector2,
    t: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetSplinePointBezierCubic(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&c2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&c3))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p4))),
        t,
    );
    return out;
}

/// Check collision between two rectangles
pub fn CheckCollisionRecs(
    rec1: Rectangle,
    rec2: Rectangle,
) bool {
    return raylib.mCheckCollisionRecs(
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec1))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec2))),
    );
}

/// Check collision between two circles
pub fn CheckCollisionCircles(
    center1: Vector2,
    radius1: f32,
    center2: Vector2,
    radius2: f32,
) bool {
    return raylib.mCheckCollisionCircles(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center1))),
        radius1,
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center2))),
        radius2,
    );
}

/// Check collision between circle and rectangle
pub fn CheckCollisionCircleRec(
    center: Vector2,
    radius: f32,
    rec: Rectangle,
) bool {
    return raylib.mCheckCollisionCircleRec(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
    );
}

/// Check if point is inside rectangle
pub fn CheckCollisionPointRec(
    point: Vector2,
    rec: Rectangle,
) bool {
    return raylib.mCheckCollisionPointRec(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&point))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
    );
}

/// Check if point is inside circle
pub fn CheckCollisionPointCircle(
    point: Vector2,
    center: Vector2,
    radius: f32,
) bool {
    return raylib.mCheckCollisionPointCircle(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&point))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
    );
}

/// Check if point is inside a triangle
pub fn CheckCollisionPointTriangle(
    point: Vector2,
    p1: Vector2,
    p2: Vector2,
    p3: Vector2,
) bool {
    return raylib.mCheckCollisionPointTriangle(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&point))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p3))),
    );
}

/// Check if point is within a polygon described by array of vertices
pub fn CheckCollisionPointPoly(
    point: Vector2,
    points: ?[*]Vector2,
    pointCount: i32,
) bool {
    return raylib.mCheckCollisionPointPoly(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&point))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(points))),
        pointCount,
    );
}

/// Check the collision between two lines defined by two points each, returns collision point by reference
pub fn CheckCollisionLines(
    startPos1: Vector2,
    endPos1: Vector2,
    startPos2: Vector2,
    endPos2: Vector2,
    collisionPoint: ?[*]Vector2,
) bool {
    return raylib.mCheckCollisionLines(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&startPos1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&endPos1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&startPos2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&endPos2))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(collisionPoint))),
    );
}

/// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub fn CheckCollisionPointLine(
    point: Vector2,
    p1: Vector2,
    p2: Vector2,
    threshold: i32,
) bool {
    return raylib.mCheckCollisionPointLine(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&point))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p2))),
        threshold,
    );
}

/// Get collision rectangle for two rectangles collision
pub fn GetCollisionRec(
    rec1: Rectangle,
    rec2: Rectangle,
) Rectangle {
    var out: Rectangle = undefined;
    raylib.mGetCollisionRec(
        @as([*c]raylib.Rectangle, @ptrCast(&out)),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec1))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec2))),
    );
    return out;
}

/// Load image from file into CPU memory (RAM)
pub fn LoadImage(
    fileName: [*:0]const u8,
) Image {
    var out: Image = undefined;
    raylib.mLoadImage(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Load image from RAW file data
pub fn LoadImageRaw(
    fileName: [*:0]const u8,
    width: i32,
    height: i32,
    format: i32,
    headerSize: i32,
) Image {
    var out: Image = undefined;
    raylib.mLoadImageRaw(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        width,
        height,
        format,
        headerSize,
    );
    return out;
}

/// Load image from SVG file data or string with specified size
pub fn LoadImageSvg(
    fileNameOrString: [*:0]const u8,
    width: i32,
    height: i32,
) Image {
    var out: Image = undefined;
    raylib.mLoadImageSvg(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileNameOrString))),
        width,
        height,
    );
    return out;
}

/// Load image sequence from file (frames appended to image.data)
pub fn LoadImageAnim(
    fileName: [*:0]const u8,
    frames: ?[*]i32,
) Image {
    var out: Image = undefined;
    raylib.mLoadImageAnim(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        @as([*c]i32, @ptrCast(frames)),
    );
    return out;
}

/// Load image sequence from memory buffer
pub fn LoadImageAnimFromMemory(
    fileType: [*:0]const u8,
    fileData: [*:0]const u8,
    dataSize: i32,
    frames: ?[*]i32,
) Image {
    var out: Image = undefined;
    raylib.mLoadImageAnimFromMemory(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileType))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileData))),
        dataSize,
        @as([*c]i32, @ptrCast(frames)),
    );
    return out;
}

/// Load image from memory buffer, fileType refers to extension: i.e. '.png'
pub fn LoadImageFromMemory(
    fileType: [*:0]const u8,
    fileData: [*:0]const u8,
    dataSize: i32,
) Image {
    var out: Image = undefined;
    raylib.mLoadImageFromMemory(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileType))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileData))),
        dataSize,
    );
    return out;
}

/// Load image from GPU texture data
pub fn LoadImageFromTexture(
    texture: Texture2D,
) Image {
    var out: Image = undefined;
    raylib.mLoadImageFromTexture(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
    );
    return out;
}

/// Load image from screen buffer and (screenshot)
pub fn LoadImageFromScreen() Image {
    var out: Image = undefined;
    raylib.mLoadImageFromScreen(
        @as([*c]raylib.Image, @ptrCast(&out)),
    );
    return out;
}

/// Check if an image is ready
pub fn IsImageReady(
    image: Image,
) bool {
    return raylib.mIsImageReady(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
    );
}

/// Unload image from CPU memory (RAM)
pub fn UnloadImage(
    image: Image,
) void {
    raylib.mUnloadImage(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
    );
}

/// Export image data to file, returns true on success
pub fn ExportImage(
    image: Image,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportImage(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Export image to memory buffer
pub fn ExportImageToMemory(
    image: Image,
    fileType: [*:0]const u8,
    fileSize: ?[*]i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mExportImageToMemory(
            @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
            @as([*c]const u8, @ptrFromInt(@intFromPtr(fileType))),
            @as([*c]i32, @ptrCast(fileSize)),
        )),
    );
}

/// Export image as code file defining an array of bytes, returns true on success
pub fn ExportImageAsCode(
    image: Image,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportImageAsCode(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Generate image: plain color
pub fn GenImageColor(
    width: i32,
    height: i32,
    color: Color,
) Image {
    var out: Image = undefined;
    raylib.mGenImageColor(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
    return out;
}

/// Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
pub fn GenImageGradientLinear(
    width: i32,
    height: i32,
    direction: i32,
    start: Color,
    end: Color,
) Image {
    var out: Image = undefined;
    raylib.mGenImageGradientLinear(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        direction,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&start))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&end))),
    );
    return out;
}

/// Generate image: radial gradient
pub fn GenImageGradientRadial(
    width: i32,
    height: i32,
    density: f32,
    inner: Color,
    outer: Color,
) Image {
    var out: Image = undefined;
    raylib.mGenImageGradientRadial(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        density,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&inner))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&outer))),
    );
    return out;
}

/// Generate image: square gradient
pub fn GenImageGradientSquare(
    width: i32,
    height: i32,
    density: f32,
    inner: Color,
    outer: Color,
) Image {
    var out: Image = undefined;
    raylib.mGenImageGradientSquare(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        density,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&inner))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&outer))),
    );
    return out;
}

/// Generate image: checked
pub fn GenImageChecked(
    width: i32,
    height: i32,
    checksX: i32,
    checksY: i32,
    col1: Color,
    col2: Color,
) Image {
    var out: Image = undefined;
    raylib.mGenImageChecked(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        checksX,
        checksY,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&col1))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&col2))),
    );
    return out;
}

/// Generate image: white noise
pub fn GenImageWhiteNoise(
    width: i32,
    height: i32,
    factor: f32,
) Image {
    var out: Image = undefined;
    raylib.mGenImageWhiteNoise(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        factor,
    );
    return out;
}

/// Generate image: perlin noise
pub fn GenImagePerlinNoise(
    width: i32,
    height: i32,
    offsetX: i32,
    offsetY: i32,
    scale: f32,
) Image {
    var out: Image = undefined;
    raylib.mGenImagePerlinNoise(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        offsetX,
        offsetY,
        scale,
    );
    return out;
}

/// Generate image: cellular algorithm, bigger tileSize means bigger cells
pub fn GenImageCellular(
    width: i32,
    height: i32,
    tileSize: i32,
) Image {
    var out: Image = undefined;
    raylib.mGenImageCellular(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        tileSize,
    );
    return out;
}

/// Generate image: grayscale image from text data
pub fn GenImageText(
    width: i32,
    height: i32,
    text: [*:0]const u8,
) Image {
    var out: Image = undefined;
    raylib.mGenImageText(
        @as([*c]raylib.Image, @ptrCast(&out)),
        width,
        height,
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
    );
    return out;
}

/// Create an image duplicate (useful for transformations)
pub fn ImageCopy(
    image: Image,
) Image {
    var out: Image = undefined;
    raylib.mImageCopy(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
    );
    return out;
}

/// Create an image from another image piece
pub fn ImageFromImage(
    image: Image,
    rec: Rectangle,
) Image {
    var out: Image = undefined;
    raylib.mImageFromImage(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
    );
    return out;
}

/// Create an image from text (default font)
pub fn ImageText(
    text: [*:0]const u8,
    fontSize: i32,
    color: Color,
) Image {
    var out: Image = undefined;
    raylib.mImageText(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        fontSize,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
    return out;
}

/// Create an image from text (custom sprite font)
pub fn ImageTextEx(
    font: Font,
    text: [*:0]const u8,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) Image {
    var out: Image = undefined;
    raylib.mImageTextEx(
        @as([*c]raylib.Image, @ptrCast(&out)),
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        fontSize,
        spacing,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
    return out;
}

/// Convert image data to desired format
pub fn ImageFormat(
    image: *Image,
    newFormat: i32,
) void {
    raylib.mImageFormat(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        newFormat,
    );
}

/// Convert image to POT (power-of-two)
pub fn ImageToPOT(
    image: *Image,
    fill: Color,
) void {
    raylib.mImageToPOT(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&fill))),
    );
}

/// Crop an image to a defined rectangle
pub fn ImageCrop(
    image: *Image,
    crop: Rectangle,
) void {
    raylib.mImageCrop(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&crop))),
    );
}

/// Crop image depending on alpha value
pub fn ImageAlphaCrop(
    image: *Image,
    threshold: f32,
) void {
    raylib.mImageAlphaCrop(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        threshold,
    );
}

/// Clear alpha channel to desired color
pub fn ImageAlphaClear(
    image: *Image,
    color: Color,
    threshold: f32,
) void {
    raylib.mImageAlphaClear(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        threshold,
    );
}

/// Apply alpha mask to image
pub fn ImageAlphaMask(
    image: *Image,
    alphaMask: Image,
) void {
    raylib.mImageAlphaMask(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&alphaMask))),
    );
}

/// Premultiply alpha channel
pub fn ImageAlphaPremultiply(
    image: *Image,
) void {
    raylib.mImageAlphaPremultiply(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Apply Gaussian blur using a box blur approximation
pub fn ImageBlurGaussian(
    image: *Image,
    blurSize: i32,
) void {
    raylib.mImageBlurGaussian(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        blurSize,
    );
}

/// Apply Custom Square image convolution kernel
pub fn ImageKernelConvolution(
    image: *Image,
    kernel: ?[*]f32,
    kernelSize: i32,
) void {
    raylib.mImageKernelConvolution(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        @as([*c]f32, @ptrCast(kernel)),
        kernelSize,
    );
}

/// Resize image (Bicubic scaling algorithm)
pub fn ImageResize(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.mImageResize(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        newWidth,
        newHeight,
    );
}

/// Resize image (Nearest-Neighbor scaling algorithm)
pub fn ImageResizeNN(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.mImageResizeNN(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        newWidth,
        newHeight,
    );
}

/// Resize canvas and fill with color
pub fn ImageResizeCanvas(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
    offsetX: i32,
    offsetY: i32,
    fill: Color,
) void {
    raylib.mImageResizeCanvas(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        newWidth,
        newHeight,
        offsetX,
        offsetY,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&fill))),
    );
}

/// Compute all mipmap levels for a provided image
pub fn ImageMipmaps(
    image: *Image,
) void {
    raylib.mImageMipmaps(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub fn ImageDither(
    image: *Image,
    rBpp: i32,
    gBpp: i32,
    bBpp: i32,
    aBpp: i32,
) void {
    raylib.mImageDither(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        rBpp,
        gBpp,
        bBpp,
        aBpp,
    );
}

/// Flip image vertically
pub fn ImageFlipVertical(
    image: *Image,
) void {
    raylib.mImageFlipVertical(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Flip image horizontally
pub fn ImageFlipHorizontal(
    image: *Image,
) void {
    raylib.mImageFlipHorizontal(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Rotate image by input angle in degrees (-359 to 359)
pub fn ImageRotate(
    image: *Image,
    degrees: i32,
) void {
    raylib.mImageRotate(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        degrees,
    );
}

/// Rotate image clockwise 90deg
pub fn ImageRotateCW(
    image: *Image,
) void {
    raylib.mImageRotateCW(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Rotate image counter-clockwise 90deg
pub fn ImageRotateCCW(
    image: *Image,
) void {
    raylib.mImageRotateCCW(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Modify image color: tint
pub fn ImageColorTint(
    image: *Image,
    color: Color,
) void {
    raylib.mImageColorTint(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Modify image color: invert
pub fn ImageColorInvert(
    image: *Image,
) void {
    raylib.mImageColorInvert(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Modify image color: grayscale
pub fn ImageColorGrayscale(
    image: *Image,
) void {
    raylib.mImageColorGrayscale(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
    );
}

/// Modify image color: contrast (-100 to 100)
pub fn ImageColorContrast(
    image: *Image,
    contrast: f32,
) void {
    raylib.mImageColorContrast(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        contrast,
    );
}

/// Modify image color: brightness (-255 to 255)
pub fn ImageColorBrightness(
    image: *Image,
    brightness: i32,
) void {
    raylib.mImageColorBrightness(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        brightness,
    );
}

/// Modify image color: replace color
pub fn ImageColorReplace(
    image: *Image,
    color: Color,
    replace: Color,
) void {
    raylib.mImageColorReplace(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(image))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&replace))),
    );
}

/// Load color data from image as a Color array (RGBA - 32bit)
pub fn LoadImageColors(
    image: Image,
) ?[*]Color {
    return @as(
        ?[*]Color,
        @ptrCast(raylib.mLoadImageColors(
            @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        )),
    );
}

/// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn LoadImagePalette(
    image: Image,
    maxPaletteSize: i32,
    colorCount: ?[*]i32,
) ?[*]Color {
    return @as(
        ?[*]Color,
        @ptrCast(raylib.mLoadImagePalette(
            @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
            maxPaletteSize,
            @as([*c]i32, @ptrCast(colorCount)),
        )),
    );
}

/// Unload color data loaded with LoadImageColors()
pub fn UnloadImageColors(
    colors: ?[*]Color,
) void {
    raylib.mUnloadImageColors(
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(colors))),
    );
}

/// Unload colors palette loaded with LoadImagePalette()
pub fn UnloadImagePalette(
    colors: ?[*]Color,
) void {
    raylib.mUnloadImagePalette(
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(colors))),
    );
}

/// Get image alpha border rectangle
pub fn GetImageAlphaBorder(
    image: Image,
    threshold: f32,
) Rectangle {
    var out: Rectangle = undefined;
    raylib.mGetImageAlphaBorder(
        @as([*c]raylib.Rectangle, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        threshold,
    );
    return out;
}

/// Get image pixel color at (x, y) position
pub fn GetImageColor(
    image: Image,
    x: i32,
    y: i32,
) Color {
    var out: Color = undefined;
    raylib.mGetImageColor(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        x,
        y,
    );
    return out;
}

/// Clear image background with given color
pub fn ImageClearBackground(
    dst: *Image,
    color: Color,
) void {
    raylib.mImageClearBackground(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw pixel within an image
pub fn ImageDrawPixel(
    dst: *Image,
    posX: i32,
    posY: i32,
    color: Color,
) void {
    raylib.mImageDrawPixel(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        posX,
        posY,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw pixel within an image (Vector version)
pub fn ImageDrawPixelV(
    dst: *Image,
    position: Vector2,
    color: Color,
) void {
    raylib.mImageDrawPixelV(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw line within an image
pub fn ImageDrawLine(
    dst: *Image,
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: Color,
) void {
    raylib.mImageDrawLine(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        startPosX,
        startPosY,
        endPosX,
        endPosY,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw line within an image (Vector version)
pub fn ImageDrawLineV(
    dst: *Image,
    start: Vector2,
    end: Vector2,
    color: Color,
) void {
    raylib.mImageDrawLineV(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&start))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&end))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a filled circle within an image
pub fn ImageDrawCircle(
    dst: *Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: Color,
) void {
    raylib.mImageDrawCircle(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        centerX,
        centerY,
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a filled circle within an image (Vector version)
pub fn ImageDrawCircleV(
    dst: *Image,
    center: Vector2,
    radius: i32,
    color: Color,
) void {
    raylib.mImageDrawCircleV(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw circle outline within an image
pub fn ImageDrawCircleLines(
    dst: *Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: Color,
) void {
    raylib.mImageDrawCircleLines(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        centerX,
        centerY,
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw circle outline within an image (Vector version)
pub fn ImageDrawCircleLinesV(
    dst: *Image,
    center: Vector2,
    radius: i32,
    color: Color,
) void {
    raylib.mImageDrawCircleLinesV(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&center))),
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangle(
    dst: *Image,
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {
    raylib.mImageDrawRectangle(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        posX,
        posY,
        width,
        height,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw rectangle within an image (Vector version)
pub fn ImageDrawRectangleV(
    dst: *Image,
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    raylib.mImageDrawRectangleV(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&size))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangleRec(
    dst: *Image,
    rec: Rectangle,
    color: Color,
) void {
    raylib.mImageDrawRectangleRec(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw rectangle lines within an image
pub fn ImageDrawRectangleLines(
    dst: *Image,
    rec: Rectangle,
    thick: i32,
    color: Color,
) void {
    raylib.mImageDrawRectangleLines(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        thick,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a source image within a destination image (tint applied to source)
pub fn ImageDraw(
    dst: *Image,
    src: Image,
    srcRec: Rectangle,
    dstRec: Rectangle,
    tint: Color,
) void {
    raylib.mImageDraw(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&src))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&srcRec))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&dstRec))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw text (using default font) within an image (destination)
pub fn ImageDrawText(
    dst: *Image,
    text: [*:0]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {
    raylib.mImageDrawText(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        posX,
        posY,
        fontSize,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw text (custom sprite font) within an image (destination)
pub fn ImageDrawTextEx(
    dst: *Image,
    font: Font,
    text: [*:0]const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.mImageDrawTextEx(
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(dst))),
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        fontSize,
        spacing,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Load texture from file into GPU memory (VRAM)
pub fn LoadTexture(
    fileName: [*:0]const u8,
) Texture2D {
    var out: Texture2D = undefined;
    raylib.mLoadTexture(
        @as([*c]raylib.Texture2D, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Load texture from image data
pub fn LoadTextureFromImage(
    image: Image,
) Texture2D {
    var out: Texture2D = undefined;
    raylib.mLoadTextureFromImage(
        @as([*c]raylib.Texture2D, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
    );
    return out;
}

/// Load cubemap from image, multiple image cubemap layouts supported
pub fn LoadTextureCubemap(
    image: Image,
    layout: i32,
) Texture2D {
    var out: Texture2D = undefined;
    raylib.mLoadTextureCubemap(
        @as([*c]raylib.Texture2D, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        layout,
    );
    return out;
}

/// Load texture for rendering (framebuffer)
pub fn LoadRenderTexture(
    width: i32,
    height: i32,
) RenderTexture2D {
    var out: RenderTexture2D = undefined;
    raylib.mLoadRenderTexture(
        @as([*c]raylib.RenderTexture2D, @ptrCast(&out)),
        width,
        height,
    );
    return out;
}

/// Check if a texture is ready
pub fn IsTextureReady(
    texture: Texture2D,
) bool {
    return raylib.mIsTextureReady(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
    );
}

/// Unload texture from GPU memory (VRAM)
pub fn UnloadTexture(
    texture: Texture2D,
) void {
    raylib.mUnloadTexture(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
    );
}

/// Check if a render texture is ready
pub fn IsRenderTextureReady(
    target: RenderTexture2D,
) bool {
    return raylib.mIsRenderTextureReady(
        @as([*c]raylib.RenderTexture2D, @ptrFromInt(@intFromPtr(&target))),
    );
}

/// Unload render texture from GPU memory (VRAM)
pub fn UnloadRenderTexture(
    target: RenderTexture2D,
) void {
    raylib.mUnloadRenderTexture(
        @as([*c]raylib.RenderTexture2D, @ptrFromInt(@intFromPtr(&target))),
    );
}

/// Update GPU texture with new data
pub fn UpdateTexture(
    texture: Texture2D,
    pixels: *const anyopaque,
) void {
    raylib.mUpdateTexture(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        pixels,
    );
}

/// Update GPU texture rectangle with new data
pub fn UpdateTextureRec(
    texture: Texture2D,
    rec: Rectangle,
    pixels: *const anyopaque,
) void {
    raylib.mUpdateTextureRec(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&rec))),
        pixels,
    );
}

/// Set texture scaling filter mode
pub fn SetTextureFilter(
    texture: Texture2D,
    filter: i32,
) void {
    raylib.mSetTextureFilter(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        filter,
    );
}

/// Set texture wrapping mode
pub fn SetTextureWrap(
    texture: Texture2D,
    wrap: i32,
) void {
    raylib.mSetTextureWrap(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        wrap,
    );
}

/// Draw a Texture2D
pub fn DrawTexture(
    texture: Texture2D,
    posX: i32,
    posY: i32,
    tint: Color,
) void {
    raylib.mDrawTexture(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        posX,
        posY,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a Texture2D with position defined as Vector2
pub fn DrawTextureV(
    texture: Texture2D,
    position: Vector2,
    tint: Color,
) void {
    raylib.mDrawTextureV(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a Texture2D with extended parameters
pub fn DrawTextureEx(
    texture: Texture2D,
    position: Vector2,
    rotation: f32,
    scale: f32,
    tint: Color,
) void {
    raylib.mDrawTextureEx(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        rotation,
        scale,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a part of a texture defined by a rectangle
pub fn DrawTextureRec(
    texture: Texture2D,
    source: Rectangle,
    position: Vector2,
    tint: Color,
) void {
    raylib.mDrawTextureRec(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&source))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a part of a texture defined by a rectangle with 'pro' parameters
pub fn DrawTexturePro(
    texture: Texture2D,
    source: Rectangle,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {
    raylib.mDrawTexturePro(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&source))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&dest))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&origin))),
        rotation,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draws a texture (or part of it) that stretches or shrinks nicely
pub fn DrawTextureNPatch(
    texture: Texture2D,
    nPatchInfo: NPatchInfo,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {
    raylib.mDrawTextureNPatch(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.NPatchInfo, @ptrFromInt(@intFromPtr(&nPatchInfo))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&dest))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&origin))),
        rotation,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn Fade(
    color: Color,
    alpha: f32,
) Color {
    var out: Color = undefined;
    raylib.mFade(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        alpha,
    );
    return out;
}

/// Get hexadecimal value for a Color
pub fn ColorToInt(
    color: Color,
) i32 {
    return raylib.mColorToInt(
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Get Color normalized as float [0..1]
pub fn ColorNormalize(
    color: Color,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mColorNormalize(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
    return out;
}

/// Get Color from normalized values [0..1]
pub fn ColorFromNormalized(
    normalized: Vector4,
) Color {
    var out: Color = undefined;
    raylib.mColorFromNormalized(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&normalized))),
    );
    return out;
}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn ColorToHSV(
    color: Color,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mColorToHSV(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
    return out;
}

/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub fn ColorFromHSV(
    hue: f32,
    saturation: f32,
    value: f32,
) Color {
    var out: Color = undefined;
    raylib.mColorFromHSV(
        @as([*c]raylib.Color, @ptrCast(&out)),
        hue,
        saturation,
        value,
    );
    return out;
}

/// Get color multiplied with another color
pub fn ColorTint(
    color: Color,
    tint: Color,
) Color {
    var out: Color = undefined;
    raylib.mColorTint(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
    return out;
}

/// Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
pub fn ColorBrightness(
    color: Color,
    factor: f32,
) Color {
    var out: Color = undefined;
    raylib.mColorBrightness(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        factor,
    );
    return out;
}

/// Get color with contrast correction, contrast values between -1.0f and 1.0f
pub fn ColorContrast(
    color: Color,
    contrast: f32,
) Color {
    var out: Color = undefined;
    raylib.mColorContrast(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        contrast,
    );
    return out;
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn ColorAlpha(
    color: Color,
    alpha: f32,
) Color {
    var out: Color = undefined;
    raylib.mColorAlpha(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        alpha,
    );
    return out;
}

/// Get src alpha-blended into dst color with tint
pub fn ColorAlphaBlend(
    dst: Color,
    src: Color,
    tint: Color,
) Color {
    var out: Color = undefined;
    raylib.mColorAlphaBlend(
        @as([*c]raylib.Color, @ptrCast(&out)),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&dst))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&src))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
    return out;
}

/// Get Color structure from hexadecimal value
pub fn GetColor(
    hexValue: u32,
) Color {
    var out: Color = undefined;
    raylib.mGetColor(
        @as([*c]raylib.Color, @ptrCast(&out)),
        hexValue,
    );
    return out;
}

/// Get Color from a source pixel pointer of certain format
pub fn GetPixelColor(
    srcPtr: *anyopaque,
    format: i32,
) Color {
    var out: Color = undefined;
    raylib.mGetPixelColor(
        @as([*c]raylib.Color, @ptrCast(&out)),
        srcPtr,
        format,
    );
    return out;
}

/// Set color formatted into destination pixel pointer
pub fn SetPixelColor(
    dstPtr: *anyopaque,
    color: Color,
    format: i32,
) void {
    raylib.mSetPixelColor(
        dstPtr,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
        format,
    );
}

/// Get pixel data size in bytes for certain format
pub fn GetPixelDataSize(
    width: i32,
    height: i32,
    format: i32,
) i32 {
    return raylib.mGetPixelDataSize(
        width,
        height,
        format,
    );
}

/// Get the default Font
pub fn GetFontDefault() Font {
    var out: Font = undefined;
    raylib.mGetFontDefault(
        @as([*c]raylib.Font, @ptrCast(&out)),
    );
    return out;
}

/// Load font from file into GPU memory (VRAM)
pub fn LoadFont(
    fileName: [*:0]const u8,
) Font {
    var out: Font = undefined;
    raylib.mLoadFont(
        @as([*c]raylib.Font, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character setFont
pub fn LoadFontEx(
    fileName: [*:0]const u8,
    fontSize: i32,
    codepoints: ?[*]i32,
    codepointCount: i32,
) Font {
    var out: Font = undefined;
    raylib.mLoadFontEx(
        @as([*c]raylib.Font, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
        fontSize,
        @as([*c]i32, @ptrCast(codepoints)),
        codepointCount,
    );
    return out;
}

/// Load font from Image (XNA style)
pub fn LoadFontFromImage(
    image: Image,
    key: Color,
    firstChar: i32,
) Font {
    var out: Font = undefined;
    raylib.mLoadFontFromImage(
        @as([*c]raylib.Font, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&image))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&key))),
        firstChar,
    );
    return out;
}

/// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
pub fn LoadFontFromMemory(
    fileType: [*:0]const u8,
    fileData: [*:0]const u8,
    dataSize: i32,
    fontSize: i32,
    codepoints: ?[*]i32,
    codepointCount: i32,
) Font {
    var out: Font = undefined;
    raylib.mLoadFontFromMemory(
        @as([*c]raylib.Font, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileType))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileData))),
        dataSize,
        fontSize,
        @as([*c]i32, @ptrCast(codepoints)),
        codepointCount,
    );
    return out;
}

/// Check if a font is ready
pub fn IsFontReady(
    font: Font,
) bool {
    return raylib.mIsFontReady(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
    );
}

/// Unload font chars info data (RAM)
pub fn UnloadFontData(
    glyphs: ?[*]GlyphInfo,
    glyphCount: i32,
) void {
    raylib.mUnloadFontData(
        @as([*c]raylib.GlyphInfo, @ptrFromInt(@intFromPtr(glyphs))),
        glyphCount,
    );
}

/// Unload font from GPU memory (VRAM)
pub fn UnloadFont(
    font: Font,
) void {
    raylib.mUnloadFont(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
    );
}

/// Export font as code file, returns true on success
pub fn ExportFontAsCode(
    font: Font,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportFontAsCode(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Draw current FPS
pub fn DrawFPS(
    posX: i32,
    posY: i32,
) void {
    raylib.mDrawFPS(
        posX,
        posY,
    );
}

/// Draw text (using default font)
pub fn DrawText(
    text: [*:0]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {
    raylib.mDrawText(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        posX,
        posY,
        fontSize,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw text using font and additional parameters
pub fn DrawTextEx(
    font: Font,
    text: [*:0]const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.mDrawTextEx(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        fontSize,
        spacing,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw text using Font and pro parameters (rotation)
pub fn DrawTextPro(
    font: Font,
    text: [*:0]const u8,
    position: Vector2,
    origin: Vector2,
    rotation: f32,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.mDrawTextPro(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&origin))),
        rotation,
        fontSize,
        spacing,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw one character (codepoint)
pub fn DrawTextCodepoint(
    font: Font,
    codepoint: i32,
    position: Vector2,
    fontSize: f32,
    tint: Color,
) void {
    raylib.mDrawTextCodepoint(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        codepoint,
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        fontSize,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw multiple character (codepoint)
pub fn DrawTextCodepoints(
    font: Font,
    codepoints: ?[*]const i32,
    codepointCount: i32,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.mDrawTextCodepoints(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        @as([*c]const i32, @ptrFromInt(@intFromPtr(codepoints))),
        codepointCount,
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&position))),
        fontSize,
        spacing,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Set vertical line spacing when drawing with line-breaks
pub fn SetTextLineSpacing(
    spacing: i32,
) void {
    raylib.mSetTextLineSpacing(
        spacing,
    );
}

/// Measure string width for default font
pub fn MeasureText(
    text: [*:0]const u8,
    fontSize: i32,
) i32 {
    return raylib.mMeasureText(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        fontSize,
    );
}

/// Measure string size for Font
pub fn MeasureTextEx(
    font: Font,
    text: [*:0]const u8,
    fontSize: f32,
    spacing: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mMeasureTextEx(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        fontSize,
        spacing,
    );
    return out;
}

/// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphIndex(
    font: Font,
    codepoint: i32,
) i32 {
    return raylib.mGetGlyphIndex(
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        codepoint,
    );
}

/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphInfo(
    font: Font,
    codepoint: i32,
) GlyphInfo {
    var out: GlyphInfo = undefined;
    raylib.mGetGlyphInfo(
        @as([*c]raylib.GlyphInfo, @ptrCast(&out)),
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        codepoint,
    );
    return out;
}

/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphAtlasRec(
    font: Font,
    codepoint: i32,
) Rectangle {
    var out: Rectangle = undefined;
    raylib.mGetGlyphAtlasRec(
        @as([*c]raylib.Rectangle, @ptrCast(&out)),
        @as([*c]raylib.Font, @ptrFromInt(@intFromPtr(&font))),
        codepoint,
    );
    return out;
}

/// Load UTF-8 text encoded from codepoints array
pub fn LoadUTF8(
    codepoints: ?[*]const i32,
    length: i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mLoadUTF8(
            @as([*c]const i32, @ptrFromInt(@intFromPtr(codepoints))),
            length,
        )),
    );
}

/// Unload UTF-8 text encoded from codepoints array
pub fn UnloadUTF8(
    text: ?[*]u8,
) void {
    raylib.mUnloadUTF8(
        @as([*c]u8, @ptrCast(text)),
    );
}

/// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
pub fn LoadCodepoints(
    text: [*:0]const u8,
    count: ?[*]i32,
) ?[*]i32 {
    return @as(
        ?[*]i32,
        @ptrCast(raylib.mLoadCodepoints(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
            @as([*c]i32, @ptrCast(count)),
        )),
    );
}

/// Unload codepoints data from memory
pub fn UnloadCodepoints(
    codepoints: ?[*]i32,
) void {
    raylib.mUnloadCodepoints(
        @as([*c]i32, @ptrCast(codepoints)),
    );
}

/// Get total number of codepoints in a UTF-8 encoded string
pub fn GetCodepointCount(
    text: [*:0]const u8,
) i32 {
    return raylib.mGetCodepointCount(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
    );
}

/// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn GetCodepoint(
    text: [*:0]const u8,
    codepointSize: ?[*]i32,
) i32 {
    return raylib.mGetCodepoint(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        @as([*c]i32, @ptrCast(codepointSize)),
    );
}

/// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn GetCodepointNext(
    text: [*:0]const u8,
    codepointSize: ?[*]i32,
) i32 {
    return raylib.mGetCodepointNext(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        @as([*c]i32, @ptrCast(codepointSize)),
    );
}

/// Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn GetCodepointPrevious(
    text: [*:0]const u8,
    codepointSize: ?[*]i32,
) i32 {
    return raylib.mGetCodepointPrevious(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        @as([*c]i32, @ptrCast(codepointSize)),
    );
}

/// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
pub fn CodepointToUTF8(
    codepoint: i32,
    utf8Size: ?[*]i32,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mCodepointToUTF8(
            codepoint,
            @as([*c]i32, @ptrCast(utf8Size)),
        )),
    );
}

/// Copy one string to another, returns bytes copied
pub fn TextCopy(
    dst: ?[*]u8,
    src: [*:0]const u8,
) i32 {
    return raylib.mTextCopy(
        @as([*c]u8, @ptrCast(dst)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(src))),
    );
}

/// Check if two text string are equal
pub fn TextIsEqual(
    text1: [*:0]const u8,
    text2: [*:0]const u8,
) bool {
    return raylib.mTextIsEqual(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text1))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text2))),
    );
}

/// Get text length, checks for '\0' ending
pub fn TextLength(
    text: [*:0]const u8,
) u32 {
    return raylib.mTextLength(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
    );
}

/// Generate GPU mipmaps for a texture
pub fn GenTextureMipmaps(
    texture: *Texture2D,
) void {
    raylib.mGenTextureMipmaps(
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(texture))),
    );
}

/// Get a piece of a text string
pub fn TextSubtext(
    text: [*:0]const u8,
    position: i32,
    length: i32,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mTextSubtext(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
            position,
            length,
        )),
    );
}

/// Replace text string (WARNING: memory must be freed!)
pub fn TextReplace(
    text: [*:0]const u8,
    replace: [*:0]const u8,
    by: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mTextReplace(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
            @as([*c]const u8, @ptrFromInt(@intFromPtr(replace))),
            @as([*c]const u8, @ptrFromInt(@intFromPtr(by))),
        )),
    );
}

/// Insert text in a position (WARNING: memory must be freed!)
pub fn TextInsert(
    text: [*:0]const u8,
    insert: [*:0]const u8,
    position: i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mTextInsert(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
            @as([*c]const u8, @ptrFromInt(@intFromPtr(insert))),
            position,
        )),
    );
}

/// Load font data for further use
pub fn LoadFontData(
    fileData: [*:0]const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: [*]i32,
    glyphCount: i32,
    typ: i32,
) [*]GlyphInfo {
    return @as(
        [*]GlyphInfo,
        @ptrCast(raylib.mLoadFontData(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(fileData))),
            dataSize,
            fontSize,
            @as([*c]i32, @ptrCast(fontChars)),
            glyphCount,
            typ,
        )),
    );
}

///
pub fn rlSetVertexAttribute(
    index: u32,
    compSize: i32,
    typ: i32,
    normalized: bool,
    stride: i32,
    pointer: *anyopaque,
) void {
    raylib.mrlSetVertexAttribute(
        index,
        compSize,
        typ,
        normalized,
        stride,
        pointer,
    );
}

/// Find first text occurrence within a string
pub fn TextFindIndex(
    text: [*:0]const u8,
    find: [*:0]const u8,
) i32 {
    return raylib.mTextFindIndex(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(find))),
    );
}

/// Get upper case version of provided string
pub fn TextToUpper(
    text: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mTextToUpper(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        )),
    );
}

/// Get lower case version of provided string
pub fn TextToLower(
    text: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mTextToLower(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        )),
    );
}

/// Get Pascal case notation version of provided string
pub fn TextToPascal(
    text: [*:0]const u8,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mTextToPascal(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
        )),
    );
}

/// Get integer value from text (negative values not supported)
pub fn TextToInteger(
    text: [*:0]const u8,
) i32 {
    return raylib.mTextToInteger(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
    );
}

/// Get float value from text (negative values not supported)
pub fn TextToFloat(
    text: [*:0]const u8,
) f32 {
    return raylib.mTextToFloat(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(text))),
    );
}

/// Draw a line in 3D world space
pub fn DrawLine3D(
    startPos: Vector3,
    endPos: Vector3,
    color: Color,
) void {
    raylib.mDrawLine3D(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&endPos))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a point in 3D space, actually a small line
pub fn DrawPoint3D(
    position: Vector3,
    color: Color,
) void {
    raylib.mDrawPoint3D(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a circle in 3D world space
pub fn DrawCircle3D(
    center: Vector3,
    radius: f32,
    rotationAxis: Vector3,
    rotationAngle: f32,
    color: Color,
) void {
    raylib.mDrawCircle3D(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&center))),
        radius,
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&rotationAxis))),
        rotationAngle,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle3D(
    v1: Vector3,
    v2: Vector3,
    v3: Vector3,
    color: Color,
) void {
    raylib.mDrawTriangle3D(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v3))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip3D(
    points: ?[*]Vector3,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawTriangleStrip3D(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(points))),
        pointCount,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw cube
pub fn DrawCube(
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {
    raylib.mDrawCube(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        width,
        height,
        length,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw cube (Vector version)
pub fn DrawCubeV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.mDrawCubeV(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&size))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw cube wires
pub fn DrawCubeWires(
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {
    raylib.mDrawCubeWires(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        width,
        height,
        length,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw cube wires (Vector version)
pub fn DrawCubeWiresV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.mDrawCubeWiresV(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&size))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw sphere
pub fn DrawSphere(
    centerPos: Vector3,
    radius: f32,
    color: Color,
) void {
    raylib.mDrawSphere(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&centerPos))),
        radius,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw sphere with extended parameters
pub fn DrawSphereEx(
    centerPos: Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: Color,
) void {
    raylib.mDrawSphereEx(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&centerPos))),
        radius,
        rings,
        slices,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw sphere wires
pub fn DrawSphereWires(
    centerPos: Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: Color,
) void {
    raylib.mDrawSphereWires(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&centerPos))),
        radius,
        rings,
        slices,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a cylinder/cone
pub fn DrawCylinder(
    position: Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: Color,
) void {
    raylib.mDrawCylinder(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        radiusTop,
        radiusBottom,
        height,
        slices,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a cylinder with base at startPos and top at endPos
pub fn DrawCylinderEx(
    startPos: Vector3,
    endPos: Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: Color,
) void {
    raylib.mDrawCylinderEx(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&endPos))),
        startRadius,
        endRadius,
        sides,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a cylinder/cone wires
pub fn DrawCylinderWires(
    position: Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: Color,
) void {
    raylib.mDrawCylinderWires(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        radiusTop,
        radiusBottom,
        height,
        slices,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a cylinder wires with base at startPos and top at endPos
pub fn DrawCylinderWiresEx(
    startPos: Vector3,
    endPos: Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: Color,
) void {
    raylib.mDrawCylinderWiresEx(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&endPos))),
        startRadius,
        endRadius,
        sides,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a capsule with the center of its sphere caps at startPos and endPos
pub fn DrawCapsule(
    startPos: Vector3,
    endPos: Vector3,
    radius: f32,
    slices: i32,
    rings: i32,
    color: Color,
) void {
    raylib.mDrawCapsule(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&endPos))),
        radius,
        slices,
        rings,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw capsule wireframe with the center of its sphere caps at startPos and endPos
pub fn DrawCapsuleWires(
    startPos: Vector3,
    endPos: Vector3,
    radius: f32,
    slices: i32,
    rings: i32,
    color: Color,
) void {
    raylib.mDrawCapsuleWires(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&startPos))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&endPos))),
        radius,
        slices,
        rings,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a plane XZ
pub fn DrawPlane(
    centerPos: Vector3,
    size: Vector2,
    color: Color,
) void {
    raylib.mDrawPlane(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&centerPos))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&size))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a ray line
pub fn DrawRay(
    ray: Ray,
    color: Color,
) void {
    raylib.mDrawRay(
        @as([*c]raylib.Ray, @ptrFromInt(@intFromPtr(&ray))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a grid (centered at (0, 0, 0))
pub fn DrawGrid(
    slices: i32,
    spacing: f32,
) void {
    raylib.mDrawGrid(
        slices,
        spacing,
    );
}

/// Load model from files (meshes and materials)
pub fn LoadModel(
    fileName: [*:0]const u8,
) Model {
    var out: Model = undefined;
    raylib.mLoadModel(
        @as([*c]raylib.Model, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Load model from generated mesh (default material)
pub fn LoadModelFromMesh(
    mesh: Mesh,
) Model {
    var out: Model = undefined;
    raylib.mLoadModelFromMesh(
        @as([*c]raylib.Model, @ptrCast(&out)),
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
    );
    return out;
}

/// Check if a model is ready
pub fn IsModelReady(
    model: Model,
) bool {
    return raylib.mIsModelReady(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
    );
}

/// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn UnloadModel(
    model: Model,
) void {
    raylib.mUnloadModel(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
    );
}

/// Compute model bounding box limits (considers all meshes)
pub fn GetModelBoundingBox(
    model: Model,
) BoundingBox {
    var out: BoundingBox = undefined;
    raylib.mGetModelBoundingBox(
        @as([*c]raylib.BoundingBox, @ptrCast(&out)),
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
    );
    return out;
}

/// Draw a model (with texture if set)
pub fn DrawModel(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {
    raylib.mDrawModel(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        scale,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a model with extended parameters
pub fn DrawModelEx(
    model: Model,
    position: Vector3,
    rotationAxis: Vector3,
    rotationAngle: f32,
    scale: Vector3,
    tint: Color,
) void {
    raylib.mDrawModelEx(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&rotationAxis))),
        rotationAngle,
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&scale))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a model wires (with texture if set)
pub fn DrawModelWires(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {
    raylib.mDrawModelWires(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        scale,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a model wires (with texture if set) with extended parameters
pub fn DrawModelWiresEx(
    model: Model,
    position: Vector3,
    rotationAxis: Vector3,
    rotationAngle: f32,
    scale: Vector3,
    tint: Color,
) void {
    raylib.mDrawModelWiresEx(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&rotationAxis))),
        rotationAngle,
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&scale))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw bounding box (wires)
pub fn DrawBoundingBox(
    box: BoundingBox,
    color: Color,
) void {
    raylib.mDrawBoundingBox(
        @as([*c]raylib.BoundingBox, @ptrFromInt(@intFromPtr(&box))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&color))),
    );
}

/// Draw a billboard texture
pub fn DrawBillboard(
    camera: Camera3D,
    texture: Texture2D,
    position: Vector3,
    size: f32,
    tint: Color,
) void {
    raylib.mDrawBillboard(
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        size,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a billboard texture defined by source
pub fn DrawBillboardRec(
    camera: Camera3D,
    texture: Texture2D,
    source: Rectangle,
    position: Vector3,
    size: Vector2,
    tint: Color,
) void {
    raylib.mDrawBillboardRec(
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&source))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&size))),
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Draw a billboard texture defined by source and rotation
pub fn DrawBillboardPro(
    camera: Camera3D,
    texture: Texture2D,
    source: Rectangle,
    position: Vector3,
    up: Vector3,
    size: Vector2,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {
    raylib.mDrawBillboardPro(
        @as([*c]raylib.Camera3D, @ptrFromInt(@intFromPtr(&camera))),
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
        @as([*c]raylib.Rectangle, @ptrFromInt(@intFromPtr(&source))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&position))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&up))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&size))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&origin))),
        rotation,
        @as([*c]raylib.Color, @ptrFromInt(@intFromPtr(&tint))),
    );
}

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
pub fn UploadMesh(
    mesh: ?[*]Mesh,
    dynamic: bool,
) void {
    raylib.mUploadMesh(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(mesh))),
        dynamic,
    );
}

/// Update mesh vertex data in GPU for a specific buffer index
pub fn UpdateMeshBuffer(
    mesh: Mesh,
    index: i32,
    data: *const anyopaque,
    dataSize: i32,
    offset: i32,
) void {
    raylib.mUpdateMeshBuffer(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
        index,
        data,
        dataSize,
        offset,
    );
}

/// Unload mesh data from CPU and GPU
pub fn UnloadMesh(
    mesh: Mesh,
) void {
    raylib.mUnloadMesh(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
    );
}

/// Draw a 3d mesh with material and transform
pub fn DrawMesh(
    mesh: Mesh,
    material: Material,
    transform: Matrix,
) void {
    raylib.mDrawMesh(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
        @as([*c]raylib.Material, @ptrFromInt(@intFromPtr(&material))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&transform))),
    );
}

/// Draw multiple mesh instances with material and different transforms
pub fn DrawMeshInstanced(
    mesh: Mesh,
    material: Material,
    transforms: ?[*]const Matrix,
    instances: i32,
) void {
    raylib.mDrawMeshInstanced(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
        @as([*c]raylib.Material, @ptrFromInt(@intFromPtr(&material))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(transforms))),
        instances,
    );
}

/// Compute mesh bounding box limits
pub fn GetMeshBoundingBox(
    mesh: Mesh,
) BoundingBox {
    var out: BoundingBox = undefined;
    raylib.mGetMeshBoundingBox(
        @as([*c]raylib.BoundingBox, @ptrCast(&out)),
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
    );
    return out;
}

/// Compute mesh tangents
pub fn GenMeshTangents(
    mesh: ?[*]Mesh,
) void {
    raylib.mGenMeshTangents(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(mesh))),
    );
}

/// Export mesh data to file, returns true on success
pub fn ExportMesh(
    mesh: Mesh,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportMesh(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Export mesh as code file (.h) defining multiple arrays of vertex attributes
pub fn ExportMeshAsCode(
    mesh: Mesh,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportMeshAsCode(
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Generate polygonal mesh
pub fn GenMeshPoly(
    sides: i32,
    radius: f32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshPoly(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        sides,
        radius,
    );
    return out;
}

/// Generate plane mesh (with subdivisions)
pub fn GenMeshPlane(
    width: f32,
    length: f32,
    resX: i32,
    resZ: i32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshPlane(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        width,
        length,
        resX,
        resZ,
    );
    return out;
}

/// Generate cuboid mesh
pub fn GenMeshCube(
    width: f32,
    height: f32,
    length: f32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshCube(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        width,
        height,
        length,
    );
    return out;
}

/// Generate sphere mesh (standard sphere)
pub fn GenMeshSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshSphere(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        radius,
        rings,
        slices,
    );
    return out;
}

/// Generate half-sphere mesh (no bottom cap)
pub fn GenMeshHemiSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshHemiSphere(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        radius,
        rings,
        slices,
    );
    return out;
}

/// Generate cylinder mesh
pub fn GenMeshCylinder(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshCylinder(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        radius,
        height,
        slices,
    );
    return out;
}

/// Generate cone/pyramid mesh
pub fn GenMeshCone(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshCone(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        radius,
        height,
        slices,
    );
    return out;
}

/// Generate torus mesh
pub fn GenMeshTorus(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshTorus(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        radius,
        size,
        radSeg,
        sides,
    );
    return out;
}

/// Generate trefoil knot mesh
pub fn GenMeshKnot(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshKnot(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        radius,
        size,
        radSeg,
        sides,
    );
    return out;
}

/// Generate heightmap mesh from image data
pub fn GenMeshHeightmap(
    heightmap: Image,
    size: Vector3,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshHeightmap(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&heightmap))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&size))),
    );
    return out;
}

/// Generate cubes-based map mesh from image data
pub fn GenMeshCubicmap(
    cubicmap: Image,
    cubeSize: Vector3,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshCubicmap(
        @as([*c]raylib.Mesh, @ptrCast(&out)),
        @as([*c]raylib.Image, @ptrFromInt(@intFromPtr(&cubicmap))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&cubeSize))),
    );
    return out;
}

/// Load materials from model file
pub fn LoadMaterials(
    fileName: [*:0]const u8,
    materialCount: ?[*]i32,
) ?[*]Material {
    return @as(
        ?[*]Material,
        @ptrCast(raylib.mLoadMaterials(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
            @as([*c]i32, @ptrCast(materialCount)),
        )),
    );
}

/// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub fn LoadMaterialDefault() Material {
    var out: Material = undefined;
    raylib.mLoadMaterialDefault(
        @as([*c]raylib.Material, @ptrCast(&out)),
    );
    return out;
}

/// Check if a material is ready
pub fn IsMaterialReady(
    material: Material,
) bool {
    return raylib.mIsMaterialReady(
        @as([*c]raylib.Material, @ptrFromInt(@intFromPtr(&material))),
    );
}

/// Unload material from GPU memory (VRAM)
pub fn UnloadMaterial(
    material: Material,
) void {
    raylib.mUnloadMaterial(
        @as([*c]raylib.Material, @ptrFromInt(@intFromPtr(&material))),
    );
}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn SetMaterialTexture(
    material: ?[*]Material,
    mapType: i32,
    texture: Texture2D,
) void {
    raylib.mSetMaterialTexture(
        @as([*c]raylib.Material, @ptrFromInt(@intFromPtr(material))),
        mapType,
        @as([*c]raylib.Texture2D, @ptrFromInt(@intFromPtr(&texture))),
    );
}

/// Set material for a mesh
pub fn SetModelMeshMaterial(
    model: ?[*]Model,
    meshId: i32,
    materialId: i32,
) void {
    raylib.mSetModelMeshMaterial(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(model))),
        meshId,
        materialId,
    );
}

/// Load model animations from file
pub fn LoadModelAnimations(
    fileName: [*:0]const u8,
    animCount: ?[*]i32,
) ?[*]ModelAnimation {
    return @as(
        ?[*]ModelAnimation,
        @ptrCast(raylib.mLoadModelAnimations(
            @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
            @as([*c]i32, @ptrCast(animCount)),
        )),
    );
}

/// Update model animation pose
pub fn UpdateModelAnimation(
    model: Model,
    anim: ModelAnimation,
    frame: i32,
) void {
    raylib.mUpdateModelAnimation(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
        @as([*c]raylib.ModelAnimation, @ptrFromInt(@intFromPtr(&anim))),
        frame,
    );
}

/// Unload animation data
pub fn UnloadModelAnimation(
    anim: ModelAnimation,
) void {
    raylib.mUnloadModelAnimation(
        @as([*c]raylib.ModelAnimation, @ptrFromInt(@intFromPtr(&anim))),
    );
}

/// Unload animation array data
pub fn UnloadModelAnimations(
    animations: ?[*]ModelAnimation,
    animCount: i32,
) void {
    raylib.mUnloadModelAnimations(
        @as([*c]raylib.ModelAnimation, @ptrFromInt(@intFromPtr(animations))),
        animCount,
    );
}

/// Check model animation skeleton match
pub fn IsModelAnimationValid(
    model: Model,
    anim: ModelAnimation,
) bool {
    return raylib.mIsModelAnimationValid(
        @as([*c]raylib.Model, @ptrFromInt(@intFromPtr(&model))),
        @as([*c]raylib.ModelAnimation, @ptrFromInt(@intFromPtr(&anim))),
    );
}

/// Check collision between two spheres
pub fn CheckCollisionSpheres(
    center1: Vector3,
    radius1: f32,
    center2: Vector3,
    radius2: f32,
) bool {
    return raylib.mCheckCollisionSpheres(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&center1))),
        radius1,
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&center2))),
        radius2,
    );
}

/// Check collision between two bounding boxes
pub fn CheckCollisionBoxes(
    box1: BoundingBox,
    box2: BoundingBox,
) bool {
    return raylib.mCheckCollisionBoxes(
        @as([*c]raylib.BoundingBox, @ptrFromInt(@intFromPtr(&box1))),
        @as([*c]raylib.BoundingBox, @ptrFromInt(@intFromPtr(&box2))),
    );
}

/// Check collision between box and sphere
pub fn CheckCollisionBoxSphere(
    box: BoundingBox,
    center: Vector3,
    radius: f32,
) bool {
    return raylib.mCheckCollisionBoxSphere(
        @as([*c]raylib.BoundingBox, @ptrFromInt(@intFromPtr(&box))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&center))),
        radius,
    );
}

/// Get collision info between ray and sphere
pub fn GetRayCollisionSphere(
    ray: Ray,
    center: Vector3,
    radius: f32,
) RayCollision {
    var out: RayCollision = undefined;
    raylib.mGetRayCollisionSphere(
        @as([*c]raylib.RayCollision, @ptrCast(&out)),
        @as([*c]raylib.Ray, @ptrFromInt(@intFromPtr(&ray))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&center))),
        radius,
    );
    return out;
}

/// Get collision info between ray and box
pub fn GetRayCollisionBox(
    ray: Ray,
    box: BoundingBox,
) RayCollision {
    var out: RayCollision = undefined;
    raylib.mGetRayCollisionBox(
        @as([*c]raylib.RayCollision, @ptrCast(&out)),
        @as([*c]raylib.Ray, @ptrFromInt(@intFromPtr(&ray))),
        @as([*c]raylib.BoundingBox, @ptrFromInt(@intFromPtr(&box))),
    );
    return out;
}

/// Get collision info between ray and mesh
pub fn GetRayCollisionMesh(
    ray: Ray,
    mesh: Mesh,
    transform: Matrix,
) RayCollision {
    var out: RayCollision = undefined;
    raylib.mGetRayCollisionMesh(
        @as([*c]raylib.RayCollision, @ptrCast(&out)),
        @as([*c]raylib.Ray, @ptrFromInt(@intFromPtr(&ray))),
        @as([*c]raylib.Mesh, @ptrFromInt(@intFromPtr(&mesh))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&transform))),
    );
    return out;
}

/// Get collision info between ray and triangle
pub fn GetRayCollisionTriangle(
    ray: Ray,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
) RayCollision {
    var out: RayCollision = undefined;
    raylib.mGetRayCollisionTriangle(
        @as([*c]raylib.RayCollision, @ptrCast(&out)),
        @as([*c]raylib.Ray, @ptrFromInt(@intFromPtr(&ray))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p2))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p3))),
    );
    return out;
}

/// Get collision info between ray and quad
pub fn GetRayCollisionQuad(
    ray: Ray,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
    p4: Vector3,
) RayCollision {
    var out: RayCollision = undefined;
    raylib.mGetRayCollisionQuad(
        @as([*c]raylib.RayCollision, @ptrCast(&out)),
        @as([*c]raylib.Ray, @ptrFromInt(@intFromPtr(&ray))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p2))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p3))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p4))),
    );
    return out;
}

/// Initialize audio device and context
pub fn InitAudioDevice() void {
    raylib.mInitAudioDevice();
}

/// Close the audio device and context
pub fn CloseAudioDevice() void {
    raylib.mCloseAudioDevice();
}

/// Check if audio device has been initialized successfully
pub fn IsAudioDeviceReady() bool {
    return raylib.mIsAudioDeviceReady();
}

/// Set master volume (listener)
pub fn SetMasterVolume(
    volume: f32,
) void {
    raylib.mSetMasterVolume(
        volume,
    );
}

/// Get master volume (listener)
pub fn GetMasterVolume() f32 {
    return raylib.mGetMasterVolume();
}

/// Load wave data from file
pub fn LoadWave(
    fileName: [*:0]const u8,
) Wave {
    var out: Wave = undefined;
    raylib.mLoadWave(
        @as([*c]raylib.Wave, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
pub fn LoadWaveFromMemory(
    fileType: [*:0]const u8,
    fileData: [*:0]const u8,
    dataSize: i32,
) Wave {
    var out: Wave = undefined;
    raylib.mLoadWaveFromMemory(
        @as([*c]raylib.Wave, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileType))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileData))),
        dataSize,
    );
    return out;
}

/// Checks if wave data is ready
pub fn IsWaveReady(
    wave: Wave,
) bool {
    return raylib.mIsWaveReady(
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(&wave))),
    );
}

/// Load sound from file
pub fn LoadSound(
    fileName: [*:0]const u8,
) Sound {
    var out: Sound = undefined;
    raylib.mLoadSound(
        @as([*c]raylib.Sound, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Load sound from wave data
pub fn LoadSoundFromWave(
    wave: Wave,
) Sound {
    var out: Sound = undefined;
    raylib.mLoadSoundFromWave(
        @as([*c]raylib.Sound, @ptrCast(&out)),
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(&wave))),
    );
    return out;
}

/// Create a new sound that shares the same sample data as the source sound, does not own the sound data
pub fn LoadSoundAlias(
    source: Sound,
) Sound {
    var out: Sound = undefined;
    raylib.mLoadSoundAlias(
        @as([*c]raylib.Sound, @ptrCast(&out)),
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&source))),
    );
    return out;
}

/// Checks if a sound is ready
pub fn IsSoundReady(
    sound: Sound,
) bool {
    return raylib.mIsSoundReady(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
    );
}

/// Update sound buffer with new data
pub fn UpdateSound(
    sound: Sound,
    data: *const anyopaque,
    sampleCount: i32,
) void {
    raylib.mUpdateSound(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
        data,
        sampleCount,
    );
}

/// Unload wave data
pub fn UnloadWave(
    wave: Wave,
) void {
    raylib.mUnloadWave(
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(&wave))),
    );
}

/// Unload sound
pub fn UnloadSound(
    sound: Sound,
) void {
    raylib.mUnloadSound(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
    );
}

/// Unload a sound alias (does not deallocate sample data)
pub fn UnloadSoundAlias(
    alias: Sound,
) void {
    raylib.mUnloadSoundAlias(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&alias))),
    );
}

/// Export wave data to file, returns true on success
pub fn ExportWave(
    wave: Wave,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportWave(
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(&wave))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Export wave sample data to code (.h), returns true on success
pub fn ExportWaveAsCode(
    wave: Wave,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportWaveAsCode(
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(&wave))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
}

/// Play a sound
pub fn PlaySound(
    sound: Sound,
) void {
    raylib.mPlaySound(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
    );
}

/// Stop playing a sound
pub fn StopSound(
    sound: Sound,
) void {
    raylib.mStopSound(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
    );
}

/// Pause a sound
pub fn PauseSound(
    sound: Sound,
) void {
    raylib.mPauseSound(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
    );
}

/// Resume a paused sound
pub fn ResumeSound(
    sound: Sound,
) void {
    raylib.mResumeSound(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
    );
}

/// Check if a sound is currently playing
pub fn IsSoundPlaying(
    sound: Sound,
) bool {
    return raylib.mIsSoundPlaying(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
    );
}

/// Set volume for a sound (1.0 is max level)
pub fn SetSoundVolume(
    sound: Sound,
    volume: f32,
) void {
    raylib.mSetSoundVolume(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
        volume,
    );
}

/// Set pitch for a sound (1.0 is base level)
pub fn SetSoundPitch(
    sound: Sound,
    pitch: f32,
) void {
    raylib.mSetSoundPitch(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
        pitch,
    );
}

/// Set pan for a sound (0.5 is center)
pub fn SetSoundPan(
    sound: Sound,
    pan: f32,
) void {
    raylib.mSetSoundPan(
        @as([*c]raylib.Sound, @ptrFromInt(@intFromPtr(&sound))),
        pan,
    );
}

/// Copy a wave to a new wave
pub fn WaveCopy(
    wave: Wave,
) Wave {
    var out: Wave = undefined;
    raylib.mWaveCopy(
        @as([*c]raylib.Wave, @ptrCast(&out)),
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(&wave))),
    );
    return out;
}

/// Crop a wave to defined samples range
pub fn WaveCrop(
    wave: ?[*]Wave,
    initSample: i32,
    finalSample: i32,
) void {
    raylib.mWaveCrop(
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(wave))),
        initSample,
        finalSample,
    );
}

/// Convert wave data to desired format
pub fn WaveFormat(
    wave: ?[*]Wave,
    sampleRate: i32,
    sampleSize: i32,
    channels: i32,
) void {
    raylib.mWaveFormat(
        @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(wave))),
        sampleRate,
        sampleSize,
        channels,
    );
}

/// Load samples data from wave as a 32bit float data array
pub fn LoadWaveSamples(
    wave: Wave,
) ?[*]f32 {
    return @as(
        ?[*]f32,
        @ptrCast(raylib.mLoadWaveSamples(
            @as([*c]raylib.Wave, @ptrFromInt(@intFromPtr(&wave))),
        )),
    );
}

/// Unload samples data loaded with LoadWaveSamples()
pub fn UnloadWaveSamples(
    samples: ?[*]f32,
) void {
    raylib.mUnloadWaveSamples(
        @as([*c]f32, @ptrCast(samples)),
    );
}

/// Load music stream from file
pub fn LoadMusicStream(
    fileName: [*:0]const u8,
) Music {
    var out: Music = undefined;
    raylib.mLoadMusicStream(
        @as([*c]raylib.Music, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileName))),
    );
    return out;
}

/// Load music stream from data
pub fn LoadMusicStreamFromMemory(
    fileType: [*:0]const u8,
    data: [*:0]const u8,
    dataSize: i32,
) Music {
    var out: Music = undefined;
    raylib.mLoadMusicStreamFromMemory(
        @as([*c]raylib.Music, @ptrCast(&out)),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fileType))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(data))),
        dataSize,
    );
    return out;
}

/// Checks if a music stream is ready
pub fn IsMusicReady(
    music: Music,
) bool {
    return raylib.mIsMusicReady(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Unload music stream
pub fn UnloadMusicStream(
    music: Music,
) void {
    raylib.mUnloadMusicStream(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Start music playing
pub fn PlayMusicStream(
    music: Music,
) void {
    raylib.mPlayMusicStream(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Check if music is playing
pub fn IsMusicStreamPlaying(
    music: Music,
) bool {
    return raylib.mIsMusicStreamPlaying(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Updates buffers for music streaming
pub fn UpdateMusicStream(
    music: Music,
) void {
    raylib.mUpdateMusicStream(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Stop music playing
pub fn StopMusicStream(
    music: Music,
) void {
    raylib.mStopMusicStream(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Pause music playing
pub fn PauseMusicStream(
    music: Music,
) void {
    raylib.mPauseMusicStream(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Resume playing paused music
pub fn ResumeMusicStream(
    music: Music,
) void {
    raylib.mResumeMusicStream(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Seek music to a position (in seconds)
pub fn SeekMusicStream(
    music: Music,
    position: f32,
) void {
    raylib.mSeekMusicStream(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
        position,
    );
}

/// Set volume for music (1.0 is max level)
pub fn SetMusicVolume(
    music: Music,
    volume: f32,
) void {
    raylib.mSetMusicVolume(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
        volume,
    );
}

/// Set pitch for a music (1.0 is base level)
pub fn SetMusicPitch(
    music: Music,
    pitch: f32,
) void {
    raylib.mSetMusicPitch(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
        pitch,
    );
}

/// Set pan for a music (0.5 is center)
pub fn SetMusicPan(
    music: Music,
    pan: f32,
) void {
    raylib.mSetMusicPan(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
        pan,
    );
}

/// Get music time length (in seconds)
pub fn GetMusicTimeLength(
    music: Music,
) f32 {
    return raylib.mGetMusicTimeLength(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Get current music time played (in seconds)
pub fn GetMusicTimePlayed(
    music: Music,
) f32 {
    return raylib.mGetMusicTimePlayed(
        @as([*c]raylib.Music, @ptrFromInt(@intFromPtr(&music))),
    );
}

/// Load audio stream (to stream raw audio pcm data)
pub fn LoadAudioStream(
    sampleRate: u32,
    sampleSize: u32,
    channels: u32,
) AudioStream {
    var out: AudioStream = undefined;
    raylib.mLoadAudioStream(
        @as([*c]raylib.AudioStream, @ptrCast(&out)),
        sampleRate,
        sampleSize,
        channels,
    );
    return out;
}

/// Checks if an audio stream is ready
pub fn IsAudioStreamReady(
    stream: AudioStream,
) bool {
    return raylib.mIsAudioStreamReady(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Unload audio stream and free memory
pub fn UnloadAudioStream(
    stream: AudioStream,
) void {
    raylib.mUnloadAudioStream(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Update audio stream buffers with data
pub fn UpdateAudioStream(
    stream: AudioStream,
    data: *const anyopaque,
    frameCount: i32,
) void {
    raylib.mUpdateAudioStream(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
        data,
        frameCount,
    );
}

/// Check if any audio stream buffers requires refill
pub fn IsAudioStreamProcessed(
    stream: AudioStream,
) bool {
    return raylib.mIsAudioStreamProcessed(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Play audio stream
pub fn PlayAudioStream(
    stream: AudioStream,
) void {
    raylib.mPlayAudioStream(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Pause audio stream
pub fn PauseAudioStream(
    stream: AudioStream,
) void {
    raylib.mPauseAudioStream(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Resume audio stream
pub fn ResumeAudioStream(
    stream: AudioStream,
) void {
    raylib.mResumeAudioStream(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Check if audio stream is playing
pub fn IsAudioStreamPlaying(
    stream: AudioStream,
) bool {
    return raylib.mIsAudioStreamPlaying(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Stop audio stream
pub fn StopAudioStream(
    stream: AudioStream,
) void {
    raylib.mStopAudioStream(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
    );
}

/// Set volume for audio stream (1.0 is max level)
pub fn SetAudioStreamVolume(
    stream: AudioStream,
    volume: f32,
) void {
    raylib.mSetAudioStreamVolume(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
        volume,
    );
}

/// Set pitch for audio stream (1.0 is base level)
pub fn SetAudioStreamPitch(
    stream: AudioStream,
    pitch: f32,
) void {
    raylib.mSetAudioStreamPitch(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
        pitch,
    );
}

/// Set pan for audio stream (0.5 is centered)
pub fn SetAudioStreamPan(
    stream: AudioStream,
    pan: f32,
) void {
    raylib.mSetAudioStreamPan(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
        pan,
    );
}

/// Default size for new audio streams
pub fn SetAudioStreamBufferSizeDefault(
    size: i32,
) void {
    raylib.mSetAudioStreamBufferSizeDefault(
        size,
    );
}

/// Audio thread callback to request new data
pub fn SetAudioStreamCallback(
    stream: AudioStream,
    callback: AudioCallback,
) void {
    raylib.mSetAudioStreamCallback(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
        @ptrCast(callback),
    );
}

/// Attach audio stream processor to stream, receives the samples as <float>s
pub fn AttachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.mAttachAudioStreamProcessor(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
        @ptrCast(processor),
    );
}

/// Detach audio stream processor from stream
pub fn DetachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.mDetachAudioStreamProcessor(
        @as([*c]raylib.AudioStream, @ptrFromInt(@intFromPtr(&stream))),
        @ptrCast(processor),
    );
}

/// Attach audio stream processor to the entire audio pipeline, receives the samples as <float>s
pub fn AttachAudioMixedProcessor(
    processor: AudioCallback,
) void {
    raylib.mAttachAudioMixedProcessor(
        @ptrCast(processor),
    );
}

/// Detach audio stream processor from the entire audio pipeline
pub fn DetachAudioMixedProcessor(
    processor: AudioCallback,
) void {
    raylib.mDetachAudioMixedProcessor(
        @ptrCast(processor),
    );
}

/// Choose the current matrix to be transformed
pub fn rlMatrixMode(
    mode: i32,
) void {
    raylib.mrlMatrixMode(
        mode,
    );
}

/// Push the current matrix to stack
pub fn rlPushMatrix() void {
    raylib.mrlPushMatrix();
}

/// Pop latest inserted matrix from stack
pub fn rlPopMatrix() void {
    raylib.mrlPopMatrix();
}

/// Reset current matrix to identity matrix
pub fn rlLoadIdentity() void {
    raylib.mrlLoadIdentity();
}

/// Multiply the current matrix by a translation matrix
pub fn rlTranslatef(
    x: f32,
    y: f32,
    z: f32,
) void {
    raylib.mrlTranslatef(
        x,
        y,
        z,
    );
}

/// Multiply the current matrix by a rotation matrix
pub fn rlRotatef(
    angle: f32,
    x: f32,
    y: f32,
    z: f32,
) void {
    raylib.mrlRotatef(
        angle,
        x,
        y,
        z,
    );
}

/// Multiply the current matrix by a scaling matrix
pub fn rlScalef(
    x: f32,
    y: f32,
    z: f32,
) void {
    raylib.mrlScalef(
        x,
        y,
        z,
    );
}

/// Multiply the current matrix by another matrix
pub fn rlMultMatrixf(
    matf: ?[*]const f32,
) void {
    raylib.mrlMultMatrixf(
        @as([*c]const f32, @ptrFromInt(@intFromPtr(matf))),
    );
}

///
pub fn rlFrustum(
    left: f64,
    right: f64,
    bottom: f64,
    top: f64,
    znear: f64,
    zfar: f64,
) void {
    raylib.mrlFrustum(
        left,
        right,
        bottom,
        top,
        znear,
        zfar,
    );
}

///
pub fn rlOrtho(
    left: f64,
    right: f64,
    bottom: f64,
    top: f64,
    znear: f64,
    zfar: f64,
) void {
    raylib.mrlOrtho(
        left,
        right,
        bottom,
        top,
        znear,
        zfar,
    );
}

/// Set the viewport area
pub fn rlViewport(
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {
    raylib.mrlViewport(
        x,
        y,
        width,
        height,
    );
}

/// Initialize drawing mode (how to organize vertex)
pub fn rlBegin(
    mode: i32,
) void {
    raylib.mrlBegin(
        mode,
    );
}

/// Finish vertex providing
pub fn rlEnd() void {
    raylib.mrlEnd();
}

/// Define one vertex (position) - 2 int
pub fn rlVertex2i(
    x: i32,
    y: i32,
) void {
    raylib.mrlVertex2i(
        x,
        y,
    );
}

/// Define one vertex (position) - 2 float
pub fn rlVertex2f(
    x: f32,
    y: f32,
) void {
    raylib.mrlVertex2f(
        x,
        y,
    );
}

/// Define one vertex (position) - 3 float
pub fn rlVertex3f(
    x: f32,
    y: f32,
    z: f32,
) void {
    raylib.mrlVertex3f(
        x,
        y,
        z,
    );
}

/// Define one vertex (texture coordinate) - 2 float
pub fn rlTexCoord2f(
    x: f32,
    y: f32,
) void {
    raylib.mrlTexCoord2f(
        x,
        y,
    );
}

/// Define one vertex (normal) - 3 float
pub fn rlNormal3f(
    x: f32,
    y: f32,
    z: f32,
) void {
    raylib.mrlNormal3f(
        x,
        y,
        z,
    );
}

/// Define one vertex (color) - 4 byte
pub fn rlColor4ub(
    r: u8,
    g: u8,
    b: u8,
    a: u8,
) void {
    raylib.mrlColor4ub(
        r,
        g,
        b,
        a,
    );
}

/// Define one vertex (color) - 3 float
pub fn rlColor3f(
    x: f32,
    y: f32,
    z: f32,
) void {
    raylib.mrlColor3f(
        x,
        y,
        z,
    );
}

/// Define one vertex (color) - 4 float
pub fn rlColor4f(
    x: f32,
    y: f32,
    z: f32,
    w: f32,
) void {
    raylib.mrlColor4f(
        x,
        y,
        z,
        w,
    );
}

/// Enable vertex array (VAO, if supported)
pub fn rlEnableVertexArray(
    vaoId: u32,
) bool {
    return raylib.mrlEnableVertexArray(
        vaoId,
    );
}

/// Disable vertex array (VAO, if supported)
pub fn rlDisableVertexArray() void {
    raylib.mrlDisableVertexArray();
}

/// Enable vertex buffer (VBO)
pub fn rlEnableVertexBuffer(
    id: u32,
) void {
    raylib.mrlEnableVertexBuffer(
        id,
    );
}

/// Disable vertex buffer (VBO)
pub fn rlDisableVertexBuffer() void {
    raylib.mrlDisableVertexBuffer();
}

/// Enable vertex buffer element (VBO element)
pub fn rlEnableVertexBufferElement(
    id: u32,
) void {
    raylib.mrlEnableVertexBufferElement(
        id,
    );
}

/// Disable vertex buffer element (VBO element)
pub fn rlDisableVertexBufferElement() void {
    raylib.mrlDisableVertexBufferElement();
}

/// Enable vertex attribute index
pub fn rlEnableVertexAttribute(
    index: u32,
) void {
    raylib.mrlEnableVertexAttribute(
        index,
    );
}

/// Disable vertex attribute index
pub fn rlDisableVertexAttribute(
    index: u32,
) void {
    raylib.mrlDisableVertexAttribute(
        index,
    );
}

/// Select and active a texture slot
pub fn rlActiveTextureSlot(
    slot: i32,
) void {
    raylib.mrlActiveTextureSlot(
        slot,
    );
}

/// Enable texture
pub fn rlEnableTexture(
    id: u32,
) void {
    raylib.mrlEnableTexture(
        id,
    );
}

/// Disable texture
pub fn rlDisableTexture() void {
    raylib.mrlDisableTexture();
}

/// Enable texture cubemap
pub fn rlEnableTextureCubemap(
    id: u32,
) void {
    raylib.mrlEnableTextureCubemap(
        id,
    );
}

/// Disable texture cubemap
pub fn rlDisableTextureCubemap() void {
    raylib.mrlDisableTextureCubemap();
}

/// Set texture parameters (filter, wrap)
pub fn rlTextureParameters(
    id: u32,
    param: i32,
    value: i32,
) void {
    raylib.mrlTextureParameters(
        id,
        param,
        value,
    );
}

/// Set cubemap parameters (filter, wrap)
pub fn rlCubemapParameters(
    id: u32,
    param: i32,
    value: i32,
) void {
    raylib.mrlCubemapParameters(
        id,
        param,
        value,
    );
}

/// Enable shader program
pub fn rlEnableShader(
    id: u32,
) void {
    raylib.mrlEnableShader(
        id,
    );
}

/// Disable shader program
pub fn rlDisableShader() void {
    raylib.mrlDisableShader();
}

/// Enable render texture (fbo)
pub fn rlEnableFramebuffer(
    id: u32,
) void {
    raylib.mrlEnableFramebuffer(
        id,
    );
}

/// Disable render texture (fbo), return to default framebuffer
pub fn rlDisableFramebuffer() void {
    raylib.mrlDisableFramebuffer();
}

/// Activate multiple draw color buffers
pub fn rlActiveDrawBuffers(
    count: i32,
) void {
    raylib.mrlActiveDrawBuffers(
        count,
    );
}

/// Blit active framebuffer to main framebuffer
pub fn rlBlitFramebuffer(
    srcX: i32,
    srcY: i32,
    srcWidth: i32,
    srcHeight: i32,
    dstX: i32,
    dstY: i32,
    dstWidth: i32,
    dstHeight: i32,
    bufferMask: i32,
) void {
    raylib.mrlBlitFramebuffer(
        srcX,
        srcY,
        srcWidth,
        srcHeight,
        dstX,
        dstY,
        dstWidth,
        dstHeight,
        bufferMask,
    );
}

/// Bind framebuffer (FBO)
pub fn rlBindFramebuffer(
    target: u32,
    framebuffer: u32,
) void {
    raylib.mrlBindFramebuffer(
        target,
        framebuffer,
    );
}

/// Enable color blending
pub fn rlEnableColorBlend() void {
    raylib.mrlEnableColorBlend();
}

/// Disable color blending
pub fn rlDisableColorBlend() void {
    raylib.mrlDisableColorBlend();
}

/// Enable depth test
pub fn rlEnableDepthTest() void {
    raylib.mrlEnableDepthTest();
}

/// Disable depth test
pub fn rlDisableDepthTest() void {
    raylib.mrlDisableDepthTest();
}

/// Enable depth write
pub fn rlEnableDepthMask() void {
    raylib.mrlEnableDepthMask();
}

/// Disable depth write
pub fn rlDisableDepthMask() void {
    raylib.mrlDisableDepthMask();
}

/// Enable backface culling
pub fn rlEnableBackfaceCulling() void {
    raylib.mrlEnableBackfaceCulling();
}

/// Disable backface culling
pub fn rlDisableBackfaceCulling() void {
    raylib.mrlDisableBackfaceCulling();
}

/// Color mask control
pub fn rlColorMask(
    r: bool,
    g: bool,
    b: bool,
    a: bool,
) void {
    raylib.mrlColorMask(
        r,
        g,
        b,
        a,
    );
}

/// Set face culling mode
pub fn rlSetCullFace(
    mode: i32,
) void {
    raylib.mrlSetCullFace(
        mode,
    );
}

/// Enable scissor test
pub fn rlEnableScissorTest() void {
    raylib.mrlEnableScissorTest();
}

/// Disable scissor test
pub fn rlDisableScissorTest() void {
    raylib.mrlDisableScissorTest();
}

/// Scissor test
pub fn rlScissor(
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {
    raylib.mrlScissor(
        x,
        y,
        width,
        height,
    );
}

/// Enable wire mode
pub fn rlEnableWireMode() void {
    raylib.mrlEnableWireMode();
}

/// Enable point mode
pub fn rlEnablePointMode() void {
    raylib.mrlEnablePointMode();
}

/// Disable wire mode ( and point ) maybe rename
pub fn rlDisableWireMode() void {
    raylib.mrlDisableWireMode();
}

/// Set the line drawing width
pub fn rlSetLineWidth(
    width: f32,
) void {
    raylib.mrlSetLineWidth(
        width,
    );
}

/// Get the line drawing width
pub fn rlGetLineWidth() f32 {
    return raylib.mrlGetLineWidth();
}

/// Enable line aliasing
pub fn rlEnableSmoothLines() void {
    raylib.mrlEnableSmoothLines();
}

/// Disable line aliasing
pub fn rlDisableSmoothLines() void {
    raylib.mrlDisableSmoothLines();
}

/// Enable stereo rendering
pub fn rlEnableStereoRender() void {
    raylib.mrlEnableStereoRender();
}

/// Disable stereo rendering
pub fn rlDisableStereoRender() void {
    raylib.mrlDisableStereoRender();
}

/// Check if stereo render is enabled
pub fn rlIsStereoRenderEnabled() bool {
    return raylib.mrlIsStereoRenderEnabled();
}

/// Clear color buffer with color
pub fn rlClearColor(
    r: u8,
    g: u8,
    b: u8,
    a: u8,
) void {
    raylib.mrlClearColor(
        r,
        g,
        b,
        a,
    );
}

/// Clear used screen buffers (color and depth)
pub fn rlClearScreenBuffers() void {
    raylib.mrlClearScreenBuffers();
}

/// Check and log OpenGL error codes
pub fn rlCheckErrors() void {
    raylib.mrlCheckErrors();
}

/// Set blending mode
pub fn rlSetBlendMode(
    mode: i32,
) void {
    raylib.mrlSetBlendMode(
        mode,
    );
}

/// Set blending mode factor and equation (using OpenGL factors)
pub fn rlSetBlendFactors(
    glSrcFactor: i32,
    glDstFactor: i32,
    glEquation: i32,
) void {
    raylib.mrlSetBlendFactors(
        glSrcFactor,
        glDstFactor,
        glEquation,
    );
}

/// Set blending mode factors and equations separately (using OpenGL factors)
pub fn rlSetBlendFactorsSeparate(
    glSrcRGB: i32,
    glDstRGB: i32,
    glSrcAlpha: i32,
    glDstAlpha: i32,
    glEqRGB: i32,
    glEqAlpha: i32,
) void {
    raylib.mrlSetBlendFactorsSeparate(
        glSrcRGB,
        glDstRGB,
        glSrcAlpha,
        glDstAlpha,
        glEqRGB,
        glEqAlpha,
    );
}

/// Initialize rlgl (buffers, shaders, textures, states)
pub fn rlglInit(
    width: i32,
    height: i32,
) void {
    raylib.mrlglInit(
        width,
        height,
    );
}

/// De-initialize rlgl (buffers, shaders, textures)
pub fn rlglClose() void {
    raylib.mrlglClose();
}

/// Load OpenGL extensions (loader function required)
pub fn rlLoadExtensions(
    loader: *anyopaque,
) void {
    raylib.mrlLoadExtensions(
        loader,
    );
}

/// Get current OpenGL version
pub fn rlGetVersion() i32 {
    return raylib.mrlGetVersion();
}

/// Set current framebuffer width
pub fn rlSetFramebufferWidth(
    width: i32,
) void {
    raylib.mrlSetFramebufferWidth(
        width,
    );
}

/// Get default framebuffer width
pub fn rlGetFramebufferWidth() i32 {
    return raylib.mrlGetFramebufferWidth();
}

/// Set current framebuffer height
pub fn rlSetFramebufferHeight(
    height: i32,
) void {
    raylib.mrlSetFramebufferHeight(
        height,
    );
}

/// Get default framebuffer height
pub fn rlGetFramebufferHeight() i32 {
    return raylib.mrlGetFramebufferHeight();
}

/// Get default texture id
pub fn rlGetTextureIdDefault() u32 {
    return raylib.mrlGetTextureIdDefault();
}

/// Get default shader id
pub fn rlGetShaderIdDefault() u32 {
    return raylib.mrlGetShaderIdDefault();
}

/// Get default shader locations
pub fn rlGetShaderLocsDefault() ?[*]i32 {
    return @as(
        ?[*]i32,
        @ptrCast(raylib.mrlGetShaderLocsDefault()),
    );
}

/// Load a render batch system
pub fn rlLoadRenderBatch(
    numBuffers: i32,
    bufferElements: i32,
) rlRenderBatch {
    var out: rlRenderBatch = undefined;
    raylib.mrlLoadRenderBatch(
        @as([*c]raylib.rlRenderBatch, @ptrCast(&out)),
        numBuffers,
        bufferElements,
    );
    return out;
}

/// Unload render batch system
pub fn rlUnloadRenderBatch(
    batch: rlRenderBatch,
) void {
    raylib.mrlUnloadRenderBatch(
        @as([*c]raylib.rlRenderBatch, @ptrFromInt(@intFromPtr(&batch))),
    );
}

/// Draw render batch data (Update->Draw->Reset)
pub fn rlDrawRenderBatch(
    batch: ?[*]rlRenderBatch,
) void {
    raylib.mrlDrawRenderBatch(
        @as([*c]raylib.rlRenderBatch, @ptrFromInt(@intFromPtr(batch))),
    );
}

/// Set the active render batch for rlgl (NULL for default internal)
pub fn rlSetRenderBatchActive(
    batch: ?[*]rlRenderBatch,
) void {
    raylib.mrlSetRenderBatchActive(
        @as([*c]raylib.rlRenderBatch, @ptrFromInt(@intFromPtr(batch))),
    );
}

/// Update and draw internal render batch
pub fn rlDrawRenderBatchActive() void {
    raylib.mrlDrawRenderBatchActive();
}

/// Check internal buffer overflow for a given number of vertex
pub fn rlCheckRenderBatchLimit(
    vCount: i32,
) bool {
    return raylib.mrlCheckRenderBatchLimit(
        vCount,
    );
}

/// Set current texture for render batch and check buffers limits
pub fn rlSetTexture(
    id: u32,
) void {
    raylib.mrlSetTexture(
        id,
    );
}

/// Load vertex array (vao) if supported
pub fn rlLoadVertexArray() u32 {
    return raylib.mrlLoadVertexArray();
}

/// Load a vertex buffer object
pub fn rlLoadVertexBuffer(
    buffer: *const anyopaque,
    size: i32,
    dynamic: bool,
) u32 {
    return raylib.mrlLoadVertexBuffer(
        buffer,
        size,
        dynamic,
    );
}

/// Load vertex buffer elements object
pub fn rlLoadVertexBufferElement(
    buffer: *const anyopaque,
    size: i32,
    dynamic: bool,
) u32 {
    return raylib.mrlLoadVertexBufferElement(
        buffer,
        size,
        dynamic,
    );
}

/// Update vertex buffer object data on GPU buffer
pub fn rlUpdateVertexBuffer(
    bufferId: u32,
    data: *const anyopaque,
    dataSize: i32,
    offset: i32,
) void {
    raylib.mrlUpdateVertexBuffer(
        bufferId,
        data,
        dataSize,
        offset,
    );
}

/// Update vertex buffer elements data on GPU buffer
pub fn rlUpdateVertexBufferElements(
    id: u32,
    data: *const anyopaque,
    dataSize: i32,
    offset: i32,
) void {
    raylib.mrlUpdateVertexBufferElements(
        id,
        data,
        dataSize,
        offset,
    );
}

/// Unload vertex array (vao)
pub fn rlUnloadVertexArray(
    vaoId: u32,
) void {
    raylib.mrlUnloadVertexArray(
        vaoId,
    );
}

/// Unload vertex buffer object
pub fn rlUnloadVertexBuffer(
    vboId: u32,
) void {
    raylib.mrlUnloadVertexBuffer(
        vboId,
    );
}

/// Compile custom shader and return shader id (type: RL_VERTEX_SHADER, RL_FRAGMENT_SHADER, RL_COMPUTE_SHADER)
pub fn rlCompileShader(
    shaderCode: [*:0]const u8,
    typ: i32,
) u32 {
    return raylib.mrlCompileShader(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(shaderCode))),
        typ,
    );
}

/// Set vertex attribute data divisor
pub fn rlSetVertexAttributeDivisor(
    index: u32,
    divisor: i32,
) void {
    raylib.mrlSetVertexAttributeDivisor(
        index,
        divisor,
    );
}

/// Set vertex attribute default value, when attribute to provided
pub fn rlSetVertexAttributeDefault(
    locIndex: i32,
    value: *const anyopaque,
    attribType: i32,
    count: i32,
) void {
    raylib.mrlSetVertexAttributeDefault(
        locIndex,
        value,
        attribType,
        count,
    );
}

/// Draw vertex array (currently active vao)
pub fn rlDrawVertexArray(
    offset: i32,
    count: i32,
) void {
    raylib.mrlDrawVertexArray(
        offset,
        count,
    );
}

/// Draw vertex array elements
pub fn rlDrawVertexArrayElements(
    offset: i32,
    count: i32,
    buffer: *const anyopaque,
) void {
    raylib.mrlDrawVertexArrayElements(
        offset,
        count,
        buffer,
    );
}

/// Draw vertex array (currently active vao) with instancing
pub fn rlDrawVertexArrayInstanced(
    offset: i32,
    count: i32,
    instances: i32,
) void {
    raylib.mrlDrawVertexArrayInstanced(
        offset,
        count,
        instances,
    );
}

/// Draw vertex array elements with instancing
pub fn rlDrawVertexArrayElementsInstanced(
    offset: i32,
    count: i32,
    buffer: *const anyopaque,
    instances: i32,
) void {
    raylib.mrlDrawVertexArrayElementsInstanced(
        offset,
        count,
        buffer,
        instances,
    );
}

/// Load texture data
pub fn rlLoadTexture(
    data: *const anyopaque,
    width: i32,
    height: i32,
    format: i32,
    mipmapCount: i32,
) u32 {
    return raylib.mrlLoadTexture(
        data,
        width,
        height,
        format,
        mipmapCount,
    );
}

/// Load depth texture/renderbuffer (to be attached to fbo)
pub fn rlLoadTextureDepth(
    width: i32,
    height: i32,
    useRenderBuffer: bool,
) u32 {
    return raylib.mrlLoadTextureDepth(
        width,
        height,
        useRenderBuffer,
    );
}

/// Load texture cubemap data
pub fn rlLoadTextureCubemap(
    data: *const anyopaque,
    size: i32,
    format: i32,
) u32 {
    return raylib.mrlLoadTextureCubemap(
        data,
        size,
        format,
    );
}

/// Update texture with new data on GPU
pub fn rlUpdateTexture(
    id: u32,
    offsetX: i32,
    offsetY: i32,
    width: i32,
    height: i32,
    format: i32,
    data: *const anyopaque,
) void {
    raylib.mrlUpdateTexture(
        id,
        offsetX,
        offsetY,
        width,
        height,
        format,
        data,
    );
}

/// Get OpenGL internal formats
pub fn rlGetGlTextureFormats(
    format: i32,
    glInternalFormat: ?[*]u32,
    glFormat: ?[*]u32,
    glType: ?[*]u32,
) void {
    raylib.mrlGetGlTextureFormats(
        format,
        @as([*c]u32, @ptrCast(glInternalFormat)),
        @as([*c]u32, @ptrCast(glFormat)),
        @as([*c]u32, @ptrCast(glType)),
    );
}

/// Get name string for pixel format
pub fn rlGetPixelFormatName(
    format: u32,
) [*:0]const u8 {
    return @as(
        [*:0]const u8,
        @ptrCast(raylib.mrlGetPixelFormatName(
            format,
        )),
    );
}

/// Unload texture from GPU memory
pub fn rlUnloadTexture(
    id: u32,
) void {
    raylib.mrlUnloadTexture(
        id,
    );
}

/// Generate mipmap data for selected texture
pub fn rlGenTextureMipmaps(
    id: u32,
    width: i32,
    height: i32,
    format: i32,
    mipmaps: ?[*]i32,
) void {
    raylib.mrlGenTextureMipmaps(
        id,
        width,
        height,
        format,
        @as([*c]i32, @ptrCast(mipmaps)),
    );
}

/// Read texture pixel data
pub fn rlReadTexturePixels(
    id: u32,
    width: i32,
    height: i32,
    format: i32,
) *anyopaque {
    return @as(
        *anyopaque,
        @ptrCast(raylib.mrlReadTexturePixels(
            id,
            width,
            height,
            format,
        )),
    );
}

/// Read screen pixel data (color buffer)
pub fn rlReadScreenPixels(
    width: i32,
    height: i32,
) [*:0]const u8 {
    return @as(
        ?[*]u8,
        @ptrCast(raylib.mrlReadScreenPixels(
            width,
            height,
        )),
    );
}

/// Load an empty framebuffer
pub fn rlLoadFramebuffer(
    width: i32,
    height: i32,
) u32 {
    return raylib.mrlLoadFramebuffer(
        width,
        height,
    );
}

/// Attach texture/renderbuffer to a framebuffer
pub fn rlFramebufferAttach(
    fboId: u32,
    texId: u32,
    attachType: i32,
    texType: i32,
    mipLevel: i32,
) void {
    raylib.mrlFramebufferAttach(
        fboId,
        texId,
        attachType,
        texType,
        mipLevel,
    );
}

/// Verify framebuffer is complete
pub fn rlFramebufferComplete(
    id: u32,
) bool {
    return raylib.mrlFramebufferComplete(
        id,
    );
}

/// Delete framebuffer from GPU
pub fn rlUnloadFramebuffer(
    id: u32,
) void {
    raylib.mrlUnloadFramebuffer(
        id,
    );
}

/// Load shader from code strings
pub fn rlLoadShaderCode(
    vsCode: [*:0]const u8,
    fsCode: [*:0]const u8,
) u32 {
    return raylib.mrlLoadShaderCode(
        @as([*c]const u8, @ptrFromInt(@intFromPtr(vsCode))),
        @as([*c]const u8, @ptrFromInt(@intFromPtr(fsCode))),
    );
}

/// Load custom shader program
pub fn rlLoadShaderProgram(
    vShaderId: u32,
    fShaderId: u32,
) u32 {
    return raylib.mrlLoadShaderProgram(
        vShaderId,
        fShaderId,
    );
}

/// Unload shader program
pub fn rlUnloadShaderProgram(
    id: u32,
) void {
    raylib.mrlUnloadShaderProgram(
        id,
    );
}

/// Get shader location uniform
pub fn rlGetLocationUniform(
    shaderId: u32,
    uniformName: [*:0]const u8,
) i32 {
    return raylib.mrlGetLocationUniform(
        shaderId,
        @as([*c]const u8, @ptrFromInt(@intFromPtr(uniformName))),
    );
}

/// Get shader location attribute
pub fn rlGetLocationAttrib(
    shaderId: u32,
    attribName: [*:0]const u8,
) i32 {
    return raylib.mrlGetLocationAttrib(
        shaderId,
        @as([*c]const u8, @ptrFromInt(@intFromPtr(attribName))),
    );
}

/// Set shader value uniform
pub fn rlSetUniform(
    locIndex: i32,
    value: *const anyopaque,
    uniformType: i32,
    count: i32,
) void {
    raylib.mrlSetUniform(
        locIndex,
        value,
        uniformType,
        count,
    );
}

/// Set shader value matrix
pub fn rlSetUniformMatrix(
    locIndex: i32,
    mat: Matrix,
) void {
    raylib.mrlSetUniformMatrix(
        locIndex,
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
}

/// Set shader value sampler
pub fn rlSetUniformSampler(
    locIndex: i32,
    textureId: u32,
) void {
    raylib.mrlSetUniformSampler(
        locIndex,
        textureId,
    );
}

/// Set shader currently active (id and locations)
pub fn rlSetShader(
    id: u32,
    locs: ?[*]i32,
) void {
    raylib.mrlSetShader(
        id,
        @as([*c]i32, @ptrCast(locs)),
    );
}

/// Load compute shader program
pub fn rlLoadComputeShaderProgram(
    shaderId: u32,
) u32 {
    return raylib.mrlLoadComputeShaderProgram(
        shaderId,
    );
}

/// Dispatch compute shader (equivalent to *draw* for graphics pipeline)
pub fn rlComputeShaderDispatch(
    groupX: u32,
    groupY: u32,
    groupZ: u32,
) void {
    raylib.mrlComputeShaderDispatch(
        groupX,
        groupY,
        groupZ,
    );
}

/// Load shader storage buffer object (SSBO)
pub fn rlLoadShaderBuffer(
    size: u32,
    data: *const anyopaque,
    usageHint: i32,
) u32 {
    return raylib.mrlLoadShaderBuffer(
        size,
        data,
        usageHint,
    );
}

/// Unload shader storage buffer object (SSBO)
pub fn rlUnloadShaderBuffer(
    ssboId: u32,
) void {
    raylib.mrlUnloadShaderBuffer(
        ssboId,
    );
}

/// Update SSBO buffer data
pub fn rlUpdateShaderBuffer(
    id: u32,
    data: *const anyopaque,
    dataSize: u32,
    offset: u32,
) void {
    raylib.mrlUpdateShaderBuffer(
        id,
        data,
        dataSize,
        offset,
    );
}

/// Bind SSBO buffer
pub fn rlBindShaderBuffer(
    id: u32,
    index: u32,
) void {
    raylib.mrlBindShaderBuffer(
        id,
        index,
    );
}

/// Read SSBO buffer data (GPU->CPU)
pub fn rlReadShaderBuffer(
    id: u32,
    dest: *anyopaque,
    count: u32,
    offset: u32,
) void {
    raylib.mrlReadShaderBuffer(
        id,
        dest,
        count,
        offset,
    );
}

/// Copy SSBO data between buffers
pub fn rlCopyShaderBuffer(
    destId: u32,
    srcId: u32,
    destOffset: u32,
    srcOffset: u32,
    count: u32,
) void {
    raylib.mrlCopyShaderBuffer(
        destId,
        srcId,
        destOffset,
        srcOffset,
        count,
    );
}

/// Get SSBO buffer size
pub fn rlGetShaderBufferSize(
    id: u32,
) u32 {
    return raylib.mrlGetShaderBufferSize(
        id,
    );
}

/// Bind image texture
pub fn rlBindImageTexture(
    id: u32,
    index: u32,
    format: i32,
    readonly: bool,
) void {
    raylib.mrlBindImageTexture(
        id,
        index,
        format,
        readonly,
    );
}

/// Get internal modelview matrix
pub fn rlGetMatrixModelview() Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixModelview(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
    );
    return out;
}

/// Get internal projection matrix
pub fn rlGetMatrixProjection() Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixProjection(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
    );
    return out;
}

/// Get internal accumulated transform matrix
pub fn rlGetMatrixTransform() Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixTransform(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
    );
    return out;
}

///
pub fn rlGetMatrixProjectionStereo(
    eye: i32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixProjectionStereo(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        eye,
    );
    return out;
}

///
pub fn rlGetMatrixViewOffsetStereo(
    eye: i32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixViewOffsetStereo(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        eye,
    );
    return out;
}

/// Set a custom projection matrix (replaces internal projection matrix)
pub fn rlSetMatrixProjection(
    proj: Matrix,
) void {
    raylib.mrlSetMatrixProjection(
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&proj))),
    );
}

/// Set a custom modelview matrix (replaces internal modelview matrix)
pub fn rlSetMatrixModelview(
    view: Matrix,
) void {
    raylib.mrlSetMatrixModelview(
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&view))),
    );
}

/// Set eyes projection matrices for stereo rendering
pub fn rlSetMatrixProjectionStereo(
    right: Matrix,
    left: Matrix,
) void {
    raylib.mrlSetMatrixProjectionStereo(
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&right))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&left))),
    );
}

/// Set eyes view offsets matrices for stereo rendering
pub fn rlSetMatrixViewOffsetStereo(
    right: Matrix,
    left: Matrix,
) void {
    raylib.mrlSetMatrixViewOffsetStereo(
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&right))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&left))),
    );
}

/// Load and draw a cube
pub fn rlLoadDrawCube() void {
    raylib.mrlLoadDrawCube();
}

/// Load and draw a quad
pub fn rlLoadDrawQuad() void {
    raylib.mrlLoadDrawQuad();
}

///
pub fn Clamp(
    value: f32,
    min: f32,
    max: f32,
) f32 {
    return raylib.mClamp(
        value,
        min,
        max,
    );
}

///
pub fn Lerp(
    start: f32,
    end: f32,
    amount: f32,
) f32 {
    return raylib.mLerp(
        start,
        end,
        amount,
    );
}

///
pub fn Normalize(
    value: f32,
    start: f32,
    end: f32,
) f32 {
    return raylib.mNormalize(
        value,
        start,
        end,
    );
}

///
pub fn Remap(
    value: f32,
    inputStart: f32,
    inputEnd: f32,
    outputStart: f32,
    outputEnd: f32,
) f32 {
    return raylib.mRemap(
        value,
        inputStart,
        inputEnd,
        outputStart,
        outputEnd,
    );
}

///
pub fn Wrap(
    value: f32,
    min: f32,
    max: f32,
) f32 {
    return raylib.mWrap(
        value,
        min,
        max,
    );
}

///
pub fn FloatEquals(
    x: f32,
    y: f32,
) i32 {
    return raylib.mFloatEquals(
        x,
        y,
    );
}

///
pub fn Vector2Zero() Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Zero(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

///
pub fn Vector2One() Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2One(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
    );
    return out;
}

///
pub fn Vector2Add(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Add(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector2AddValue(
    v: Vector2,
    add: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2AddValue(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        add,
    );
    return out;
}

///
pub fn Vector2Subtract(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Subtract(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector2SubtractValue(
    v: Vector2,
    sub: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2SubtractValue(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        sub,
    );
    return out;
}

///
pub fn Vector2Length(
    v: Vector2,
) f32 {
    return raylib.mVector2Length(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
    );
}

///
pub fn Vector2LengthSqr(
    v: Vector2,
) f32 {
    return raylib.mVector2LengthSqr(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
    );
}

///
pub fn Vector2DotProduct(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2DotProduct(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector2Distance(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2Distance(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector2DistanceSqr(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2DistanceSqr(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector2Angle(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2Angle(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector2LineAngle(
    start: Vector2,
    end: Vector2,
) f32 {
    return raylib.mVector2LineAngle(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&start))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&end))),
    );
}

///
pub fn Vector2Scale(
    v: Vector2,
    scale: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Scale(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        scale,
    );
    return out;
}

///
pub fn Vector2Multiply(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Multiply(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector2Negate(
    v: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Negate(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector2Divide(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Divide(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector2Normalize(
    v: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Normalize(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector2Transform(
    v: Vector2,
    mat: Matrix,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Transform(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
    return out;
}

///
pub fn Vector2Lerp(
    v1: Vector2,
    v2: Vector2,
    amount: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Lerp(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v2))),
        amount,
    );
    return out;
}

///
pub fn Vector2Reflect(
    v: Vector2,
    normal: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Reflect(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&normal))),
    );
    return out;
}

///
pub fn Vector2Rotate(
    v: Vector2,
    angle: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Rotate(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        angle,
    );
    return out;
}

///
pub fn Vector2MoveTowards(
    v: Vector2,
    target: Vector2,
    maxDistance: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2MoveTowards(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&target))),
        maxDistance,
    );
    return out;
}

///
pub fn Vector2Invert(
    v: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Invert(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector2Clamp(
    v: Vector2,
    min: Vector2,
    max: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Clamp(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&min))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&max))),
    );
    return out;
}

///
pub fn Vector2ClampValue(
    v: Vector2,
    min: f32,
    max: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2ClampValue(
        @as([*c]raylib.Vector2, @ptrCast(&out)),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&v))),
        min,
        max,
    );
    return out;
}

///
pub fn Vector2Equals(
    p: Vector2,
    q: Vector2,
) i32 {
    return raylib.mVector2Equals(
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&p))),
        @as([*c]raylib.Vector2, @ptrFromInt(@intFromPtr(&q))),
    );
}

///
pub fn Vector3Zero() Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Zero(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
    );
    return out;
}

///
pub fn Vector3One() Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3One(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
    );
    return out;
}

///
pub fn Vector3Add(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Add(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3AddValue(
    v: Vector3,
    add: f32,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3AddValue(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        add,
    );
    return out;
}

///
pub fn Vector3Subtract(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Subtract(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3SubtractValue(
    v: Vector3,
    sub: f32,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3SubtractValue(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        sub,
    );
    return out;
}

///
pub fn Vector3Scale(
    v: Vector3,
    scalar: f32,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Scale(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        scalar,
    );
    return out;
}

///
pub fn Vector3Multiply(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Multiply(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3CrossProduct(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3CrossProduct(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3Perpendicular(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Perpendicular(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector3Length(
    v: Vector3,
) f32 {
    return raylib.mVector3Length(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
    );
}

///
pub fn Vector3LengthSqr(
    v: Vector3,
) f32 {
    return raylib.mVector3LengthSqr(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
    );
}

///
pub fn Vector3DotProduct(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3DotProduct(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector3Distance(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3Distance(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector3DistanceSqr(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3DistanceSqr(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector3Angle(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3Angle(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
}

///
pub fn Vector3Negate(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Negate(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector3Divide(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Divide(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3Normalize(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Normalize(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector3Project(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Project(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3Reject(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Reject(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3OrthoNormalize(
    v1: ?[*]Vector3,
    v2: ?[*]Vector3,
) void {
    raylib.mVector3OrthoNormalize(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(v2))),
    );
}

///
pub fn Vector3Transform(
    v: Vector3,
    mat: Matrix,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Transform(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
    return out;
}

///
pub fn Vector3RotateByQuaternion(
    v: Vector3,
    q: Vector4,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3RotateByQuaternion(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
    );
    return out;
}

///
pub fn Vector3RotateByAxisAngle(
    v: Vector3,
    axis: Vector3,
    angle: f32,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3RotateByAxisAngle(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&axis))),
        angle,
    );
    return out;
}

///
pub fn Vector3Lerp(
    v1: Vector3,
    v2: Vector3,
    amount: f32,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Lerp(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
        amount,
    );
    return out;
}

///
pub fn Vector3Reflect(
    v: Vector3,
    normal: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Reflect(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&normal))),
    );
    return out;
}

///
pub fn Vector3Min(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Min(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3Max(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Max(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v1))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v2))),
    );
    return out;
}

///
pub fn Vector3Barycenter(
    p: Vector3,
    a: Vector3,
    b: Vector3,
    c: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Barycenter(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&a))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&b))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&c))),
    );
    return out;
}

///
pub fn Vector3Unproject(
    source: Vector3,
    projection: Matrix,
    view: Matrix,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Unproject(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&source))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&projection))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&view))),
    );
    return out;
}

///
pub fn Vector3ToFloatV(
    v: Vector3,
) float3 {
    var out: float3 = undefined;
    raylib.mVector3ToFloatV(
        @as([*c]raylib.float3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector3Invert(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Invert(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
    );
    return out;
}

///
pub fn Vector3Clamp(
    v: Vector3,
    min: Vector3,
    max: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Clamp(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&min))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&max))),
    );
    return out;
}

///
pub fn Vector3ClampValue(
    v: Vector3,
    min: f32,
    max: f32,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3ClampValue(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        min,
        max,
    );
    return out;
}

///
pub fn Vector3Equals(
    p: Vector3,
    q: Vector3,
) i32 {
    return raylib.mVector3Equals(
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&p))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&q))),
    );
}

///
pub fn Vector3Refract(
    v: Vector3,
    n: Vector3,
    r: f32,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Refract(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&v))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&n))),
        r,
    );
    return out;
}

///
pub fn MatrixDeterminant(
    mat: Matrix,
) f32 {
    return raylib.mMatrixDeterminant(
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
}

///
pub fn MatrixTrace(
    mat: Matrix,
) f32 {
    return raylib.mMatrixTrace(
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
}

///
pub fn MatrixTranspose(
    mat: Matrix,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixTranspose(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
    return out;
}

///
pub fn MatrixInvert(
    mat: Matrix,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixInvert(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
    return out;
}

///
pub fn MatrixIdentity() Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixIdentity(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
    );
    return out;
}

///
pub fn MatrixAdd(
    left: Matrix,
    right: Matrix,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixAdd(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&left))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&right))),
    );
    return out;
}

///
pub fn MatrixSubtract(
    left: Matrix,
    right: Matrix,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixSubtract(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&left))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&right))),
    );
    return out;
}

///
pub fn MatrixMultiply(
    left: Matrix,
    right: Matrix,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixMultiply(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&left))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&right))),
    );
    return out;
}

///
pub fn MatrixTranslate(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixTranslate(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        x,
        y,
        z,
    );
    return out;
}

///
pub fn MatrixRotate(
    axis: Vector3,
    angle: f32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixRotate(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&axis))),
        angle,
    );
    return out;
}

///
pub fn MatrixRotateX(
    angle: f32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixRotateX(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        angle,
    );
    return out;
}

///
pub fn MatrixRotateY(
    angle: f32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixRotateY(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        angle,
    );
    return out;
}

///
pub fn MatrixRotateZ(
    angle: f32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixRotateZ(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        angle,
    );
    return out;
}

///
pub fn MatrixRotateXYZ(
    angle: Vector3,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixRotateXYZ(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&angle))),
    );
    return out;
}

///
pub fn MatrixRotateZYX(
    angle: Vector3,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixRotateZYX(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&angle))),
    );
    return out;
}

///
pub fn MatrixScale(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixScale(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        x,
        y,
        z,
    );
    return out;
}

///
pub fn MatrixFrustum(
    left: f64,
    right: f64,
    bottom: f64,
    top: f64,
    near: f64,
    far: f64,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixFrustum(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        left,
        right,
        bottom,
        top,
        near,
        far,
    );
    return out;
}

///
pub fn MatrixPerspective(
    fovY: f64,
    aspect: f64,
    nearPlane: f64,
    farPlane: f64,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixPerspective(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        fovY,
        aspect,
        nearPlane,
        farPlane,
    );
    return out;
}

///
pub fn MatrixOrtho(
    left: f64,
    right: f64,
    bottom: f64,
    top: f64,
    nearPlane: f64,
    farPlane: f64,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixOrtho(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        left,
        right,
        bottom,
        top,
        nearPlane,
        farPlane,
    );
    return out;
}

///
pub fn MatrixLookAt(
    eye: Vector3,
    target: Vector3,
    up: Vector3,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixLookAt(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&eye))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&target))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&up))),
    );
    return out;
}

///
pub fn MatrixToFloatV(
    mat: Matrix,
) float16 {
    var out: float16 = undefined;
    raylib.mMatrixToFloatV(
        @as([*c]raylib.float16, @ptrCast(&out)),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
    return out;
}

///
pub fn QuaternionAdd(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionAdd(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q1))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q2))),
    );
    return out;
}

///
pub fn QuaternionAddValue(
    q: Vector4,
    add: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionAddValue(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
        add,
    );
    return out;
}

///
pub fn QuaternionSubtract(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionSubtract(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q1))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q2))),
    );
    return out;
}

///
pub fn QuaternionSubtractValue(
    q: Vector4,
    sub: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionSubtractValue(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
        sub,
    );
    return out;
}

///
pub fn QuaternionIdentity() Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionIdentity(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
    );
    return out;
}

///
pub fn QuaternionLength(
    q: Vector4,
) f32 {
    return raylib.mQuaternionLength(
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
    );
}

///
pub fn QuaternionNormalize(
    q: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionNormalize(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
    );
    return out;
}

///
pub fn QuaternionInvert(
    q: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionInvert(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
    );
    return out;
}

///
pub fn QuaternionMultiply(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionMultiply(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q1))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q2))),
    );
    return out;
}

///
pub fn QuaternionScale(
    q: Vector4,
    mul: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionScale(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
        mul,
    );
    return out;
}

///
pub fn QuaternionDivide(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionDivide(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q1))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q2))),
    );
    return out;
}

///
pub fn QuaternionLerp(
    q1: Vector4,
    q2: Vector4,
    amount: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionLerp(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q1))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q2))),
        amount,
    );
    return out;
}

///
pub fn QuaternionNlerp(
    q1: Vector4,
    q2: Vector4,
    amount: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionNlerp(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q1))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q2))),
        amount,
    );
    return out;
}

///
pub fn QuaternionSlerp(
    q1: Vector4,
    q2: Vector4,
    amount: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionSlerp(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q1))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q2))),
        amount,
    );
    return out;
}

///
pub fn QuaternionFromVector3ToVector3(
    from: Vector3,
    to: Vector3,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionFromVector3ToVector3(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&from))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&to))),
    );
    return out;
}

///
pub fn QuaternionFromMatrix(
    mat: Matrix,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionFromMatrix(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
    return out;
}

///
pub fn QuaternionToMatrix(
    q: Vector4,
) Matrix {
    var out: Matrix = undefined;
    raylib.mQuaternionToMatrix(
        @as([*c]raylib.Matrix, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
    );
    return out;
}

///
pub fn QuaternionFromAxisAngle(
    axis: Vector3,
    angle: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionFromAxisAngle(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(&axis))),
        angle,
    );
    return out;
}

///
pub fn QuaternionToAxisAngle(
    q: Vector4,
    outAxis: ?[*]Vector3,
    outAngle: ?[*]f32,
) void {
    raylib.mQuaternionToAxisAngle(
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
        @as([*c]raylib.Vector3, @ptrFromInt(@intFromPtr(outAxis))),
        @as([*c]f32, @ptrCast(outAngle)),
    );
}

///
pub fn QuaternionFromEuler(
    pitch: f32,
    yaw: f32,
    roll: f32,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionFromEuler(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        pitch,
        yaw,
        roll,
    );
    return out;
}

///
pub fn QuaternionToEuler(
    q: Vector4,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mQuaternionToEuler(
        @as([*c]raylib.Vector3, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
    );
    return out;
}

///
pub fn QuaternionTransform(
    q: Vector4,
    mat: Matrix,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionTransform(
        @as([*c]raylib.Vector4, @ptrCast(&out)),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
        @as([*c]raylib.Matrix, @ptrFromInt(@intFromPtr(&mat))),
    );
    return out;
}

///
pub fn QuaternionEquals(
    p: Vector4,
    q: Vector4,
) i32 {
    return raylib.mQuaternionEquals(
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&p))),
        @as([*c]raylib.Vector4, @ptrFromInt(@intFromPtr(&q))),
    );
}

/// Image, pixel data stored in CPU memory (RAM)
pub const Image = extern struct {
    /// Image raw data
    data: *anyopaque,
    /// Image base width
    width: i32,
    /// Image base height
    height: i32,
    /// Mipmap levels, 1 by default
    mipmaps: i32,
    /// Data format (PixelFormat type)
    format: i32,
};

/// Texture, tex data stored in GPU memory (VRAM)
pub const Texture2D = extern struct {
    /// OpenGL texture id
    id: u32,
    /// Texture base width
    width: i32,
    /// Texture base height
    height: i32,
    /// Mipmap levels, 1 by default
    mipmaps: i32,
    /// Data format (PixelFormat type)
    format: i32,
};

/// RenderTexture, fbo for texture rendering
pub const RenderTexture2D = extern struct {
    /// OpenGL framebuffer object id
    id: u32,
    /// Color buffer attachment texture
    texture: Texture2D,
    /// Depth buffer attachment texture
    depth: Texture2D,
};

/// NPatchInfo, n-patch layout info
pub const NPatchInfo = extern struct {
    /// Texture source rectangle
    source: Rectangle,
    /// Left border offset
    left: i32,
    /// Top border offset
    top: i32,
    /// Right border offset
    right: i32,
    /// Bottom border offset
    bottom: i32,
    /// Layout of the n-patch: 3x3, 1x3 or 3x1
    layout: i32,
};

/// GlyphInfo, font characters glyphs info
pub const GlyphInfo = extern struct {
    /// Character value (Unicode)
    value: i32,
    /// Character offset X when drawing
    offsetX: i32,
    /// Character offset Y when drawing
    offsetY: i32,
    /// Character advance position X
    advanceX: i32,
    /// Character image data
    image: Image,
};

/// Font, font texture and GlyphInfo array data
pub const Font = extern struct {
    /// Base size (default chars height)
    baseSize: i32,
    /// Number of glyph characters
    glyphCount: i32,
    /// Padding around the glyph characters
    glyphPadding: i32,
    /// Texture atlas containing the glyphs
    texture: Texture2D,
    /// Rectangles in texture for the glyphs
    recs: ?[*]Rectangle,
    /// Glyphs info data
    glyphs: ?[*]GlyphInfo,
};

/// Camera, defines position/orientation in 3d space
pub const Camera3D = extern struct {
    /// Camera position
    position: Vector3,
    /// Camera target it looks-at
    target: Vector3,
    /// Camera up vector (rotation over its axis)
    up: Vector3,
    /// Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
    fovy: f32,
    /// Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
    projection: CameraProjection,
};

/// Mesh, vertex data and vao/vbo
pub const Mesh = extern struct {
    /// Number of vertices stored in arrays
    vertexCount: i32,
    /// Number of triangles stored (indexed or not)
    triangleCount: i32,
    /// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    vertices: ?[*]f32,
    /// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords: ?[*]f32,
    /// Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    texcoords2: ?[*]f32,
    /// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    normals: ?[*]f32,
    /// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    tangents: ?[*]f32,
    /// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    colors: ?[*]u8,
    /// Vertex indices (in case vertex data comes indexed)
    indices: ?[*]u16,
    /// Animated vertex positions (after bones transformations)
    animVertices: ?[*]f32,
    /// Animated normals (after bones transformations)
    animNormals: ?[*]f32,
    /// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    boneIds: ?[*]u8,
    /// Vertex bone weight, up to 4 bones influence by vertex (skinning)
    boneWeights: ?[*]f32,
    /// OpenGL Vertex Array Object id
    vaoId: u32,
    /// OpenGL Vertex Buffer Objects id (default vertex data)
    vboId: ?[*]u32,
};

/// Shader
pub const Shader = extern struct {
    /// Shader program id
    id: u32,
    /// Shader locations array (RL_MAX_SHADER_LOCATIONS)
    locs: ?[*]i32,
};

/// MaterialMap
pub const MaterialMap = extern struct {
    /// Material map texture
    texture: Texture2D,
    /// Material map color
    color: Color,
    /// Material map value
    value: f32,
};

/// Material, includes shader and maps
pub const Material = extern struct {
    /// Material shader
    shader: Shader,
    /// Material maps array (MAX_MATERIAL_MAPS)
    maps: ?[*]MaterialMap,
    /// Material generic parameters (if required)
    params: [4]f32,
};

/// Bone, skeletal animation bone
pub const BoneInfo = extern struct {
    /// Bone name
    name: [32]u8,
    /// Bone parent
    parent: i32,
};

/// Model, meshes, materials and animation data
pub const Model = extern struct {
    /// Local transform matrix
    transform: Matrix,
    /// Number of meshes
    meshCount: i32,
    /// Number of materials
    materialCount: i32,
    /// Meshes array
    meshes: ?[*]Mesh,
    /// Materials array
    materials: ?[*]Material,
    /// Mesh material number
    meshMaterial: ?[*]i32,
    /// Number of bones
    boneCount: i32,
    /// Bones information (skeleton)
    bones: ?[*]BoneInfo,
    /// Bones base transformation (pose)
    bindPose: ?[*]Transform,
};

/// ModelAnimation
pub const ModelAnimation = extern struct {
    /// Number of bones
    boneCount: i32,
    /// Number of animation frames
    frameCount: i32,
    /// Bones information (skeleton)
    bones: ?[*]BoneInfo,
    /// Poses array by frame
    framePoses: ?[*][*]Transform,
    /// Animation name
    name: [32]u8,
};

/// Ray, ray for raycasting
pub const Ray = extern struct {
    /// Ray position (origin)
    position: Vector3,
    /// Ray direction
    direction: Vector3,
};

/// RayCollision, ray hit information
pub const RayCollision = extern struct {
    /// Did the ray hit something?
    hit: bool,
    /// Distance to the nearest hit
    distance: f32,
    /// Point of the nearest hit
    point: Vector3,
    /// Surface normal of hit
    normal: Vector3,
};

/// BoundingBox
pub const BoundingBox = extern struct {
    /// Minimum vertex box-corner
    min: Vector3,
    /// Maximum vertex box-corner
    max: Vector3,
};

/// Wave, audio wave data
pub const Wave = extern struct {
    /// Total number of frames (considering channels)
    frameCount: u32,
    /// Frequency (samples per second)
    sampleRate: u32,
    /// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    sampleSize: u32,
    /// Number of channels (1-mono, 2-stereo, ...)
    channels: u32,
    /// Buffer data pointer
    data: *anyopaque,
};

/// AudioStream, custom audio stream
pub const AudioStream = extern struct {
    /// Pointer to internal data used by the audio system
    buffer: *anyopaque,
    /// Pointer to internal data processor, useful for audio effects
    processor: *anyopaque,
    /// Frequency (samples per second)
    sampleRate: u32,
    /// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    sampleSize: u32,
    /// Number of channels (1-mono, 2-stereo, ...)
    channels: u32,
};

/// Sound
pub const Sound = extern struct {
    /// Audio stream
    stream: AudioStream,
    /// Total number of frames (considering channels)
    frameCount: u32,
};

/// Music, audio stream, anything longer than ~10 seconds should be streamed
pub const Music = extern struct {
    /// Audio stream
    stream: AudioStream,
    /// Total number of frames (considering channels)
    frameCount: u32,
    /// Music looping enable
    looping: bool,
    /// Type of music context (audio filetype)
    ctxType: i32,
    /// Audio context data, depends on type
    ctxData: *anyopaque,
};

/// VrDeviceInfo, Head-Mounted-Display device parameters
pub const VrDeviceInfo = extern struct {
    /// Horizontal resolution in pixels
    hResolution: i32,
    /// Vertical resolution in pixels
    vResolution: i32,
    /// Horizontal size in meters
    hScreenSize: f32,
    /// Vertical size in meters
    vScreenSize: f32,
    /// Distance between eye and display in meters
    eyeToScreenDistance: f32,
    /// Lens separation distance in meters
    lensSeparationDistance: f32,
    /// IPD (distance between pupils) in meters
    interpupillaryDistance: f32,
    /// Lens distortion constant parameters
    lensDistortionValues: [4]f32,
    /// Chromatic aberration correction parameters
    chromaAbCorrection: [4]f32,
};

/// VrStereoConfig, VR stereo rendering configuration for simulator
pub const VrStereoConfig = extern struct {
    /// VR projection matrices (per eye)
    projection: [2]Matrix,
    /// VR view offset matrices (per eye)
    viewOffset: [2]Matrix,
    /// VR left lens center
    leftLensCenter: [2]f32,
    /// VR right lens center
    rightLensCenter: [2]f32,
    /// VR left screen center
    leftScreenCenter: [2]f32,
    /// VR right screen center
    rightScreenCenter: [2]f32,
    /// VR distortion scale
    scale: [2]f32,
    /// VR distortion scale in
    scaleIn: [2]f32,
};

/// File path list
pub const FilePathList = extern struct {
    /// Filepaths max entries
    capacity: u32,
    /// Filepaths entries count
    count: u32,
    /// Filepaths entries
    paths: [*][*:0]u8,
};

/// Automation event
pub const AutomationEvent = extern struct {
    /// Event frame
    frame: u32,
    /// Event type (AutomationEventType)
    type: u32,
    /// Event parameters (if required)
    params: [4]i32,
};

/// Automation event list
pub const AutomationEventList = extern struct {
    /// Events max entries (MAX_AUTOMATION_EVENTS)
    capacity: u32,
    /// Events entries count
    count: u32,
    /// Events entries
    events: ?[*]AutomationEvent,
};

/// Dynamic vertex buffers (position + texcoords + colors + indices arrays)
pub const rlVertexBuffer = extern struct {
    /// Number of elements in the buffer (QUADS)
    elementCount: i32,
    /// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    vertices: [*]f32,
    /// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords: [*]f32,
    /// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    colors: [*]u8,
    /// Vertex indices (in case vertex data comes indexed) (6 indices per quad)
    indices: [*]u16,
    /// OpenGL Vertex Array Object id
    vaoId: u32,
    /// OpenGL Vertex Buffer Objects id (4 types of vertex data)
    vboId: [4]u32,
};

/// of those state-change happens (this is done in core module)
pub const rlDrawCall = extern struct {
    /// Drawing mode: LINES, TRIANGLES, QUADS
    mode: i32,
    /// Number of vertex of the draw
    vertexCount: i32,
    /// Number of vertex required for index alignment (LINES, TRIANGLES)
    vertexAlignment: i32,
    /// Texture id to be used on the draw -> Use to create new draw call if changes
    textureId: u32,
};

/// rlRenderBatch type
pub const rlRenderBatch = extern struct {
    /// Number of vertex buffers (multi-buffering support)
    bufferCount: i32,
    /// Current buffer tracking in case of multi-buffering
    currentBuffer: i32,
    /// Dynamic buffer(s) for vertex data
    vertexBuffer: ?[*]rlVertexBuffer,
    /// Draw calls array, depends on textureId
    draws: ?[*]rlDrawCall,
    /// Draw calls counter
    drawCounter: i32,
    /// Current depth value for next draw
    currentDepth: f32,
};

/// NOTE: Helper types to be used instead of array return types for *ToFloat functions
pub const float3 = extern struct {
    ///
    v: [3]f32,
};

///
pub const float16 = extern struct {
    ///
    v: [16]f32,
};

/// Trace log level
pub const TraceLogLevel = enum(i32) {
    /// Display all logs
    LOG_ALL = 0,
    /// Trace logging, intended for internal use only
    LOG_TRACE = 1,
    /// Debug logging, used for internal debugging, it should be disabled on release builds
    LOG_DEBUG = 2,
    /// Info logging, used for program execution info
    LOG_INFO = 3,
    /// Warning logging, used on recoverable failures
    LOG_WARNING = 4,
    /// Error logging, used on unrecoverable failures
    LOG_ERROR = 5,
    /// Fatal logging, used to abort program: exit(EXIT_FAILURE)
    LOG_FATAL = 6,
    /// Disable logging
    LOG_NONE = 7,
};

/// Keyboard keys (US keyboard layout)
pub const KeyboardKey = enum(i32) {
    /// Key: NULL, used for no key pressed
    KEY_NULL = 0,
    /// Key: '
    KEY_APOSTROPHE = 39,
    /// Key: ,
    KEY_COMMA = 44,
    /// Key: -
    KEY_MINUS = 45,
    /// Key: .
    KEY_PERIOD = 46,
    /// Key: /
    KEY_SLASH = 47,
    /// Key: 0
    KEY_ZERO = 48,
    /// Key: 1
    KEY_ONE = 49,
    /// Key: 2
    KEY_TWO = 50,
    /// Key: 3
    KEY_THREE = 51,
    /// Key: 4
    KEY_FOUR = 52,
    /// Key: 5
    KEY_FIVE = 53,
    /// Key: 6
    KEY_SIX = 54,
    /// Key: 7
    KEY_SEVEN = 55,
    /// Key: 8
    KEY_EIGHT = 56,
    /// Key: 9
    KEY_NINE = 57,
    /// Key: ;
    KEY_SEMICOLON = 59,
    /// Key: =
    KEY_EQUAL = 61,
    /// Key: A | a
    KEY_A = 65,
    /// Key: B | b
    KEY_B = 66,
    /// Key: C | c
    KEY_C = 67,
    /// Key: D | d
    KEY_D = 68,
    /// Key: E | e
    KEY_E = 69,
    /// Key: F | f
    KEY_F = 70,
    /// Key: G | g
    KEY_G = 71,
    /// Key: H | h
    KEY_H = 72,
    /// Key: I | i
    KEY_I = 73,
    /// Key: J | j
    KEY_J = 74,
    /// Key: K | k
    KEY_K = 75,
    /// Key: L | l
    KEY_L = 76,
    /// Key: M | m
    KEY_M = 77,
    /// Key: N | n
    KEY_N = 78,
    /// Key: O | o
    KEY_O = 79,
    /// Key: P | p
    KEY_P = 80,
    /// Key: Q | q
    KEY_Q = 81,
    /// Key: R | r
    KEY_R = 82,
    /// Key: S | s
    KEY_S = 83,
    /// Key: T | t
    KEY_T = 84,
    /// Key: U | u
    KEY_U = 85,
    /// Key: V | v
    KEY_V = 86,
    /// Key: W | w
    KEY_W = 87,
    /// Key: X | x
    KEY_X = 88,
    /// Key: Y | y
    KEY_Y = 89,
    /// Key: Z | z
    KEY_Z = 90,
    /// Key: [
    KEY_LEFT_BRACKET = 91,
    /// Key: '\'
    KEY_BACKSLASH = 92,
    /// Key: ]
    KEY_RIGHT_BRACKET = 93,
    /// Key: `
    KEY_GRAVE = 96,
    /// Key: Space
    KEY_SPACE = 32,
    /// Key: Esc
    KEY_ESCAPE = 256,
    /// Key: Enter
    KEY_ENTER = 257,
    /// Key: Tab
    KEY_TAB = 258,
    /// Key: Backspace
    KEY_BACKSPACE = 259,
    /// Key: Ins
    KEY_INSERT = 260,
    /// Key: Del
    KEY_DELETE = 261,
    /// Key: Cursor right
    KEY_RIGHT = 262,
    /// Key: Cursor left
    KEY_LEFT = 263,
    /// Key: Cursor down
    KEY_DOWN = 264,
    /// Key: Cursor up
    KEY_UP = 265,
    /// Key: Page up
    KEY_PAGE_UP = 266,
    /// Key: Page down
    KEY_PAGE_DOWN = 267,
    /// Key: Home
    KEY_HOME = 268,
    /// Key: End
    KEY_END = 269,
    /// Key: Caps lock
    KEY_CAPS_LOCK = 280,
    /// Key: Scroll down
    KEY_SCROLL_LOCK = 281,
    /// Key: Num lock
    KEY_NUM_LOCK = 282,
    /// Key: Print screen
    KEY_PRINT_SCREEN = 283,
    /// Key: Pause
    KEY_PAUSE = 284,
    /// Key: F1
    KEY_F1 = 290,
    /// Key: F2
    KEY_F2 = 291,
    /// Key: F3
    KEY_F3 = 292,
    /// Key: F4
    KEY_F4 = 293,
    /// Key: F5
    KEY_F5 = 294,
    /// Key: F6
    KEY_F6 = 295,
    /// Key: F7
    KEY_F7 = 296,
    /// Key: F8
    KEY_F8 = 297,
    /// Key: F9
    KEY_F9 = 298,
    /// Key: F10
    KEY_F10 = 299,
    /// Key: F11
    KEY_F11 = 300,
    /// Key: F12
    KEY_F12 = 301,
    /// Key: Shift left
    KEY_LEFT_SHIFT = 340,
    /// Key: Control left
    KEY_LEFT_CONTROL = 341,
    /// Key: Alt left
    KEY_LEFT_ALT = 342,
    /// Key: Super left
    KEY_LEFT_SUPER = 343,
    /// Key: Shift right
    KEY_RIGHT_SHIFT = 344,
    /// Key: Control right
    KEY_RIGHT_CONTROL = 345,
    /// Key: Alt right
    KEY_RIGHT_ALT = 346,
    /// Key: Super right
    KEY_RIGHT_SUPER = 347,
    /// Key: KB menu
    KEY_KB_MENU = 348,
    /// Key: Keypad 0
    KEY_KP_0 = 320,
    /// Key: Keypad 1
    KEY_KP_1 = 321,
    /// Key: Keypad 2
    KEY_KP_2 = 322,
    /// Key: Keypad 3
    KEY_KP_3 = 323,
    /// Key: Keypad 4
    KEY_KP_4 = 324,
    /// Key: Keypad 5
    KEY_KP_5 = 325,
    /// Key: Keypad 6
    KEY_KP_6 = 326,
    /// Key: Keypad 7
    KEY_KP_7 = 327,
    /// Key: Keypad 8
    KEY_KP_8 = 328,
    /// Key: Keypad 9
    KEY_KP_9 = 329,
    /// Key: Keypad .
    KEY_KP_DECIMAL = 330,
    /// Key: Keypad /
    KEY_KP_DIVIDE = 331,
    /// Key: Keypad *
    KEY_KP_MULTIPLY = 332,
    /// Key: Keypad -
    KEY_KP_SUBTRACT = 333,
    /// Key: Keypad +
    KEY_KP_ADD = 334,
    /// Key: Keypad Enter
    KEY_KP_ENTER = 335,
    /// Key: Keypad =
    KEY_KP_EQUAL = 336,
    /// Key: Android back button
    KEY_BACK = 4,
    /// Key: Android volume up button
    KEY_VOLUME_UP = 24,
    /// Key: Android volume down button
    KEY_VOLUME_DOWN = 25,
};

/// Mouse buttons
pub const MouseButton = enum(i32) {
    /// Mouse button left
    MOUSE_BUTTON_LEFT = 0,
    /// Mouse button right
    MOUSE_BUTTON_RIGHT = 1,
    /// Mouse button middle (pressed wheel)
    MOUSE_BUTTON_MIDDLE = 2,
    /// Mouse button side (advanced mouse device)
    MOUSE_BUTTON_SIDE = 3,
    /// Mouse button extra (advanced mouse device)
    MOUSE_BUTTON_EXTRA = 4,
    /// Mouse button forward (advanced mouse device)
    MOUSE_BUTTON_FORWARD = 5,
    /// Mouse button back (advanced mouse device)
    MOUSE_BUTTON_BACK = 6,
};

/// Mouse cursor
pub const MouseCursor = enum(i32) {
    /// Default pointer shape
    MOUSE_CURSOR_DEFAULT = 0,
    /// Arrow shape
    MOUSE_CURSOR_ARROW = 1,
    /// Text writing cursor shape
    MOUSE_CURSOR_IBEAM = 2,
    /// Cross shape
    MOUSE_CURSOR_CROSSHAIR = 3,
    /// Pointing hand cursor
    MOUSE_CURSOR_POINTING_HAND = 4,
    /// Horizontal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_EW = 5,
    /// Vertical resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NS = 6,
    /// Top-left to bottom-right diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NWSE = 7,
    /// The top-right to bottom-left diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NESW = 8,
    /// The omnidirectional resize/move cursor shape
    MOUSE_CURSOR_RESIZE_ALL = 9,
    /// The operation-not-allowed shape
    MOUSE_CURSOR_NOT_ALLOWED = 10,
};

/// Gamepad buttons
pub const GamepadButton = enum(i32) {
    /// Unknown button, just for error checking
    GAMEPAD_BUTTON_UNKNOWN = 0,
    /// Gamepad left DPAD up button
    GAMEPAD_BUTTON_LEFT_FACE_UP = 1,
    /// Gamepad left DPAD right button
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2,
    /// Gamepad left DPAD down button
    GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3,
    /// Gamepad left DPAD left button
    GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4,
    /// Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
    GAMEPAD_BUTTON_RIGHT_FACE_UP = 5,
    /// Gamepad right button right (i.e. PS3: Square, Xbox: X)
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6,
    /// Gamepad right button down (i.e. PS3: Cross, Xbox: A)
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7,
    /// Gamepad right button left (i.e. PS3: Circle, Xbox: B)
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8,
    /// Gamepad top/back trigger left (first), it could be a trailing button
    GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9,
    /// Gamepad top/back trigger left (second), it could be a trailing button
    GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10,
    /// Gamepad top/back trigger right (one), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11,
    /// Gamepad top/back trigger right (second), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12,
    /// Gamepad center buttons, left one (i.e. PS3: Select)
    GAMEPAD_BUTTON_MIDDLE_LEFT = 13,
    /// Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
    GAMEPAD_BUTTON_MIDDLE = 14,
    /// Gamepad center buttons, right one (i.e. PS3: Start)
    GAMEPAD_BUTTON_MIDDLE_RIGHT = 15,
    /// Gamepad joystick pressed button left
    GAMEPAD_BUTTON_LEFT_THUMB = 16,
    /// Gamepad joystick pressed button right
    GAMEPAD_BUTTON_RIGHT_THUMB = 17,
};

/// Gamepad axis
pub const GamepadAxis = enum(i32) {
    /// Gamepad left stick X axis
    GAMEPAD_AXIS_LEFT_X = 0,
    /// Gamepad left stick Y axis
    GAMEPAD_AXIS_LEFT_Y = 1,
    /// Gamepad right stick X axis
    GAMEPAD_AXIS_RIGHT_X = 2,
    /// Gamepad right stick Y axis
    GAMEPAD_AXIS_RIGHT_Y = 3,
    /// Gamepad back trigger left, pressure level: [1..-1]
    GAMEPAD_AXIS_LEFT_TRIGGER = 4,
    /// Gamepad back trigger right, pressure level: [1..-1]
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5,
};

/// Material map index
pub const MaterialMapIndex = enum(i32) {
    /// Albedo material (same as: MATERIAL_MAP_DIFFUSE)
    MATERIAL_MAP_ALBEDO = 0,
    /// Metalness material (same as: MATERIAL_MAP_SPECULAR)
    MATERIAL_MAP_METALNESS = 1,
    /// Normal material
    MATERIAL_MAP_NORMAL = 2,
    /// Roughness material
    MATERIAL_MAP_ROUGHNESS = 3,
    /// Ambient occlusion material
    MATERIAL_MAP_OCCLUSION = 4,
    /// Emission material
    MATERIAL_MAP_EMISSION = 5,
    /// Heightmap material
    MATERIAL_MAP_HEIGHT = 6,
    /// Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_CUBEMAP = 7,
    /// Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_IRRADIANCE = 8,
    /// Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_PREFILTER = 9,
    /// Brdf material
    MATERIAL_MAP_BRDF = 10,
};

/// Shader location index
pub const ShaderLocationIndex = enum(i32) {
    /// Shader location: vertex attribute: position
    SHADER_LOC_VERTEX_POSITION = 0,
    /// Shader location: vertex attribute: texcoord01
    SHADER_LOC_VERTEX_TEXCOORD01 = 1,
    /// Shader location: vertex attribute: texcoord02
    SHADER_LOC_VERTEX_TEXCOORD02 = 2,
    /// Shader location: vertex attribute: normal
    SHADER_LOC_VERTEX_NORMAL = 3,
    /// Shader location: vertex attribute: tangent
    SHADER_LOC_VERTEX_TANGENT = 4,
    /// Shader location: vertex attribute: color
    SHADER_LOC_VERTEX_COLOR = 5,
    /// Shader location: matrix uniform: model-view-projection
    SHADER_LOC_MATRIX_MVP = 6,
    /// Shader location: matrix uniform: view (camera transform)
    SHADER_LOC_MATRIX_VIEW = 7,
    /// Shader location: matrix uniform: projection
    SHADER_LOC_MATRIX_PROJECTION = 8,
    /// Shader location: matrix uniform: model (transform)
    SHADER_LOC_MATRIX_MODEL = 9,
    /// Shader location: matrix uniform: normal
    SHADER_LOC_MATRIX_NORMAL = 10,
    /// Shader location: vector uniform: view
    SHADER_LOC_VECTOR_VIEW = 11,
    /// Shader location: vector uniform: diffuse color
    SHADER_LOC_COLOR_DIFFUSE = 12,
    /// Shader location: vector uniform: specular color
    SHADER_LOC_COLOR_SPECULAR = 13,
    /// Shader location: vector uniform: ambient color
    SHADER_LOC_COLOR_AMBIENT = 14,
    /// Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
    SHADER_LOC_MAP_ALBEDO = 15,
    /// Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
    SHADER_LOC_MAP_METALNESS = 16,
    /// Shader location: sampler2d texture: normal
    SHADER_LOC_MAP_NORMAL = 17,
    /// Shader location: sampler2d texture: roughness
    SHADER_LOC_MAP_ROUGHNESS = 18,
    /// Shader location: sampler2d texture: occlusion
    SHADER_LOC_MAP_OCCLUSION = 19,
    /// Shader location: sampler2d texture: emission
    SHADER_LOC_MAP_EMISSION = 20,
    /// Shader location: sampler2d texture: height
    SHADER_LOC_MAP_HEIGHT = 21,
    /// Shader location: samplerCube texture: cubemap
    SHADER_LOC_MAP_CUBEMAP = 22,
    /// Shader location: samplerCube texture: irradiance
    SHADER_LOC_MAP_IRRADIANCE = 23,
    /// Shader location: samplerCube texture: prefilter
    SHADER_LOC_MAP_PREFILTER = 24,
    /// Shader location: sampler2d texture: brdf
    SHADER_LOC_MAP_BRDF = 25,
};

/// Shader uniform data type
pub const ShaderUniformDataType = enum(i32) {
    /// Shader uniform type: float
    SHADER_UNIFORM_FLOAT = 0,
    /// Shader uniform type: vec2 (2 float)
    SHADER_UNIFORM_VEC2 = 1,
    /// Shader uniform type: vec3 (3 float)
    SHADER_UNIFORM_VEC3 = 2,
    /// Shader uniform type: vec4 (4 float)
    SHADER_UNIFORM_VEC4 = 3,
    /// Shader uniform type: int
    SHADER_UNIFORM_INT = 4,
    /// Shader uniform type: ivec2 (2 int)
    SHADER_UNIFORM_IVEC2 = 5,
    /// Shader uniform type: ivec3 (3 int)
    SHADER_UNIFORM_IVEC3 = 6,
    /// Shader uniform type: ivec4 (4 int)
    SHADER_UNIFORM_IVEC4 = 7,
    /// Shader uniform type: sampler2d
    SHADER_UNIFORM_SAMPLER2D = 8,
};

/// Shader attribute data types
pub const ShaderAttributeDataType = enum(i32) {
    /// Shader attribute type: float
    SHADER_ATTRIB_FLOAT = 0,
    /// Shader attribute type: vec2 (2 float)
    SHADER_ATTRIB_VEC2 = 1,
    /// Shader attribute type: vec3 (3 float)
    SHADER_ATTRIB_VEC3 = 2,
    /// Shader attribute type: vec4 (4 float)
    SHADER_ATTRIB_VEC4 = 3,
};

/// Pixel formats
pub const PixelFormat = enum(i32) {
    /// 8 bit per pixel (no alpha)
    PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,
    /// 8*2 bpp (2 channels)
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2,
    /// 16 bpp
    PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3,
    /// 24 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4,
    /// 16 bpp (1 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5,
    /// 16 bpp (4 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6,
    /// 32 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7,
    /// 32 bpp (1 channel - float)
    PIXELFORMAT_UNCOMPRESSED_R32 = 8,
    /// 32*3 bpp (3 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9,
    /// 32*4 bpp (4 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10,
    /// 16 bpp (1 channel - half float)
    PIXELFORMAT_UNCOMPRESSED_R16 = 11,
    /// 16*3 bpp (3 channels - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16 = 12,
    /// 16*4 bpp (4 channels - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13,
    /// 4 bpp (no alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGB = 14,
    /// 4 bpp (1 bit alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGBA = 15,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_DXT3_RGBA = 16,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_DXT5_RGBA = 17,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC1_RGB = 18,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_RGB = 19,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 20,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGB = 21,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGBA = 22,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 23,
    /// 2 bpp
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 24,
};

/// Texture parameters: filter mode
pub const TextureFilter = enum(i32) {
    /// No filter, just pixel approximation
    TEXTURE_FILTER_POINT = 0,
    /// Linear filtering
    TEXTURE_FILTER_BILINEAR = 1,
    /// Trilinear filtering (linear with mipmaps)
    TEXTURE_FILTER_TRILINEAR = 2,
    /// Anisotropic filtering 4x
    TEXTURE_FILTER_ANISOTROPIC_4X = 3,
    /// Anisotropic filtering 8x
    TEXTURE_FILTER_ANISOTROPIC_8X = 4,
    /// Anisotropic filtering 16x
    TEXTURE_FILTER_ANISOTROPIC_16X = 5,
};

/// Texture parameters: wrap mode
pub const TextureWrap = enum(i32) {
    /// Repeats texture in tiled mode
    TEXTURE_WRAP_REPEAT = 0,
    /// Clamps texture to edge pixel in tiled mode
    TEXTURE_WRAP_CLAMP = 1,
    /// Mirrors and repeats the texture in tiled mode
    TEXTURE_WRAP_MIRROR_REPEAT = 2,
    /// Mirrors and clamps to border the texture in tiled mode
    TEXTURE_WRAP_MIRROR_CLAMP = 3,
};

/// Cubemap layouts
pub const CubemapLayout = enum(i32) {
    /// Automatically detect layout type
    CUBEMAP_LAYOUT_AUTO_DETECT = 0,
    /// Layout is defined by a vertical line with faces
    CUBEMAP_LAYOUT_LINE_VERTICAL = 1,
    /// Layout is defined by a horizontal line with faces
    CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2,
    /// Layout is defined by a 3x4 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3,
    /// Layout is defined by a 4x3 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4,
    /// Layout is defined by a panorama image (equirrectangular map)
    CUBEMAP_LAYOUT_PANORAMA = 5,
};

/// Font type, defines generation method
pub const FontType = enum(i32) {
    /// Default font generation, anti-aliased
    FONT_DEFAULT = 0,
    /// Bitmap font generation, no anti-aliasing
    FONT_BITMAP = 1,
    /// SDF font generation, requires external shader
    FONT_SDF = 2,
};

/// Color blending modes (pre-defined)
pub const BlendMode = enum(i32) {
    /// Blend textures considering alpha (default)
    BLEND_ALPHA = 0,
    /// Blend textures adding colors
    BLEND_ADDITIVE = 1,
    /// Blend textures multiplying colors
    BLEND_MULTIPLIED = 2,
    /// Blend textures adding colors (alternative)
    BLEND_ADD_COLORS = 3,
    /// Blend textures subtracting colors (alternative)
    BLEND_SUBTRACT_COLORS = 4,
    /// Blend premultiplied textures considering alpha
    BLEND_ALPHA_PREMULTIPLY = 5,
    /// Blend textures using custom src/dst factors (use rlSetBlendFactors())
    BLEND_CUSTOM = 6,
    /// Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())
    BLEND_CUSTOM_SEPARATE = 7,
};

/// Gesture
pub const Gesture = enum(i32) {
    /// No gesture
    GESTURE_NONE = 0,
    /// Tap gesture
    GESTURE_TAP = 1,
    /// Double tap gesture
    GESTURE_DOUBLETAP = 2,
    /// Hold gesture
    GESTURE_HOLD = 4,
    /// Drag gesture
    GESTURE_DRAG = 8,
    /// Swipe right gesture
    GESTURE_SWIPE_RIGHT = 16,
    /// Swipe left gesture
    GESTURE_SWIPE_LEFT = 32,
    /// Swipe up gesture
    GESTURE_SWIPE_UP = 64,
    /// Swipe down gesture
    GESTURE_SWIPE_DOWN = 128,
    /// Pinch in gesture
    GESTURE_PINCH_IN = 256,
    /// Pinch out gesture
    GESTURE_PINCH_OUT = 512,
};

/// Camera system modes
pub const CameraMode = enum(i32) {
    /// Custom camera
    CAMERA_CUSTOM = 0,
    /// Free camera
    CAMERA_FREE = 1,
    /// Orbital camera
    CAMERA_ORBITAL = 2,
    /// First person camera
    CAMERA_FIRST_PERSON = 3,
    /// Third person camera
    CAMERA_THIRD_PERSON = 4,
};

/// Camera projection
pub const CameraProjection = enum(i32) {
    /// Perspective projection
    CAMERA_PERSPECTIVE = 0,
    /// Orthographic projection
    CAMERA_ORTHOGRAPHIC = 1,
};

/// N-patch layout
pub const NPatchLayout = enum(i32) {
    /// Npatch layout: 3x3 tiles
    NPATCH_NINE_PATCH = 0,
    /// Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_VERTICAL = 1,
    /// Npatch layout: 3x1 tiles
    NPATCH_THREE_PATCH_HORIZONTAL = 2,
};

/// OpenGL version
pub const rlGlVersion = enum(i32) {
    /// OpenGL 1.1
    RL_OPENGL_11 = 1,
    /// OpenGL 2.1 (GLSL 120)
    RL_OPENGL_21 = 2,
    /// OpenGL 3.3 (GLSL 330)
    RL_OPENGL_33 = 3,
    /// OpenGL 4.3 (using GLSL 330)
    RL_OPENGL_43 = 4,
    /// OpenGL ES 2.0 (GLSL 100)
    RL_OPENGL_ES_20 = 5,
    /// OpenGL ES 3.0 (GLSL 300 es)
    RL_OPENGL_ES_30 = 6,
};

/// Trace log level
pub const rlTraceLogLevel = enum(i32) {
    /// Display all logs
    RL_LOG_ALL = 0,
    /// Trace logging, intended for internal use only
    RL_LOG_TRACE = 1,
    /// Debug logging, used for internal debugging, it should be disabled on release builds
    RL_LOG_DEBUG = 2,
    /// Info logging, used for program execution info
    RL_LOG_INFO = 3,
    /// Warning logging, used on recoverable failures
    RL_LOG_WARNING = 4,
    /// Error logging, used on unrecoverable failures
    RL_LOG_ERROR = 5,
    /// Fatal logging, used to abort program: exit(EXIT_FAILURE)
    RL_LOG_FATAL = 6,
    /// Disable logging
    RL_LOG_NONE = 7,
};

/// Texture pixel formats
pub const rlPixelFormat = enum(i32) {
    /// 8 bit per pixel (no alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,
    /// 8*2 bpp (2 channels)
    RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2,
    /// 16 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3,
    /// 24 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4,
    /// 16 bpp (1 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5,
    /// 16 bpp (4 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6,
    /// 32 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7,
    /// 32 bpp (1 channel - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32 = 8,
    /// 32*3 bpp (3 channels - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9,
    /// 32*4 bpp (4 channels - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10,
    /// 16 bpp (1 channel - half float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16 = 11,
    /// 16*3 bpp (3 channels - half float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16 = 12,
    /// 16*4 bpp (4 channels - half float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13,
    /// 4 bpp (no alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGB = 14,
    /// 4 bpp (1 bit alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA = 15,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA = 16,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA = 17,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC1_RGB = 18,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_RGB = 19,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 20,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGB = 21,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA = 22,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 23,
    /// 2 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 24,
};

/// Texture parameters: filter mode
pub const rlTextureFilter = enum(i32) {
    /// No filter, just pixel approximation
    RL_TEXTURE_FILTER_POINT = 0,
    /// Linear filtering
    RL_TEXTURE_FILTER_BILINEAR = 1,
    /// Trilinear filtering (linear with mipmaps)
    RL_TEXTURE_FILTER_TRILINEAR = 2,
    /// Anisotropic filtering 4x
    RL_TEXTURE_FILTER_ANISOTROPIC_4X = 3,
    /// Anisotropic filtering 8x
    RL_TEXTURE_FILTER_ANISOTROPIC_8X = 4,
    /// Anisotropic filtering 16x
    RL_TEXTURE_FILTER_ANISOTROPIC_16X = 5,
};

/// Color blending modes (pre-defined)
pub const rlBlendMode = enum(i32) {
    /// Blend textures considering alpha (default)
    RL_BLEND_ALPHA = 0,
    /// Blend textures adding colors
    RL_BLEND_ADDITIVE = 1,
    /// Blend textures multiplying colors
    RL_BLEND_MULTIPLIED = 2,
    /// Blend textures adding colors (alternative)
    RL_BLEND_ADD_COLORS = 3,
    /// Blend textures subtracting colors (alternative)
    RL_BLEND_SUBTRACT_COLORS = 4,
    /// Blend premultiplied textures considering alpha
    RL_BLEND_ALPHA_PREMULTIPLY = 5,
    /// Blend textures using custom src/dst factors (use rlSetBlendFactors())
    RL_BLEND_CUSTOM = 6,
    /// Blend textures using custom src/dst factors (use rlSetBlendFactorsSeparate())
    RL_BLEND_CUSTOM_SEPARATE = 7,
};

/// Shader location point type
pub const rlShaderLocationIndex = enum(i32) {
    /// Shader location: vertex attribute: position
    RL_SHADER_LOC_VERTEX_POSITION = 0,
    /// Shader location: vertex attribute: texcoord01
    RL_SHADER_LOC_VERTEX_TEXCOORD01 = 1,
    /// Shader location: vertex attribute: texcoord02
    RL_SHADER_LOC_VERTEX_TEXCOORD02 = 2,
    /// Shader location: vertex attribute: normal
    RL_SHADER_LOC_VERTEX_NORMAL = 3,
    /// Shader location: vertex attribute: tangent
    RL_SHADER_LOC_VERTEX_TANGENT = 4,
    /// Shader location: vertex attribute: color
    RL_SHADER_LOC_VERTEX_COLOR = 5,
    /// Shader location: matrix uniform: model-view-projection
    RL_SHADER_LOC_MATRIX_MVP = 6,
    /// Shader location: matrix uniform: view (camera transform)
    RL_SHADER_LOC_MATRIX_VIEW = 7,
    /// Shader location: matrix uniform: projection
    RL_SHADER_LOC_MATRIX_PROJECTION = 8,
    /// Shader location: matrix uniform: model (transform)
    RL_SHADER_LOC_MATRIX_MODEL = 9,
    /// Shader location: matrix uniform: normal
    RL_SHADER_LOC_MATRIX_NORMAL = 10,
    /// Shader location: vector uniform: view
    RL_SHADER_LOC_VECTOR_VIEW = 11,
    /// Shader location: vector uniform: diffuse color
    RL_SHADER_LOC_COLOR_DIFFUSE = 12,
    /// Shader location: vector uniform: specular color
    RL_SHADER_LOC_COLOR_SPECULAR = 13,
    /// Shader location: vector uniform: ambient color
    RL_SHADER_LOC_COLOR_AMBIENT = 14,
    /// Shader location: sampler2d texture: albedo (same as: RL_SHADER_LOC_MAP_DIFFUSE)
    RL_SHADER_LOC_MAP_ALBEDO = 15,
    /// Shader location: sampler2d texture: metalness (same as: RL_SHADER_LOC_MAP_SPECULAR)
    RL_SHADER_LOC_MAP_METALNESS = 16,
    /// Shader location: sampler2d texture: normal
    RL_SHADER_LOC_MAP_NORMAL = 17,
    /// Shader location: sampler2d texture: roughness
    RL_SHADER_LOC_MAP_ROUGHNESS = 18,
    /// Shader location: sampler2d texture: occlusion
    RL_SHADER_LOC_MAP_OCCLUSION = 19,
    /// Shader location: sampler2d texture: emission
    RL_SHADER_LOC_MAP_EMISSION = 20,
    /// Shader location: sampler2d texture: height
    RL_SHADER_LOC_MAP_HEIGHT = 21,
    /// Shader location: samplerCube texture: cubemap
    RL_SHADER_LOC_MAP_CUBEMAP = 22,
    /// Shader location: samplerCube texture: irradiance
    RL_SHADER_LOC_MAP_IRRADIANCE = 23,
    /// Shader location: samplerCube texture: prefilter
    RL_SHADER_LOC_MAP_PREFILTER = 24,
    /// Shader location: sampler2d texture: brdf
    RL_SHADER_LOC_MAP_BRDF = 25,
};

/// Shader uniform data type
pub const rlShaderUniformDataType = enum(i32) {
    /// Shader uniform type: float
    RL_SHADER_UNIFORM_FLOAT = 0,
    /// Shader uniform type: vec2 (2 float)
    RL_SHADER_UNIFORM_VEC2 = 1,
    /// Shader uniform type: vec3 (3 float)
    RL_SHADER_UNIFORM_VEC3 = 2,
    /// Shader uniform type: vec4 (4 float)
    RL_SHADER_UNIFORM_VEC4 = 3,
    /// Shader uniform type: int
    RL_SHADER_UNIFORM_INT = 4,
    /// Shader uniform type: ivec2 (2 int)
    RL_SHADER_UNIFORM_IVEC2 = 5,
    /// Shader uniform type: ivec3 (3 int)
    RL_SHADER_UNIFORM_IVEC3 = 6,
    /// Shader uniform type: ivec4 (4 int)
    RL_SHADER_UNIFORM_IVEC4 = 7,
    /// Shader uniform type: sampler2d
    RL_SHADER_UNIFORM_SAMPLER2D = 8,
};

/// Shader attribute data types
pub const rlShaderAttributeDataType = enum(i32) {
    /// Shader attribute type: float
    RL_SHADER_ATTRIB_FLOAT = 0,
    /// Shader attribute type: vec2 (2 float)
    RL_SHADER_ATTRIB_VEC2 = 1,
    /// Shader attribute type: vec3 (3 float)
    RL_SHADER_ATTRIB_VEC3 = 2,
    /// Shader attribute type: vec4 (4 float)
    RL_SHADER_ATTRIB_VEC4 = 3,
};

/// Framebuffer attachment type
pub const rlFramebufferAttachType = enum(i32) {
    /// Framebuffer attachment type: color 0
    RL_ATTACHMENT_COLOR_CHANNEL0 = 0,
    /// Framebuffer attachment type: color 1
    RL_ATTACHMENT_COLOR_CHANNEL1 = 1,
    /// Framebuffer attachment type: color 2
    RL_ATTACHMENT_COLOR_CHANNEL2 = 2,
    /// Framebuffer attachment type: color 3
    RL_ATTACHMENT_COLOR_CHANNEL3 = 3,
    /// Framebuffer attachment type: color 4
    RL_ATTACHMENT_COLOR_CHANNEL4 = 4,
    /// Framebuffer attachment type: color 5
    RL_ATTACHMENT_COLOR_CHANNEL5 = 5,
    /// Framebuffer attachment type: color 6
    RL_ATTACHMENT_COLOR_CHANNEL6 = 6,
    /// Framebuffer attachment type: color 7
    RL_ATTACHMENT_COLOR_CHANNEL7 = 7,
    /// Framebuffer attachment type: depth
    RL_ATTACHMENT_DEPTH = 100,
    /// Framebuffer attachment type: stencil
    RL_ATTACHMENT_STENCIL = 200,
};

/// Framebuffer texture attachment type
pub const rlFramebufferAttachTextureType = enum(i32) {
    /// Framebuffer texture attachment type: cubemap, +X side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0,
    /// Framebuffer texture attachment type: cubemap, -X side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_X = 1,
    /// Framebuffer texture attachment type: cubemap, +Y side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Y = 2,
    /// Framebuffer texture attachment type: cubemap, -Y side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y = 3,
    /// Framebuffer texture attachment type: cubemap, +Z side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Z = 4,
    /// Framebuffer texture attachment type: cubemap, -Z side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z = 5,
    /// Framebuffer texture attachment type: texture2d
    RL_ATTACHMENT_TEXTURE2D = 100,
    /// Framebuffer texture attachment type: renderbuffer
    RL_ATTACHMENT_RENDERBUFFER = 200,
};

/// Face culling mode
pub const rlCullMode = enum(i32) {
    ///
    RL_CULL_FACE_FRONT = 0,
    ///
    RL_CULL_FACE_BACK = 1,
};

/// circle or polygon
pub const PhysicsShapeType = enum(i32) {
    /// physics shape is a circle
    PHYSICS_CIRCLE = 0,
    /// physics shape is a polygon
    PHYSICS_POLYGON = 1,
};

///
pub const RAYLIB_VERSION_MAJOR: i32 = 5;

///
pub const RAYLIB_VERSION_MINOR: i32 = 1;

///
pub const RAYLIB_VERSION_PATCH: i32 = 0;

///
pub const RAYLIB_VERSION: []const u8 = "5.1-dev";

///
pub const PI: f32 = 3.14159265358979323846;

/// Light Gray
pub const LIGHTGRAY: Color = .{ .r = 200, .g = 200, .b = 200, .a = 255 };

/// Gray
pub const GRAY: Color = .{ .r = 130, .g = 130, .b = 130, .a = 255 };

/// Dark Gray
pub const DARKGRAY: Color = .{ .r = 80, .g = 80, .b = 80, .a = 255 };

/// Yellow
pub const YELLOW: Color = .{ .r = 253, .g = 249, .b = 0, .a = 255 };

/// Gold
pub const GOLD: Color = .{ .r = 255, .g = 203, .b = 0, .a = 255 };

/// Orange
pub const ORANGE: Color = .{ .r = 255, .g = 161, .b = 0, .a = 255 };

/// Pink
pub const PINK: Color = .{ .r = 255, .g = 109, .b = 194, .a = 255 };

/// Red
pub const RED: Color = .{ .r = 230, .g = 41, .b = 55, .a = 255 };

/// Maroon
pub const MAROON: Color = .{ .r = 190, .g = 33, .b = 55, .a = 255 };

/// Green
pub const GREEN: Color = .{ .r = 0, .g = 228, .b = 48, .a = 255 };

/// Lime
pub const LIME: Color = .{ .r = 0, .g = 158, .b = 47, .a = 255 };

/// Dark Green
pub const DARKGREEN: Color = .{ .r = 0, .g = 117, .b = 44, .a = 255 };

/// Sky Blue
pub const SKYBLUE: Color = .{ .r = 102, .g = 191, .b = 255, .a = 255 };

/// Blue
pub const BLUE: Color = .{ .r = 0, .g = 121, .b = 241, .a = 255 };

/// Dark Blue
pub const DARKBLUE: Color = .{ .r = 0, .g = 82, .b = 172, .a = 255 };

/// Purple
pub const PURPLE: Color = .{ .r = 200, .g = 122, .b = 255, .a = 255 };

/// Violet
pub const VIOLET: Color = .{ .r = 135, .g = 60, .b = 190, .a = 255 };

/// Dark Purple
pub const DARKPURPLE: Color = .{ .r = 112, .g = 31, .b = 126, .a = 255 };

/// Beige
pub const BEIGE: Color = .{ .r = 211, .g = 176, .b = 131, .a = 255 };

/// Brown
pub const BROWN: Color = .{ .r = 127, .g = 106, .b = 79, .a = 255 };

/// Dark Brown
pub const DARKBROWN: Color = .{ .r = 76, .g = 63, .b = 47, .a = 255 };

/// White
pub const WHITE: Color = .{ .r = 255, .g = 255, .b = 255, .a = 255 };

/// Black
pub const BLACK: Color = .{ .r = 0, .g = 0, .b = 0, .a = 255 };

/// Blank (Transparent)
pub const BLANK: Color = .{ .r = 0, .g = 0, .b = 0, .a = 0 };

/// Magenta
pub const MAGENTA: Color = .{ .r = 255, .g = 0, .b = 255, .a = 255 };

/// My own White (raylib logo)
pub const RAYWHITE: Color = .{ .r = 245, .g = 245, .b = 245, .a = 255 };

///
pub const RLGL_VERSION: []const u8 = "4.5";

///
pub const RL_DEFAULT_BATCH_BUFFER_ELEMENTS: i32 = 8192;

/// Default number of batch buffers (multi-buffering)
pub const RL_DEFAULT_BATCH_BUFFERS: i32 = 1;

/// Default number of batch draw calls (by state changes: mode, texture)
pub const RL_DEFAULT_BATCH_DRAWCALLS: i32 = 256;

/// Maximum number of textures units that can be activated on batch drawing (SetShaderValueTexture())
pub const RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS: i32 = 4;

/// Maximum size of Matrix stack
pub const RL_MAX_MATRIX_STACK_SIZE: i32 = 32;

/// Maximum number of shader locations supported
pub const RL_MAX_SHADER_LOCATIONS: i32 = 32;

/// Default near cull distance
pub const RL_CULL_DISTANCE_NEAR: f64 = 0.01;

/// Default far cull distance
pub const RL_CULL_DISTANCE_FAR: f64 = 1000.0;

/// GL_TEXTURE_WRAP_S
pub const RL_TEXTURE_WRAP_S: i32 = 10242;

/// GL_TEXTURE_WRAP_T
pub const RL_TEXTURE_WRAP_T: i32 = 10243;

/// GL_TEXTURE_MAG_FILTER
pub const RL_TEXTURE_MAG_FILTER: i32 = 10240;

/// GL_TEXTURE_MIN_FILTER
pub const RL_TEXTURE_MIN_FILTER: i32 = 10241;

/// GL_NEAREST
pub const RL_TEXTURE_FILTER_NEAREST: i32 = 9728;

/// GL_LINEAR
pub const RL_TEXTURE_FILTER_LINEAR: i32 = 9729;

/// GL_NEAREST_MIPMAP_NEAREST
pub const RL_TEXTURE_FILTER_MIP_NEAREST: i32 = 9984;

/// GL_NEAREST_MIPMAP_LINEAR
pub const RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR: i32 = 9986;

/// GL_LINEAR_MIPMAP_NEAREST
pub const RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST: i32 = 9985;

/// GL_LINEAR_MIPMAP_LINEAR
pub const RL_TEXTURE_FILTER_MIP_LINEAR: i32 = 9987;

/// Anisotropic filter (custom identifier)
pub const RL_TEXTURE_FILTER_ANISOTROPIC: i32 = 12288;

/// Texture mipmap bias, percentage ratio (custom identifier)
pub const RL_TEXTURE_MIPMAP_BIAS_RATIO: i32 = 16384;

/// GL_REPEAT
pub const RL_TEXTURE_WRAP_REPEAT: i32 = 10497;

/// GL_CLAMP_TO_EDGE
pub const RL_TEXTURE_WRAP_CLAMP: i32 = 33071;

/// GL_MIRRORED_REPEAT
pub const RL_TEXTURE_WRAP_MIRROR_REPEAT: i32 = 33648;

/// GL_MIRROR_CLAMP_EXT
pub const RL_TEXTURE_WRAP_MIRROR_CLAMP: i32 = 34626;

/// GL_MODELVIEW
pub const RL_MODELVIEW: i32 = 5888;

/// GL_PROJECTION
pub const RL_PROJECTION: i32 = 5889;

/// GL_TEXTURE
pub const RL_TEXTURE: i32 = 5890;

/// GL_LINES
pub const RL_LINES: i32 = 1;

/// GL_TRIANGLES
pub const RL_TRIANGLES: i32 = 4;

/// GL_QUADS
pub const RL_QUADS: i32 = 7;

/// GL_UNSIGNED_BYTE
pub const RL_UNSIGNED_BYTE: i32 = 5121;

/// GL_FLOAT
pub const RL_FLOAT: i32 = 5126;

/// GL_STREAM_DRAW
pub const RL_STREAM_DRAW: i32 = 35040;

/// GL_STREAM_READ
pub const RL_STREAM_READ: i32 = 35041;

/// GL_STREAM_COPY
pub const RL_STREAM_COPY: i32 = 35042;

/// GL_STATIC_DRAW
pub const RL_STATIC_DRAW: i32 = 35044;

/// GL_STATIC_READ
pub const RL_STATIC_READ: i32 = 35045;

/// GL_STATIC_COPY
pub const RL_STATIC_COPY: i32 = 35046;

/// GL_DYNAMIC_DRAW
pub const RL_DYNAMIC_DRAW: i32 = 35048;

/// GL_DYNAMIC_READ
pub const RL_DYNAMIC_READ: i32 = 35049;

/// GL_DYNAMIC_COPY
pub const RL_DYNAMIC_COPY: i32 = 35050;

/// GL_FRAGMENT_SHADER
pub const RL_FRAGMENT_SHADER: i32 = 35632;

/// GL_VERTEX_SHADER
pub const RL_VERTEX_SHADER: i32 = 35633;

/// GL_COMPUTE_SHADER
pub const RL_COMPUTE_SHADER: i32 = 37305;

/// GL_ZERO
pub const RL_ZERO: i32 = 0;

/// GL_ONE
pub const RL_ONE: i32 = 1;

/// GL_SRC_COLOR
pub const RL_SRC_COLOR: i32 = 768;

/// GL_ONE_MINUS_SRC_COLOR
pub const RL_ONE_MINUS_SRC_COLOR: i32 = 769;

/// GL_SRC_ALPHA
pub const RL_SRC_ALPHA: i32 = 770;

/// GL_ONE_MINUS_SRC_ALPHA
pub const RL_ONE_MINUS_SRC_ALPHA: i32 = 771;

/// GL_DST_ALPHA
pub const RL_DST_ALPHA: i32 = 772;

/// GL_ONE_MINUS_DST_ALPHA
pub const RL_ONE_MINUS_DST_ALPHA: i32 = 773;

/// GL_DST_COLOR
pub const RL_DST_COLOR: i32 = 774;

/// GL_ONE_MINUS_DST_COLOR
pub const RL_ONE_MINUS_DST_COLOR: i32 = 775;

/// GL_SRC_ALPHA_SATURATE
pub const RL_SRC_ALPHA_SATURATE: i32 = 776;

/// GL_CONSTANT_COLOR
pub const RL_CONSTANT_COLOR: i32 = 32769;

/// GL_ONE_MINUS_CONSTANT_COLOR
pub const RL_ONE_MINUS_CONSTANT_COLOR: i32 = 32770;

/// GL_CONSTANT_ALPHA
pub const RL_CONSTANT_ALPHA: i32 = 32771;

/// GL_ONE_MINUS_CONSTANT_ALPHA
pub const RL_ONE_MINUS_CONSTANT_ALPHA: i32 = 32772;

/// GL_FUNC_ADD
pub const RL_FUNC_ADD: i32 = 32774;

/// GL_MIN
pub const RL_MIN: i32 = 32775;

/// GL_MAX
pub const RL_MAX: i32 = 32776;

/// GL_FUNC_SUBTRACT
pub const RL_FUNC_SUBTRACT: i32 = 32778;

/// GL_FUNC_REVERSE_SUBTRACT
pub const RL_FUNC_REVERSE_SUBTRACT: i32 = 32779;

/// GL_BLEND_EQUATION
pub const RL_BLEND_EQUATION: i32 = 32777;

/// GL_BLEND_EQUATION_RGB   // (Same as BLEND_EQUATION)
pub const RL_BLEND_EQUATION_RGB: i32 = 32777;

/// GL_BLEND_EQUATION_ALPHA
pub const RL_BLEND_EQUATION_ALPHA: i32 = 34877;

/// GL_BLEND_DST_RGB
pub const RL_BLEND_DST_RGB: i32 = 32968;

/// GL_BLEND_SRC_RGB
pub const RL_BLEND_SRC_RGB: i32 = 32969;

/// GL_BLEND_DST_ALPHA
pub const RL_BLEND_DST_ALPHA: i32 = 32970;

/// GL_BLEND_SRC_ALPHA
pub const RL_BLEND_SRC_ALPHA: i32 = 32971;

/// GL_BLEND_COLOR
pub const RL_BLEND_COLOR: i32 = 32773;

/// GL_READ_FRAMEBUFFER
pub const RL_READ_FRAMEBUFFER: i32 = 36008;

/// GL_DRAW_FRAMEBUFFER
pub const RL_DRAW_FRAMEBUFFER: i32 = 36009;

///
pub const GL_SHADING_LANGUAGE_VERSION: i32 = 35724;

///
pub const GL_COMPRESSED_RGB_S3TC_DXT1_EXT: i32 = 33776;

///
pub const GL_COMPRESSED_RGBA_S3TC_DXT1_EXT: i32 = 33777;

///
pub const GL_COMPRESSED_RGBA_S3TC_DXT3_EXT: i32 = 33778;

///
pub const GL_COMPRESSED_RGBA_S3TC_DXT5_EXT: i32 = 33779;

///
pub const GL_ETC1_RGB8_OES: i32 = 36196;

///
pub const GL_COMPRESSED_RGB8_ETC2: i32 = 37492;

///
pub const GL_COMPRESSED_RGBA8_ETC2_EAC: i32 = 37496;

///
pub const GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG: i32 = 35840;

///
pub const GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG: i32 = 35842;

///
pub const GL_COMPRESSED_RGBA_ASTC_4x4_KHR: i32 = 37808;

///
pub const GL_COMPRESSED_RGBA_ASTC_8x8_KHR: i32 = 37815;

///
pub const GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT: i32 = 34047;

///
pub const GL_TEXTURE_MAX_ANISOTROPY_EXT: i32 = 34046;

///
pub const GL_UNSIGNED_SHORT_5_6_5: i32 = 33635;

///
pub const GL_UNSIGNED_SHORT_5_5_5_1: i32 = 32820;

///
pub const GL_UNSIGNED_SHORT_4_4_4_4: i32 = 32819;

///
pub const GL_LUMINANCE: i32 = 6409;

///
pub const GL_LUMINANCE_ALPHA: i32 = 6410;

/// Bound by default to shader location: 0
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_POSITION: []const u8 = "vertexPosition";

/// Bound by default to shader location: 1
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_TEXCOORD: []const u8 = "vertexTexCoord";

/// Bound by default to shader location: 2
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_NORMAL: []const u8 = "vertexNormal";

/// Bound by default to shader location: 3
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_COLOR: []const u8 = "vertexColor";

/// Bound by default to shader location: 4
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_TANGENT: []const u8 = "vertexTangent";

/// Bound by default to shader location: 5
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_TEXCOORD2: []const u8 = "vertexTexCoord2";

/// model-view-projection matrix
pub const RL_DEFAULT_SHADER_UNIFORM_NAME_MVP: []const u8 = "mvp";

/// view matrix
pub const RL_DEFAULT_SHADER_UNIFORM_NAME_VIEW: []const u8 = "matView";

/// projection matrix
pub const RL_DEFAULT_SHADER_UNIFORM_NAME_PROJECTION: []const u8 = "matProjection";

/// model matrix
pub const RL_DEFAULT_SHADER_UNIFORM_NAME_MODEL: []const u8 = "matModel";

/// normal matrix (transpose(inverse(matModelView))
pub const RL_DEFAULT_SHADER_UNIFORM_NAME_NORMAL: []const u8 = "matNormal";

/// color diffuse (base tint color, multiplied by texture color)
pub const RL_DEFAULT_SHADER_UNIFORM_NAME_COLOR: []const u8 = "colDiffuse";

/// texture0 (texture slot active 0)
pub const RL_DEFAULT_SHADER_SAMPLER2D_NAME_TEXTURE0: []const u8 = "texture0";

/// texture1 (texture slot active 1)
pub const RL_DEFAULT_SHADER_SAMPLER2D_NAME_TEXTURE1: []const u8 = "texture1";

/// texture2 (texture slot active 2)
pub const RL_DEFAULT_SHADER_SAMPLER2D_NAME_TEXTURE2: []const u8 = "texture2";

///
pub const EPSILON: f32 = 0.000001;
