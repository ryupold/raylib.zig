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
    x: f32 = 0,
    y: f32 = 0,
    width: f32 = 0,
    height: f32 = 0,

    pub fn toI32(self: @This()) RectangleI {
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
        return self.x * self.y;
    }
};

pub const RectangleI = extern struct {
    x: f32 = 0,
    y: f32 = 0,
    width: f32 = 0,
    height: f32 = 0,

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
        return .{ .x = @floatToInt(i32, self.x), .y = @floatToInt(i32, self.y) };
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
        const a = @intToFloat(f32, self.a);
        copy.a = @floatToInt(u8, a * (1 - t) + @intToFloat(f32, targetAlpha) * t);
        return copy;
    }

    pub fn toVector4(self: @This()) Vector4 {
        return .{
            .x = @intToFloat(f32, self.r) / 255.0,
            .y = @intToFloat(f32, self.g) / 255.0,
            .z = @intToFloat(f32, self.b) / 255.0,
            .w = @intToFloat(f32, self.a) / 255.0,
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
        @ptrCast([*c]anyopaque, buffer),
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

/// Initialize window and OpenGL context
pub fn InitWindow(
    width: i32,
    height: i32,
    title: [*:0]const u8,
) void {
    raylib.mInitWindow(
        width,
        height,
        @intToPtr([*c]const u8, @ptrToInt(title)),
    );
}

/// Check if KEY_ESCAPE pressed or Close icon pressed
pub fn WindowShouldClose() bool {
    return raylib.mWindowShouldClose();
}

/// Close window and unload OpenGL context
pub fn CloseWindow() void {
    raylib.mCloseWindow();
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

/// Set icon for window (only PLATFORM_DESKTOP)
pub fn SetWindowIcon(
    image: Image,
) void {
    raylib.mSetWindowIcon(
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
    );
}

/// Set title for window (only PLATFORM_DESKTOP)
pub fn SetWindowTitle(
    title: [*:0]const u8,
) void {
    raylib.mSetWindowTitle(
        @intToPtr([*c]const u8, @ptrToInt(title)),
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

/// Set monitor for the current window (fullscreen mode)
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
        @ptrCast([*c]raylib.Vector2, &out),
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
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

/// Get window scale DPI factor
pub fn GetWindowScaleDPI() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetWindowScaleDPI(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

/// Get the human-readable, UTF-8 encoded name of the primary monitor
pub fn GetMonitorName(
    monitor: i32,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetMonitorName(
            monitor,
        ),
    );
}

/// Set clipboard text content
pub fn SetClipboardText(
    text: [*:0]const u8,
) void {
    raylib.mSetClipboardText(
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
}

/// Get clipboard text content
pub fn GetClipboardText() [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetClipboardText(),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
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
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
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
        @intToPtr([*c]raylib.RenderTexture2D, @ptrToInt(&target)),
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
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
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
        @intToPtr([*c]raylib.VrStereoConfig, @ptrToInt(&config)),
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
        @ptrCast([*c]raylib.VrStereoConfig, &out),
        @intToPtr([*c]raylib.VrDeviceInfo, @ptrToInt(&device)),
    );
    return out;
}

/// Unload VR stereo config
pub fn UnloadVrStereoConfig(
    config: VrStereoConfig,
) void {
    raylib.mUnloadVrStereoConfig(
        @intToPtr([*c]raylib.VrStereoConfig, @ptrToInt(&config)),
    );
}

/// Load shader from files and bind default locations
pub fn LoadShader(
    vsFileName: [*:0]const u8,
    fsFileName: [*:0]const u8,
) Shader {
    var out: Shader = undefined;
    raylib.mLoadShader(
        @ptrCast([*c]raylib.Shader, &out),
        @intToPtr([*c]const u8, @ptrToInt(vsFileName)),
        @intToPtr([*c]const u8, @ptrToInt(fsFileName)),
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
        @ptrCast([*c]raylib.Shader, &out),
        @intToPtr([*c]const u8, @ptrToInt(vsCode)),
        @intToPtr([*c]const u8, @ptrToInt(fsCode)),
    );
    return out;
}

/// Get shader uniform location
pub fn GetShaderLocation(
    shader: Shader,
    uniformName: [*:0]const u8,
) i32 {
    return raylib.mGetShaderLocation(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        @intToPtr([*c]const u8, @ptrToInt(uniformName)),
    );
}

/// Get shader attribute location
pub fn GetShaderLocationAttrib(
    shader: Shader,
    attribName: [*:0]const u8,
) i32 {
    return raylib.mGetShaderLocationAttrib(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        @intToPtr([*c]const u8, @ptrToInt(attribName)),
    );
}

/// Set shader uniform value
pub fn SetShaderValue(
    shader: Shader,
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
) void {
    raylib.mSetShaderValue(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @ptrCast([*c]anyopaque, value),
        uniformType,
    );
}

/// Set shader uniform value vector
pub fn SetShaderValueV(
    shader: Shader,
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
    count: i32,
) void {
    raylib.mSetShaderValueV(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @ptrCast([*c]anyopaque, value),
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
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
}

/// Set shader uniform value for texture (sampler2d)
pub fn SetShaderValueTexture(
    shader: Shader,
    locIndex: i32,
    texture: Texture2D,
) void {
    raylib.mSetShaderValueTexture(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
}

/// Unload shader from GPU memory (VRAM)
pub fn UnloadShader(
    shader: Shader,
) void {
    raylib.mUnloadShader(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
    );
}

/// Get a ray trace from mouse position
pub fn GetMouseRay(
    mousePosition: Vector2,
    camera: Camera3D,
) Ray {
    var out: Ray = undefined;
    raylib.mGetMouseRay(
        @ptrCast([*c]raylib.Ray, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&mousePosition)),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
    );
    return out;
}

/// Get camera transform matrix (view matrix)
pub fn GetCameraMatrix(
    camera: Camera3D,
) Matrix {
    var out: Matrix = undefined;
    raylib.mGetCameraMatrix(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
    );
    return out;
}

/// Get camera 2d transform matrix
pub fn GetCameraMatrix2D(
    camera: Camera2D,
) Matrix {
    var out: Matrix = undefined;
    raylib.mGetCameraMatrix2D(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
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

/// Get current FPS
pub fn GetFPS() i32 {
    return raylib.mGetFPS();
}

/// Get time in seconds for last frame drawn (delta time)
pub fn GetFrameTime() f32 {
    return raylib.mGetFrameTime();
}

/// Get elapsed time in seconds since InitWindow()
pub fn GetTime() f64 {
    return raylib.mGetTime();
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

/// Set the seed for the random number generator
pub fn SetRandomSeed(
    seed: u32,
) void {
    raylib.mSetRandomSeed(
        seed,
    );
}

/// Takes a screenshot of current screen (filename extension defines format)
pub fn TakeScreenshot(
    fileName: [*:0]const u8,
) void {
    raylib.mTakeScreenshot(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
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

/// Open URL with default system browser (if available)
pub fn OpenURL(
    url: [*:0]const u8,
) void {
    raylib.mOpenURL(
        @intToPtr([*c]const u8, @ptrToInt(url)),
    );
}

/// Set custom file binary data loader
pub fn SetLoadFileDataCallback(
    callback: LoadFileDataCallback,
) void {
    raylib.mSetLoadFileDataCallback(
        callback,
    );
}

/// Set custom file binary data saver
pub fn SetSaveFileDataCallback(
    callback: SaveFileDataCallback,
) void {
    raylib.mSetSaveFileDataCallback(
        callback,
    );
}

/// Set custom file text data loader
pub fn SetLoadFileTextCallback(
    callback: LoadFileTextCallback,
) void {
    raylib.mSetLoadFileTextCallback(
        callback,
    );
}

/// Set custom file text data saver
pub fn SetSaveFileTextCallback(
    callback: SaveFileTextCallback,
) void {
    raylib.mSetSaveFileTextCallback(
        callback,
    );
}

/// Save data to file from byte array (write), returns true on success
pub fn SaveFileData(
    fileName: [*:0]const u8,
    data: *anyopaque,
    bytesToWrite: u32,
) bool {
    return raylib.mSaveFileData(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        @ptrCast([*c]anyopaque, data),
        bytesToWrite,
    );
}

/// Export data to code (.h), returns true on success
pub fn ExportDataAsCode(
    data: [*:0]const u8,
    size: u32,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportDataAsCode(
        @intToPtr([*c]const u8, @ptrToInt(data)),
        size,
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Load text data from file (read), returns a '\0' terminated string
pub fn LoadFileText(
    fileName: [*:0]const u8,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mLoadFileText(
        @ptrCast([*c]?[*]u8, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

/// Unload file text data allocated by LoadFileText()
pub fn UnloadFileText(
    text: ?[*]u8,
) void {
    raylib.mUnloadFileText(
        text,
    );
}

/// Save text data to file (write), string must be '\0' terminated, returns true on success
pub fn SaveFileText(
    fileName: [*:0]const u8,
    text: ?[*]u8,
) bool {
    return raylib.mSaveFileText(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        text,
    );
}

/// Check if file exists
pub fn FileExists(
    fileName: [*:0]const u8,
) bool {
    return raylib.mFileExists(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Check if a directory path exists
pub fn DirectoryExists(
    dirPath: [*:0]const u8,
) bool {
    return raylib.mDirectoryExists(
        @intToPtr([*c]const u8, @ptrToInt(dirPath)),
    );
}

/// Check file extension (including point: .png, .wav)
pub fn IsFileExtension(
    fileName: [*:0]const u8,
    ext: [*:0]const u8,
) bool {
    return raylib.mIsFileExtension(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        @intToPtr([*c]const u8, @ptrToInt(ext)),
    );
}

/// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub fn GetFileLength(
    fileName: [*:0]const u8,
) i32 {
    return raylib.mGetFileLength(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Get pointer to extension for a filename string (includes dot: '.png')
pub fn GetFileExtension(
    fileName: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetFileExtension(
            @intToPtr([*c]const u8, @ptrToInt(fileName)),
        ),
    );
}

/// Get pointer to filename for a path string
pub fn GetFileName(
    filePath: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetFileName(
            @intToPtr([*c]const u8, @ptrToInt(filePath)),
        ),
    );
}

/// Get filename string without extension (uses static string)
pub fn GetFileNameWithoutExt(
    filePath: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetFileNameWithoutExt(
            @intToPtr([*c]const u8, @ptrToInt(filePath)),
        ),
    );
}

/// Get full path for a given fileName with path (uses static string)
pub fn GetDirectoryPath(
    filePath: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetDirectoryPath(
            @intToPtr([*c]const u8, @ptrToInt(filePath)),
        ),
    );
}

/// Get previous directory path for a given path (uses static string)
pub fn GetPrevDirectoryPath(
    dirPath: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetPrevDirectoryPath(
            @intToPtr([*c]const u8, @ptrToInt(dirPath)),
        ),
    );
}

/// Get current working directory (uses static string)
pub fn GetWorkingDirectory() [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetWorkingDirectory(),
    );
}

/// Get the directory if the running application (uses static string)
pub fn GetApplicationDirectory() [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetApplicationDirectory(),
    );
}

/// Change working directory, return true on success
pub fn ChangeDirectory(
    dir: [*:0]const u8,
) bool {
    return raylib.mChangeDirectory(
        @intToPtr([*c]const u8, @ptrToInt(dir)),
    );
}

/// Check if a given path is a file or a directory
pub fn IsPathFile(
    path: [*:0]const u8,
) bool {
    return raylib.mIsPathFile(
        @intToPtr([*c]const u8, @ptrToInt(path)),
    );
}

/// Load directory filepaths
pub fn LoadDirectoryFiles(
    dirPath: [*:0]const u8,
) FilePathList {
    var out: FilePathList = undefined;
    raylib.mLoadDirectoryFiles(
        @ptrCast([*c]raylib.FilePathList, &out),
        @intToPtr([*c]const u8, @ptrToInt(dirPath)),
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
        @ptrCast([*c]raylib.FilePathList, &out),
        @intToPtr([*c]const u8, @ptrToInt(basePath)),
        @intToPtr([*c]const u8, @ptrToInt(filter)),
        scanSubdirs,
    );
    return out;
}

/// Unload filepaths
pub fn UnloadDirectoryFiles(
    files: FilePathList,
) void {
    raylib.mUnloadDirectoryFiles(
        @intToPtr([*c]raylib.FilePathList, @ptrToInt(&files)),
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
        @ptrCast([*c]raylib.FilePathList, &out),
    );
    return out;
}

/// Unload dropped filepaths
pub fn UnloadDroppedFiles(
    files: FilePathList,
) void {
    raylib.mUnloadDroppedFiles(
        @intToPtr([*c]raylib.FilePathList, @ptrToInt(&files)),
    );
}

/// Get file modification time (last write time)
pub fn GetFileModTime(
    fileName: [*:0]const u8,
) i64 {
    return raylib.mGetFileModTime(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Compress data (DEFLATE algorithm), memory must be MemFree()
pub fn CompressData(
    data: [*:0]const u8,
    dataSize: i32,
    compDataSize: ?[*]i32,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mCompressData(
        @ptrCast([*c]?[*]u8, &out),
        @intToPtr([*c]const u8, @ptrToInt(data)),
        dataSize,
        compDataSize,
    );
    return out;
}

/// Decompress data (DEFLATE algorithm), memory must be MemFree()
pub fn DecompressData(
    compData: [*:0]const u8,
    compDataSize: i32,
    dataSize: ?[*]i32,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mDecompressData(
        @ptrCast([*c]?[*]u8, &out),
        @intToPtr([*c]const u8, @ptrToInt(compData)),
        compDataSize,
        dataSize,
    );
    return out;
}

/// Encode data to Base64 string, memory must be MemFree()
pub fn EncodeDataBase64(
    data: [*:0]const u8,
    dataSize: i32,
    outputSize: ?[*]i32,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mEncodeDataBase64(
        @ptrCast([*c]?[*]u8, &out),
        @intToPtr([*c]const u8, @ptrToInt(data)),
        dataSize,
        outputSize,
    );
    return out;
}

/// Decode Base64 string data, memory must be MemFree()
pub fn DecodeDataBase64(
    data: [*:0]const u8,
    outputSize: ?[*]i32,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mDecodeDataBase64(
        @ptrCast([*c]?[*]u8, &out),
        @intToPtr([*c]const u8, @ptrToInt(data)),
        outputSize,
    );
    return out;
}

/// Check if a key has been pressed once
pub fn IsKeyPressed(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyPressed(
        @enumToInt(key),
    );
}

/// Check if a key is being pressed
pub fn IsKeyDown(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyDown(
        @enumToInt(key),
    );
}

/// Check if a key has been released once
pub fn IsKeyReleased(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyReleased(
        @enumToInt(key),
    );
}

/// Check if a key is NOT being pressed
pub fn IsKeyUp(
    key: KeyboardKey,
) bool {
    return raylib.mIsKeyUp(
        @enumToInt(key),
    );
}

/// Set a custom key to exit program (default is ESC)
pub fn SetExitKey(
    key: KeyboardKey,
) void {
    raylib.mSetExitKey(
        @enumToInt(key),
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
    return @ptrCast(
        [*:0]const u8,
        raylib.mGetGamepadName(
            gamepad,
        ),
    );
}

/// Check if a gamepad button has been pressed once
pub fn IsGamepadButtonPressed(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.mIsGamepadButtonPressed(
        gamepad,
        button,
    );
}

/// Check if a gamepad button is being pressed
pub fn IsGamepadButtonDown(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.mIsGamepadButtonDown(
        gamepad,
        button,
    );
}

/// Check if a gamepad button has been released once
pub fn IsGamepadButtonReleased(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.mIsGamepadButtonReleased(
        gamepad,
        button,
    );
}

/// Check if a gamepad button is NOT being pressed
pub fn IsGamepadButtonUp(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.mIsGamepadButtonUp(
        gamepad,
        button,
    );
}

/// Get the last gamepad button pressed
pub fn GetGamepadButtonPressed() i32 {
    return raylib.mGetGamepadButtonPressed();
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
    axis: i32,
) f32 {
    return raylib.mGetGamepadAxisMovement(
        gamepad,
        axis,
    );
}

/// Set internal gamepad mappings (SDL_GameControllerDB)
pub fn SetGamepadMappings(
    mappings: [*:0]const u8,
) i32 {
    return raylib.mSetGamepadMappings(
        @intToPtr([*c]const u8, @ptrToInt(mappings)),
    );
}

/// Check if a mouse button has been pressed once
pub fn IsMouseButtonPressed(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonPressed(
        @enumToInt(button),
    );
}

/// Check if a mouse button is being pressed
pub fn IsMouseButtonDown(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonDown(
        @enumToInt(button),
    );
}

/// Check if a mouse button has been released once
pub fn IsMouseButtonReleased(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonReleased(
        @enumToInt(button),
    );
}

/// Check if a mouse button is NOT being pressed
pub fn IsMouseButtonUp(
    button: MouseButton,
) bool {
    return raylib.mIsMouseButtonUp(
        @enumToInt(button),
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
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

/// Get mouse delta between frames
pub fn GetMouseDelta() Vector2 {
    var out: Vector2 = undefined;
    raylib.mGetMouseDelta(
        @ptrCast([*c]raylib.Vector2, &out),
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
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

/// Set mouse cursor
pub fn SetMouseCursor(
    cursor: MouseCursor,
) void {
    raylib.mSetMouseCursor(
        @enumToInt(cursor),
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
        @ptrCast([*c]raylib.Vector2, &out),
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
    gesture: i32,
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
        @ptrCast([*c]raylib.Vector2, &out),
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
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

/// Get gesture pinch angle
pub fn GetGesturePinchAngle() f32 {
    return raylib.mGetGesturePinchAngle();
}

/// Set camera mode (multiple camera modes available)
pub fn SetCameraMode(
    camera: Camera3D,
    mode: CameraMode,
) void {
    raylib.mSetCameraMode(
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        @enumToInt(mode),
    );
}

/// Set camera pan key to combine with mouse movement (free camera)
pub fn SetCameraPanControl(
    keyPan: i32,
) void {
    raylib.mSetCameraPanControl(
        keyPan,
    );
}

/// Set camera alt key to combine with mouse movement (free camera)
pub fn SetCameraAltControl(
    keyAlt: i32,
) void {
    raylib.mSetCameraAltControl(
        keyAlt,
    );
}

/// Set camera smooth zoom key to combine with mouse (free camera)
pub fn SetCameraSmoothZoomControl(
    keySmoothZoom: i32,
) void {
    raylib.mSetCameraSmoothZoomControl(
        keySmoothZoom,
    );
}

/// Set camera move controls (1st person and 3rd person cameras)
pub fn SetCameraMoveControls(
    keyFront: i32,
    keyBack: i32,
    keyRight: i32,
    keyLeft: i32,
    keyUp: i32,
    keyDown: i32,
) void {
    raylib.mSetCameraMoveControls(
        keyFront,
        keyBack,
        keyRight,
        keyLeft,
        keyUp,
        keyDown,
    );
}

/// Set texture and rectangle to be used on shapes drawing
pub fn SetShapesTexture(
    texture: Texture2D,
    source: Rectangle,
) void {
    raylib.mSetShapesTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
    );
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a pixel (Vector version)
pub fn DrawPixelV(
    position: Vector2,
    color: Color,
) void {
    raylib.mDrawPixelV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a line (Vector version)
pub fn DrawLineV(
    startPos: Vector2,
    endPos: Vector2,
    color: Color,
) void {
    raylib.mDrawLineV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a line defining thickness
pub fn DrawLineEx(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawLineEx(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a line using cubic-bezier curves in-out
pub fn DrawLineBezier(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawLineBezier(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw line using quadratic bezier curves with a control point
pub fn DrawLineBezierQuad(
    startPos: Vector2,
    endPos: Vector2,
    controlPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawLineBezierQuad(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&controlPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw line using cubic bezier curves with 2 control points
pub fn DrawLineBezierCubic(
    startPos: Vector2,
    endPos: Vector2,
    startControlPos: Vector2,
    endControlPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.mDrawLineBezierCubic(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startControlPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endControlPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw lines sequence
pub fn DrawLineStrip(
    points: ?[*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawLineStrip(
        points,
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color2)),
    );
}

/// Draw a color-filled circle (Vector version)
pub fn DrawCircleV(
    center: Vector2,
    radius: f32,
    color: Color,
) void {
    raylib.mDrawCircleV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a color-filled rectangle (Vector version)
pub fn DrawRectangleV(
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    raylib.mDrawRectangleV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a color-filled rectangle
pub fn DrawRectangleRec(
    rec: Rectangle,
    color: Color,
) void {
    raylib.mDrawRectangleRec(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color2)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color2)),
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
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col2)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col4)),
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
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw rectangle outline with extended parameters
pub fn DrawRectangleLinesEx(
    rec: Rectangle,
    lineThick: f32,
    color: Color,
) void {
    raylib.mDrawRectangleLinesEx(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        lineThick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        roundness,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        roundness,
        segments,
        lineThick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a triangle fan defined by points (first vertex is the center)
pub fn DrawTriangleFan(
    points: ?[*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawTriangleFan(
        points,
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip(
    points: ?[*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawTriangleStrip(
        points,
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        sides,
        radius,
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        sides,
        radius,
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        sides,
        radius,
        rotation,
        lineThick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Check collision between two rectangles
pub fn CheckCollisionRecs(
    rec1: Rectangle,
    rec2: Rectangle,
) bool {
    return raylib.mCheckCollisionRecs(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec1)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec2)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center1)),
        radius1,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center2)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
    );
}

/// Check if point is inside rectangle
pub fn CheckCollisionPointRec(
    point: Vector2,
    rec: Rectangle,
) bool {
    return raylib.mCheckCollisionPointRec(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
    );
}

/// Check if point is inside circle
pub fn CheckCollisionPointCircle(
    point: Vector2,
    center: Vector2,
    radius: f32,
) bool {
    return raylib.mCheckCollisionPointCircle(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p3)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos2)),
        collisionPoint,
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p2)),
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
        @ptrCast([*c]raylib.Rectangle, &out),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec1)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec2)),
    );
    return out;
}

/// Load image from file into CPU memory (RAM)
pub fn LoadImage(
    fileName: [*:0]const u8,
) Image {
    var out: Image = undefined;
    raylib.mLoadImage(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
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
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        width,
        height,
        format,
        headerSize,
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
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        frames,
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
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(fileData)),
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
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
    return out;
}

/// Load image from screen buffer and (screenshot)
pub fn LoadImageFromScreen() Image {
    var out: Image = undefined;
    raylib.mLoadImageFromScreen(
        @ptrCast([*c]raylib.Image, &out),
    );
    return out;
}

/// Unload image from CPU memory (RAM)
pub fn UnloadImage(
    image: Image,
) void {
    raylib.mUnloadImage(
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
    );
}

/// Export image data to file, returns true on success
pub fn ExportImage(
    image: Image,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportImage(
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Export image as code file defining an array of bytes, returns true on success
pub fn ExportImageAsCode(
    image: Image,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportImageAsCode(
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
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
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
    return out;
}

/// Generate image: vertical gradient
pub fn GenImageGradientV(
    width: i32,
    height: i32,
    top: Color,
    bottom: Color,
) Image {
    var out: Image = undefined;
    raylib.mGenImageGradientV(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&top)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&bottom)),
    );
    return out;
}

/// Generate image: horizontal gradient
pub fn GenImageGradientH(
    width: i32,
    height: i32,
    left: Color,
    right: Color,
) Image {
    var out: Image = undefined;
    raylib.mGenImageGradientH(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&right)),
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
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        density,
        @intToPtr([*c]raylib.Color, @ptrToInt(&inner)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&outer)),
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
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        checksX,
        checksY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&col1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col2)),
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
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        factor,
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
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        tileSize,
    );
    return out;
}

/// Create an image duplicate (useful for transformations)
pub fn ImageCopy(
    image: Image,
) Image {
    var out: Image = undefined;
    raylib.mImageCopy(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
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
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
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
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
    return out;
}

/// Convert image data to desired format
pub fn ImageFormat(
    image: ?[*]Image,
    newFormat: i32,
) void {
    raylib.mImageFormat(
        image,
        newFormat,
    );
}

/// Convert image to POT (power-of-two)
pub fn ImageToPOT(
    image: ?[*]Image,
    fill: Color,
) void {
    raylib.mImageToPOT(
        image,
        @intToPtr([*c]raylib.Color, @ptrToInt(&fill)),
    );
}

/// Crop an image to a defined rectangle
pub fn ImageCrop(
    image: ?[*]Image,
    crop: Rectangle,
) void {
    raylib.mImageCrop(
        image,
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&crop)),
    );
}

/// Crop image depending on alpha value
pub fn ImageAlphaCrop(
    image: ?[*]Image,
    threshold: f32,
) void {
    raylib.mImageAlphaCrop(
        image,
        threshold,
    );
}

/// Clear alpha channel to desired color
pub fn ImageAlphaClear(
    image: ?[*]Image,
    color: Color,
    threshold: f32,
) void {
    raylib.mImageAlphaClear(
        image,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        threshold,
    );
}

/// Apply alpha mask to image
pub fn ImageAlphaMask(
    image: ?[*]Image,
    alphaMask: Image,
) void {
    raylib.mImageAlphaMask(
        image,
        @intToPtr([*c]raylib.Image, @ptrToInt(&alphaMask)),
    );
}

/// Premultiply alpha channel
pub fn ImageAlphaPremultiply(
    image: ?[*]Image,
) void {
    raylib.mImageAlphaPremultiply(
        image,
    );
}

/// Resize image (Bicubic scaling algorithm)
pub fn ImageResize(
    image: ?[*]Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.mImageResize(
        image,
        newWidth,
        newHeight,
    );
}

/// Resize image (Nearest-Neighbor scaling algorithm)
pub fn ImageResizeNN(
    image: ?[*]Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.mImageResizeNN(
        image,
        newWidth,
        newHeight,
    );
}

/// Resize canvas and fill with color
pub fn ImageResizeCanvas(
    image: ?[*]Image,
    newWidth: i32,
    newHeight: i32,
    offsetX: i32,
    offsetY: i32,
    fill: Color,
) void {
    raylib.mImageResizeCanvas(
        image,
        newWidth,
        newHeight,
        offsetX,
        offsetY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&fill)),
    );
}

/// Compute all mipmap levels for a provided image
pub fn ImageMipmaps(
    image: ?[*]Image,
) void {
    raylib.mImageMipmaps(
        image,
    );
}

/// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub fn ImageDither(
    image: ?[*]Image,
    rBpp: i32,
    gBpp: i32,
    bBpp: i32,
    aBpp: i32,
) void {
    raylib.mImageDither(
        image,
        rBpp,
        gBpp,
        bBpp,
        aBpp,
    );
}

/// Flip image vertically
pub fn ImageFlipVertical(
    image: ?[*]Image,
) void {
    raylib.mImageFlipVertical(
        image,
    );
}

/// Flip image horizontally
pub fn ImageFlipHorizontal(
    image: ?[*]Image,
) void {
    raylib.mImageFlipHorizontal(
        image,
    );
}

/// Rotate image clockwise 90deg
pub fn ImageRotateCW(
    image: ?[*]Image,
) void {
    raylib.mImageRotateCW(
        image,
    );
}

/// Rotate image counter-clockwise 90deg
pub fn ImageRotateCCW(
    image: ?[*]Image,
) void {
    raylib.mImageRotateCCW(
        image,
    );
}

/// Modify image color: tint
pub fn ImageColorTint(
    image: ?[*]Image,
    color: Color,
) void {
    raylib.mImageColorTint(
        image,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Modify image color: invert
pub fn ImageColorInvert(
    image: ?[*]Image,
) void {
    raylib.mImageColorInvert(
        image,
    );
}

/// Modify image color: grayscale
pub fn ImageColorGrayscale(
    image: ?[*]Image,
) void {
    raylib.mImageColorGrayscale(
        image,
    );
}

/// Modify image color: contrast (-100 to 100)
pub fn ImageColorContrast(
    image: ?[*]Image,
    contrast: f32,
) void {
    raylib.mImageColorContrast(
        image,
        contrast,
    );
}

/// Modify image color: brightness (-255 to 255)
pub fn ImageColorBrightness(
    image: ?[*]Image,
    brightness: i32,
) void {
    raylib.mImageColorBrightness(
        image,
        brightness,
    );
}

/// Modify image color: replace color
pub fn ImageColorReplace(
    image: ?[*]Image,
    color: Color,
    replace: Color,
) void {
    raylib.mImageColorReplace(
        image,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&replace)),
    );
}

/// Load color data from image as a Color array (RGBA - 32bit)
pub fn LoadImageColors(
    image: Image,
) ?[*]Color {
    var out: ?[*]Color = undefined;
    raylib.mLoadImageColors(
        @ptrCast([*c]?[*]Color, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
    );
    return out;
}

/// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn LoadImagePalette(
    image: Image,
    maxPaletteSize: i32,
    colorCount: ?[*]i32,
) ?[*]Color {
    var out: ?[*]Color = undefined;
    raylib.mLoadImagePalette(
        @ptrCast([*c]?[*]Color, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        maxPaletteSize,
        colorCount,
    );
    return out;
}

/// Unload color data loaded with LoadImageColors()
pub fn UnloadImageColors(
    colors: ?[*]Color,
) void {
    raylib.mUnloadImageColors(
        colors,
    );
}

/// Unload colors palette loaded with LoadImagePalette()
pub fn UnloadImagePalette(
    colors: ?[*]Color,
) void {
    raylib.mUnloadImagePalette(
        colors,
    );
}

/// Get image alpha border rectangle
pub fn GetImageAlphaBorder(
    image: Image,
    threshold: f32,
) Rectangle {
    var out: Rectangle = undefined;
    raylib.mGetImageAlphaBorder(
        @ptrCast([*c]raylib.Rectangle, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
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
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        x,
        y,
    );
    return out;
}

/// Clear image background with given color
pub fn ImageClearBackground(
    dst: ?[*]Image,
    color: Color,
) void {
    raylib.mImageClearBackground(
        dst,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw pixel within an image
pub fn ImageDrawPixel(
    dst: ?[*]Image,
    posX: i32,
    posY: i32,
    color: Color,
) void {
    raylib.mImageDrawPixel(
        dst,
        posX,
        posY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw pixel within an image (Vector version)
pub fn ImageDrawPixelV(
    dst: ?[*]Image,
    position: Vector2,
    color: Color,
) void {
    raylib.mImageDrawPixelV(
        dst,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw line within an image
pub fn ImageDrawLine(
    dst: ?[*]Image,
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: Color,
) void {
    raylib.mImageDrawLine(
        dst,
        startPosX,
        startPosY,
        endPosX,
        endPosY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw line within an image (Vector version)
pub fn ImageDrawLineV(
    dst: ?[*]Image,
    start: Vector2,
    end: Vector2,
    color: Color,
) void {
    raylib.mImageDrawLineV(
        dst,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&start)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&end)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw circle within an image
pub fn ImageDrawCircle(
    dst: ?[*]Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: Color,
) void {
    raylib.mImageDrawCircle(
        dst,
        centerX,
        centerY,
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw circle within an image (Vector version)
pub fn ImageDrawCircleV(
    dst: ?[*]Image,
    center: Vector2,
    radius: i32,
    color: Color,
) void {
    raylib.mImageDrawCircleV(
        dst,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangle(
    dst: ?[*]Image,
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {
    raylib.mImageDrawRectangle(
        dst,
        posX,
        posY,
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw rectangle within an image (Vector version)
pub fn ImageDrawRectangleV(
    dst: ?[*]Image,
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    raylib.mImageDrawRectangleV(
        dst,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangleRec(
    dst: ?[*]Image,
    rec: Rectangle,
    color: Color,
) void {
    raylib.mImageDrawRectangleRec(
        dst,
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw rectangle lines within an image
pub fn ImageDrawRectangleLines(
    dst: ?[*]Image,
    rec: Rectangle,
    thick: i32,
    color: Color,
) void {
    raylib.mImageDrawRectangleLines(
        dst,
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a source image within a destination image (tint applied to source)
pub fn ImageDraw(
    dst: ?[*]Image,
    src: Image,
    srcRec: Rectangle,
    dstRec: Rectangle,
    tint: Color,
) void {
    raylib.mImageDraw(
        dst,
        @intToPtr([*c]raylib.Image, @ptrToInt(&src)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&srcRec)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dstRec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Draw text (using default font) within an image (destination)
pub fn ImageDrawText(
    dst: ?[*]Image,
    text: [*:0]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {
    raylib.mImageDrawText(
        dst,
        @intToPtr([*c]const u8, @ptrToInt(text)),
        posX,
        posY,
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw text (custom sprite font) within an image (destination)
pub fn ImageDrawTextEx(
    dst: ?[*]Image,
    font: Font,
    text: [*:0]const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.mImageDrawTextEx(
        dst,
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Load texture from file into GPU memory (VRAM)
pub fn LoadTexture(
    fileName: [*:0]const u8,
) Texture2D {
    var out: Texture2D = undefined;
    raylib.mLoadTexture(
        @ptrCast([*c]raylib.Texture2D, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

/// Load texture from image data
pub fn LoadTextureFromImage(
    image: Image,
) Texture2D {
    var out: Texture2D = undefined;
    raylib.mLoadTextureFromImage(
        @ptrCast([*c]raylib.Texture2D, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
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
        @ptrCast([*c]raylib.Texture2D, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
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
        @ptrCast([*c]raylib.RenderTexture2D, &out),
        width,
        height,
    );
    return out;
}

/// Unload texture from GPU memory (VRAM)
pub fn UnloadTexture(
    texture: Texture2D,
) void {
    raylib.mUnloadTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
}

/// Unload render texture from GPU memory (VRAM)
pub fn UnloadRenderTexture(
    target: RenderTexture2D,
) void {
    raylib.mUnloadRenderTexture(
        @intToPtr([*c]raylib.RenderTexture2D, @ptrToInt(&target)),
    );
}

/// Update GPU texture with new data
pub fn UpdateTexture(
    texture: Texture2D,
    pixels: *anyopaque,
) void {
    raylib.mUpdateTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @ptrCast([*c]anyopaque, pixels),
    );
}

/// Update GPU texture rectangle with new data
pub fn UpdateTextureRec(
    texture: Texture2D,
    rec: Rectangle,
    pixels: *anyopaque,
) void {
    raylib.mUpdateTextureRec(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @ptrCast([*c]anyopaque, pixels),
    );
}

/// Generate GPU mipmaps for a texture
pub fn GenTextureMipmaps(
    texture: *Texture2D,
) void {
    raylib.mGenTextureMipmaps(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(texture)),
    );
}

/// Set texture scaling filter mode
pub fn SetTextureFilter(
    texture: Texture2D,
    filter: i32,
) void {
    raylib.mSetTextureFilter(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        filter,
    );
}

/// Set texture wrapping mode
pub fn SetTextureWrap(
    texture: Texture2D,
    wrap: i32,
) void {
    raylib.mSetTextureWrap(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
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
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        posX,
        posY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Draw a Texture2D with position defined as Vector2
pub fn DrawTextureV(
    texture: Texture2D,
    position: Vector2,
    tint: Color,
) void {
    raylib.mDrawTextureV(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        rotation,
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Draw texture quad with tiling and offset parameters
pub fn DrawTextureQuad(
    texture: Texture2D,
    tiling: Vector2,
    offset: Vector2,
    quad: Rectangle,
    tint: Color,
) void {
    raylib.mDrawTextureQuad(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&tiling)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&offset)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&quad)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
pub fn DrawTextureTiled(
    texture: Texture2D,
    source: Rectangle,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    scale: f32,
    tint: Color,
) void {
    raylib.mDrawTextureTiled(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dest)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dest)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.NPatchInfo, @ptrToInt(&nPatchInfo)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dest)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Draw a textured polygon
pub fn DrawTexturePoly(
    texture: Texture2D,
    center: Vector2,
    points: ?[*]Vector2,
    texcoords: ?[*]Vector2,
    pointCount: i32,
    tint: Color,
) void {
    raylib.mDrawTexturePoly(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        points,
        texcoords,
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn Fade(
    color: Color,
    alpha: f32,
) Color {
    var out: Color = undefined;
    raylib.mFade(
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        alpha,
    );
    return out;
}

/// Get hexadecimal value for a Color
pub fn ColorToInt(
    color: Color,
) i32 {
    return raylib.mColorToInt(
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Get Color normalized as float [0..1]
pub fn ColorNormalize(
    color: Color,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mColorNormalize(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
    return out;
}

/// Get Color from normalized values [0..1]
pub fn ColorFromNormalized(
    normalized: Vector4,
) Color {
    var out: Color = undefined;
    raylib.mColorFromNormalized(
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&normalized)),
    );
    return out;
}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn ColorToHSV(
    color: Color,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mColorToHSV(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @ptrCast([*c]raylib.Color, &out),
        hue,
        saturation,
        value,
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
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&dst)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&src)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
    return out;
}

/// Get Color structure from hexadecimal value
pub fn GetColor(
    hexValue: u32,
) Color {
    var out: Color = undefined;
    raylib.mGetColor(
        @ptrCast([*c]raylib.Color, &out),
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
        @ptrCast([*c]raylib.Color, &out),
        @ptrCast([*c]anyopaque, srcPtr),
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
        @ptrCast([*c]anyopaque, dstPtr),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @ptrCast([*c]raylib.Font, &out),
    );
    return out;
}

/// Load font from file into GPU memory (VRAM)
pub fn LoadFont(
    fileName: [*:0]const u8,
) Font {
    var out: Font = undefined;
    raylib.mLoadFont(
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

/// Load font from file with extended parameters, use NULL for fontChars and 0 for glyphCount to load the default character set
pub fn LoadFontEx(
    fileName: [*:0]const u8,
    fontSize: i32,
    fontChars: ?[*]i32,
    glyphCount: i32,
) Font {
    var out: Font = undefined;
    raylib.mLoadFontEx(
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        fontSize,
        fontChars,
        glyphCount,
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
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&key)),
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
    fontChars: ?[*]i32,
    glyphCount: i32,
) Font {
    var out: Font = undefined;
    raylib.mLoadFontFromMemory(
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(fileData)),
        dataSize,
        fontSize,
        fontChars,
        glyphCount,
    );
    return out;
}

///
pub fn Vector3Length(
    v: Vector3,
) f32 {
    return raylib.mVector3Length(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
}

/// Unload font chars info data (RAM)
pub fn UnloadFontData(
    chars: ?[*]GlyphInfo,
    glyphCount: i32,
) void {
    raylib.mUnloadFontData(
        chars,
        glyphCount,
    );
}

/// Unload font from GPU memory (VRAM)
pub fn UnloadFont(
    font: Font,
) void {
    raylib.mUnloadFont(
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
    );
}

/// Export font as code file, returns true on success
pub fn ExportFontAsCode(
    font: Font,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportFontAsCode(
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
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
        @intToPtr([*c]const u8, @ptrToInt(text)),
        posX,
        posY,
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        codepoint,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Draw multiple character (codepoint)
pub fn DrawTextCodepoints(
    font: Font,
    codepoints: ?[*]const i32,
    count: i32,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.mDrawTextCodepoints(
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        codepoints,
        count,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Measure string width for default font
pub fn MeasureText(
    text: [*:0]const u8,
    fontSize: i32,
) i32 {
    return raylib.mMeasureText(
        @intToPtr([*c]const u8, @ptrToInt(text)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
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
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
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
        @ptrCast([*c]raylib.GlyphInfo, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
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
        @ptrCast([*c]raylib.Rectangle, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        codepoint,
    );
    return out;
}

/// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
pub fn LoadCodepoints(
    text: [*:0]const u8,
    count: ?[*]i32,
) ?[*]i32 {
    var out: ?[*]i32 = undefined;
    raylib.mLoadCodepoints(
        @ptrCast([*c]?[*]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        count,
    );
    return out;
}

/// Unload codepoints data from memory
pub fn UnloadCodepoints(
    codepoints: ?[*]i32,
) void {
    raylib.mUnloadCodepoints(
        codepoints,
    );
}

/// Get total number of codepoints in a UTF-8 encoded string
pub fn GetCodepointCount(
    text: [*:0]const u8,
) i32 {
    return raylib.mGetCodepointCount(
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
}

/// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn GetCodepoint(
    text: [*:0]const u8,
    bytesProcessed: ?[*]i32,
) i32 {
    return raylib.mGetCodepoint(
        @intToPtr([*c]const u8, @ptrToInt(text)),
        bytesProcessed,
    );
}

/// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
pub fn CodepointToUTF8(
    codepoint: i32,
    byteSize: ?[*]i32,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mCodepointToUTF8(
            codepoint,
            byteSize,
        ),
    );
}

/// Encode text as codepoints array into UTF-8 text string (WARNING: memory must be freed!)
pub fn TextCodepointsToUTF8(
    codepoints: ?[*]const i32,
    length: i32,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mTextCodepointsToUTF8(
        @ptrCast([*c]?[*]u8, &out),
        codepoints,
        length,
    );
    return out;
}

/// Copy one string to another, returns bytes copied
pub fn TextCopy(
    dst: ?[*]u8,
    src: [*:0]const u8,
) i32 {
    return raylib.mTextCopy(
        dst,
        @intToPtr([*c]const u8, @ptrToInt(src)),
    );
}

/// Check if two text string are equal
pub fn TextIsEqual(
    text1: [*:0]const u8,
    text2: [*:0]const u8,
) bool {
    return raylib.mTextIsEqual(
        @intToPtr([*c]const u8, @ptrToInt(text1)),
        @intToPtr([*c]const u8, @ptrToInt(text2)),
    );
}

/// Get text length, checks for '\0' ending
pub fn TextLength(
    text: [*:0]const u8,
) u32 {
    return raylib.mTextLength(
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
}

///
pub fn Vector3LengthSqr(
    v: Vector3,
) f32 {
    return raylib.mVector3LengthSqr(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
}

/// Get a piece of a text string
pub fn TextSubtext(
    text: [*:0]const u8,
    position: i32,
    length: i32,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mTextSubtext(
            @intToPtr([*c]const u8, @ptrToInt(text)),
            position,
            length,
        ),
    );
}

/// Replace text string (WARNING: memory must be freed!)
pub fn TextReplace(
    text: ?[*]u8,
    replace: [*:0]const u8,
    by: [*:0]const u8,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mTextReplace(
        @ptrCast([*c]?[*]u8, &out),
        text,
        @intToPtr([*c]const u8, @ptrToInt(replace)),
        @intToPtr([*c]const u8, @ptrToInt(by)),
    );
    return out;
}

/// Insert text in a position (WARNING: memory must be freed!)
pub fn TextInsert(
    text: [*:0]const u8,
    insert: [*:0]const u8,
    position: i32,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mTextInsert(
        @ptrCast([*c]?[*]u8, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]const u8, @ptrToInt(insert)),
        position,
    );
    return out;
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
    return @ptrCast(
        [*]GlyphInfo,
        raylib.mLoadFontData(
            @intToPtr([*c]const u8, @ptrToInt(fileData)),
            dataSize,
            fontSize,
            @ptrCast([*c]i32, fontChars),
            glyphCount,
            typ,
        ),
    );
}

/// Update camera position for selected mode
pub fn UpdateCamera(
    camera: *Camera3D,
) void {
    raylib.mUpdateCamera(
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(camera)),
    );
}

/// Find first text occurrence within a string
pub fn TextFindIndex(
    text: [*:0]const u8,
    find: [*:0]const u8,
) i32 {
    return raylib.mTextFindIndex(
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]const u8, @ptrToInt(find)),
    );
}

/// Get upper case version of provided string
pub fn TextToUpper(
    text: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mTextToUpper(
            @intToPtr([*c]const u8, @ptrToInt(text)),
        ),
    );
}

/// Get lower case version of provided string
pub fn TextToLower(
    text: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mTextToLower(
            @intToPtr([*c]const u8, @ptrToInt(text)),
        ),
    );
}

/// Get Pascal case notation version of provided string
pub fn TextToPascal(
    text: [*:0]const u8,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mTextToPascal(
            @intToPtr([*c]const u8, @ptrToInt(text)),
        ),
    );
}

/// Get integer value from text (negative values not supported)
pub fn TextToInteger(
    text: [*:0]const u8,
) i32 {
    return raylib.mTextToInteger(
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
}

/// Draw a line in 3D world space
pub fn DrawLine3D(
    startPos: Vector3,
    endPos: Vector3,
    color: Color,
) void {
    raylib.mDrawLine3D(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a point in 3D space, actually a small line
pub fn DrawPoint3D(
    position: Vector3,
    color: Color,
) void {
    raylib.mDrawPoint3D(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&rotationAxis)),
        rotationAngle,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip3D(
    points: ?[*]Vector3,
    pointCount: i32,
    color: Color,
) void {
    raylib.mDrawTriangleStrip3D(
        points,
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw cube (Vector version)
pub fn DrawCubeV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.mDrawCubeV(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw cube wires (Vector version)
pub fn DrawCubeWiresV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.mDrawCubeWiresV(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw cube textured
pub fn DrawCubeTexture(
    texture: Texture2D,
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {
    raylib.mDrawCubeTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw cube with a region of a texture
pub fn DrawCubeTextureRec(
    texture: Texture2D,
    source: Rectangle,
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {
    raylib.mDrawCubeTextureRec(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw sphere
pub fn DrawSphere(
    centerPos: Vector3,
    radius: f32,
    color: Color,
) void {
    raylib.mDrawSphere(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        radius,
        rings,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        radius,
        rings,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        radiusTop,
        radiusBottom,
        height,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&endPos)),
        startRadius,
        endRadius,
        sides,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        radiusTop,
        radiusBottom,
        height,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&endPos)),
        startRadius,
        endRadius,
        sides,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a plane XZ
pub fn DrawPlane(
    centerPos: Vector3,
    size: Vector2,
    color: Color,
) void {
    raylib.mDrawPlane(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

/// Draw a ray line
pub fn DrawRay(
    ray: Ray,
    color: Color,
) void {
    raylib.mDrawRay(
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @ptrCast([*c]raylib.Model, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

/// Load model from generated mesh (default material)
pub fn LoadModelFromMesh(
    mesh: Mesh,
) Model {
    var out: Model = undefined;
    raylib.mLoadModelFromMesh(
        @ptrCast([*c]raylib.Model, &out),
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
    );
    return out;
}

/// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn UnloadModel(
    model: Model,
) void {
    raylib.mUnloadModel(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
    );
}

/// Unload model (but not meshes) from memory (RAM and/or VRAM)
pub fn UnloadModelKeepMeshes(
    model: Model,
) void {
    raylib.mUnloadModelKeepMeshes(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
    );
}

/// Compute model bounding box limits (considers all meshes)
pub fn GetModelBoundingBox(
    model: Model,
) BoundingBox {
    var out: BoundingBox = undefined;
    raylib.mGetModelBoundingBox(
        @ptrCast([*c]raylib.BoundingBox, &out),
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
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
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&rotationAxis)),
        rotationAngle,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&scale)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&rotationAxis)),
        rotationAngle,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&scale)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Draw bounding box (wires)
pub fn DrawBoundingBox(
    box: BoundingBox,
    color: Color,
) void {
    raylib.mDrawBoundingBox(
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
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
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        size,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
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
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&up)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
pub fn UploadMesh(
    mesh: ?[*]Mesh,
    dynamic: bool,
) void {
    raylib.mUploadMesh(
        mesh,
        dynamic,
    );
}

/// Update mesh vertex data in GPU for a specific buffer index
pub fn UpdateMeshBuffer(
    mesh: Mesh,
    index: i32,
    data: *anyopaque,
    dataSize: i32,
    offset: i32,
) void {
    raylib.mUpdateMeshBuffer(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        index,
        @ptrCast([*c]anyopaque, data),
        dataSize,
        offset,
    );
}

/// Unload mesh data from CPU and GPU
pub fn UnloadMesh(
    mesh: Mesh,
) void {
    raylib.mUnloadMesh(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
    );
}

/// Draw a 3d mesh with material and transform
pub fn DrawMesh(
    mesh: Mesh,
    material: Material,
    transform: Matrix,
) void {
    raylib.mDrawMesh(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]raylib.Material, @ptrToInt(&material)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&transform)),
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
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]raylib.Material, @ptrToInt(&material)),
        transforms,
        instances,
    );
}

/// Export mesh data to file, returns true on success
pub fn ExportMesh(
    mesh: Mesh,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportMesh(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Compute mesh bounding box limits
pub fn GetMeshBoundingBox(
    mesh: Mesh,
) BoundingBox {
    var out: BoundingBox = undefined;
    raylib.mGetMeshBoundingBox(
        @ptrCast([*c]raylib.BoundingBox, &out),
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
    );
    return out;
}

/// Compute mesh tangents
pub fn GenMeshTangents(
    mesh: ?[*]Mesh,
) void {
    raylib.mGenMeshTangents(
        mesh,
    );
}

/// Generate polygonal mesh
pub fn GenMeshPoly(
    sides: i32,
    radius: f32,
) Mesh {
    var out: Mesh = undefined;
    raylib.mGenMeshPoly(
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
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
        @ptrCast([*c]raylib.Mesh, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&heightmap)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&size)),
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
        @ptrCast([*c]raylib.Mesh, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&cubicmap)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&cubeSize)),
    );
    return out;
}

/// Load materials from model file
pub fn LoadMaterials(
    fileName: [*:0]const u8,
    materialCount: ?[*]i32,
) ?[*]Material {
    var out: ?[*]Material = undefined;
    raylib.mLoadMaterials(
        @ptrCast([*c]?[*]Material, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        materialCount,
    );
    return out;
}

/// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub fn LoadMaterialDefault() Material {
    var out: Material = undefined;
    raylib.mLoadMaterialDefault(
        @ptrCast([*c]raylib.Material, &out),
    );
    return out;
}

/// Unload material from GPU memory (VRAM)
pub fn UnloadMaterial(
    material: Material,
) void {
    raylib.mUnloadMaterial(
        @intToPtr([*c]raylib.Material, @ptrToInt(&material)),
    );
}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn SetMaterialTexture(
    material: ?[*]Material,
    mapType: i32,
    texture: Texture2D,
) void {
    raylib.mSetMaterialTexture(
        material,
        mapType,
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
}

/// Set material for a mesh
pub fn SetModelMeshMaterial(
    model: ?[*]Model,
    meshId: i32,
    materialId: i32,
) void {
    raylib.mSetModelMeshMaterial(
        model,
        meshId,
        materialId,
    );
}

/// Load model animations from file
pub fn LoadModelAnimations(
    fileName: [*:0]const u8,
    animCount: ?[*]u32,
) ?[*]ModelAnimation {
    var out: ?[*]ModelAnimation = undefined;
    raylib.mLoadModelAnimations(
        @ptrCast([*c]?[*]ModelAnimation, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        animCount,
    );
    return out;
}

/// Update model animation pose
pub fn UpdateModelAnimation(
    model: Model,
    anim: ModelAnimation,
    frame: i32,
) void {
    raylib.mUpdateModelAnimation(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.ModelAnimation, @ptrToInt(&anim)),
        frame,
    );
}

/// Unload animation data
pub fn UnloadModelAnimation(
    anim: ModelAnimation,
) void {
    raylib.mUnloadModelAnimation(
        @intToPtr([*c]raylib.ModelAnimation, @ptrToInt(&anim)),
    );
}

/// Unload animation array data
pub fn UnloadModelAnimations(
    animations: ?[*]ModelAnimation,
    count: u32,
) void {
    raylib.mUnloadModelAnimations(
        animations,
        count,
    );
}

/// Check model animation skeleton match
pub fn IsModelAnimationValid(
    model: Model,
    anim: ModelAnimation,
) bool {
    return raylib.mIsModelAnimationValid(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.ModelAnimation, @ptrToInt(&anim)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center1)),
        radius1,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center2)),
        radius2,
    );
}

/// Check collision between two bounding boxes
pub fn CheckCollisionBoxes(
    box1: BoundingBox,
    box2: BoundingBox,
) bool {
    return raylib.mCheckCollisionBoxes(
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box1)),
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box2)),
    );
}

/// Check collision between box and sphere
pub fn CheckCollisionBoxSphere(
    box: BoundingBox,
    center: Vector3,
    radius: f32,
) bool {
    return raylib.mCheckCollisionBoxSphere(
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center)),
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
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center)),
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
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box)),
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
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&transform)),
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
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p2)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p3)),
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
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p2)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p3)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p4)),
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

/// Load wave data from file
pub fn LoadWave(
    fileName: [*:0]const u8,
) Wave {
    var out: Wave = undefined;
    raylib.mLoadWave(
        @ptrCast([*c]raylib.Wave, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
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
        @ptrCast([*c]raylib.Wave, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(fileData)),
        dataSize,
    );
    return out;
}

/// Load sound from file
pub fn LoadSound(
    fileName: [*:0]const u8,
) Sound {
    var out: Sound = undefined;
    raylib.mLoadSound(
        @ptrCast([*c]raylib.Sound, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

/// Load sound from wave data
pub fn LoadSoundFromWave(
    wave: Wave,
) Sound {
    var out: Sound = undefined;
    raylib.mLoadSoundFromWave(
        @ptrCast([*c]raylib.Sound, &out),
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
    );
    return out;
}

/// Update sound buffer with new data
pub fn UpdateSound(
    sound: Sound,
    data: *anyopaque,
    sampleCount: i32,
) void {
    raylib.mUpdateSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        @ptrCast([*c]anyopaque, data),
        sampleCount,
    );
}

/// Unload wave data
pub fn UnloadWave(
    wave: Wave,
) void {
    raylib.mUnloadWave(
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
    );
}

/// Unload sound
pub fn UnloadSound(
    sound: Sound,
) void {
    raylib.mUnloadSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

/// Export wave data to file, returns true on success
pub fn ExportWave(
    wave: Wave,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportWave(
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Export wave sample data to code (.h), returns true on success
pub fn ExportWaveAsCode(
    wave: Wave,
    fileName: [*:0]const u8,
) bool {
    return raylib.mExportWaveAsCode(
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

/// Play a sound
pub fn PlaySound(
    sound: Sound,
) void {
    raylib.mPlaySound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

/// Stop playing a sound
pub fn StopSound(
    sound: Sound,
) void {
    raylib.mStopSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

/// Pause a sound
pub fn PauseSound(
    sound: Sound,
) void {
    raylib.mPauseSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

/// Resume a paused sound
pub fn ResumeSound(
    sound: Sound,
) void {
    raylib.mResumeSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

/// Play a sound (using multichannel buffer pool)
pub fn PlaySoundMulti(
    sound: Sound,
) void {
    raylib.mPlaySoundMulti(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

/// Stop any sound playing (using multichannel buffer pool)
pub fn StopSoundMulti() void {
    raylib.mStopSoundMulti();
}

/// Get number of sounds playing in the multichannel
pub fn GetSoundsPlaying() i32 {
    return raylib.mGetSoundsPlaying();
}

/// Check if a sound is currently playing
pub fn IsSoundPlaying(
    sound: Sound,
) bool {
    return raylib.mIsSoundPlaying(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

/// Set volume for a sound (1.0 is max level)
pub fn SetSoundVolume(
    sound: Sound,
    volume: f32,
) void {
    raylib.mSetSoundVolume(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        volume,
    );
}

/// Set pitch for a sound (1.0 is base level)
pub fn SetSoundPitch(
    sound: Sound,
    pitch: f32,
) void {
    raylib.mSetSoundPitch(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        pitch,
    );
}

/// Set pan for a sound (0.5 is center)
pub fn SetSoundPan(
    sound: Sound,
    pan: f32,
) void {
    raylib.mSetSoundPan(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        pan,
    );
}

/// Copy a wave to a new wave
pub fn WaveCopy(
    wave: Wave,
) Wave {
    var out: Wave = undefined;
    raylib.mWaveCopy(
        @ptrCast([*c]raylib.Wave, &out),
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
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
        wave,
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
        wave,
        sampleRate,
        sampleSize,
        channels,
    );
}

/// Load samples data from wave as a 32bit float data array
pub fn LoadWaveSamples(
    wave: Wave,
) ?[*]f32 {
    var out: ?[*]f32 = undefined;
    raylib.mLoadWaveSamples(
        @ptrCast([*c]?[*]f32, &out),
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
    );
    return out;
}

/// Unload samples data loaded with LoadWaveSamples()
pub fn UnloadWaveSamples(
    samples: ?[*]f32,
) void {
    raylib.mUnloadWaveSamples(
        samples,
    );
}

/// Load music stream from file
pub fn LoadMusicStream(
    fileName: [*:0]const u8,
) Music {
    var out: Music = undefined;
    raylib.mLoadMusicStream(
        @ptrCast([*c]raylib.Music, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
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
        @ptrCast([*c]raylib.Music, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(data)),
        dataSize,
    );
    return out;
}

/// Unload music stream
pub fn UnloadMusicStream(
    music: Music,
) void {
    raylib.mUnloadMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Start music playing
pub fn PlayMusicStream(
    music: Music,
) void {
    raylib.mPlayMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Check if music is playing
pub fn IsMusicStreamPlaying(
    music: Music,
) bool {
    return raylib.mIsMusicStreamPlaying(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Updates buffers for music streaming
pub fn UpdateMusicStream(
    music: Music,
) void {
    raylib.mUpdateMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Stop music playing
pub fn StopMusicStream(
    music: Music,
) void {
    raylib.mStopMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Pause music playing
pub fn PauseMusicStream(
    music: Music,
) void {
    raylib.mPauseMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Resume playing paused music
pub fn ResumeMusicStream(
    music: Music,
) void {
    raylib.mResumeMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Seek music to a position (in seconds)
pub fn SeekMusicStream(
    music: Music,
    position: f32,
) void {
    raylib.mSeekMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        position,
    );
}

/// Set volume for music (1.0 is max level)
pub fn SetMusicVolume(
    music: Music,
    volume: f32,
) void {
    raylib.mSetMusicVolume(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        volume,
    );
}

/// Set pitch for a music (1.0 is base level)
pub fn SetMusicPitch(
    music: Music,
    pitch: f32,
) void {
    raylib.mSetMusicPitch(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        pitch,
    );
}

/// Set pan for a music (0.5 is center)
pub fn SetMusicPan(
    music: Music,
    pan: f32,
) void {
    raylib.mSetMusicPan(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        pan,
    );
}

/// Get music time length (in seconds)
pub fn GetMusicTimeLength(
    music: Music,
) f32 {
    return raylib.mGetMusicTimeLength(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

/// Get current music time played (in seconds)
pub fn GetMusicTimePlayed(
    music: Music,
) f32 {
    return raylib.mGetMusicTimePlayed(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
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
        @ptrCast([*c]raylib.AudioStream, &out),
        sampleRate,
        sampleSize,
        channels,
    );
    return out;
}

/// Unload audio stream and free memory
pub fn UnloadAudioStream(
    stream: AudioStream,
) void {
    raylib.mUnloadAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

/// Update audio stream buffers with data
pub fn UpdateAudioStream(
    stream: AudioStream,
    data: *anyopaque,
    frameCount: i32,
) void {
    raylib.mUpdateAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        @ptrCast([*c]anyopaque, data),
        frameCount,
    );
}

/// Check if any audio stream buffers requires refill
pub fn IsAudioStreamProcessed(
    stream: AudioStream,
) bool {
    return raylib.mIsAudioStreamProcessed(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

/// Play audio stream
pub fn PlayAudioStream(
    stream: AudioStream,
) void {
    raylib.mPlayAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

/// Pause audio stream
pub fn PauseAudioStream(
    stream: AudioStream,
) void {
    raylib.mPauseAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

/// Resume audio stream
pub fn ResumeAudioStream(
    stream: AudioStream,
) void {
    raylib.mResumeAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

/// Check if audio stream is playing
pub fn IsAudioStreamPlaying(
    stream: AudioStream,
) bool {
    return raylib.mIsAudioStreamPlaying(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

/// Stop audio stream
pub fn StopAudioStream(
    stream: AudioStream,
) void {
    raylib.mStopAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

/// Set volume for audio stream (1.0 is max level)
pub fn SetAudioStreamVolume(
    stream: AudioStream,
    volume: f32,
) void {
    raylib.mSetAudioStreamVolume(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        volume,
    );
}

/// Set pitch for audio stream (1.0 is base level)
pub fn SetAudioStreamPitch(
    stream: AudioStream,
    pitch: f32,
) void {
    raylib.mSetAudioStreamPitch(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        pitch,
    );
}

/// Set pan for audio stream (0.5 is centered)
pub fn SetAudioStreamPan(
    stream: AudioStream,
    pan: f32,
) void {
    raylib.mSetAudioStreamPan(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
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
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        callback,
    );
}

/// Attach audio stream processor to stream
pub fn AttachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.mAttachAudioStreamProcessor(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        processor,
    );
}

/// Detach audio stream processor from stream
pub fn DetachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.mDetachAudioStreamProcessor(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        processor,
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

/// Pop lattest inserted matrix from stack
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
    matf: ?[*]f32,
) void {
    raylib.mrlMultMatrixf(
        matf,
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

/// Disable wire mode
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

/// De-inititialize rlgl (buffers, shaders, textures)
pub fn rlglClose() void {
    raylib.mrlglClose();
}

/// Load OpenGL extensions (loader function required)
pub fn rlLoadExtensions(
    loader: *anyopaque,
) void {
    raylib.mrlLoadExtensions(
        @ptrCast([*c]anyopaque, loader),
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
    var out: ?[*]i32 = undefined;
    raylib.mrlGetShaderLocsDefault(
        @ptrCast([*c]?[*]i32, &out),
    );
    return out;
}

/// Load a render batch system
pub fn rlLoadRenderBatch(
    numBuffers: i32,
    bufferElements: i32,
) rlRenderBatch {
    var out: rlRenderBatch = undefined;
    raylib.mrlLoadRenderBatch(
        @ptrCast([*c]raylib.rlRenderBatch, &out),
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
        @intToPtr([*c]raylib.rlRenderBatch, @ptrToInt(&batch)),
    );
}

/// Draw render batch data (Update->Draw->Reset)
pub fn rlDrawRenderBatch(
    batch: ?[*]rlRenderBatch,
) void {
    raylib.mrlDrawRenderBatch(
        batch,
    );
}

/// Set the active render batch for rlgl (NULL for default internal)
pub fn rlSetRenderBatchActive(
    batch: ?[*]rlRenderBatch,
) void {
    raylib.mrlSetRenderBatchActive(
        batch,
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

/// Load a vertex buffer attribute
pub fn rlLoadVertexBuffer(
    buffer: *anyopaque,
    size: i32,
    dynamic: bool,
) u32 {
    return raylib.mrlLoadVertexBuffer(
        @ptrCast([*c]anyopaque, buffer),
        size,
        dynamic,
    );
}

/// Load a new attributes element buffer
pub fn rlLoadVertexBufferElement(
    buffer: *anyopaque,
    size: i32,
    dynamic: bool,
) u32 {
    return raylib.mrlLoadVertexBufferElement(
        @ptrCast([*c]anyopaque, buffer),
        size,
        dynamic,
    );
}

/// Update GPU buffer with new data
pub fn rlUpdateVertexBuffer(
    bufferId: u32,
    data: *anyopaque,
    dataSize: i32,
    offset: i32,
) void {
    raylib.mrlUpdateVertexBuffer(
        bufferId,
        @ptrCast([*c]anyopaque, data),
        dataSize,
        offset,
    );
}

/// Update vertex buffer elements with new data
pub fn rlUpdateVertexBufferElements(
    id: u32,
    data: *anyopaque,
    dataSize: i32,
    offset: i32,
) void {
    raylib.mrlUpdateVertexBufferElements(
        id,
        @ptrCast([*c]anyopaque, data),
        dataSize,
        offset,
    );
}

///
pub fn rlUnloadVertexArray(
    vaoId: u32,
) void {
    raylib.mrlUnloadVertexArray(
        vaoId,
    );
}

///
pub fn rlUnloadVertexBuffer(
    vboId: u32,
) void {
    raylib.mrlUnloadVertexBuffer(
        vboId,
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
        @ptrCast([*c]anyopaque, pointer),
    );
}

///
pub fn rlSetVertexAttributeDivisor(
    index: u32,
    divisor: i32,
) void {
    raylib.mrlSetVertexAttributeDivisor(
        index,
        divisor,
    );
}

/// Set vertex attribute default value
pub fn rlSetVertexAttributeDefault(
    locIndex: i32,
    value: *anyopaque,
    attribType: i32,
    count: i32,
) void {
    raylib.mrlSetVertexAttributeDefault(
        locIndex,
        @ptrCast([*c]anyopaque, value),
        attribType,
        count,
    );
}

///
pub fn rlDrawVertexArray(
    offset: i32,
    count: i32,
) void {
    raylib.mrlDrawVertexArray(
        offset,
        count,
    );
}

///
pub fn rlDrawVertexArrayElements(
    offset: i32,
    count: i32,
    buffer: *anyopaque,
) void {
    raylib.mrlDrawVertexArrayElements(
        offset,
        count,
        @ptrCast([*c]anyopaque, buffer),
    );
}

///
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

///
pub fn rlDrawVertexArrayElementsInstanced(
    offset: i32,
    count: i32,
    buffer: *anyopaque,
    instances: i32,
) void {
    raylib.mrlDrawVertexArrayElementsInstanced(
        offset,
        count,
        @ptrCast([*c]anyopaque, buffer),
        instances,
    );
}

/// Load texture in GPU
pub fn rlLoadTexture(
    data: *anyopaque,
    width: i32,
    height: i32,
    format: i32,
    mipmapCount: i32,
) u32 {
    return raylib.mrlLoadTexture(
        @ptrCast([*c]anyopaque, data),
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

/// Load texture cubemap
pub fn rlLoadTextureCubemap(
    data: *anyopaque,
    size: i32,
    format: i32,
) u32 {
    return raylib.mrlLoadTextureCubemap(
        @ptrCast([*c]anyopaque, data),
        size,
        format,
    );
}

/// Update GPU texture with new data
pub fn rlUpdateTexture(
    id: u32,
    offsetX: i32,
    offsetY: i32,
    width: i32,
    height: i32,
    format: i32,
    data: *anyopaque,
) void {
    raylib.mrlUpdateTexture(
        id,
        offsetX,
        offsetY,
        width,
        height,
        format,
        @ptrCast([*c]anyopaque, data),
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
        glInternalFormat,
        glFormat,
        glType,
    );
}

/// Get name string for pixel format
pub fn rlGetPixelFormatName(
    format: u32,
) [*:0]const u8 {
    return @ptrCast(
        [*:0]const u8,
        raylib.mrlGetPixelFormatName(
            format,
        ),
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
        mipmaps,
    );
}

/// Read texture pixel data
pub fn rlReadTexturePixels(
    id: u32,
    width: i32,
    height: i32,
    format: i32,
) [*]const anyopaque {
    return @ptrCast(
        *anyopaque,
        raylib.mrlReadTexturePixels(
            id,
            width,
            height,
            format,
        ),
    );
}

/// Read screen pixel data (color buffer)
pub fn rlReadScreenPixels(
    width: i32,
    height: i32,
) ?[*]u8 {
    var out: ?[*]u8 = undefined;
    raylib.mrlReadScreenPixels(
        @ptrCast([*c]?[*]u8, &out),
        width,
        height,
    );
    return out;
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
        @intToPtr([*c]const u8, @ptrToInt(vsCode)),
        @intToPtr([*c]const u8, @ptrToInt(fsCode)),
    );
}

/// Compile custom shader and return shader id (type: RL_VERTEX_SHADER, RL_FRAGMENT_SHADER, RL_COMPUTE_SHADER)
pub fn rlCompileShader(
    shaderCode: [*:0]const u8,
    typ: i32,
) u32 {
    return raylib.mrlCompileShader(
        @intToPtr([*c]const u8, @ptrToInt(shaderCode)),
        typ,
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
        @intToPtr([*c]const u8, @ptrToInt(uniformName)),
    );
}

/// Get shader location attribute
pub fn rlGetLocationAttrib(
    shaderId: u32,
    attribName: [*:0]const u8,
) i32 {
    return raylib.mrlGetLocationAttrib(
        shaderId,
        @intToPtr([*c]const u8, @ptrToInt(attribName)),
    );
}

/// Set shader value uniform
pub fn rlSetUniform(
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
    count: i32,
) void {
    raylib.mrlSetUniform(
        locIndex,
        @ptrCast([*c]anyopaque, value),
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
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
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
        locs,
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

/// Dispatch compute shader (equivalent to *draw* for graphics pilepine)
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
    size: u64,
    data: *anyopaque,
    usageHint: i32,
) u32 {
    return raylib.mrlLoadShaderBuffer(
        size,
        @ptrCast([*c]anyopaque, data),
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
pub fn rlUpdateShaderBufferElements(
    id: u32,
    data: *anyopaque,
    dataSize: u64,
    offset: u64,
) void {
    raylib.mrlUpdateShaderBufferElements(
        id,
        @ptrCast([*c]anyopaque, data),
        dataSize,
        offset,
    );
}

/// Get SSBO buffer size
pub fn rlGetShaderBufferSize(
    id: u32,
) u64 {
    return raylib.mrlGetShaderBufferSize(
        id,
    );
}

/// Bind SSBO buffer
pub fn rlReadShaderBufferElements(
    id: u32,
    dest: *anyopaque,
    count: u64,
    offset: u64,
) void {
    raylib.mrlReadShaderBufferElements(
        id,
        @ptrCast([*c]anyopaque, dest),
        count,
        offset,
    );
}

/// Copy SSBO buffer data
pub fn rlBindShaderBuffer(
    id: u32,
    index: u32,
) void {
    raylib.mrlBindShaderBuffer(
        id,
        index,
    );
}

/// Copy SSBO buffer data
pub fn rlCopyBuffersElements(
    destId: u32,
    srcId: u32,
    destOffset: u64,
    srcOffset: u64,
    count: u64,
) void {
    raylib.mrlCopyBuffersElements(
        destId,
        srcId,
        destOffset,
        srcOffset,
        count,
    );
}

/// Bind image texture
pub fn rlBindImageTexture(
    id: u32,
    index: u32,
    format: u32,
    readonly: i32,
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
        @ptrCast([*c]raylib.Matrix, &out),
    );
    return out;
}

/// Get internal projection matrix
pub fn rlGetMatrixProjection() Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixProjection(
        @ptrCast([*c]raylib.Matrix, &out),
    );
    return out;
}

/// Get internal accumulated transform matrix
pub fn rlGetMatrixTransform() Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixTransform(
        @ptrCast([*c]raylib.Matrix, &out),
    );
    return out;
}

///
pub fn rlGetMatrixProjectionStereo(
    eye: i32,
) Matrix {
    var out: Matrix = undefined;
    raylib.mrlGetMatrixProjectionStereo(
        @ptrCast([*c]raylib.Matrix, &out),
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
        @ptrCast([*c]raylib.Matrix, &out),
        eye,
    );
    return out;
}

/// Set a custom projection matrix (replaces internal projection matrix)
pub fn rlSetMatrixProjection(
    proj: Matrix,
) void {
    raylib.mrlSetMatrixProjection(
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&proj)),
    );
}

/// Set a custom modelview matrix (replaces internal modelview matrix)
pub fn rlSetMatrixModelview(
    view: Matrix,
) void {
    raylib.mrlSetMatrixModelview(
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&view)),
    );
}

/// Set eyes projection matrices for stereo rendering
pub fn rlSetMatrixProjectionStereo(
    right: Matrix,
    left: Matrix,
) void {
    raylib.mrlSetMatrixProjectionStereo(
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
    );
}

/// Set eyes view offsets matrices for stereo rendering
pub fn rlSetMatrixViewOffsetStereo(
    right: Matrix,
    left: Matrix,
) void {
    raylib.mrlSetMatrixViewOffsetStereo(
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
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
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

///
pub fn Vector2One() Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2One(
        @ptrCast([*c]raylib.Vector2, &out),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        sub,
    );
    return out;
}

///
pub fn Vector2Length(
    v: Vector2,
) f32 {
    return raylib.mVector2Length(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
    );
}

///
pub fn Vector2LengthSqr(
    v: Vector2,
) f32 {
    return raylib.mVector2LengthSqr(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
    );
}

///
pub fn Vector2DotProduct(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2DotProduct(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
}

///
pub fn Vector2Distance(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2Distance(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
}

///
pub fn Vector2DistanceSqr(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2DistanceSqr(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
}

///
pub fn Vector2Angle(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.mVector2Angle(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
}

///
pub fn Vector2Scale(
    v: Vector2,
    scale: f32,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Scale(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

///
pub fn Vector2Negate(
    v: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Negate(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

///
pub fn Vector2Normalize(
    v: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    raylib.mVector2Normalize(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&normal)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&target)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&min)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&max)),
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
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
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
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&q)),
    );
}

///
pub fn Vector3Zero() Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Zero(
        @ptrCast([*c]raylib.Vector3, &out),
    );
    return out;
}

///
pub fn Vector3One() Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3One(
        @ptrCast([*c]raylib.Vector3, &out),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

///
pub fn Vector3Perpendicular(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Perpendicular(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

///
pub fn Vector3DotProduct(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3DotProduct(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
}

///
pub fn Vector3Distance(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3Distance(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
}

///
pub fn Vector3DistanceSqr(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3DistanceSqr(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
}

///
pub fn Vector3Angle(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.mVector3Angle(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
}

///
pub fn Vector3Negate(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Negate(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

///
pub fn Vector3Normalize(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Normalize(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

///
pub fn Vector3OrthoNormalize(
    v1: ?[*]Vector3,
    v2: ?[*]Vector3,
) void {
    raylib.mVector3OrthoNormalize(
        v1,
        v2,
    );
}

///
pub fn Vector3Transform(
    v: Vector3,
    mat: Matrix,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Transform(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&axis)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&normal)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&a)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&b)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&c)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&projection)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&view)),
    );
    return out;
}

///
pub fn Vector3ToFloatV(
    v: Vector3,
) float3 {
    var out: float3 = undefined;
    raylib.mVector3ToFloatV(
        @ptrCast([*c]raylib.float3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

///
pub fn Vector3Invert(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    raylib.mVector3Invert(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&min)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&max)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
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
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&q)),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&n)),
        r,
    );
    return out;
}

///
pub fn MatrixDeterminant(
    mat: Matrix,
) f32 {
    return raylib.mMatrixDeterminant(
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
}

///
pub fn MatrixTrace(
    mat: Matrix,
) f32 {
    return raylib.mMatrixTrace(
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
}

///
pub fn MatrixTranspose(
    mat: Matrix,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixTranspose(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

///
pub fn MatrixInvert(
    mat: Matrix,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixInvert(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

///
pub fn MatrixIdentity() Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixIdentity(
        @ptrCast([*c]raylib.Matrix, &out),
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
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
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
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
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
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
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
        @ptrCast([*c]raylib.Matrix, &out),
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
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&axis)),
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
        @ptrCast([*c]raylib.Matrix, &out),
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
        @ptrCast([*c]raylib.Matrix, &out),
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
        @ptrCast([*c]raylib.Matrix, &out),
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
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&angle)),
    );
    return out;
}

///
pub fn MatrixRotateZYX(
    angle: Vector3,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixRotateZYX(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&angle)),
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
        @ptrCast([*c]raylib.Matrix, &out),
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
        @ptrCast([*c]raylib.Matrix, &out),
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
    fovy: f64,
    aspect: f64,
    near: f64,
    far: f64,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixPerspective(
        @ptrCast([*c]raylib.Matrix, &out),
        fovy,
        aspect,
        near,
        far,
    );
    return out;
}

///
pub fn MatrixOrtho(
    left: f64,
    right: f64,
    bottom: f64,
    top: f64,
    near: f64,
    far: f64,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixOrtho(
        @ptrCast([*c]raylib.Matrix, &out),
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
pub fn MatrixLookAt(
    eye: Vector3,
    target: Vector3,
    up: Vector3,
) Matrix {
    var out: Matrix = undefined;
    raylib.mMatrixLookAt(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&eye)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&target)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&up)),
    );
    return out;
}

///
pub fn MatrixToFloatV(
    mat: Matrix,
) float16 {
    var out: float16 = undefined;
    raylib.mMatrixToFloatV(
        @ptrCast([*c]raylib.float16, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        sub,
    );
    return out;
}

///
pub fn QuaternionIdentity() Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionIdentity(
        @ptrCast([*c]raylib.Vector4, &out),
    );
    return out;
}

///
pub fn QuaternionLength(
    q: Vector4,
) f32 {
    return raylib.mQuaternionLength(
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
}

///
pub fn QuaternionNormalize(
    q: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionNormalize(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
    return out;
}

///
pub fn QuaternionInvert(
    q: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionInvert(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&from)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&to)),
    );
    return out;
}

///
pub fn QuaternionFromMatrix(
    mat: Matrix,
) Vector4 {
    var out: Vector4 = undefined;
    raylib.mQuaternionFromMatrix(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

///
pub fn QuaternionToMatrix(
    q: Vector4,
) Matrix {
    var out: Matrix = undefined;
    raylib.mQuaternionToMatrix(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&axis)),
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
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        outAxis,
        outAngle,
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
        @ptrCast([*c]raylib.Vector4, &out),
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
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
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
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

///
pub fn QuaternionEquals(
    p: Vector4,
    q: Vector4,
) i32 {
    return raylib.mQuaternionEquals(
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&p)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
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
    framePoses: ?[*]Transform,
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
    /// Distance to nearest hit
    distance: f32,
    /// Point of nearest hit
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
    /// Screen center in meters
    vScreenCenter: f32,
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

/// System/Window config flags
pub const ConfigFlags = enum(i32) {
    /// Set to try enabling V-Sync on GPU
    FLAG_VSYNC_HINT = 64,
    /// Set to run program in fullscreen
    FLAG_FULLSCREEN_MODE = 2,
    /// Set to allow resizable window
    FLAG_WINDOW_RESIZABLE = 4,
    /// Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_UNDECORATED = 8,
    /// Set to hide window
    FLAG_WINDOW_HIDDEN = 128,
    /// Set to minimize window (iconify)
    FLAG_WINDOW_MINIMIZED = 512,
    /// Set to maximize window (expanded to monitor)
    FLAG_WINDOW_MAXIMIZED = 1024,
    /// Set to window non focused
    FLAG_WINDOW_UNFOCUSED = 2048,
    /// Set to window always on top
    FLAG_WINDOW_TOPMOST = 4096,
    /// Set to allow windows running while minimized
    FLAG_WINDOW_ALWAYS_RUN = 256,
    /// Set to allow transparent framebuffer
    FLAG_WINDOW_TRANSPARENT = 16,
    /// Set to support HighDPI
    FLAG_WINDOW_HIGHDPI = 8192,
    /// Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    FLAG_WINDOW_MOUSE_PASSTHROUGH = 16384,
    /// Set to try enabling MSAA 4X
    FLAG_MSAA_4X_HINT = 32,
    /// Set to try enabling interlaced video format (for V3D)
    FLAG_INTERLACED_HINT = 65536,
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
    /// Mouse button fordward (advanced mouse device)
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
    /// The omni-directional resize/move cursor shape
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
    /// 4 bpp (no alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGB = 11,
    /// 4 bpp (1 bit alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGBA = 12,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_DXT3_RGBA = 13,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_DXT5_RGBA = 14,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC1_RGB = 15,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_RGB = 16,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 17,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGB = 18,
    /// 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGBA = 19,
    /// 8 bpp
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 20,
    /// 2 bpp
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 21,
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
    /// Layout is defined by an horizontal line with faces
    CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2,
    /// Layout is defined by a 3x4 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3,
    /// Layout is defined by a 4x3 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4,
    /// Layout is defined by a panorama image (equirectangular map)
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
    /// Blend textures using custom src/dst factors (use rlSetBlendMode())
    BLEND_CUSTOM = 6,
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

///
pub const rlGlVersion = enum(i32) {
    ///
    OPENGL_11 = 1,
    ///
    OPENGL_21 = 2,
    ///
    OPENGL_33 = 3,
    ///
    OPENGL_43 = 4,
    ///
    OPENGL_ES_20 = 5,
};

///
pub const rlFramebufferAttachType = enum(i32) {
    ///
    RL_ATTACHMENT_COLOR_CHANNEL0 = 0,
    ///
    RL_ATTACHMENT_COLOR_CHANNEL1 = 1,
    ///
    RL_ATTACHMENT_COLOR_CHANNEL2 = 2,
    ///
    RL_ATTACHMENT_COLOR_CHANNEL3 = 3,
    ///
    RL_ATTACHMENT_COLOR_CHANNEL4 = 4,
    ///
    RL_ATTACHMENT_COLOR_CHANNEL5 = 5,
    ///
    RL_ATTACHMENT_COLOR_CHANNEL6 = 6,
    ///
    RL_ATTACHMENT_COLOR_CHANNEL7 = 7,
    ///
    RL_ATTACHMENT_DEPTH = 100,
    ///
    RL_ATTACHMENT_STENCIL = 200,
};

///
pub const rlFramebufferAttachTextureType = enum(i32) {
    ///
    RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0,
    ///
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_X = 1,
    ///
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Y = 2,
    ///
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y = 3,
    ///
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Z = 4,
    ///
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z = 5,
    ///
    RL_ATTACHMENT_TEXTURE2D = 100,
    ///
    RL_ATTACHMENT_RENDERBUFFER = 200,
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

/// Texture formats (support depends on OpenGL version)
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
    /// 4 bpp (no alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGB = 11,
    /// 4 bpp (1 bit alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA = 12,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA = 13,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA = 14,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC1_RGB = 15,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_RGB = 16,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 17,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGB = 18,
    /// 4 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA = 19,
    /// 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 20,
    /// 2 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 21,
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

/// circle or polygon
pub const PhysicsShapeType = enum(i32) {
    /// physics shape is a circle
    PHYSICS_CIRCLE = 0,
    /// physics shape is a polygon
    PHYSICS_POLYGON = 1,
};

///
pub const RAYLIB_VERSION: []const u8 = "4.2";

///
pub const PI: f32 = 3.1415927410125732;

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
pub const RLGL_VERSION: []const u8 = "4.0";

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

/// Binded by default to shader location: 0
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_POSITION: []const u8 = "vertexPosition";

/// Binded by default to shader location: 1
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_TEXCOORD: []const u8 = "vertexTexCoord";

/// Binded by default to shader location: 2
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_NORMAL: []const u8 = "vertexNormal";

/// Binded by default to shader location: 3
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_COLOR: []const u8 = "vertexColor";

/// Binded by default to shader location: 4
pub const RL_DEFAULT_SHADER_ATTRIB_NAME_TANGENT: []const u8 = "vertexTangent";

/// Binded by default to shader location: 5
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
pub const EPSILON: f32 = 0.0000009999999974752427;
