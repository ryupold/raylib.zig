//! This file contains manual binding definitions for structs & functions.
//! The lower part is auto generated.

const std = @import("std");

const raylib = @cImport({
    @cInclude("raylib.h");
});

/// Load file data as byte array (read)
pub fn LoadFileData(
    fileName: [:0]const u8,
) ![]const u8 {
    var bytesRead: u32 = undefined;

    const ptr: [*c]const u8 = raylib.LoadFileData(
        @ptrCast([*c]const u8, fileName),
        @ptrCast([*c]c_uint, &bytesRead),
    );

    if (bytesRead == 0 and ptr == null) return error.FileNotFound;

    return ptr[0..bytesRead];
}

/// Unload file data allocated by LoadFileData()
pub fn UnloadFileData(
    data: []const u8,
) void {
    var ptr: [*c]u8 = @intToPtr([*c]u8, @ptrToInt(data.ptr));
    raylib.UnloadFileData(
        ptr,
    );
}

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

/// Load font data for further use
pub fn LoadFontData(
    fileData: [:0]const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: []i32,
    glyphCount: i32,
    typ: i32,
) [*c]GlyphInfo {
    return LoadFontData(
        fileData,
        @intCast(c_int, dataSize),
        @intCast(c_int, fontSize),
        @ptrCast([*c]c_int, fontChars.ptr),
        @intCast(c_int, glyphCount),
        @intCast(c_int, typ),
    );
}

pub const GuiStyle = *c_uint;

//--- structs -------------------------------------------------------------------------------------

/// Same layout as Texture
pub const TextureCubemap = Texture;

/// Same layout as RenderTexture
pub const RenderTexture2D = RenderTexture;

/// Alias for Camera3D
pub const Camera = Camera3D;

/// Transform, vectex transformation data
pub const Transform = extern struct {
    /// Translation
    translation: Vector3,
    /// Rotation
    rotation: Quaternion,
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

/// Model, meshes, materials and animation data
pub const Model = extern struct {
    /// Local transform matrix
    transform: Matrix,
    /// Number of meshes
    meshCount: i32,
    /// Number of materials
    materialCount: i32,
    /// Meshes array
    meshes: *Mesh,
    /// Materials array
    materials: *Material,
    /// Mesh material number
    meshMaterial: []i32,
    /// Number of bones
    boneCount: i32,
    /// Bones information (skeleton)
    bones: *BoneInfo,
    /// Bones base transformation (pose)
    bindPose: *Transform,
};

/// ModelAnimation
pub const ModelAnimation = extern struct {
    /// Number of bones
    boneCount: i32,
    /// Number of animation frames
    frameCount: i32,
    /// Bones information (skeleton)
    bones: *BoneInfo,
    /// Poses array by frame
    framePoses: [*c][*c]Transform,
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

pub const RectangleI = struct {
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
    x: f32,
    y: f32,

    pub fn zero() @This() {
        return .{ .x = 0, .y = 0 };
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
};

pub const Vector2i = struct {
    x: i32,
    y: i32,

    pub fn float(self: @This()) Vector2 {
        return .{ .x = @intToFloat(f32, self.x), .y = @intToFloat(f32, self.y) };
    }
};

pub const Vector3 = extern struct {
    x: f32,
    y: f32,
    z: f32,

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
    x: f32,
    y: f32,
    z: f32,
    w: f32,

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
};

pub const Quaternion = extern struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,

    pub fn fromAngleAxis(axis: Vector3, angle: f32) @This() {
        return QuaternionFromAxisAngle(axis, angle);
    }
};

pub const Matrix3x3 = extern struct {
    m0: f32,
    m3: f32,
    m6: f32,

    m1: f32,
    m4: f32,
    m7: f32,

    m2: f32,
    m5: f32,
    m8: f32,

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
        };
    }

    pub fn identity() @This() {
        var x = @This().zero();
        x.m0 = 1;
        x.m4 = 1;
        x.m8 = 1;
        return x;
    }
};

/// Color type, RGBA (32bit)
pub const Color = extern struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,

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

//--- callbacks -----------------------------------------------------------------------------------

/// Logging: Redirect trace log messages
pub const TraceLogCallback = fn (logLevel: i32, text: [:0]const u8) void;

/// FileIO: Load binary data
pub const LoadFileDataCallback = fn (fileName: [:0]const u8, bytesRead: *u32) [:0]const u8;

/// FileIO: Save binary data
pub const SaveFileDataCallback = fn (fileName: [:0]const u8, data: *anyopaque, bytesToWrite: u32) bool;

/// FileIO: Load text data
pub const LoadFileTextCallback = fn (fileName: [:0]const u8) [:0]u8;

/// FileIO: Save text data
pub const SaveFileTextCallback = fn (fileName: [:0]const u8, text: [:0]const u8) bool;

/// Audio Loading and Playing Functions (Module: audio)
pub const AudioCallback = fn (bufferData: *anyopaque, frames: u32) void;

//--- colors --------------------------------------------------------------------------------------

pub const LIGHTGRAY = Color{ .r = 200, .g = 200, .b = 200, .a = 255 };
pub const GRAY = Color{ .r = 130, .g = 130, .b = 130, .a = 255 };
pub const DARKGRAY = Color{ .r = 80, .g = 80, .b = 80, .a = 255 };
pub const YELLOW = Color{ .r = 253, .g = 249, .b = 0, .a = 255 };
pub const GOLD = Color{ .r = 255, .g = 203, .b = 0, .a = 255 };
pub const ORANGE = Color{ .r = 255, .g = 161, .b = 0, .a = 255 };
pub const PINK = Color{ .r = 255, .g = 109, .b = 194, .a = 255 };
pub const RED = Color{ .r = 230, .g = 41, .b = 55, .a = 255 };
pub const MAROON = Color{ .r = 190, .g = 33, .b = 55, .a = 255 };
pub const GREEN = Color{ .r = 0, .g = 228, .b = 48, .a = 255 };
pub const LIME = Color{ .r = 0, .g = 158, .b = 47, .a = 255 };
pub const DARKGREEN = Color{ .r = 0, .g = 117, .b = 44, .a = 255 };
pub const SKYBLUE = Color{ .r = 102, .g = 191, .b = 255, .a = 255 };
pub const BLUE = Color{ .r = 0, .g = 121, .b = 241, .a = 255 };
pub const DARKBLUE = Color{ .r = 0, .g = 82, .b = 172, .a = 255 };
pub const PURPLE = Color{ .r = 200, .g = 122, .b = 255, .a = 255 };
pub const VIOLET = Color{ .r = 135, .g = 60, .b = 190, .a = 255 };
pub const DARKPURPLE = Color{ .r = 112, .g = 31, .b = 126, .a = 255 };
pub const BEIGE = Color{ .r = 211, .g = 176, .b = 131, .a = 255 };
pub const BROWN = Color{ .r = 127, .g = 106, .b = 79, .a = 255 };
pub const DARKBROWN = Color{ .r = 76, .g = 63, .b = 47, .a = 255 };
pub const WHITE = Color{ .r = 255, .g = 255, .b = 255, .a = 255 };
pub const BLACK = Color{ .r = 0, .g = 0, .b = 0, .a = 255 };
pub const BLANK = Color{ .r = 0, .g = 0, .b = 0, .a = 0 };
pub const MAGENTA = Color{ .r = 255, .g = 0, .b = 255, .a = 255 };
pub const RAYWHITE = Color{ .r = 245, .g = 245, .b = 245, .a = 255 };

//--- utils ---------------------------------------------------------------------------------------

fn randomF32(rng: std.rand.Random, min: f32, max: f32) f32 {
    return rng.float(f32) * (max - min) + min;
}

//--- generated -----------------------------------------------------------------------------------

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
pub const Texture = extern struct {
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
pub const RenderTexture = extern struct {
    /// OpenGL framebuffer object id
    id: u32,
    /// Color buffer attachment texture
    texture: Texture,
    /// Depth buffer attachment texture
    depth: Texture,
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
    recs: *Rectangle,
    /// Glyphs info data
    glyphs: *GlyphInfo,
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
    projection: i32,
};

/// Mesh, vertex data and vao/vbo
pub const Mesh = extern struct {
    /// Number of vertices stored in arrays
    vertexCount: i32,
    /// Number of triangles stored (indexed or not)
    triangleCount: i32,
    /// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    vertices: []f32,
    /// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords: []f32,
    /// Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
    texcoords2: []f32,
    /// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    normals: []f32,
    /// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    tangents: []f32,
    /// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    colors: [:0]const u8,
    /// Vertex indices (in case vertex data comes indexed)
    indices: []u16,
    /// Animated vertex positions (after bones transformations)
    animVertices: []f32,
    /// Animated normals (after bones transformations)
    animNormals: []f32,
    /// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    boneIds: [:0]const u8,
    /// Vertex bone weight, up to 4 bones influence by vertex (skinning)
    boneWeights: []f32,
    /// OpenGL Vertex Array Object id
    vaoId: u32,
    /// OpenGL Vertex Buffer Objects id (default vertex data)
    vboId: []u32,
};

/// Shader
pub const Shader = extern struct {
    /// Shader program id
    id: u32,
    /// Shader locations array (RL_MAX_SHADER_LOCATIONS)
    locs: []i32,
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
    maps: *MaterialMap,
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

/// It should be redesigned to be provided by user
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

/// Style property
pub const GuiStyleProp = extern struct {
    /// 
    controlId: u16,
    /// 
    propertyId: u16,
    /// 
    propertyValue: i32,
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
    // Key: Android menu button
    // KEY_MENU = 82,
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
    BLEND_ALPHA_PREMUL = 5,
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

/// Gui control state
pub const GuiControlState = enum(i32) {
    /// 
    GUI_STATE_NORMAL = 0,
    /// 
    GUI_STATE_FOCUSED = 1,
    /// 
    GUI_STATE_PRESSED = 2,
    /// 
    GUI_STATE_DISABLED = 3,
};

/// Gui control text alignment
pub const GuiTextAlignment = enum(i32) {
    /// 
    GUI_TEXT_ALIGN_LEFT = 0,
    /// 
    GUI_TEXT_ALIGN_CENTER = 1,
    /// 
    GUI_TEXT_ALIGN_RIGHT = 2,
};

/// Gui controls
pub const GuiControl = enum(i32) {
    /// Generic control -> populates to all controls when set
    DEFAULT = 0,
    /// Used also for: LABELBUTTON
    LABEL = 1,
    /// 
    BUTTON = 2,
    /// Used also for: TOGGLEGROUP
    TOGGLE = 3,
    /// Used also for: SLIDERBAR
    SLIDER = 4,
    /// 
    PROGRESSBAR = 5,
    /// 
    CHECKBOX = 6,
    /// 
    COMBOBOX = 7,
    /// 
    DROPDOWNBOX = 8,
    /// Used also for: TEXTBOXMULTI
    TEXTBOX = 9,
    /// 
    VALUEBOX = 10,
    /// 
    SPINNER = 11,
    /// 
    LISTVIEW = 12,
    /// 
    COLORPICKER = 13,
    /// 
    SCROLLBAR = 14,
    /// 
    STATUSBAR = 15,
};

/// Gui base properties for every control
pub const GuiControlProperty = enum(i32) {
    /// 
    BORDER_COLOR_NORMAL = 0,
    /// 
    BASE_COLOR_NORMAL = 1,
    /// 
    TEXT_COLOR_NORMAL = 2,
    /// 
    BORDER_COLOR_FOCUSED = 3,
    /// 
    BASE_COLOR_FOCUSED = 4,
    /// 
    TEXT_COLOR_FOCUSED = 5,
    /// 
    BORDER_COLOR_PRESSED = 6,
    /// 
    BASE_COLOR_PRESSED = 7,
    /// 
    TEXT_COLOR_PRESSED = 8,
    /// 
    BORDER_COLOR_DISABLED = 9,
    /// 
    BASE_COLOR_DISABLED = 10,
    /// 
    TEXT_COLOR_DISABLED = 11,
    /// 
    BORDER_WIDTH = 12,
    /// 
    TEXT_PADDING = 13,
    /// 
    TEXT_ALIGNMENT = 14,
    /// 
    RESERVED = 15,
};

/// DEFAULT extended properties
pub const GuiDefaultProperty = enum(i32) {
    /// 
    TEXT_SIZE = 16,
    /// 
    TEXT_SPACING = 17,
    /// 
    LINE_COLOR = 18,
    /// 
    BACKGROUND_COLOR = 19,
};

/// Toggle/ToggleGroup
pub const GuiToggleProperty = enum(i32) {
    /// 
    GROUP_PADDING = 16,
};

/// Slider/SliderBar
pub const GuiSliderProperty = enum(i32) {
    /// 
    SLIDER_WIDTH = 16,
    /// 
    SLIDER_PADDING = 17,
};

/// ProgressBar
pub const GuiProgressBarProperty = enum(i32) {
    /// 
    PROGRESS_PADDING = 16,
};

/// CheckBox
pub const GuiCheckBoxProperty = enum(i32) {
    /// 
    CHECK_PADDING = 16,
};

/// ComboBox
pub const GuiComboBoxProperty = enum(i32) {
    /// 
    COMBO_BUTTON_WIDTH = 16,
    /// 
    COMBO_BUTTON_PADDING = 17,
};

/// DropdownBox
pub const GuiDropdownBoxProperty = enum(i32) {
    /// 
    ARROW_PADDING = 16,
    /// 
    DROPDOWN_ITEMS_PADDING = 17,
};

/// TextBox/TextBoxMulti/ValueBox/Spinner
pub const GuiTextBoxProperty = enum(i32) {
    /// 
    TEXT_INNER_PADDING = 16,
    /// 
    TEXT_LINES_PADDING = 17,
    /// 
    COLOR_SELECTED_FG = 18,
    /// 
    COLOR_SELECTED_BG = 19,
};

/// Spinner
pub const GuiSpinnerProperty = enum(i32) {
    /// 
    SPIN_BUTTON_WIDTH = 16,
    /// 
    SPIN_BUTTON_PADDING = 17,
};

/// ScrollBar
pub const GuiScrollBarProperty = enum(i32) {
    /// 
    ARROWS_SIZE = 16,
    /// 
    ARROWS_VISIBLE = 17,
    /// 
    SCROLL_SLIDER_PADDING = 18,
    /// 
    SCROLL_SLIDER_SIZE = 19,
    /// 
    SCROLL_PADDING = 20,
    /// 
    SCROLL_SPEED = 21,
};

/// ScrollBar side
pub const GuiScrollBarSide = enum(i32) {
    /// 
    SCROLLBAR_LEFT_SIDE = 0,
    /// 
    SCROLLBAR_RIGHT_SIDE = 1,
};

/// ListView
pub const GuiListViewProperty = enum(i32) {
    /// 
    LIST_ITEMS_HEIGHT = 16,
    /// 
    LIST_ITEMS_PADDING = 17,
    /// 
    SCROLLBAR_WIDTH = 18,
    /// 
    SCROLLBAR_SIDE = 19,
};

/// ColorPicker
pub const GuiColorPickerProperty = enum(i32) {
    /// 
    COLOR_SELECTOR_SIZE = 16,
    /// Right hue bar width
    HUEBAR_WIDTH = 17,
    /// Right hue bar separation from panel
    HUEBAR_PADDING = 18,
    /// Right hue bar selector height
    HUEBAR_SELECTOR_HEIGHT = 19,
    /// Right hue bar selector overflow
    HUEBAR_SELECTOR_OVERFLOW = 20,
};

/// edef enum {
pub const guiIconName = enum(i32) {
    /// 
    RICON_NONE = 0,
    /// 
    RICON_FOLDER_FILE_OPEN = 1,
    /// 
    RICON_FILE_SAVE_CLASSIC = 2,
    /// 
    RICON_FOLDER_OPEN = 3,
    /// 
    RICON_FOLDER_SAVE = 4,
    /// 
    RICON_FILE_OPEN = 5,
    /// 
    RICON_FILE_SAVE = 6,
    /// 
    RICON_FILE_EXPORT = 7,
    /// 
    RICON_FILE_NEW = 8,
    /// 
    RICON_FILE_DELETE = 9,
    /// 
    RICON_FILETYPE_TEXT = 10,
    /// 
    RICON_FILETYPE_AUDIO = 11,
    /// 
    RICON_FILETYPE_IMAGE = 12,
    /// 
    RICON_FILETYPE_PLAY = 13,
    /// 
    RICON_FILETYPE_VIDEO = 14,
    /// 
    RICON_FILETYPE_INFO = 15,
    /// 
    RICON_FILE_COPY = 16,
    /// 
    RICON_FILE_CUT = 17,
    /// 
    RICON_FILE_PASTE = 18,
    /// 
    RICON_CURSOR_HAND = 19,
    /// 
    RICON_CURSOR_POINTER = 20,
    /// 
    RICON_CURSOR_CLASSIC = 21,
    /// 
    RICON_PENCIL = 22,
    /// 
    RICON_PENCIL_BIG = 23,
    /// 
    RICON_BRUSH_CLASSIC = 24,
    /// 
    RICON_BRUSH_PAINTER = 25,
    /// 
    RICON_WATER_DROP = 26,
    /// 
    RICON_COLOR_PICKER = 27,
    /// 
    RICON_RUBBER = 28,
    /// 
    RICON_COLOR_BUCKET = 29,
    /// 
    RICON_TEXT_T = 30,
    /// 
    RICON_TEXT_A = 31,
    /// 
    RICON_SCALE = 32,
    /// 
    RICON_RESIZE = 33,
    /// 
    RICON_FILTER_POINT = 34,
    /// 
    RICON_FILTER_BILINEAR = 35,
    /// 
    RICON_CROP = 36,
    /// 
    RICON_CROP_ALPHA = 37,
    /// 
    RICON_SQUARE_TOGGLE = 38,
    /// 
    RICON_SYMMETRY = 39,
    /// 
    RICON_SYMMETRY_HORIZONTAL = 40,
    /// 
    RICON_SYMMETRY_VERTICAL = 41,
    /// 
    RICON_LENS = 42,
    /// 
    RICON_LENS_BIG = 43,
    /// 
    RICON_EYE_ON = 44,
    /// 
    RICON_EYE_OFF = 45,
    /// 
    RICON_FILTER_TOP = 46,
    /// 
    RICON_FILTER = 47,
    /// 
    RICON_TARGET_POINT = 48,
    /// 
    RICON_TARGET_SMALL = 49,
    /// 
    RICON_TARGET_BIG = 50,
    /// 
    RICON_TARGET_MOVE = 51,
    /// 
    RICON_CURSOR_MOVE = 52,
    /// 
    RICON_CURSOR_SCALE = 53,
    /// 
    RICON_CURSOR_SCALE_RIGHT = 54,
    /// 
    RICON_CURSOR_SCALE_LEFT = 55,
    /// 
    RICON_UNDO = 56,
    /// 
    RICON_REDO = 57,
    /// 
    RICON_REREDO = 58,
    /// 
    RICON_MUTATE = 59,
    /// 
    RICON_ROTATE = 60,
    /// 
    RICON_REPEAT = 61,
    /// 
    RICON_SHUFFLE = 62,
    /// 
    RICON_EMPTYBOX = 63,
    /// 
    RICON_TARGET = 64,
    /// 
    RICON_TARGET_SMALL_FILL = 65,
    /// 
    RICON_TARGET_BIG_FILL = 66,
    /// 
    RICON_TARGET_MOVE_FILL = 67,
    /// 
    RICON_CURSOR_MOVE_FILL = 68,
    /// 
    RICON_CURSOR_SCALE_FILL = 69,
    /// 
    RICON_CURSOR_SCALE_RIGHT_FILL = 70,
    /// 
    RICON_CURSOR_SCALE_LEFT_FILL = 71,
    /// 
    RICON_UNDO_FILL = 72,
    /// 
    RICON_REDO_FILL = 73,
    /// 
    RICON_REREDO_FILL = 74,
    /// 
    RICON_MUTATE_FILL = 75,
    /// 
    RICON_ROTATE_FILL = 76,
    /// 
    RICON_REPEAT_FILL = 77,
    /// 
    RICON_SHUFFLE_FILL = 78,
    /// 
    RICON_EMPTYBOX_SMALL = 79,
    /// 
    RICON_BOX = 80,
    /// 
    RICON_BOX_TOP = 81,
    /// 
    RICON_BOX_TOP_RIGHT = 82,
    /// 
    RICON_BOX_RIGHT = 83,
    /// 
    RICON_BOX_BOTTOM_RIGHT = 84,
    /// 
    RICON_BOX_BOTTOM = 85,
    /// 
    RICON_BOX_BOTTOM_LEFT = 86,
    /// 
    RICON_BOX_LEFT = 87,
    /// 
    RICON_BOX_TOP_LEFT = 88,
    /// 
    RICON_BOX_CENTER = 89,
    /// 
    RICON_BOX_CIRCLE_MASK = 90,
    /// 
    RICON_POT = 91,
    /// 
    RICON_ALPHA_MULTIPLY = 92,
    /// 
    RICON_ALPHA_CLEAR = 93,
    /// 
    RICON_DITHERING = 94,
    /// 
    RICON_MIPMAPS = 95,
    /// 
    RICON_BOX_GRID = 96,
    /// 
    RICON_GRID = 97,
    /// 
    RICON_BOX_CORNERS_SMALL = 98,
    /// 
    RICON_BOX_CORNERS_BIG = 99,
    /// 
    RICON_FOUR_BOXES = 100,
    /// 
    RICON_GRID_FILL = 101,
    /// 
    RICON_BOX_MULTISIZE = 102,
    /// 
    RICON_ZOOM_SMALL = 103,
    /// 
    RICON_ZOOM_MEDIUM = 104,
    /// 
    RICON_ZOOM_BIG = 105,
    /// 
    RICON_ZOOM_ALL = 106,
    /// 
    RICON_ZOOM_CENTER = 107,
    /// 
    RICON_BOX_DOTS_SMALL = 108,
    /// 
    RICON_BOX_DOTS_BIG = 109,
    /// 
    RICON_BOX_CONCENTRIC = 110,
    /// 
    RICON_BOX_GRID_BIG = 111,
    /// 
    RICON_OK_TICK = 112,
    /// 
    RICON_CROSS = 113,
    /// 
    RICON_ARROW_LEFT = 114,
    /// 
    RICON_ARROW_RIGHT = 115,
    /// 
    RICON_ARROW_DOWN = 116,
    /// 
    RICON_ARROW_UP = 117,
    /// 
    RICON_ARROW_LEFT_FILL = 118,
    /// 
    RICON_ARROW_RIGHT_FILL = 119,
    /// 
    RICON_ARROW_DOWN_FILL = 120,
    /// 
    RICON_ARROW_UP_FILL = 121,
    /// 
    RICON_AUDIO = 122,
    /// 
    RICON_FX = 123,
    /// 
    RICON_WAVE = 124,
    /// 
    RICON_WAVE_SINUS = 125,
    /// 
    RICON_WAVE_SQUARE = 126,
    /// 
    RICON_WAVE_TRIANGULAR = 127,
    /// 
    RICON_CROSS_SMALL = 128,
    /// 
    RICON_PLAYER_PREVIOUS = 129,
    /// 
    RICON_PLAYER_PLAY_BACK = 130,
    /// 
    RICON_PLAYER_PLAY = 131,
    /// 
    RICON_PLAYER_PAUSE = 132,
    /// 
    RICON_PLAYER_STOP = 133,
    /// 
    RICON_PLAYER_NEXT = 134,
    /// 
    RICON_PLAYER_RECORD = 135,
    /// 
    RICON_MAGNET = 136,
    /// 
    RICON_LOCK_CLOSE = 137,
    /// 
    RICON_LOCK_OPEN = 138,
    /// 
    RICON_CLOCK = 139,
    /// 
    RICON_TOOLS = 140,
    /// 
    RICON_GEAR = 141,
    /// 
    RICON_GEAR_BIG = 142,
    /// 
    RICON_BIN = 143,
    /// 
    RICON_HAND_POINTER = 144,
    /// 
    RICON_LASER = 145,
    /// 
    RICON_COIN = 146,
    /// 
    RICON_EXPLOSION = 147,
    /// 
    RICON_1UP = 148,
    /// 
    RICON_PLAYER = 149,
    /// 
    RICON_PLAYER_JUMP = 150,
    /// 
    RICON_KEY = 151,
    /// 
    RICON_DEMON = 152,
    /// 
    RICON_TEXT_POPUP = 153,
    /// 
    RICON_GEAR_EX = 154,
    /// 
    RICON_CRACK = 155,
    /// 
    RICON_CRACK_POINTS = 156,
    /// 
    RICON_STAR = 157,
    /// 
    RICON_DOOR = 158,
    /// 
    RICON_EXIT = 159,
    /// 
    RICON_MODE_2D = 160,
    /// 
    RICON_MODE_3D = 161,
    /// 
    RICON_CUBE = 162,
    /// 
    RICON_CUBE_FACE_TOP = 163,
    /// 
    RICON_CUBE_FACE_LEFT = 164,
    /// 
    RICON_CUBE_FACE_FRONT = 165,
    /// 
    RICON_CUBE_FACE_BOTTOM = 166,
    /// 
    RICON_CUBE_FACE_RIGHT = 167,
    /// 
    RICON_CUBE_FACE_BACK = 168,
    /// 
    RICON_CAMERA = 169,
    /// 
    RICON_SPECIAL = 170,
    /// 
    RICON_LINK_NET = 171,
    /// 
    RICON_LINK_BOXES = 172,
    /// 
    RICON_LINK_MULTI = 173,
    /// 
    RICON_LINK = 174,
    /// 
    RICON_LINK_BROKE = 175,
    /// 
    RICON_TEXT_NOTES = 176,
    /// 
    RICON_NOTEBOOK = 177,
    /// 
    RICON_SUITCASE = 178,
    /// 
    RICON_SUITCASE_ZIP = 179,
    /// 
    RICON_MAILBOX = 180,
    /// 
    RICON_MONITOR = 181,
    /// 
    RICON_PRINTER = 182,
    /// 
    RICON_PHOTO_CAMERA = 183,
    /// 
    RICON_PHOTO_CAMERA_FLASH = 184,
    /// 
    RICON_HOUSE = 185,
    /// 
    RICON_HEART = 186,
    /// 
    RICON_CORNER = 187,
    /// 
    RICON_VERTICAL_BARS = 188,
    /// 
    RICON_VERTICAL_BARS_FILL = 189,
    /// 
    RICON_LIFE_BARS = 190,
    /// 
    RICON_INFO = 191,
    /// 
    RICON_CROSSLINE = 192,
    /// 
    RICON_HELP = 193,
    /// 
    RICON_FILETYPE_ALPHA = 194,
    /// 
    RICON_FILETYPE_HOME = 195,
    /// 
    RICON_LAYERS_VISIBLE = 196,
    /// 
    RICON_LAYERS = 197,
    /// 
    RICON_WINDOW = 198,
    /// 
    RICON_HIDPI = 199,
    /// 
    RICON_200 = 200,
    /// 
    RICON_201 = 201,
    /// 
    RICON_202 = 202,
    /// 
    RICON_203 = 203,
    /// 
    RICON_204 = 204,
    /// 
    RICON_205 = 205,
    /// 
    RICON_206 = 206,
    /// 
    RICON_207 = 207,
    /// 
    RICON_208 = 208,
    /// 
    RICON_209 = 209,
    /// 
    RICON_210 = 210,
    /// 
    RICON_211 = 211,
    /// 
    RICON_212 = 212,
    /// 
    RICON_213 = 213,
    /// 
    RICON_214 = 214,
    /// 
    RICON_215 = 215,
    /// 
    RICON_216 = 216,
    /// 
    RICON_217 = 217,
    /// 
    RICON_218 = 218,
    /// 
    RICON_219 = 219,
    /// 
    RICON_220 = 220,
    /// 
    RICON_221 = 221,
    /// 
    RICON_222 = 222,
    /// 
    RICON_223 = 223,
    /// 
    RICON_224 = 224,
    /// 
    RICON_225 = 225,
    /// 
    RICON_226 = 226,
    /// 
    RICON_227 = 227,
    /// 
    RICON_228 = 228,
    /// 
    RICON_229 = 229,
    /// 
    RICON_230 = 230,
    /// 
    RICON_231 = 231,
    /// 
    RICON_232 = 232,
    /// 
    RICON_233 = 233,
    /// 
    RICON_234 = 234,
    /// 
    RICON_235 = 235,
    /// 
    RICON_236 = 236,
    /// 
    RICON_237 = 237,
    /// 
    RICON_238 = 238,
    /// 
    RICON_239 = 239,
    /// 
    RICON_240 = 240,
    /// 
    RICON_241 = 241,
    /// 
    RICON_242 = 242,
    /// 
    RICON_243 = 243,
    /// 
    RICON_244 = 244,
    /// 
    RICON_245 = 245,
    /// 
    RICON_246 = 246,
    /// 
    RICON_247 = 247,
    /// 
    RICON_248 = 248,
    /// 
    RICON_249 = 249,
    /// 
    RICON_250 = 250,
    /// 
    RICON_251 = 251,
    /// 
    RICON_252 = 252,
    /// 
    RICON_253 = 253,
    /// 
    RICON_254 = 254,
    /// 
    RICON_255 = 255,
};

/// Initialize window and OpenGL context
pub fn InitWindow(
    width: i32,
    height: i32,
    title: [:0]const u8,
) void {
    raylib.InitWindow(
        @intCast(c_int, width),
        @intCast(c_int, height),
        title,
    );
}

/// Check if KEY_ESCAPE pressed or Close icon pressed
pub fn WindowShouldClose() bool {
    return raylib.WindowShouldClose();
}

/// Close window and unload OpenGL context
pub fn CloseWindow() void {
    raylib.CloseWindow();
}

/// Check if window has been initialized successfully
pub fn IsWindowReady() bool {
    return raylib.IsWindowReady();
}

/// Check if window is currently fullscreen
pub fn IsWindowFullscreen() bool {
    return raylib.IsWindowFullscreen();
}

/// Check if window is currently hidden (only PLATFORM_DESKTOP)
pub fn IsWindowHidden() bool {
    return raylib.IsWindowHidden();
}

/// Check if window is currently minimized (only PLATFORM_DESKTOP)
pub fn IsWindowMinimized() bool {
    return raylib.IsWindowMinimized();
}

/// Check if window is currently maximized (only PLATFORM_DESKTOP)
pub fn IsWindowMaximized() bool {
    return raylib.IsWindowMaximized();
}

/// Check if window is currently focused (only PLATFORM_DESKTOP)
pub fn IsWindowFocused() bool {
    return raylib.IsWindowFocused();
}

/// Check if window has been resized last frame
pub fn IsWindowResized() bool {
    return raylib.IsWindowResized();
}

/// Check if one specific window flag is enabled
pub fn IsWindowState(
    flag: u32,
) bool {
    return raylib.IsWindowState(
        @intCast(c_uint, flag),
    );
}

/// Set window configuration state using flags (only PLATFORM_DESKTOP)
pub fn SetWindowState(
    flags: u32,
) void {
    raylib.SetWindowState(
        @intCast(c_uint, flags),
    );
}

/// Clear window configuration state flags
pub fn ClearWindowState(
    flags: u32,
) void {
    raylib.ClearWindowState(
        @intCast(c_uint, flags),
    );
}

/// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
pub fn ToggleFullscreen() void {
    raylib.ToggleFullscreen();
}

/// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
pub fn MaximizeWindow() void {
    raylib.MaximizeWindow();
}

/// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
pub fn MinimizeWindow() void {
    raylib.MinimizeWindow();
}

/// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
pub fn RestoreWindow() void {
    raylib.RestoreWindow();
}

/// Set icon for window (only PLATFORM_DESKTOP)
pub fn SetWindowIcon(
    image: Image,
) void {
    raylib.SetWindowIcon(
        @bitCast(raylib.Image, image),
    );
}

/// Set title for window (only PLATFORM_DESKTOP)
pub fn SetWindowTitle(
    title: [:0]const u8,
) void {
    raylib.SetWindowTitle(
        title,
    );
}

/// Set window position on screen (only PLATFORM_DESKTOP)
pub fn SetWindowPosition(
    x: i32,
    y: i32,
) void {
    raylib.SetWindowPosition(
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}

/// Set monitor for the current window (fullscreen mode)
pub fn SetWindowMonitor(
    monitor: i32,
) void {
    raylib.SetWindowMonitor(
        @intCast(c_int, monitor),
    );
}

/// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub fn SetWindowMinSize(
    width: i32,
    height: i32,
) void {
    raylib.SetWindowMinSize(
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

/// Set window dimensions
pub fn SetWindowSize(
    width: i32,
    height: i32,
) void {
    raylib.SetWindowSize(
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

/// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
pub fn SetWindowOpacity(
    opacity: f32,
) void {
    raylib.SetWindowOpacity(
        @bitCast(f32, opacity),
    );
}

/// Get native window handle
pub fn GetWindowHandle() *anyopaque {
    return raylib.GetWindowHandle();
}

/// Get current screen width
pub fn GetScreenWidth() i32 {
    return raylib.GetScreenWidth();
}

/// Get current screen height
pub fn GetScreenHeight() i32 {
    return raylib.GetScreenHeight();
}

/// Get current render width (it considers HiDPI)
pub fn GetRenderWidth() i32 {
    return raylib.GetRenderWidth();
}

/// Get current render height (it considers HiDPI)
pub fn GetRenderHeight() i32 {
    return raylib.GetRenderHeight();
}

/// Get number of connected monitors
pub fn GetMonitorCount() i32 {
    return raylib.GetMonitorCount();
}

/// Get current connected monitor
pub fn GetCurrentMonitor() i32 {
    return raylib.GetCurrentMonitor();
}

/// Get specified monitor position
pub fn GetMonitorPosition(
    monitor: i32,
) Vector2 {
    return raylib.GetMonitorPosition(
        @intCast(c_int, monitor),
    );
}

/// Get specified monitor width (max available by monitor)
pub fn GetMonitorWidth(
    monitor: i32,
) i32 {
    return raylib.GetMonitorWidth(
        @intCast(c_int, monitor),
    );
}

/// Get specified monitor height (max available by monitor)
pub fn GetMonitorHeight(
    monitor: i32,
) i32 {
    return raylib.GetMonitorHeight(
        @intCast(c_int, monitor),
    );
}

/// Get specified monitor physical width in millimetres
pub fn GetMonitorPhysicalWidth(
    monitor: i32,
) i32 {
    return raylib.GetMonitorPhysicalWidth(
        @intCast(c_int, monitor),
    );
}

/// Get specified monitor physical height in millimetres
pub fn GetMonitorPhysicalHeight(
    monitor: i32,
) i32 {
    return raylib.GetMonitorPhysicalHeight(
        @intCast(c_int, monitor),
    );
}

/// Get specified monitor refresh rate
pub fn GetMonitorRefreshRate(
    monitor: i32,
) i32 {
    return raylib.GetMonitorRefreshRate(
        @intCast(c_int, monitor),
    );
}

/// Get window position XY on monitor
pub fn GetWindowPosition() Vector2 {
    return raylib.GetWindowPosition();
}

/// Get window scale DPI factor
pub fn GetWindowScaleDPI() Vector2 {
    return raylib.GetWindowScaleDPI();
}

/// Get the human-readable, UTF-8 encoded name of the primary monitor
pub fn GetMonitorName(
    monitor: i32,
) [:0]const u8 {
    return raylib.GetMonitorName(
        @intCast(c_int, monitor),
    );
}

/// Set clipboard text content
pub fn SetClipboardText(
    text: [:0]const u8,
) void {
    raylib.SetClipboardText(
        text,
    );
}

/// Get clipboard text content
pub fn GetClipboardText() [:0]const u8 {
    return raylib.GetClipboardText();
}

/// Swap back buffer with front buffer (screen drawing)
pub fn SwapScreenBuffer() void {
    raylib.SwapScreenBuffer();
}

/// Register all input events
pub fn PollInputEvents() void {
    raylib.PollInputEvents();
}

/// Wait for some milliseconds (halt program execution)
pub fn WaitTime(
    ms: f32,
) void {
    raylib.WaitTime(
        @bitCast(f32, ms),
    );
}

/// Shows cursor
pub fn ShowCursor() void {
    raylib.ShowCursor();
}

/// Hides cursor
pub fn HideCursor() void {
    raylib.HideCursor();
}

/// Check if cursor is not visible
pub fn IsCursorHidden() bool {
    return raylib.IsCursorHidden();
}

/// Enables cursor (unlock cursor)
pub fn EnableCursor() void {
    raylib.EnableCursor();
}

/// Disables cursor (lock cursor)
pub fn DisableCursor() void {
    raylib.DisableCursor();
}

/// Check if cursor is on the screen
pub fn IsCursorOnScreen() bool {
    return raylib.IsCursorOnScreen();
}

/// Set background color (framebuffer clear color)
pub fn ClearBackground(
    color: Color,
) void {
    raylib.ClearBackground(
        @bitCast(raylib.Color, color),
    );
}

/// Setup canvas (framebuffer) to start drawing
pub fn BeginDrawing() void {
    raylib.BeginDrawing();
}

/// End canvas drawing and swap buffers (double buffering)
pub fn EndDrawing() void {
    raylib.EndDrawing();
}

/// Begin 2D mode with custom camera (2D)
pub fn BeginMode2D(
    camera: Camera2D,
) void {
    raylib.BeginMode2D(
        @bitCast(raylib.Camera2D, camera),
    );
}

/// Ends 2D mode with custom camera
pub fn EndMode2D() void {
    raylib.EndMode2D();
}

/// Begin 3D mode with custom camera (3D)
pub fn BeginMode3D(
    camera: Camera3D,
) void {
    raylib.BeginMode3D(
        @bitCast(raylib.Camera3D, camera),
    );
}

/// Ends 3D mode and returns to default 2D orthographic mode
pub fn EndMode3D() void {
    raylib.EndMode3D();
}

/// Begin drawing to render texture
pub fn BeginTextureMode(
    target: RenderTexture2D,
) void {
    raylib.BeginTextureMode(
        @bitCast(raylib.RenderTexture2D, target),
    );
}

/// Ends drawing to render texture
pub fn EndTextureMode() void {
    raylib.EndTextureMode();
}

/// Begin custom shader drawing
pub fn BeginShaderMode(
    shader: Shader,
) void {
    raylib.BeginShaderMode(
        @bitCast(raylib.Shader, shader),
    );
}

/// End custom shader drawing (use default shader)
pub fn EndShaderMode() void {
    raylib.EndShaderMode();
}

/// Begin blending mode (alpha, additive, multiplied, subtract, custom)
pub fn BeginBlendMode(
    mode: i32,
) void {
    raylib.BeginBlendMode(
        @intCast(c_int, mode),
    );
}

/// End blending mode (reset to default: alpha blending)
pub fn EndBlendMode() void {
    raylib.EndBlendMode();
}

/// Begin scissor mode (define screen area for following drawing)
pub fn BeginScissorMode(
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {
    raylib.BeginScissorMode(
        @intCast(c_int, x),
        @intCast(c_int, y),
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

/// End scissor mode
pub fn EndScissorMode() void {
    raylib.EndScissorMode();
}

/// Begin stereo rendering (requires VR simulator)
pub fn BeginVrStereoMode(
    config: VrStereoConfig,
) void {
    raylib.BeginVrStereoMode(
        @bitCast(raylib.VrStereoConfig, config),
    );
}

/// End stereo rendering (requires VR simulator)
pub fn EndVrStereoMode() void {
    raylib.EndVrStereoMode();
}

/// Load VR stereo config for VR simulator device parameters
pub fn LoadVrStereoConfig(
    device: VrDeviceInfo,
) VrStereoConfig {
    return raylib.LoadVrStereoConfig(
        @bitCast(raylib.VrDeviceInfo, device),
    );
}

/// Unload VR stereo config
pub fn UnloadVrStereoConfig(
    config: VrStereoConfig,
) void {
    raylib.UnloadVrStereoConfig(
        @bitCast(raylib.VrStereoConfig, config),
    );
}

/// Load shader from files and bind default locations
pub fn LoadShader(
    vsFileName: [:0]const u8,
    fsFileName: [:0]const u8,
) Shader {
    return raylib.LoadShader(
        vsFileName,
        fsFileName,
    );
}

/// Load shader from code strings and bind default locations
pub fn LoadShaderFromMemory(
    vsCode: [:0]const u8,
    fsCode: [:0]const u8,
) Shader {
    return raylib.LoadShaderFromMemory(
        vsCode,
        fsCode,
    );
}

/// Get shader uniform location
pub fn GetShaderLocation(
    shader: Shader,
    uniformName: [:0]const u8,
) i32 {
    return raylib.GetShaderLocation(
        @bitCast(raylib.Shader, shader),
        uniformName,
    );
}

/// Get shader attribute location
pub fn GetShaderLocationAttrib(
    shader: Shader,
    attribName: [:0]const u8,
) i32 {
    return raylib.GetShaderLocationAttrib(
        @bitCast(raylib.Shader, shader),
        attribName,
    );
}

/// Set shader uniform value
pub fn SetShaderValue(
    shader: Shader,
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
) void {
    raylib.SetShaderValue(
        @bitCast(raylib.Shader, shader),
        @intCast(c_int, locIndex),
        @bitCast(*anyopaque, value),
        @intCast(c_int, uniformType),
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
    raylib.SetShaderValueV(
        @bitCast(raylib.Shader, shader),
        @intCast(c_int, locIndex),
        @bitCast(*anyopaque, value),
        @intCast(c_int, uniformType),
        @intCast(c_int, count),
    );
}

/// Set shader uniform value (matrix 4x4)
pub fn SetShaderValueMatrix(
    shader: Shader,
    locIndex: i32,
    mat: Matrix,
) void {
    raylib.SetShaderValueMatrix(
        @bitCast(raylib.Shader, shader),
        @intCast(c_int, locIndex),
        @bitCast(raylib.Matrix, mat),
    );
}

/// Set shader uniform value for texture (sampler2d)
pub fn SetShaderValueTexture(
    shader: Shader,
    locIndex: i32,
    texture: Texture,
) void {
    raylib.SetShaderValueTexture(
        @bitCast(raylib.Shader, shader),
        @intCast(c_int, locIndex),
        @bitCast(raylib.Texture, texture),
    );
}

/// Unload shader from GPU memory (VRAM)
pub fn UnloadShader(
    shader: Shader,
) void {
    raylib.UnloadShader(
        @bitCast(raylib.Shader, shader),
    );
}

/// Get a ray trace from mouse position
pub fn GetMouseRay(
    mousePosition: Vector2,
    camera: Camera,
) Ray {
    return raylib.GetMouseRay(
        @bitCast(raylib.Vector2, mousePosition),
        @bitCast(raylib.Camera, camera),
    );
}

/// Get camera transform matrix (view matrix)
pub fn GetCameraMatrix(
    camera: Camera,
) Matrix {
    return raylib.GetCameraMatrix(
        @bitCast(raylib.Camera, camera),
    );
}

/// Get camera 2d transform matrix
pub fn GetCameraMatrix2D(
    camera: Camera2D,
) Matrix {
    return raylib.GetCameraMatrix2D(
        @bitCast(raylib.Camera2D, camera),
    );
}

/// Get the screen space position for a 3d world space position
pub fn GetWorldToScreen(
    position: Vector3,
    camera: Camera,
) Vector2 {
    return raylib.GetWorldToScreen(
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Camera, camera),
    );
}

/// Get size position for a 3d world space position
pub fn GetWorldToScreenEx(
    position: Vector3,
    camera: Camera,
    width: i32,
    height: i32,
) Vector2 {
    return raylib.GetWorldToScreenEx(
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Camera, camera),
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

/// Get the screen space position for a 2d camera world space position
pub fn GetWorldToScreen2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {
    return raylib.GetWorldToScreen2D(
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Camera2D, camera),
    );
}

/// Get the world space position for a 2d camera screen space position
pub fn GetScreenToWorld2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {
    return @bitCast(Vector2, raylib.GetScreenToWorld2D(
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Camera2D, camera),
    ));
}

/// Set target FPS (maximum)
pub fn SetTargetFPS(
    fps: i32,
) void {
    raylib.SetTargetFPS(
        @intCast(c_int, fps),
    );
}

/// Get current FPS
pub fn GetFPS() i32 {
    return raylib.GetFPS();
}

/// Get time in seconds for last frame drawn (delta time)
pub fn GetFrameTime() f32 {
    return raylib.GetFrameTime();
}

/// Get elapsed time in seconds since InitWindow()
pub fn GetTime() f64 {
    return raylib.GetTime();
}

/// Get a random value between min and max (both included)
pub fn GetRandomValue(
    min: i32,
    max: i32,
) i32 {
    return raylib.GetRandomValue(
        @intCast(c_int, min),
        @intCast(c_int, max),
    );
}

/// Set the seed for the random number generator
pub fn SetRandomSeed(
    seed: u32,
) void {
    raylib.SetRandomSeed(
        @intCast(c_uint, seed),
    );
}

/// Takes a screenshot of current screen (filename extension defines format)
pub fn TakeScreenshot(
    fileName: [:0]const u8,
) void {
    raylib.TakeScreenshot(
        fileName,
    );
}

/// Setup init configuration flags (view FLAGS)
pub fn SetConfigFlags(
    flags: u32,
) void {
    raylib.SetConfigFlags(
        @intCast(c_uint, flags),
    );
}

/// Set the current threshold (minimum) log level
pub fn SetTraceLogLevel(
    logLevel: i32,
) void {
    raylib.SetTraceLogLevel(
        @intCast(c_int, logLevel),
    );
}

/// Internal memory allocator
pub fn MemAlloc(
    size: i32,
) *anyopaque {
    return raylib.MemAlloc(
        @intCast(c_int, size),
    );
}

/// Internal memory reallocator
pub fn MemRealloc(
    ptr: *anyopaque,
    size: i32,
) *anyopaque {
    return raylib.MemRealloc(
        @bitCast(*anyopaque, ptr),
        @intCast(c_int, size),
    );
}

/// Internal memory free
pub fn MemFree(
    ptr: *anyopaque,
) void {
    raylib.MemFree(
        @bitCast(*anyopaque, ptr),
    );
}

/// Set custom trace log
pub fn SetTraceLogCallback(
    callback: TraceLogCallback,
) void {
    raylib.SetTraceLogCallback(
        @bitCast(raylib.TraceLogCallback, callback),
    );
}

/// Set custom file binary data loader
pub fn SetLoadFileDataCallback(
    callback: LoadFileDataCallback,
) void {
    raylib.SetLoadFileDataCallback(
        @bitCast(raylib.LoadFileDataCallback, callback),
    );
}

/// Set custom file binary data saver
pub fn SetSaveFileDataCallback(
    callback: SaveFileDataCallback,
) void {
    raylib.SetSaveFileDataCallback(
        @bitCast(raylib.SaveFileDataCallback, callback),
    );
}

/// Set custom file text data loader
pub fn SetLoadFileTextCallback(
    callback: LoadFileTextCallback,
) void {
    raylib.SetLoadFileTextCallback(
        @bitCast(raylib.LoadFileTextCallback, callback),
    );
}

/// Set custom file text data saver
pub fn SetSaveFileTextCallback(
    callback: SaveFileTextCallback,
) void {
    raylib.SetSaveFileTextCallback(
        @bitCast(raylib.SaveFileTextCallback, callback),
    );
}

/// Save data to file from byte array (write), returns true on success
pub fn SaveFileData(
    fileName: [:0]const u8,
    data: *anyopaque,
    bytesToWrite: u32,
) bool {
    return raylib.SaveFileData(
        fileName,
        @bitCast(*anyopaque, data),
        @intCast(c_uint, bytesToWrite),
    );
}

/// Load text data from file (read), returns a '\0' terminated string
pub fn LoadFileText(
    fileName: [:0]const u8,
) [:0]const u8 {
    return raylib.LoadFileText(
        fileName,
    );
}

/// Unload file text data allocated by LoadFileText()
pub fn UnloadFileText(
    text: [:0]const u8,
) void {
    raylib.UnloadFileText(
        text,
    );
}

/// Save text data to file (write), string must be '\0' terminated, returns true on success
pub fn SaveFileText(
    fileName: [:0]const u8,
    text: [:0]const u8,
) bool {
    return raylib.SaveFileText(
        fileName,
        text,
    );
}

/// Check if file exists
pub fn FileExists(
    fileName: [:0]const u8,
) bool {
    return raylib.FileExists(
        fileName,
    );
}

/// Check if a directory path exists
pub fn DirectoryExists(
    dirPath: [:0]const u8,
) bool {
    return raylib.DirectoryExists(
        dirPath,
    );
}

/// Check file extension (including point: .png, .wav)
pub fn IsFileExtension(
    fileName: [:0]const u8,
    ext: [:0]const u8,
) bool {
    return raylib.IsFileExtension(
        fileName,
        ext,
    );
}

/// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub fn GetFileLength(
    fileName: [:0]const u8,
) i32 {
    return raylib.GetFileLength(
        fileName,
    );
}

/// Get pointer to extension for a filename string (includes dot: '.png')
pub fn GetFileExtension(
    fileName: [:0]const u8,
) [:0]const u8 {
    return raylib.GetFileExtension(
        fileName,
    );
}

/// Get pointer to filename for a path string
pub fn GetFileName(
    filePath: [:0]const u8,
) [:0]const u8 {
    return raylib.GetFileName(
        filePath,
    );
}

/// Get filename string without extension (uses static string)
pub fn GetFileNameWithoutExt(
    filePath: [:0]const u8,
) [:0]const u8 {
    return raylib.GetFileNameWithoutExt(
        filePath,
    );
}

/// Get full path for a given fileName with path (uses static string)
pub fn GetDirectoryPath(
    filePath: [:0]const u8,
) [:0]const u8 {
    return raylib.GetDirectoryPath(
        filePath,
    );
}

/// Get previous directory path for a given path (uses static string)
pub fn GetPrevDirectoryPath(
    dirPath: [:0]const u8,
) [:0]const u8 {
    return raylib.GetPrevDirectoryPath(
        dirPath,
    );
}

/// Get current working directory (uses static string)
pub fn GetWorkingDirectory() [:0]const u8 {
    return raylib.GetWorkingDirectory();
}

/// Get the directory if the running application (uses static string)
pub fn GetApplicationDirectory() [:0]const u8 {
    return raylib.GetApplicationDirectory();
}

/// Get filenames in a directory path (memory should be freed)
pub fn GetDirectoryFiles(
    dirPath: [:0]const u8,
    count: []i32,
) [*c][:0]const u8 {
    return raylib.GetDirectoryFiles(
        dirPath,
        @ptrCast([*c]c_int, count.ptr),
    );
}

/// Clear directory files paths buffers (free memory)
pub fn ClearDirectoryFiles() void {
    raylib.ClearDirectoryFiles();
}

/// Change working directory, return true on success
pub fn ChangeDirectory(
    dir: [:0]const u8,
) bool {
    return raylib.ChangeDirectory(
        dir,
    );
}

/// Check if a file has been dropped into window
pub fn IsFileDropped() bool {
    return raylib.IsFileDropped();
}

/// Get dropped files names (memory should be freed)
pub fn GetDroppedFiles(
    count: []i32,
) [*c][:0]const u8 {
    return raylib.GetDroppedFiles(
        @ptrCast([*c]c_int, count.ptr),
    );
}

/// Clear dropped files paths buffer (free memory)
pub fn ClearDroppedFiles() void {
    raylib.ClearDroppedFiles();
}

/// Get file modification time (last write time)
pub fn GetFileModTime(
    fileName: [:0]const u8,
) i64 {
    return raylib.GetFileModTime(
        fileName,
    );
}

/// Compress data (DEFLATE algorithm)
pub fn CompressData(
    data: [:0]const u8,
    dataSize: i32,
    compDataSize: []i32,
) [:0]const u8 {
    return raylib.CompressData(
        data,
        @intCast(c_int, dataSize),
        @ptrCast([*c]c_int, compDataSize.ptr),
    );
}

/// Decompress data (DEFLATE algorithm)
pub fn DecompressData(
    compData: [:0]const u8,
    compDataSize: i32,
    dataSize: []i32,
) [:0]const u8 {
    return raylib.DecompressData(
        compData,
        @intCast(c_int, compDataSize),
        @ptrCast([*c]c_int, dataSize.ptr),
    );
}

/// Encode data to Base64 string
pub fn EncodeDataBase64(
    data: [:0]const u8,
    dataSize: i32,
    outputSize: []i32,
) [:0]const u8 {
    return raylib.EncodeDataBase64(
        data,
        @intCast(c_int, dataSize),
        @ptrCast([*c]c_int, outputSize.ptr),
    );
}

/// Decode Base64 string data
pub fn DecodeDataBase64(
    data: [:0]const u8,
    outputSize: []i32,
) [:0]const u8 {
    return raylib.DecodeDataBase64(
        data,
        @ptrCast([*c]c_int, outputSize.ptr),
    );
}

/// Save integer value to storage file (to defined position), returns true on success
pub fn SaveStorageValue(
    position: u32,
    value: i32,
) bool {
    return raylib.SaveStorageValue(
        @intCast(c_uint, position),
        @intCast(c_int, value),
    );
}

/// Load integer value from storage file (from defined position)
pub fn LoadStorageValue(
    position: u32,
) i32 {
    return raylib.LoadStorageValue(
        @intCast(c_uint, position),
    );
}

/// Open URL with default system browser (if available)
pub fn OpenURL(
    url: [:0]const u8,
) void {
    raylib.OpenURL(
        url,
    );
}

/// Check if a key has been pressed once
pub fn IsKeyPressed(
    key: i32,
) bool {
    return raylib.IsKeyPressed(
        @intCast(c_int, key),
    );
}

/// Check if a key is being pressed
pub fn IsKeyDown(
    key: i32,
) bool {
    return raylib.IsKeyDown(
        @intCast(c_int, key),
    );
}

/// Check if a key has been released once
pub fn IsKeyReleased(
    key: i32,
) bool {
    return raylib.IsKeyReleased(
        @intCast(c_int, key),
    );
}

/// Check if a key is NOT being pressed
pub fn IsKeyUp(
    key: i32,
) bool {
    return raylib.IsKeyUp(
        @intCast(c_int, key),
    );
}

/// Set a custom key to exit program (default is ESC)
pub fn SetExitKey(
    key: i32,
) void {
    raylib.SetExitKey(
        @intCast(c_int, key),
    );
}

/// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
pub fn GetKeyPressed() i32 {
    return raylib.GetKeyPressed();
}

/// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
pub fn GetCharPressed() i32 {
    return raylib.GetCharPressed();
}

/// Check if a gamepad is available
pub fn IsGamepadAvailable(
    gamepad: i32,
) bool {
    return raylib.IsGamepadAvailable(
        @intCast(c_int, gamepad),
    );
}

/// Get gamepad internal name id
pub fn GetGamepadName(
    gamepad: i32,
) [:0]const u8 {
    return raylib.GetGamepadName(
        @intCast(c_int, gamepad),
    );
}

/// Check if a gamepad button has been pressed once
pub fn IsGamepadButtonPressed(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.IsGamepadButtonPressed(
        @intCast(c_int, gamepad),
        @intCast(c_int, button),
    );
}

/// Check if a gamepad button is being pressed
pub fn IsGamepadButtonDown(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.IsGamepadButtonDown(
        @intCast(c_int, gamepad),
        @intCast(c_int, button),
    );
}

/// Check if a gamepad button has been released once
pub fn IsGamepadButtonReleased(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.IsGamepadButtonReleased(
        @intCast(c_int, gamepad),
        @intCast(c_int, button),
    );
}

/// Check if a gamepad button is NOT being pressed
pub fn IsGamepadButtonUp(
    gamepad: i32,
    button: i32,
) bool {
    return raylib.IsGamepadButtonUp(
        @intCast(c_int, gamepad),
        @intCast(c_int, button),
    );
}

/// Get the last gamepad button pressed
pub fn GetGamepadButtonPressed() i32 {
    return raylib.GetGamepadButtonPressed();
}

/// Get gamepad axis count for a gamepad
pub fn GetGamepadAxisCount(
    gamepad: i32,
) i32 {
    return raylib.GetGamepadAxisCount(
        @intCast(c_int, gamepad),
    );
}

/// Get axis movement value for a gamepad axis
pub fn GetGamepadAxisMovement(
    gamepad: i32,
    axis: i32,
) f32 {
    return raylib.GetGamepadAxisMovement(
        @intCast(c_int, gamepad),
        @intCast(c_int, axis),
    );
}

/// Set internal gamepad mappings (SDL_GameControllerDB)
pub fn SetGamepadMappings(
    mappings: [:0]const u8,
) i32 {
    return raylib.SetGamepadMappings(
        mappings,
    );
}

/// Check if a mouse button has been pressed once
pub fn IsMouseButtonPressed(
    button: i32,
) bool {
    return raylib.IsMouseButtonPressed(
        @intCast(c_int, button),
    );
}

/// Check if a mouse button is being pressed
pub fn IsMouseButtonDown(
    button: i32,
) bool {
    return raylib.IsMouseButtonDown(
        @intCast(c_int, button),
    );
}

/// Check if a mouse button has been released once
pub fn IsMouseButtonReleased(
    button: i32,
) bool {
    return raylib.IsMouseButtonReleased(
        @intCast(c_int, button),
    );
}

/// Check if a mouse button is NOT being pressed
pub fn IsMouseButtonUp(
    button: i32,
) bool {
    return raylib.IsMouseButtonUp(
        @intCast(c_int, button),
    );
}

/// Get mouse position X
pub fn GetMouseX() i32 {
    return raylib.GetMouseX();
}

/// Get mouse position Y
pub fn GetMouseY() i32 {
    return raylib.GetMouseY();
}

/// Get mouse position XY
pub fn GetMousePosition() Vector2 {
    var v2 = raylib.GetMousePosition();
    var res = @bitCast(Vector2, v2);
    std.debug.assert(@sizeOf(@TypeOf(res)) == @sizeOf(@TypeOf(v2)));
    std.debug.assert(v2.x == res.x);
    std.debug.assert(v2.y == res.y);
    return res;
    // return @bitCast(Vector2, raylib.GetMousePosition());
}

/// Get mouse delta between frames
pub fn GetMouseDelta() Vector2 {
    return @bitCast(Vector2, raylib.GetMouseDelta());
}

/// Set mouse position XY
pub fn SetMousePosition(
    x: i32,
    y: i32,
) void {
    raylib.SetMousePosition(
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}

/// Set mouse offset
pub fn SetMouseOffset(
    offsetX: i32,
    offsetY: i32,
) void {
    raylib.SetMouseOffset(
        @intCast(c_int, offsetX),
        @intCast(c_int, offsetY),
    );
}

/// Set mouse scaling
pub fn SetMouseScale(
    scaleX: f32,
    scaleY: f32,
) void {
    raylib.SetMouseScale(
        @bitCast(f32, scaleX),
        @bitCast(f32, scaleY),
    );
}

/// Get mouse wheel movement Y
pub fn GetMouseWheelMove() f32 {
    return raylib.GetMouseWheelMove();
}

/// Set mouse cursor
pub fn SetMouseCursor(
    cursor: i32,
) void {
    raylib.SetMouseCursor(
        @intCast(c_int, cursor),
    );
}

/// Get touch position X for touch point 0 (relative to screen size)
pub fn GetTouchX() i32 {
    return raylib.GetTouchX();
}

/// Get touch position Y for touch point 0 (relative to screen size)
pub fn GetTouchY() i32 {
    return raylib.GetTouchY();
}

/// Get touch position XY for a touch point index (relative to screen size)
pub fn GetTouchPosition(
    index: i32,
) Vector2 {
    return @bitCast(Vector2, raylib.GetTouchPosition(
        @intCast(c_int, index),
    ));
}

/// Get touch point identifier for given index
pub fn GetTouchPointId(
    index: i32,
) i32 {
    return raylib.GetTouchPointId(
        @intCast(c_int, index),
    );
}

/// Get number of touch points
pub fn GetTouchPointCount() i32 {
    return raylib.GetTouchPointCount();
}

/// Enable a set of gestures using flags
pub fn SetGesturesEnabled(
    flags: u32,
) void {
    raylib.SetGesturesEnabled(
        @intCast(c_uint, flags),
    );
}

/// Check if a gesture have been detected
pub fn IsGestureDetected(
    gesture: i32,
) bool {
    return raylib.IsGestureDetected(
        @intCast(c_int, gesture),
    );
}

/// Get latest detected gesture
pub fn GetGestureDetected() i32 {
    return raylib.GetGestureDetected();
}

/// Get gesture hold time in milliseconds
pub fn GetGestureHoldDuration() f32 {
    return raylib.GetGestureHoldDuration();
}

/// Get gesture drag vector
pub fn GetGestureDragVector() Vector2 {
    return @bitCast(Vector2, raylib.GetGestureDragVector());
}

/// Get gesture drag angle
pub fn GetGestureDragAngle() f32 {
    return raylib.GetGestureDragAngle();
}

/// Get gesture pinch delta
pub fn GetGesturePinchVector() Vector2 {
    return raylib.GetGesturePinchVector();
}

/// Get gesture pinch angle
pub fn GetGesturePinchAngle() f32 {
    return raylib.GetGesturePinchAngle();
}

/// Set camera mode (multiple camera modes available)
pub fn SetCameraMode(
    camera: Camera,
    mode: i32,
) void {
    raylib.SetCameraMode(
        @bitCast(raylib.Camera, camera),
        @intCast(c_int, mode),
    );
}

/// Update camera position for selected mode
pub fn UpdateCamera(
    camera: *Camera,
) void {
    raylib.UpdateCamera(
        @ptrCast([*c]raylib.Camera, camera),
    );
}

/// Set camera pan key to combine with mouse movement (free camera)
pub fn SetCameraPanControl(
    keyPan: i32,
) void {
    raylib.SetCameraPanControl(
        @intCast(c_int, keyPan),
    );
}

/// Set camera alt key to combine with mouse movement (free camera)
pub fn SetCameraAltControl(
    keyAlt: i32,
) void {
    raylib.SetCameraAltControl(
        @intCast(c_int, keyAlt),
    );
}

/// Set camera smooth zoom key to combine with mouse (free camera)
pub fn SetCameraSmoothZoomControl(
    keySmoothZoom: i32,
) void {
    raylib.SetCameraSmoothZoomControl(
        @intCast(c_int, keySmoothZoom),
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
    raylib.SetCameraMoveControls(
        @intCast(c_int, keyFront),
        @intCast(c_int, keyBack),
        @intCast(c_int, keyRight),
        @intCast(c_int, keyLeft),
        @intCast(c_int, keyUp),
        @intCast(c_int, keyDown),
    );
}

/// Set texture and rectangle to be used on shapes drawing
pub fn SetShapesTexture(
    texture: Texture,
    source: Rectangle,
) void {
    raylib.SetShapesTexture(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, source),
    );
}

/// Draw a pixel
pub fn DrawPixel(
    posX: i32,
    posY: i32,
    color: Color,
) void {
    raylib.DrawPixel(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a pixel (Vector version)
pub fn DrawPixelV(
    position: Vector2,
    color: Color,
) void {
    raylib.DrawPixelV(
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Color, color),
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
    raylib.DrawLine(
        @intCast(c_int, startPosX),
        @intCast(c_int, startPosY),
        @intCast(c_int, endPosX),
        @intCast(c_int, endPosY),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a line (Vector version)
pub fn DrawLineV(
    startPos: Vector2,
    endPos: Vector2,
    color: Color,
) void {
    raylib.DrawLineV(
        @bitCast(raylib.Vector2, startPos),
        @bitCast(raylib.Vector2, endPos),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a line defining thickness
pub fn DrawLineEx(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.DrawLineEx(
        @bitCast(raylib.Vector2, startPos),
        @bitCast(raylib.Vector2, endPos),
        @bitCast(f32, thick),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a line using cubic-bezier curves in-out
pub fn DrawLineBezier(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    raylib.DrawLineBezier(
        @bitCast(raylib.Vector2, startPos),
        @bitCast(raylib.Vector2, endPos),
        @bitCast(f32, thick),
        @bitCast(raylib.Color, color),
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
    raylib.DrawLineBezierQuad(
        @bitCast(raylib.Vector2, startPos),
        @bitCast(raylib.Vector2, endPos),
        @bitCast(raylib.Vector2, controlPos),
        @bitCast(f32, thick),
        @bitCast(raylib.Color, color),
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
    raylib.DrawLineBezierCubic(
        @bitCast(raylib.Vector2, startPos),
        @bitCast(raylib.Vector2, endPos),
        @bitCast(raylib.Vector2, startControlPos),
        @bitCast(raylib.Vector2, endControlPos),
        @bitCast(f32, thick),
        @bitCast(raylib.Color, color),
    );
}

/// Draw lines sequence
pub fn DrawLineStrip(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawLineStrip(
        @ptrCast([*c]raylib.Vector2, points),
        @intCast(c_int, pointCount),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a color-filled circle
pub fn DrawCircle(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {
    raylib.DrawCircle(
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @bitCast(f32, radius),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCircleSector(
        @bitCast(raylib.Vector2, center),
        @bitCast(f32, radius),
        @bitCast(f32, startAngle),
        @bitCast(f32, endAngle),
        @intCast(c_int, segments),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCircleSectorLines(
        @bitCast(raylib.Vector2, center),
        @bitCast(f32, radius),
        @bitCast(f32, startAngle),
        @bitCast(f32, endAngle),
        @intCast(c_int, segments),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCircleGradient(
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @bitCast(f32, radius),
        @bitCast(raylib.Color, color1),
        @bitCast(raylib.Color, color2),
    );
}

/// Draw a color-filled circle (Vector version)
pub fn DrawCircleV(
    center: Vector2,
    radius: f32,
    color: Color,
) void {
    raylib.DrawCircleV(
        @bitCast(raylib.Vector2, center),
        @bitCast(f32, radius),
        @bitCast(raylib.Color, color),
    );
}

/// Draw circle outline
pub fn DrawCircleLines(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {
    raylib.DrawCircleLines(
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @bitCast(f32, radius),
        @bitCast(raylib.Color, color),
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
    raylib.DrawEllipse(
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @bitCast(f32, radiusH),
        @bitCast(f32, radiusV),
        @bitCast(raylib.Color, color),
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
    raylib.DrawEllipseLines(
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @bitCast(f32, radiusH),
        @bitCast(f32, radiusV),
        @bitCast(raylib.Color, color),
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
    raylib.DrawRing(
        @bitCast(raylib.Vector2, center),
        @bitCast(f32, innerRadius),
        @bitCast(f32, outerRadius),
        @bitCast(f32, startAngle),
        @bitCast(f32, endAngle),
        @intCast(c_int, segments),
        @bitCast(raylib.Color, color),
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
    raylib.DrawRingLines(
        @bitCast(raylib.Vector2, center),
        @bitCast(f32, innerRadius),
        @bitCast(f32, outerRadius),
        @bitCast(f32, startAngle),
        @bitCast(f32, endAngle),
        @intCast(c_int, segments),
        @bitCast(raylib.Color, color),
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
    raylib.DrawRectangle(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a color-filled rectangle (Vector version)
pub fn DrawRectangleV(
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    raylib.DrawRectangleV(
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Vector2, size),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a color-filled rectangle
pub fn DrawRectangleRec(
    rec: Rectangle,
    color: Color,
) void {
    raylib.DrawRectangleRec(
        @bitCast(raylib.Rectangle, rec),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a color-filled rectangle with pro parameters
pub fn DrawRectanglePro(
    rec: Rectangle,
    origin: Vector2,
    rotation: f32,
    color: Color,
) void {
    raylib.DrawRectanglePro(
        @bitCast(raylib.Rectangle, rec),
        @bitCast(raylib.Vector2, origin),
        @bitCast(f32, rotation),
        @bitCast(raylib.Color, color),
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
    raylib.DrawRectangleGradientV(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, color1),
        @bitCast(raylib.Color, color2),
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
    raylib.DrawRectangleGradientH(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, color1),
        @bitCast(raylib.Color, color2),
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
    raylib.DrawRectangleGradientEx(
        @bitCast(raylib.Rectangle, rec),
        @bitCast(raylib.Color, col1),
        @bitCast(raylib.Color, col2),
        @bitCast(raylib.Color, col3),
        @bitCast(raylib.Color, col4),
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
    raylib.DrawRectangleLines(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, color),
    );
}

/// Draw rectangle outline with extended parameters
pub fn DrawRectangleLinesEx(
    rec: Rectangle,
    lineThick: f32,
    color: Color,
) void {
    raylib.DrawRectangleLinesEx(
        @bitCast(raylib.Rectangle, rec),
        @bitCast(f32, lineThick),
        @bitCast(raylib.Color, color),
    );
}

/// Draw rectangle with rounded edges
pub fn DrawRectangleRounded(
    rec: Rectangle,
    roundness: f32,
    segments: i32,
    color: Color,
) void {
    raylib.DrawRectangleRounded(
        @bitCast(raylib.Rectangle, rec),
        @bitCast(f32, roundness),
        @intCast(c_int, segments),
        @bitCast(raylib.Color, color),
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
    raylib.DrawRectangleRoundedLines(
        @bitCast(raylib.Rectangle, rec),
        @bitCast(f32, roundness),
        @intCast(c_int, segments),
        @bitCast(f32, lineThick),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {
    raylib.DrawTriangle(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
        @bitCast(raylib.Vector2, v3),
        @bitCast(raylib.Color, color),
    );
}

/// Draw triangle outline (vertex in counter-clockwise order!)
pub fn DrawTriangleLines(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {
    raylib.DrawTriangleLines(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
        @bitCast(raylib.Vector2, v3),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a triangle fan defined by points (first vertex is the center)
pub fn DrawTriangleFan(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawTriangleFan(
        @ptrCast([*c]raylib.Vector2, points),
        @intCast(c_int, pointCount),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawTriangleStrip(
        @ptrCast([*c]raylib.Vector2, points),
        @intCast(c_int, pointCount),
        @bitCast(raylib.Color, color),
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
    raylib.DrawPoly(
        @bitCast(raylib.Vector2, center),
        @intCast(c_int, sides),
        @bitCast(f32, radius),
        @bitCast(f32, rotation),
        @bitCast(raylib.Color, color),
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
    raylib.DrawPolyLines(
        @bitCast(raylib.Vector2, center),
        @intCast(c_int, sides),
        @bitCast(f32, radius),
        @bitCast(f32, rotation),
        @bitCast(raylib.Color, color),
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
    raylib.DrawPolyLinesEx(
        @bitCast(raylib.Vector2, center),
        @intCast(c_int, sides),
        @bitCast(f32, radius),
        @bitCast(f32, rotation),
        @bitCast(f32, lineThick),
        @bitCast(raylib.Color, color),
    );
}

/// Check collision between two rectangles
pub fn CheckCollisionRecs(
    rec1: Rectangle,
    rec2: Rectangle,
) bool {
    return raylib.CheckCollisionRecs(
        @bitCast(raylib.Rectangle, rec1),
        @bitCast(raylib.Rectangle, rec2),
    );
}

/// Check collision between two circles
pub fn CheckCollisionCircles(
    center1: Vector2,
    radius1: f32,
    center2: Vector2,
    radius2: f32,
) bool {
    return raylib.CheckCollisionCircles(
        @bitCast(raylib.Vector2, center1),
        @bitCast(f32, radius1),
        @bitCast(raylib.Vector2, center2),
        @bitCast(f32, radius2),
    );
}

/// Check collision between circle and rectangle
pub fn CheckCollisionCircleRec(
    center: Vector2,
    radius: f32,
    rec: Rectangle,
) bool {
    return raylib.CheckCollisionCircleRec(
        @bitCast(raylib.Vector2, center),
        @bitCast(f32, radius),
        @bitCast(raylib.Rectangle, rec),
    );
}

/// Check if point is inside rectangle
pub fn CheckCollisionPointRec(
    point: Vector2,
    rec: Rectangle,
) bool {
    return raylib.CheckCollisionPointRec(
        @bitCast(raylib.Vector2, point),
        @bitCast(raylib.Rectangle, rec),
    );
}

/// Check if point is inside circle
pub fn CheckCollisionPointCircle(
    point: Vector2,
    center: Vector2,
    radius: f32,
) bool {
    return raylib.CheckCollisionPointCircle(
        @bitCast(raylib.Vector2, point),
        @bitCast(raylib.Vector2, center),
        @bitCast(f32, radius),
    );
}

/// Check if point is inside a triangle
pub fn CheckCollisionPointTriangle(
    point: Vector2,
    p1: Vector2,
    p2: Vector2,
    p3: Vector2,
) bool {
    return raylib.CheckCollisionPointTriangle(
        @bitCast(raylib.Vector2, point),
        @bitCast(raylib.Vector2, p1),
        @bitCast(raylib.Vector2, p2),
        @bitCast(raylib.Vector2, p3),
    );
}

/// Check the collision between two lines defined by two points each, returns collision point by reference
pub fn CheckCollisionLines(
    startPos1: Vector2,
    endPos1: Vector2,
    startPos2: Vector2,
    endPos2: Vector2,
    collisionPoint: *Vector2,
) bool {
    return raylib.CheckCollisionLines(
        @bitCast(raylib.Vector2, startPos1),
        @bitCast(raylib.Vector2, endPos1),
        @bitCast(raylib.Vector2, startPos2),
        @bitCast(raylib.Vector2, endPos2),
        @ptrCast([*c]raylib.Vector2, collisionPoint),
    );
}

/// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub fn CheckCollisionPointLine(
    point: Vector2,
    p1: Vector2,
    p2: Vector2,
    threshold: i32,
) bool {
    return raylib.CheckCollisionPointLine(
        @bitCast(raylib.Vector2, point),
        @bitCast(raylib.Vector2, p1),
        @bitCast(raylib.Vector2, p2),
        @intCast(c_int, threshold),
    );
}

/// Get collision rectangle for two rectangles collision
pub fn GetCollisionRec(
    rec1: Rectangle,
    rec2: Rectangle,
) Rectangle {
    return raylib.GetCollisionRec(
        @bitCast(raylib.Rectangle, rec1),
        @bitCast(raylib.Rectangle, rec2),
    );
}

/// Load image from file into CPU memory (RAM)
pub fn LoadImage(
    fileName: [:0]const u8,
) Image {
    return raylib.LoadImage(
        fileName,
    );
}

/// Load image from RAW file data
pub fn LoadImageRaw(
    fileName: [:0]const u8,
    width: i32,
    height: i32,
    format: i32,
    headerSize: i32,
) Image {
    return raylib.LoadImageRaw(
        fileName,
        @intCast(c_int, width),
        @intCast(c_int, height),
        @intCast(c_int, format),
        @intCast(c_int, headerSize),
    );
}

/// Load image sequence from file (frames appended to image.data)
pub fn LoadImageAnim(
    fileName: [:0]const u8,
    frames: []i32,
) Image {
    return raylib.LoadImageAnim(
        fileName,
        @ptrCast([*c]c_int, frames.ptr),
    );
}

/// Load image from memory buffer, fileType refers to extension: i.e. '.png'
pub fn LoadImageFromMemory(
    fileType: [:0]const u8,
    fileData: [:0]const u8,
    dataSize: i32,
) Image {
    return raylib.LoadImageFromMemory(
        fileType,
        fileData,
        @intCast(c_int, dataSize),
    );
}

/// Load image from GPU texture data
pub fn LoadImageFromTexture(
    texture: Texture,
) Image {
    return raylib.LoadImageFromTexture(
        @bitCast(raylib.Texture, texture),
    );
}

/// Load image from screen buffer and (screenshot)
pub fn LoadImageFromScreen() Image {
    return raylib.LoadImageFromScreen();
}

/// Unload image from CPU memory (RAM)
pub fn UnloadImage(
    image: Image,
) void {
    raylib.UnloadImage(
        @bitCast(raylib.Image, image),
    );
}

/// Export image data to file, returns true on success
pub fn ExportImage(
    image: Image,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportImage(
        @bitCast(raylib.Image, image),
        fileName,
    );
}

/// Export image as code file defining an array of bytes, returns true on success
pub fn ExportImageAsCode(
    image: Image,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportImageAsCode(
        @bitCast(raylib.Image, image),
        fileName,
    );
}

/// Generate image: plain color
pub fn GenImageColor(
    width: i32,
    height: i32,
    color: Color,
) Image {
    return raylib.GenImageColor(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, color),
    );
}

/// Generate image: vertical gradient
pub fn GenImageGradientV(
    width: i32,
    height: i32,
    top: Color,
    bottom: Color,
) Image {
    return raylib.GenImageGradientV(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, top),
        @bitCast(raylib.Color, bottom),
    );
}

/// Generate image: horizontal gradient
pub fn GenImageGradientH(
    width: i32,
    height: i32,
    left: Color,
    right: Color,
) Image {
    return raylib.GenImageGradientH(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, left),
        @bitCast(raylib.Color, right),
    );
}

/// Generate image: radial gradient
pub fn GenImageGradientRadial(
    width: i32,
    height: i32,
    density: f32,
    inner: Color,
    outer: Color,
) Image {
    return raylib.GenImageGradientRadial(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(f32, density),
        @bitCast(raylib.Color, inner),
        @bitCast(raylib.Color, outer),
    );
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
    return raylib.GenImageChecked(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @intCast(c_int, checksX),
        @intCast(c_int, checksY),
        @bitCast(raylib.Color, col1),
        @bitCast(raylib.Color, col2),
    );
}

/// Generate image: white noise
pub fn GenImageWhiteNoise(
    width: i32,
    height: i32,
    factor: f32,
) Image {
    return raylib.GenImageWhiteNoise(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(f32, factor),
    );
}

/// Generate image: cellular algorithm, bigger tileSize means bigger cells
pub fn GenImageCellular(
    width: i32,
    height: i32,
    tileSize: i32,
) Image {
    return raylib.GenImageCellular(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @intCast(c_int, tileSize),
    );
}

/// Create an image duplicate (useful for transformations)
pub fn ImageCopy(
    image: Image,
) Image {
    return raylib.ImageCopy(
        @bitCast(raylib.Image, image),
    );
}

/// Create an image from another image piece
pub fn ImageFromImage(
    image: Image,
    rec: Rectangle,
) Image {
    return raylib.ImageFromImage(
        @bitCast(raylib.Image, image),
        @bitCast(raylib.Rectangle, rec),
    );
}

/// Create an image from text (default font)
pub fn ImageText(
    text: [:0]const u8,
    fontSize: i32,
    color: Color,
) Image {
    return raylib.ImageText(
        text,
        @intCast(c_int, fontSize),
        @bitCast(raylib.Color, color),
    );
}

/// Create an image from text (custom sprite font)
pub fn ImageTextEx(
    font: Font,
    text: [:0]const u8,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) Image {
    return raylib.ImageTextEx(
        @bitCast(raylib.Font, font),
        text,
        @bitCast(f32, fontSize),
        @bitCast(f32, spacing),
        @bitCast(raylib.Color, tint),
    );
}

/// Convert image data to desired format
pub fn ImageFormat(
    image: *Image,
    newFormat: i32,
) void {
    raylib.ImageFormat(
        @ptrCast([*c]raylib.Image, image),
        @intCast(c_int, newFormat),
    );
}

/// Convert image to POT (power-of-two)
pub fn ImageToPOT(
    image: *Image,
    fill: Color,
) void {
    raylib.ImageToPOT(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(raylib.Color, fill),
    );
}

/// Crop an image to a defined rectangle
pub fn ImageCrop(
    image: *Image,
    crop: Rectangle,
) void {
    raylib.ImageCrop(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(raylib.Rectangle, crop),
    );
}

/// Crop image depending on alpha value
pub fn ImageAlphaCrop(
    image: *Image,
    threshold: f32,
) void {
    raylib.ImageAlphaCrop(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(f32, threshold),
    );
}

/// Clear alpha channel to desired color
pub fn ImageAlphaClear(
    image: *Image,
    color: Color,
    threshold: f32,
) void {
    raylib.ImageAlphaClear(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(raylib.Color, color),
        @bitCast(f32, threshold),
    );
}

/// Apply alpha mask to image
pub fn ImageAlphaMask(
    image: *Image,
    alphaMask: Image,
) void {
    raylib.ImageAlphaMask(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(raylib.Image, alphaMask),
    );
}

/// Premultiply alpha channel
pub fn ImageAlphaPremultiply(
    image: *Image,
) void {
    raylib.ImageAlphaPremultiply(
        @ptrCast([*c]raylib.Image, image),
    );
}

/// Resize image (Bicubic scaling algorithm)
pub fn ImageResize(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.ImageResize(
        @ptrCast([*c]raylib.Image, image),
        @intCast(c_int, newWidth),
        @intCast(c_int, newHeight),
    );
}

/// Resize image (Nearest-Neighbor scaling algorithm)
pub fn ImageResizeNN(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.ImageResizeNN(
        @ptrCast([*c]raylib.Image, image),
        @intCast(c_int, newWidth),
        @intCast(c_int, newHeight),
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
    raylib.ImageResizeCanvas(
        @ptrCast([*c]raylib.Image, image),
        @intCast(c_int, newWidth),
        @intCast(c_int, newHeight),
        @intCast(c_int, offsetX),
        @intCast(c_int, offsetY),
        @bitCast(raylib.Color, fill),
    );
}

/// Compute all mipmap levels for a provided image
pub fn ImageMipmaps(
    image: *Image,
) void {
    raylib.ImageMipmaps(
        @ptrCast([*c]raylib.Image, image),
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
    raylib.ImageDither(
        @ptrCast([*c]raylib.Image, image),
        @intCast(c_int, rBpp),
        @intCast(c_int, gBpp),
        @intCast(c_int, bBpp),
        @intCast(c_int, aBpp),
    );
}

/// Flip image vertically
pub fn ImageFlipVertical(
    image: *Image,
) void {
    raylib.ImageFlipVertical(
        @ptrCast([*c]raylib.Image, image),
    );
}

/// Flip image horizontally
pub fn ImageFlipHorizontal(
    image: *Image,
) void {
    raylib.ImageFlipHorizontal(
        @ptrCast([*c]raylib.Image, image),
    );
}

/// Rotate image clockwise 90deg
pub fn ImageRotateCW(
    image: *Image,
) void {
    raylib.ImageRotateCW(
        @ptrCast([*c]raylib.Image, image),
    );
}

/// Rotate image counter-clockwise 90deg
pub fn ImageRotateCCW(
    image: *Image,
) void {
    raylib.ImageRotateCCW(
        @ptrCast([*c]raylib.Image, image),
    );
}

/// Modify image color: tint
pub fn ImageColorTint(
    image: *Image,
    color: Color,
) void {
    raylib.ImageColorTint(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(raylib.Color, color),
    );
}

/// Modify image color: invert
pub fn ImageColorInvert(
    image: *Image,
) void {
    raylib.ImageColorInvert(
        @ptrCast([*c]raylib.Image, image),
    );
}

/// Modify image color: grayscale
pub fn ImageColorGrayscale(
    image: *Image,
) void {
    raylib.ImageColorGrayscale(
        @ptrCast([*c]raylib.Image, image),
    );
}

/// Modify image color: contrast (-100 to 100)
pub fn ImageColorContrast(
    image: *Image,
    contrast: f32,
) void {
    raylib.ImageColorContrast(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(f32, contrast),
    );
}

/// Modify image color: brightness (-255 to 255)
pub fn ImageColorBrightness(
    image: *Image,
    brightness: i32,
) void {
    raylib.ImageColorBrightness(
        @ptrCast([*c]raylib.Image, image),
        @intCast(c_int, brightness),
    );
}

/// Modify image color: replace color
pub fn ImageColorReplace(
    image: *Image,
    color: Color,
    replace: Color,
) void {
    raylib.ImageColorReplace(
        @ptrCast([*c]raylib.Image, image),
        @bitCast(raylib.Color, color),
        @bitCast(raylib.Color, replace),
    );
}

/// Load color data from image as a Color array (RGBA - 32bit)
pub fn LoadImageColors(
    image: Image,
) [*c]Color {
    return raylib.LoadImageColors(
        @bitCast(raylib.Image, image),
    );
}

/// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn LoadImagePalette(
    image: Image,
    maxPaletteSize: i32,
    colorCount: []i32,
) [*c]Color {
    return raylib.LoadImagePalette(
        @bitCast(raylib.Image, image),
        @intCast(c_int, maxPaletteSize),
        @ptrCast([*c]c_int, colorCount.ptr),
    );
}

/// Unload color data loaded with LoadImageColors()
pub fn UnloadImageColors(
    colors: *Color,
) void {
    raylib.UnloadImageColors(
        @ptrCast([*c]raylib.Color, colors),
    );
}

/// Unload colors palette loaded with LoadImagePalette()
pub fn UnloadImagePalette(
    colors: *Color,
) void {
    raylib.UnloadImagePalette(
        @ptrCast([*c]raylib.Color, colors),
    );
}

/// Get image alpha border rectangle
pub fn GetImageAlphaBorder(
    image: Image,
    threshold: f32,
) Rectangle {
    return raylib.GetImageAlphaBorder(
        @bitCast(raylib.Image, image),
        @bitCast(f32, threshold),
    );
}

/// Get image pixel color at (x, y) position
pub fn GetImageColor(
    image: Image,
    x: i32,
    y: i32,
) Color {
    return raylib.GetImageColor(
        @bitCast(raylib.Image, image),
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}

/// Clear image background with given color
pub fn ImageClearBackground(
    dst: *Image,
    color: Color,
) void {
    raylib.ImageClearBackground(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Color, color),
    );
}

/// Draw pixel within an image
pub fn ImageDrawPixel(
    dst: *Image,
    posX: i32,
    posY: i32,
    color: Color,
) void {
    raylib.ImageDrawPixel(
        @ptrCast([*c]raylib.Image, dst),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @bitCast(raylib.Color, color),
    );
}

/// Draw pixel within an image (Vector version)
pub fn ImageDrawPixelV(
    dst: *Image,
    position: Vector2,
    color: Color,
) void {
    raylib.ImageDrawPixelV(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Color, color),
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
    raylib.ImageDrawLine(
        @ptrCast([*c]raylib.Image, dst),
        @intCast(c_int, startPosX),
        @intCast(c_int, startPosY),
        @intCast(c_int, endPosX),
        @intCast(c_int, endPosY),
        @bitCast(raylib.Color, color),
    );
}

/// Draw line within an image (Vector version)
pub fn ImageDrawLineV(
    dst: *Image,
    start: Vector2,
    end: Vector2,
    color: Color,
) void {
    raylib.ImageDrawLineV(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Vector2, start),
        @bitCast(raylib.Vector2, end),
        @bitCast(raylib.Color, color),
    );
}

/// Draw circle within an image
pub fn ImageDrawCircle(
    dst: *Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: Color,
) void {
    raylib.ImageDrawCircle(
        @ptrCast([*c]raylib.Image, dst),
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @intCast(c_int, radius),
        @bitCast(raylib.Color, color),
    );
}

/// Draw circle within an image (Vector version)
pub fn ImageDrawCircleV(
    dst: *Image,
    center: Vector2,
    radius: i32,
    color: Color,
) void {
    raylib.ImageDrawCircleV(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Vector2, center),
        @intCast(c_int, radius),
        @bitCast(raylib.Color, color),
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
    raylib.ImageDrawRectangle(
        @ptrCast([*c]raylib.Image, dst),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, width),
        @intCast(c_int, height),
        @bitCast(raylib.Color, color),
    );
}

/// Draw rectangle within an image (Vector version)
pub fn ImageDrawRectangleV(
    dst: *Image,
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    raylib.ImageDrawRectangleV(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Vector2, size),
        @bitCast(raylib.Color, color),
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangleRec(
    dst: *Image,
    rec: Rectangle,
    color: Color,
) void {
    raylib.ImageDrawRectangleRec(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Rectangle, rec),
        @bitCast(raylib.Color, color),
    );
}

/// Draw rectangle lines within an image
pub fn ImageDrawRectangleLines(
    dst: *Image,
    rec: Rectangle,
    thick: i32,
    color: Color,
) void {
    raylib.ImageDrawRectangleLines(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Rectangle, rec),
        @intCast(c_int, thick),
        @bitCast(raylib.Color, color),
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
    raylib.ImageDraw(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Image, src),
        @bitCast(raylib.Rectangle, srcRec),
        @bitCast(raylib.Rectangle, dstRec),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw text (using default font) within an image (destination)
pub fn ImageDrawText(
    dst: *Image,
    text: [:0]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {
    raylib.ImageDrawText(
        @ptrCast([*c]raylib.Image, dst),
        text,
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, fontSize),
        @bitCast(raylib.Color, color),
    );
}

/// Draw text (custom sprite font) within an image (destination)
pub fn ImageDrawTextEx(
    dst: *Image,
    font: Font,
    text: [:0]const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.ImageDrawTextEx(
        @ptrCast([*c]raylib.Image, dst),
        @bitCast(raylib.Font, font),
        text,
        @bitCast(raylib.Vector2, position),
        @bitCast(f32, fontSize),
        @bitCast(f32, spacing),
        @bitCast(raylib.Color, tint),
    );
}

/// Load texture from file into GPU memory (VRAM)
pub fn LoadTexture(
    fileName: [:0]const u8,
) Texture {
    return @bitCast(
        Texture,
        raylib.LoadTexture(
            fileName,
        ),
    );
}

/// Load texture from image data
pub fn LoadTextureFromImage(
    image: Image,
) Texture {
    return raylib.LoadTextureFromImage(
        @bitCast(raylib.Image, image),
    );
}

/// Load cubemap from image, multiple image cubemap layouts supported
pub fn LoadTextureCubemap(
    image: Image,
    layout: i32,
) TextureCubemap {
    return raylib.LoadTextureCubemap(
        @bitCast(raylib.Image, image),
        @intCast(c_int, layout),
    );
}

/// Load texture for rendering (framebuffer)
pub fn LoadRenderTexture(
    width: i32,
    height: i32,
) RenderTexture2D {
    return raylib.LoadRenderTexture(
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

/// Unload texture from GPU memory (VRAM)
pub fn UnloadTexture(
    texture: Texture,
) void {
    raylib.UnloadTexture(
        @bitCast(raylib.Texture, texture),
    );
}

/// Unload render texture from GPU memory (VRAM)
pub fn UnloadRenderTexture(
    target: RenderTexture2D,
) void {
    raylib.UnloadRenderTexture(
        @bitCast(raylib.RenderTexture2D, target),
    );
}

/// Update GPU texture with new data
pub fn UpdateTexture(
    texture: Texture,
    pixels: *anyopaque,
) void {
    raylib.UpdateTexture(
        @bitCast(raylib.Texture, texture),
        @bitCast(*anyopaque, pixels),
    );
}

/// Update GPU texture rectangle with new data
pub fn UpdateTextureRec(
    texture: Texture,
    rec: Rectangle,
    pixels: *anyopaque,
) void {
    raylib.UpdateTextureRec(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, rec),
        @bitCast(*anyopaque, pixels),
    );
}

/// Generate GPU mipmaps for a texture
pub fn GenTextureMipmaps(
    texture: *Texture2D,
) void {
    raylib.GenTextureMipmaps(
        @ptrCast([*c]raylib.Texture2D, texture),
    );
}

/// Set texture scaling filter mode
pub fn SetTextureFilter(
    texture: Texture,
    filter: i32,
) void {
    raylib.SetTextureFilter(
        @bitCast(raylib.Texture, texture),
        @intCast(c_int, filter),
    );
}

/// Set texture wrapping mode
pub fn SetTextureWrap(
    texture: Texture,
    wrap: i32,
) void {
    raylib.SetTextureWrap(
        @bitCast(raylib.Texture, texture),
        @intCast(c_int, wrap),
    );
}

/// Draw a Texture2D
pub fn DrawTexture(
    texture: Texture,
    posX: i32,
    posY: i32,
    tint: Color,
) void {
    raylib.DrawTexture(
        @bitCast(raylib.Texture, texture),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a Texture2D with position defined as Vector2
pub fn DrawTextureV(
    texture: Texture,
    position: Vector2,
    tint: Color,
) void {
    raylib.DrawTextureV(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a Texture2D with extended parameters
pub fn DrawTextureEx(
    texture: Texture,
    position: Vector2,
    rotation: f32,
    scale: f32,
    tint: Color,
) void {
    raylib.DrawTextureEx(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Vector2, position),
        @bitCast(f32, rotation),
        @bitCast(f32, scale),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a part of a texture defined by a rectangle
pub fn DrawTextureRec(
    texture: Texture,
    source: Rectangle,
    position: Vector2,
    tint: Color,
) void {
    raylib.DrawTextureRec(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, source),
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw texture quad with tiling and offset parameters
pub fn DrawTextureQuad(
    texture: Texture,
    tiling: Vector2,
    offset: Vector2,
    quad: Rectangle,
    tint: Color,
) void {
    raylib.DrawTextureQuad(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Vector2, tiling),
        @bitCast(raylib.Vector2, offset),
        @bitCast(raylib.Rectangle, quad),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
pub fn DrawTextureTiled(
    texture: Texture,
    source: Rectangle,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    scale: f32,
    tint: Color,
) void {
    raylib.DrawTextureTiled(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, source),
        @bitCast(raylib.Rectangle, dest),
        @bitCast(raylib.Vector2, origin),
        @bitCast(f32, rotation),
        @bitCast(f32, scale),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a part of a texture defined by a rectangle with 'pro' parameters
pub fn DrawTexturePro(
    texture: Texture,
    source: Rectangle,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {
    raylib.DrawTexturePro(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, source),
        @bitCast(raylib.Rectangle, dest),
        @bitCast(raylib.Vector2, origin),
        @bitCast(f32, rotation),
        @bitCast(raylib.Color, tint),
    );
}

/// Draws a texture (or part of it) that stretches or shrinks nicely
pub fn DrawTextureNPatch(
    texture: Texture,
    nPatchInfo: NPatchInfo,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {
    raylib.DrawTextureNPatch(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.NPatchInfo, nPatchInfo),
        @bitCast(raylib.Rectangle, dest),
        @bitCast(raylib.Vector2, origin),
        @bitCast(f32, rotation),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a textured polygon
pub fn DrawTexturePoly(
    texture: Texture,
    center: Vector2,
    points: *Vector2,
    texcoords: *Vector2,
    pointCount: i32,
    tint: Color,
) void {
    raylib.DrawTexturePoly(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Vector2, center),
        @ptrCast([*c]raylib.Vector2, points),
        @ptrCast([*c]raylib.Vector2, texcoords),
        @intCast(c_int, pointCount),
        @bitCast(raylib.Color, tint),
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn Fade(
    color: Color,
    alpha: f32,
) Color {
    return raylib.Fade(
        @bitCast(raylib.Color, color),
        @bitCast(f32, alpha),
    );
}

/// Get hexadecimal value for a Color
pub fn ColorToInt(
    color: Color,
) i32 {
    return raylib.ColorToInt(
        @bitCast(raylib.Color, color),
    );
}

/// Get Color normalized as float [0..1]
pub fn ColorNormalize(
    color: Color,
) Vector4 {
    return raylib.ColorNormalize(
        @bitCast(raylib.Color, color),
    );
}

/// Get Color from normalized values [0..1]
pub fn ColorFromNormalized(
    normalized: Vector4,
) Color {
    return raylib.ColorFromNormalized(
        @bitCast(raylib.Vector4, normalized),
    );
}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn ColorToHSV(
    color: Color,
) Vector3 {
    return raylib.ColorToHSV(
        @bitCast(raylib.Color, color),
    );
}

/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub fn ColorFromHSV(
    hue: f32,
    saturation: f32,
    value: f32,
) Color {
    return raylib.ColorFromHSV(
        @bitCast(f32, hue),
        @bitCast(f32, saturation),
        @bitCast(f32, value),
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn ColorAlpha(
    color: Color,
    alpha: f32,
) Color {
    return raylib.ColorAlpha(
        @bitCast(raylib.Color, color),
        @bitCast(f32, alpha),
    );
}

/// Get src alpha-blended into dst color with tint
pub fn ColorAlphaBlend(
    dst: Color,
    src: Color,
    tint: Color,
) Color {
    return raylib.ColorAlphaBlend(
        @bitCast(raylib.Color, dst),
        @bitCast(raylib.Color, src),
        @bitCast(raylib.Color, tint),
    );
}

/// Get Color structure from hexadecimal value
pub fn GetColor(
    hexValue: u32,
) Color {
    return raylib.GetColor(
        @intCast(c_uint, hexValue),
    );
}

/// Get Color from a source pixel pointer of certain format
pub fn GetPixelColor(
    srcPtr: *anyopaque,
    format: i32,
) Color {
    return raylib.GetPixelColor(
        @bitCast(*anyopaque, srcPtr),
        @intCast(c_int, format),
    );
}

/// Set color formatted into destination pixel pointer
pub fn SetPixelColor(
    dstPtr: *anyopaque,
    color: Color,
    format: i32,
) void {
    raylib.SetPixelColor(
        @bitCast(*anyopaque, dstPtr),
        @bitCast(raylib.Color, color),
        @intCast(c_int, format),
    );
}

/// Get pixel data size in bytes for certain format
pub fn GetPixelDataSize(
    width: i32,
    height: i32,
    format: i32,
) i32 {
    return raylib.GetPixelDataSize(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @intCast(c_int, format),
    );
}

/// Get the default Font
pub fn GetFontDefault() Font {
    return raylib.GetFontDefault();
}

/// Load font from file into GPU memory (VRAM)
pub fn LoadFont(
    fileName: [:0]const u8,
) Font {
    return raylib.LoadFont(
        fileName,
    );
}

/// Load font from file with extended parameters, use NULL for fontChars and 0 for glyphCount to load the default character set
pub fn LoadFontEx(
    fileName: [:0]const u8,
    fontSize: i32,
    fontChars: []i32,
    glyphCount: i32,
) Font {
    return raylib.LoadFontEx(
        fileName,
        @intCast(c_int, fontSize),
        @ptrCast([*c]c_int, fontChars.ptr),
        @intCast(c_int, glyphCount),
    );
}

/// Load font from Image (XNA style)
pub fn LoadFontFromImage(
    image: Image,
    key: Color,
    firstChar: i32,
) Font {
    return raylib.LoadFontFromImage(
        @bitCast(raylib.Image, image),
        @bitCast(raylib.Color, key),
        @intCast(c_int, firstChar),
    );
}

/// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
pub fn LoadFontFromMemory(
    fileType: [:0]const u8,
    fileData: [:0]const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: []i32,
    glyphCount: i32,
) Font {
    return raylib.LoadFontFromMemory(
        fileType,
        fileData,
        @intCast(c_int, dataSize),
        @intCast(c_int, fontSize),
        @ptrCast([*c]c_int, fontChars.ptr),
        @intCast(c_int, glyphCount),
    );
}

/// Generate image font atlas using chars info
pub fn GenImageFontAtlas(
    chars: *const GlyphInfo,
    recs: [*c][*c]Rectangle,
    glyphCount: i32,
    fontSize: i32,
    padding: i32,
    packMethod: i32,
) Image {
    return raylib.GenImageFontAtlas(
        @ptrCast([*c]const raylib.GlyphInfo, chars),
        @ptrCast([*c][*c]raylib.Rectangle, recs),
        @intCast(c_int, glyphCount),
        @intCast(c_int, fontSize),
        @intCast(c_int, padding),
        @intCast(c_int, packMethod),
    );
}

/// Unload font chars info data (RAM)
pub fn UnloadFontData(
    chars: *GlyphInfo,
    glyphCount: i32,
) void {
    raylib.UnloadFontData(
        @ptrCast([*c]raylib.GlyphInfo, chars),
        @intCast(c_int, glyphCount),
    );
}

/// Unload font from GPU memory (VRAM)
pub fn UnloadFont(
    font: Font,
) void {
    raylib.UnloadFont(
        @bitCast(raylib.Font, font),
    );
}

/// Export font as code file, returns true on success
pub fn ExportFontAsCode(
    font: Font,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportFontAsCode(
        @bitCast(raylib.Font, font),
        fileName,
    );
}

/// Draw current FPS
pub fn DrawFPS(
    posX: i32,
    posY: i32,
) void {
    raylib.DrawFPS(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
    );
}

/// Draw text (using default font)
pub fn DrawText(
    text: [:0]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {
    raylib.DrawText(
        text,
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, fontSize),
        @bitCast(raylib.Color, color),
    );
}

/// Draw text using font and additional parameters
pub fn DrawTextEx(
    font: Font,
    text: [:0]const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.DrawTextEx(
        @bitCast(raylib.Font, font),
        text,
        @bitCast(raylib.Vector2, position),
        @bitCast(f32, fontSize),
        @bitCast(f32, spacing),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw text using Font and pro parameters (rotation)
pub fn DrawTextPro(
    font: Font,
    text: [:0]const u8,
    position: Vector2,
    origin: Vector2,
    rotation: f32,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.DrawTextPro(
        @bitCast(raylib.Font, font),
        text,
        @bitCast(raylib.Vector2, position),
        @bitCast(raylib.Vector2, origin),
        @bitCast(f32, rotation),
        @bitCast(f32, fontSize),
        @bitCast(f32, spacing),
        @bitCast(raylib.Color, tint),
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
    raylib.DrawTextCodepoint(
        @bitCast(raylib.Font, font),
        @intCast(c_int, codepoint),
        @bitCast(raylib.Vector2, position),
        @bitCast(f32, fontSize),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw multiple character (codepoint)
pub fn DrawTextCodepoints(
    font: Font,
    codepoints: []i32,
    count: i32,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    raylib.DrawTextCodepoints(
        @bitCast(raylib.Font, font),
        @ptrCast([*c]c_int, codepoints.ptr),
        @intCast(c_int, count),
        @bitCast(raylib.Vector2, position),
        @bitCast(f32, fontSize),
        @bitCast(f32, spacing),
        @bitCast(raylib.Color, tint),
    );
}

/// Measure string width for default font
pub fn MeasureText(
    text: [:0]const u8,
    fontSize: i32,
) i32 {
    return raylib.MeasureText(
        text,
        @intCast(c_int, fontSize),
    );
}

/// Measure string size for Font
pub fn MeasureTextEx(
    font: Font,
    text: [:0]const u8,
    fontSize: f32,
    spacing: f32,
) Vector2 {
    return raylib.MeasureTextEx(
        @bitCast(raylib.Font, font),
        text,
        @bitCast(f32, fontSize),
        @bitCast(f32, spacing),
    );
}

/// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphIndex(
    font: Font,
    codepoint: i32,
) i32 {
    return raylib.GetGlyphIndex(
        @bitCast(raylib.Font, font),
        @intCast(c_int, codepoint),
    );
}

/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphInfo(
    font: Font,
    codepoint: i32,
) GlyphInfo {
    return raylib.GetGlyphInfo(
        @bitCast(raylib.Font, font),
        @intCast(c_int, codepoint),
    );
}

/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphAtlasRec(
    font: Font,
    codepoint: i32,
) Rectangle {
    return raylib.GetGlyphAtlasRec(
        @bitCast(raylib.Font, font),
        @intCast(c_int, codepoint),
    );
}

/// Draw a line in 3D world space
pub fn DrawLine3D(
    startPos: Vector3,
    endPos: Vector3,
    color: Color,
) void {
    raylib.DrawLine3D(
        @bitCast(raylib.Vector3, startPos),
        @bitCast(raylib.Vector3, endPos),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a point in 3D space, actually a small line
pub fn DrawPoint3D(
    position: Vector3,
    color: Color,
) void {
    raylib.DrawPoint3D(
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCircle3D(
        @bitCast(raylib.Vector3, center),
        @bitCast(f32, radius),
        @bitCast(raylib.Vector3, rotationAxis),
        @bitCast(f32, rotationAngle),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle3D(
    v1: Vector3,
    v2: Vector3,
    v3: Vector3,
    color: Color,
) void {
    raylib.DrawTriangle3D(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
        @bitCast(raylib.Vector3, v3),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip3D(
    points: *Vector3,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawTriangleStrip3D(
        @ptrCast([*c]raylib.Vector3, points),
        @intCast(c_int, pointCount),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCube(
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, width),
        @bitCast(f32, height),
        @bitCast(f32, length),
        @bitCast(raylib.Color, color),
    );
}

/// Draw cube (Vector version)
pub fn DrawCubeV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.DrawCubeV(
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Vector3, size),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCubeWires(
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, width),
        @bitCast(f32, height),
        @bitCast(f32, length),
        @bitCast(raylib.Color, color),
    );
}

/// Draw cube wires (Vector version)
pub fn DrawCubeWiresV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.DrawCubeWiresV(
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Vector3, size),
        @bitCast(raylib.Color, color),
    );
}

/// Draw cube textured
pub fn DrawCubeTexture(
    texture: Texture,
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {
    raylib.DrawCubeTexture(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, width),
        @bitCast(f32, height),
        @bitCast(f32, length),
        @bitCast(raylib.Color, color),
    );
}

/// Draw cube with a region of a texture
pub fn DrawCubeTextureRec(
    texture: Texture,
    source: Rectangle,
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {
    raylib.DrawCubeTextureRec(
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, source),
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, width),
        @bitCast(f32, height),
        @bitCast(f32, length),
        @bitCast(raylib.Color, color),
    );
}

/// Draw sphere
pub fn DrawSphere(
    centerPos: Vector3,
    radius: f32,
    color: Color,
) void {
    raylib.DrawSphere(
        @bitCast(raylib.Vector3, centerPos),
        @bitCast(f32, radius),
        @bitCast(raylib.Color, color),
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
    raylib.DrawSphereEx(
        @bitCast(raylib.Vector3, centerPos),
        @bitCast(f32, radius),
        @intCast(c_int, rings),
        @intCast(c_int, slices),
        @bitCast(raylib.Color, color),
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
    raylib.DrawSphereWires(
        @bitCast(raylib.Vector3, centerPos),
        @bitCast(f32, radius),
        @intCast(c_int, rings),
        @intCast(c_int, slices),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCylinder(
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, radiusTop),
        @bitCast(f32, radiusBottom),
        @bitCast(f32, height),
        @intCast(c_int, slices),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCylinderEx(
        @bitCast(raylib.Vector3, startPos),
        @bitCast(raylib.Vector3, endPos),
        @bitCast(f32, startRadius),
        @bitCast(f32, endRadius),
        @intCast(c_int, sides),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCylinderWires(
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, radiusTop),
        @bitCast(f32, radiusBottom),
        @bitCast(f32, height),
        @intCast(c_int, slices),
        @bitCast(raylib.Color, color),
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
    raylib.DrawCylinderWiresEx(
        @bitCast(raylib.Vector3, startPos),
        @bitCast(raylib.Vector3, endPos),
        @bitCast(f32, startRadius),
        @bitCast(f32, endRadius),
        @intCast(c_int, sides),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a plane XZ
pub fn DrawPlane(
    centerPos: Vector3,
    size: Vector2,
    color: Color,
) void {
    raylib.DrawPlane(
        @bitCast(raylib.Vector3, centerPos),
        @bitCast(raylib.Vector2, size),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a ray line
pub fn DrawRay(
    ray: Ray,
    color: Color,
) void {
    raylib.DrawRay(
        @bitCast(raylib.Ray, ray),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a grid (centered at (0, 0, 0))
pub fn DrawGrid(
    slices: i32,
    spacing: f32,
) void {
    raylib.DrawGrid(
        @intCast(c_int, slices),
        @bitCast(f32, spacing),
    );
}

/// Load model from files (meshes and materials)
pub fn LoadModel(
    fileName: [:0]const u8,
) Model {
    return raylib.LoadModel(
        fileName,
    );
}

/// Load model from generated mesh (default material)
pub fn LoadModelFromMesh(
    mesh: Mesh,
) Model {
    return raylib.LoadModelFromMesh(
        @bitCast(raylib.Mesh, mesh),
    );
}

/// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn UnloadModel(
    model: Model,
) void {
    raylib.UnloadModel(
        @bitCast(raylib.Model, model),
    );
}

/// Unload model (but not meshes) from memory (RAM and/or VRAM)
pub fn UnloadModelKeepMeshes(
    model: Model,
) void {
    raylib.UnloadModelKeepMeshes(
        @bitCast(raylib.Model, model),
    );
}

/// Compute model bounding box limits (considers all meshes)
pub fn GetModelBoundingBox(
    model: Model,
) BoundingBox {
    return raylib.GetModelBoundingBox(
        @bitCast(raylib.Model, model),
    );
}

/// Draw a model (with texture if set)
pub fn DrawModel(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {
    raylib.DrawModel(
        @bitCast(raylib.Model, model),
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, scale),
        @bitCast(raylib.Color, tint),
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
    raylib.DrawModelEx(
        @bitCast(raylib.Model, model),
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Vector3, rotationAxis),
        @bitCast(f32, rotationAngle),
        @bitCast(raylib.Vector3, scale),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a model wires (with texture if set)
pub fn DrawModelWires(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {
    raylib.DrawModelWires(
        @bitCast(raylib.Model, model),
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, scale),
        @bitCast(raylib.Color, tint),
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
    raylib.DrawModelWiresEx(
        @bitCast(raylib.Model, model),
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Vector3, rotationAxis),
        @bitCast(f32, rotationAngle),
        @bitCast(raylib.Vector3, scale),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw bounding box (wires)
pub fn DrawBoundingBox(
    box: BoundingBox,
    color: Color,
) void {
    raylib.DrawBoundingBox(
        @bitCast(raylib.BoundingBox, box),
        @bitCast(raylib.Color, color),
    );
}

/// Draw a billboard texture
pub fn DrawBillboard(
    camera: Camera,
    texture: Texture,
    position: Vector3,
    size: f32,
    tint: Color,
) void {
    raylib.DrawBillboard(
        @bitCast(raylib.Camera, camera),
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Vector3, position),
        @bitCast(f32, size),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a billboard texture defined by source
pub fn DrawBillboardRec(
    camera: Camera,
    texture: Texture,
    source: Rectangle,
    position: Vector3,
    size: Vector2,
    tint: Color,
) void {
    raylib.DrawBillboardRec(
        @bitCast(raylib.Camera, camera),
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, source),
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Vector2, size),
        @bitCast(raylib.Color, tint),
    );
}

/// Draw a billboard texture defined by source and rotation
pub fn DrawBillboardPro(
    camera: Camera,
    texture: Texture,
    source: Rectangle,
    position: Vector3,
    up: Vector3,
    size: Vector2,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {
    raylib.DrawBillboardPro(
        @bitCast(raylib.Camera, camera),
        @bitCast(raylib.Texture, texture),
        @bitCast(raylib.Rectangle, source),
        @bitCast(raylib.Vector3, position),
        @bitCast(raylib.Vector3, up),
        @bitCast(raylib.Vector2, size),
        @bitCast(raylib.Vector2, origin),
        @bitCast(f32, rotation),
        @bitCast(raylib.Color, tint),
    );
}

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
pub fn UploadMesh(
    mesh: *Mesh,
    dynamic: bool,
) void {
    raylib.UploadMesh(
        @ptrCast([*c]raylib.Mesh, mesh),
        @bitCast(bool, dynamic),
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
    raylib.UpdateMeshBuffer(
        @bitCast(raylib.Mesh, mesh),
        @intCast(c_int, index),
        @bitCast(*anyopaque, data),
        @intCast(c_int, dataSize),
        @intCast(c_int, offset),
    );
}

/// Unload mesh data from CPU and GPU
pub fn UnloadMesh(
    mesh: Mesh,
) void {
    raylib.UnloadMesh(
        @bitCast(raylib.Mesh, mesh),
    );
}

/// Draw a 3d mesh with material and transform
pub fn DrawMesh(
    mesh: Mesh,
    material: Material,
    transform: Matrix,
) void {
    raylib.DrawMesh(
        @bitCast(raylib.Mesh, mesh),
        @bitCast(raylib.Material, material),
        @bitCast(raylib.Matrix, transform),
    );
}

/// Draw multiple mesh instances with material and different transforms
pub fn DrawMeshInstanced(
    mesh: Mesh,
    material: Material,
    transforms: *const Matrix,
    instances: i32,
) void {
    raylib.DrawMeshInstanced(
        @bitCast(raylib.Mesh, mesh),
        @bitCast(raylib.Material, material),
        @ptrCast([*c]const raylib.Matrix, transforms),
        @intCast(c_int, instances),
    );
}

/// Export mesh data to file, returns true on success
pub fn ExportMesh(
    mesh: Mesh,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportMesh(
        @bitCast(raylib.Mesh, mesh),
        fileName,
    );
}

/// Compute mesh bounding box limits
pub fn GetMeshBoundingBox(
    mesh: Mesh,
) BoundingBox {
    return raylib.GetMeshBoundingBox(
        @bitCast(raylib.Mesh, mesh),
    );
}

/// Compute mesh tangents
pub fn GenMeshTangents(
    mesh: *Mesh,
) void {
    raylib.GenMeshTangents(
        @ptrCast([*c]raylib.Mesh, mesh),
    );
}

/// Compute mesh binormals
pub fn GenMeshBinormals(
    mesh: *Mesh,
) void {
    raylib.GenMeshBinormals(
        @ptrCast([*c]raylib.Mesh, mesh),
    );
}

/// Generate polygonal mesh
pub fn GenMeshPoly(
    sides: i32,
    radius: f32,
) Mesh {
    return raylib.GenMeshPoly(
        @intCast(c_int, sides),
        @bitCast(f32, radius),
    );
}

/// Generate plane mesh (with subdivisions)
pub fn GenMeshPlane(
    width: f32,
    length: f32,
    resX: i32,
    resZ: i32,
) Mesh {
    return raylib.GenMeshPlane(
        @bitCast(f32, width),
        @bitCast(f32, length),
        @intCast(c_int, resX),
        @intCast(c_int, resZ),
    );
}

/// Generate cuboid mesh
pub fn GenMeshCube(
    width: f32,
    height: f32,
    length: f32,
) Mesh {
    return raylib.GenMeshCube(
        @bitCast(f32, width),
        @bitCast(f32, height),
        @bitCast(f32, length),
    );
}

/// Generate sphere mesh (standard sphere)
pub fn GenMeshSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {
    return raylib.GenMeshSphere(
        @bitCast(f32, radius),
        @intCast(c_int, rings),
        @intCast(c_int, slices),
    );
}

/// Generate half-sphere mesh (no bottom cap)
pub fn GenMeshHemiSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {
    return raylib.GenMeshHemiSphere(
        @bitCast(f32, radius),
        @intCast(c_int, rings),
        @intCast(c_int, slices),
    );
}

/// Generate cylinder mesh
pub fn GenMeshCylinder(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {
    return raylib.GenMeshCylinder(
        @bitCast(f32, radius),
        @bitCast(f32, height),
        @intCast(c_int, slices),
    );
}

/// Generate cone/pyramid mesh
pub fn GenMeshCone(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {
    return raylib.GenMeshCone(
        @bitCast(f32, radius),
        @bitCast(f32, height),
        @intCast(c_int, slices),
    );
}

/// Generate torus mesh
pub fn GenMeshTorus(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {
    return raylib.GenMeshTorus(
        @bitCast(f32, radius),
        @bitCast(f32, size),
        @intCast(c_int, radSeg),
        @intCast(c_int, sides),
    );
}

/// Generate trefoil knot mesh
pub fn GenMeshKnot(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {
    return raylib.GenMeshKnot(
        @bitCast(f32, radius),
        @bitCast(f32, size),
        @intCast(c_int, radSeg),
        @intCast(c_int, sides),
    );
}

/// Generate heightmap mesh from image data
pub fn GenMeshHeightmap(
    heightmap: Image,
    size: Vector3,
) Mesh {
    return raylib.GenMeshHeightmap(
        @bitCast(raylib.Image, heightmap),
        @bitCast(raylib.Vector3, size),
    );
}

/// Generate cubes-based map mesh from image data
pub fn GenMeshCubicmap(
    cubicmap: Image,
    cubeSize: Vector3,
) Mesh {
    return raylib.GenMeshCubicmap(
        @bitCast(raylib.Image, cubicmap),
        @bitCast(raylib.Vector3, cubeSize),
    );
}

/// Load materials from model file
pub fn LoadMaterials(
    fileName: [:0]const u8,
    materialCount: []i32,
) [*c]Material {
    return raylib.LoadMaterials(
        fileName,
        @ptrCast([*c]c_int, materialCount.ptr),
    );
}

/// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub fn LoadMaterialDefault() Material {
    return raylib.LoadMaterialDefault();
}

/// Unload material from GPU memory (VRAM)
pub fn UnloadMaterial(
    material: Material,
) void {
    raylib.UnloadMaterial(
        @bitCast(raylib.Material, material),
    );
}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn SetMaterialTexture(
    material: *Material,
    mapType: i32,
    texture: Texture,
) void {
    raylib.SetMaterialTexture(
        @ptrCast([*c]raylib.Material, material),
        @intCast(c_int, mapType),
        @bitCast(raylib.Texture, texture),
    );
}

/// Set material for a mesh
pub fn SetModelMeshMaterial(
    model: *Model,
    meshId: i32,
    materialId: i32,
) void {
    raylib.SetModelMeshMaterial(
        @ptrCast([*c]raylib.Model, model),
        @intCast(c_int, meshId),
        @intCast(c_int, materialId),
    );
}

/// Load model animations from file
pub fn LoadModelAnimations(
    fileName: [:0]const u8,
    animCount: []u32,
) [*c]ModelAnimation {
    return raylib.LoadModelAnimations(
        fileName,
        @ptrCast([*c]c_uint, animCount.ptr),
    );
}

/// Update model animation pose
pub fn UpdateModelAnimation(
    model: Model,
    anim: ModelAnimation,
    frame: i32,
) void {
    raylib.UpdateModelAnimation(
        @bitCast(raylib.Model, model),
        @bitCast(raylib.ModelAnimation, anim),
        @intCast(c_int, frame),
    );
}

/// Unload animation data
pub fn UnloadModelAnimation(
    anim: ModelAnimation,
) void {
    raylib.UnloadModelAnimation(
        @bitCast(raylib.ModelAnimation, anim),
    );
}

/// Unload animation array data
pub fn UnloadModelAnimations(
    animations: *ModelAnimation,
    count: u32,
) void {
    raylib.UnloadModelAnimations(
        @ptrCast([*c]raylib.ModelAnimation, animations),
        @intCast(c_uint, count),
    );
}

/// Check model animation skeleton match
pub fn IsModelAnimationValid(
    model: Model,
    anim: ModelAnimation,
) bool {
    return raylib.IsModelAnimationValid(
        @bitCast(raylib.Model, model),
        @bitCast(raylib.ModelAnimation, anim),
    );
}

/// Check collision between two spheres
pub fn CheckCollisionSpheres(
    center1: Vector3,
    radius1: f32,
    center2: Vector3,
    radius2: f32,
) bool {
    return raylib.CheckCollisionSpheres(
        @bitCast(raylib.Vector3, center1),
        @bitCast(f32, radius1),
        @bitCast(raylib.Vector3, center2),
        @bitCast(f32, radius2),
    );
}

/// Check collision between two bounding boxes
pub fn CheckCollisionBoxes(
    box1: BoundingBox,
    box2: BoundingBox,
) bool {
    return raylib.CheckCollisionBoxes(
        @bitCast(raylib.BoundingBox, box1),
        @bitCast(raylib.BoundingBox, box2),
    );
}

/// Check collision between box and sphere
pub fn CheckCollisionBoxSphere(
    box: BoundingBox,
    center: Vector3,
    radius: f32,
) bool {
    return raylib.CheckCollisionBoxSphere(
        @bitCast(raylib.BoundingBox, box),
        @bitCast(raylib.Vector3, center),
        @bitCast(f32, radius),
    );
}

/// Get collision info between ray and sphere
pub fn GetRayCollisionSphere(
    ray: Ray,
    center: Vector3,
    radius: f32,
) RayCollision {
    return raylib.GetRayCollisionSphere(
        @bitCast(raylib.Ray, ray),
        @bitCast(raylib.Vector3, center),
        @bitCast(f32, radius),
    );
}

/// Get collision info between ray and box
pub fn GetRayCollisionBox(
    ray: Ray,
    box: BoundingBox,
) RayCollision {
    return raylib.GetRayCollisionBox(
        @bitCast(raylib.Ray, ray),
        @bitCast(raylib.BoundingBox, box),
    );
}

/// Get collision info between ray and mesh
pub fn GetRayCollisionMesh(
    ray: Ray,
    mesh: Mesh,
    transform: Matrix,
) RayCollision {
    return raylib.GetRayCollisionMesh(
        @bitCast(raylib.Ray, ray),
        @bitCast(raylib.Mesh, mesh),
        @bitCast(raylib.Matrix, transform),
    );
}

/// Get collision info between ray and triangle
pub fn GetRayCollisionTriangle(
    ray: Ray,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
) RayCollision {
    return raylib.GetRayCollisionTriangle(
        @bitCast(raylib.Ray, ray),
        @bitCast(raylib.Vector3, p1),
        @bitCast(raylib.Vector3, p2),
        @bitCast(raylib.Vector3, p3),
    );
}

/// Get collision info between ray and quad
pub fn GetRayCollisionQuad(
    ray: Ray,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
    p4: Vector3,
) RayCollision {
    return raylib.GetRayCollisionQuad(
        @bitCast(raylib.Ray, ray),
        @bitCast(raylib.Vector3, p1),
        @bitCast(raylib.Vector3, p2),
        @bitCast(raylib.Vector3, p3),
        @bitCast(raylib.Vector3, p4),
    );
}

/// Initialize audio device and context
pub fn InitAudioDevice() void {
    raylib.InitAudioDevice();
}

/// Close the audio device and context
pub fn CloseAudioDevice() void {
    raylib.CloseAudioDevice();
}

/// Check if audio device has been initialized successfully
pub fn IsAudioDeviceReady() bool {
    return raylib.IsAudioDeviceReady();
}

/// Set master volume (listener)
pub fn SetMasterVolume(
    volume: f32,
) void {
    raylib.SetMasterVolume(
        @bitCast(f32, volume),
    );
}

/// Load wave data from file
pub fn LoadWave(
    fileName: [:0]const u8,
) Wave {
    return raylib.LoadWave(
        fileName,
    );
}

/// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
pub fn LoadWaveFromMemory(
    fileType: [:0]const u8,
    fileData: [:0]const u8,
    dataSize: i32,
) Wave {
    return raylib.LoadWaveFromMemory(
        fileType,
        fileData,
        @intCast(c_int, dataSize),
    );
}

/// Load sound from file
pub fn LoadSound(
    fileName: [:0]const u8,
) Sound {
    return raylib.LoadSound(
        fileName,
    );
}

/// Load sound from wave data
pub fn LoadSoundFromWave(
    wave: Wave,
) Sound {
    return raylib.LoadSoundFromWave(
        @bitCast(raylib.Wave, wave),
    );
}

/// Update sound buffer with new data
pub fn UpdateSound(
    sound: Sound,
    data: *anyopaque,
    sampleCount: i32,
) void {
    raylib.UpdateSound(
        @bitCast(raylib.Sound, sound),
        @bitCast(*anyopaque, data),
        @intCast(c_int, sampleCount),
    );
}

/// Unload wave data
pub fn UnloadWave(
    wave: Wave,
) void {
    raylib.UnloadWave(
        @bitCast(raylib.Wave, wave),
    );
}

/// Unload sound
pub fn UnloadSound(
    sound: Sound,
) void {
    raylib.UnloadSound(
        @bitCast(raylib.Sound, sound),
    );
}

/// Export wave data to file, returns true on success
pub fn ExportWave(
    wave: Wave,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportWave(
        @bitCast(raylib.Wave, wave),
        fileName,
    );
}

/// Export wave sample data to code (.h), returns true on success
pub fn ExportWaveAsCode(
    wave: Wave,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportWaveAsCode(
        @bitCast(raylib.Wave, wave),
        fileName,
    );
}

/// Play a sound
pub fn PlaySound(
    sound: Sound,
) void {
    raylib.PlaySound(
        @bitCast(raylib.Sound, sound),
    );
}

/// Stop playing a sound
pub fn StopSound(
    sound: Sound,
) void {
    raylib.StopSound(
        @bitCast(raylib.Sound, sound),
    );
}

/// Pause a sound
pub fn PauseSound(
    sound: Sound,
) void {
    raylib.PauseSound(
        @bitCast(raylib.Sound, sound),
    );
}

/// Resume a paused sound
pub fn ResumeSound(
    sound: Sound,
) void {
    raylib.ResumeSound(
        @bitCast(raylib.Sound, sound),
    );
}

/// Play a sound (using multichannel buffer pool)
pub fn PlaySoundMulti(
    sound: Sound,
) void {
    raylib.PlaySoundMulti(
        @bitCast(raylib.Sound, sound),
    );
}

/// Stop any sound playing (using multichannel buffer pool)
pub fn StopSoundMulti() void {
    raylib.StopSoundMulti();
}

/// Get number of sounds playing in the multichannel
pub fn GetSoundsPlaying() i32 {
    return raylib.GetSoundsPlaying();
}

/// Check if a sound is currently playing
pub fn IsSoundPlaying(
    sound: Sound,
) bool {
    return raylib.IsSoundPlaying(
        @bitCast(raylib.Sound, sound),
    );
}

/// Set volume for a sound (1.0 is max level)
pub fn SetSoundVolume(
    sound: Sound,
    volume: f32,
) void {
    raylib.SetSoundVolume(
        @bitCast(raylib.Sound, sound),
        @bitCast(f32, volume),
    );
}

/// Set pitch for a sound (1.0 is base level)
pub fn SetSoundPitch(
    sound: Sound,
    pitch: f32,
) void {
    raylib.SetSoundPitch(
        @bitCast(raylib.Sound, sound),
        @bitCast(f32, pitch),
    );
}

/// Set pan for a sound (0.5 is center)
pub fn SetSoundPan(
    sound: Sound,
    pan: f32,
) void {
    raylib.SetSoundPan(
        @bitCast(raylib.Sound, sound),
        @bitCast(f32, pan),
    );
}

/// Copy a wave to a new wave
pub fn WaveCopy(
    wave: Wave,
) Wave {
    return raylib.WaveCopy(
        @bitCast(raylib.Wave, wave),
    );
}

/// Crop a wave to defined samples range
pub fn WaveCrop(
    wave: *Wave,
    initSample: i32,
    finalSample: i32,
) void {
    raylib.WaveCrop(
        @ptrCast([*c]raylib.Wave, wave),
        @intCast(c_int, initSample),
        @intCast(c_int, finalSample),
    );
}

/// Convert wave data to desired format
pub fn WaveFormat(
    wave: *Wave,
    sampleRate: i32,
    sampleSize: i32,
    channels: i32,
) void {
    raylib.WaveFormat(
        @ptrCast([*c]raylib.Wave, wave),
        @intCast(c_int, sampleRate),
        @intCast(c_int, sampleSize),
        @intCast(c_int, channels),
    );
}

/// Load samples data from wave as a 32bit float data array
pub fn LoadWaveSamples(
    wave: Wave,
) [*c]f32 {
    return raylib.LoadWaveSamples(
        @bitCast(raylib.Wave, wave),
    );
}

/// Unload samples data loaded with LoadWaveSamples()
pub fn UnloadWaveSamples(
    samples: []f32,
) void {
    raylib.UnloadWaveSamples(
        @ptrCast([*c]f32, samples.ptr),
    );
}

/// Load music stream from file
pub fn LoadMusicStream(
    fileName: [:0]const u8,
) Music {
    return raylib.LoadMusicStream(
        fileName,
    );
}

/// Load music stream from data
pub fn LoadMusicStreamFromMemory(
    fileType: [:0]const u8,
    data: [:0]const u8,
    dataSize: i32,
) Music {
    return raylib.LoadMusicStreamFromMemory(
        fileType,
        data,
        @intCast(c_int, dataSize),
    );
}

/// Unload music stream
pub fn UnloadMusicStream(
    music: Music,
) void {
    raylib.UnloadMusicStream(
        @bitCast(raylib.Music, music),
    );
}

/// Start music playing
pub fn PlayMusicStream(
    music: Music,
) void {
    raylib.PlayMusicStream(
        @bitCast(raylib.Music, music),
    );
}

/// Check if music is playing
pub fn IsMusicStreamPlaying(
    music: Music,
) bool {
    return raylib.IsMusicStreamPlaying(
        @bitCast(raylib.Music, music),
    );
}

/// Updates buffers for music streaming
pub fn UpdateMusicStream(
    music: Music,
) void {
    raylib.UpdateMusicStream(
        @bitCast(raylib.Music, music),
    );
}

/// Stop music playing
pub fn StopMusicStream(
    music: Music,
) void {
    raylib.StopMusicStream(
        @bitCast(raylib.Music, music),
    );
}

/// Pause music playing
pub fn PauseMusicStream(
    music: Music,
) void {
    raylib.PauseMusicStream(
        @bitCast(raylib.Music, music),
    );
}

/// Resume playing paused music
pub fn ResumeMusicStream(
    music: Music,
) void {
    raylib.ResumeMusicStream(
        @bitCast(raylib.Music, music),
    );
}

/// Seek music to a position (in seconds)
pub fn SeekMusicStream(
    music: Music,
    position: f32,
) void {
    raylib.SeekMusicStream(
        @bitCast(raylib.Music, music),
        @bitCast(f32, position),
    );
}

/// Set volume for music (1.0 is max level)
pub fn SetMusicVolume(
    music: Music,
    volume: f32,
) void {
    raylib.SetMusicVolume(
        @bitCast(raylib.Music, music),
        @bitCast(f32, volume),
    );
}

/// Set pitch for a music (1.0 is base level)
pub fn SetMusicPitch(
    music: Music,
    pitch: f32,
) void {
    raylib.SetMusicPitch(
        @bitCast(raylib.Music, music),
        @bitCast(f32, pitch),
    );
}

/// Set pan for a music (0.5 is center)
pub fn SetMusicPan(
    music: Music,
    pan: f32,
) void {
    raylib.SetMusicPan(
        @bitCast(raylib.Music, music),
        @bitCast(f32, pan),
    );
}

/// Get music time length (in seconds)
pub fn GetMusicTimeLength(
    music: Music,
) f32 {
    return raylib.GetMusicTimeLength(
        @bitCast(raylib.Music, music),
    );
}

/// Get current music time played (in seconds)
pub fn GetMusicTimePlayed(
    music: Music,
) f32 {
    return raylib.GetMusicTimePlayed(
        @bitCast(raylib.Music, music),
    );
}

/// Load audio stream (to stream raw audio pcm data)
pub fn LoadAudioStream(
    sampleRate: u32,
    sampleSize: u32,
    channels: u32,
) AudioStream {
    return raylib.LoadAudioStream(
        @intCast(c_uint, sampleRate),
        @intCast(c_uint, sampleSize),
        @intCast(c_uint, channels),
    );
}

/// Unload audio stream and free memory
pub fn UnloadAudioStream(
    stream: AudioStream,
) void {
    raylib.UnloadAudioStream(
        @bitCast(raylib.AudioStream, stream),
    );
}

/// Update audio stream buffers with data
pub fn UpdateAudioStream(
    stream: AudioStream,
    data: *anyopaque,
    frameCount: i32,
) void {
    raylib.UpdateAudioStream(
        @bitCast(raylib.AudioStream, stream),
        @bitCast(*anyopaque, data),
        @intCast(c_int, frameCount),
    );
}

/// Check if any audio stream buffers requires refill
pub fn IsAudioStreamProcessed(
    stream: AudioStream,
) bool {
    return raylib.IsAudioStreamProcessed(
        @bitCast(raylib.AudioStream, stream),
    );
}

/// Play audio stream
pub fn PlayAudioStream(
    stream: AudioStream,
) void {
    raylib.PlayAudioStream(
        @bitCast(raylib.AudioStream, stream),
    );
}

/// Pause audio stream
pub fn PauseAudioStream(
    stream: AudioStream,
) void {
    raylib.PauseAudioStream(
        @bitCast(raylib.AudioStream, stream),
    );
}

/// Resume audio stream
pub fn ResumeAudioStream(
    stream: AudioStream,
) void {
    raylib.ResumeAudioStream(
        @bitCast(raylib.AudioStream, stream),
    );
}

/// Check if audio stream is playing
pub fn IsAudioStreamPlaying(
    stream: AudioStream,
) bool {
    return raylib.IsAudioStreamPlaying(
        @bitCast(raylib.AudioStream, stream),
    );
}

/// Stop audio stream
pub fn StopAudioStream(
    stream: AudioStream,
) void {
    raylib.StopAudioStream(
        @bitCast(raylib.AudioStream, stream),
    );
}

/// Set volume for audio stream (1.0 is max level)
pub fn SetAudioStreamVolume(
    stream: AudioStream,
    volume: f32,
) void {
    raylib.SetAudioStreamVolume(
        @bitCast(raylib.AudioStream, stream),
        @bitCast(f32, volume),
    );
}

/// Set pitch for audio stream (1.0 is base level)
pub fn SetAudioStreamPitch(
    stream: AudioStream,
    pitch: f32,
) void {
    raylib.SetAudioStreamPitch(
        @bitCast(raylib.AudioStream, stream),
        @bitCast(f32, pitch),
    );
}

/// Set pan for audio stream (0.5 is centered)
pub fn SetAudioStreamPan(
    stream: AudioStream,
    pan: f32,
) void {
    raylib.SetAudioStreamPan(
        @bitCast(raylib.AudioStream, stream),
        @bitCast(f32, pan),
    );
}

/// Default size for new audio streams
pub fn SetAudioStreamBufferSizeDefault(
    size: i32,
) void {
    raylib.SetAudioStreamBufferSizeDefault(
        @intCast(c_int, size),
    );
}

/// Audio thread callback to request new data
pub fn SetAudioStreamCallback(
    stream: AudioStream,
    callback: AudioCallback,
) void {
    raylib.SetAudioStreamCallback(
        @bitCast(raylib.AudioStream, stream),
        @bitCast(raylib.AudioCallback, callback),
    );
}

/// 
pub fn AttachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.AttachAudioStreamProcessor(
        @bitCast(raylib.AudioStream, stream),
        @bitCast(raylib.AudioCallback, processor),
    );
}

/// 
pub fn DetachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.DetachAudioStreamProcessor(
        @bitCast(raylib.AudioStream, stream),
        @bitCast(raylib.AudioCallback, processor),
    );
}

/// 
pub fn Clamp(
    value: f32,
    min: f32,
    max: f32,
) f32 {
    return raylib.Clamp(
        @bitCast(f32, value),
        @bitCast(f32, min),
        @bitCast(f32, max),
    );
}

/// 
pub fn Lerp(
    start: f32,
    end: f32,
    amount: f32,
) f32 {
    return raylib.Lerp(
        @bitCast(f32, start),
        @bitCast(f32, end),
        @bitCast(f32, amount),
    );
}

/// 
pub fn Normalize(
    value: f32,
    start: f32,
    end: f32,
) f32 {
    return raylib.Normalize(
        @bitCast(f32, value),
        @bitCast(f32, start),
        @bitCast(f32, end),
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
    return raylib.Remap(
        @bitCast(f32, value),
        @bitCast(f32, inputStart),
        @bitCast(f32, inputEnd),
        @bitCast(f32, outputStart),
        @bitCast(f32, outputEnd),
    );
}

/// 
pub fn Vector2Zero() Vector2 {
    return raylib.Vector2Zero();
}

/// 
pub fn Vector2One() Vector2 {
    return raylib.Vector2One();
}

/// 
pub fn Vector2Add(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    return raylib.Vector2Add(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2AddValue(
    v: Vector2,
    add: f32,
) Vector2 {
    return raylib.Vector2AddValue(
        @bitCast(raylib.Vector2, v),
        @bitCast(f32, add),
    );
}

/// 
pub fn Vector2Subtract(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    return raylib.Vector2Subtract(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2SubtractValue(
    v: Vector2,
    sub: f32,
) Vector2 {
    return raylib.Vector2SubtractValue(
        @bitCast(raylib.Vector2, v),
        @bitCast(f32, sub),
    );
}

/// 
pub fn Vector2Length(
    v: Vector2,
) f32 {
    return raylib.Vector2Length(
        @bitCast(raylib.Vector2, v),
    );
}

/// 
pub fn Vector2LengthSqr(
    v: Vector2,
) f32 {
    return raylib.Vector2LengthSqr(
        @bitCast(raylib.Vector2, v),
    );
}

/// 
pub fn Vector2DotProduct(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2DotProduct(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2Distance(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2Distance(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2DistanceSqr(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2DistanceSqr(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2Angle(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2Angle(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2Scale(
    v: Vector2,
    scale: f32,
) Vector2 {
    return raylib.Vector2Scale(
        @bitCast(raylib.Vector2, v),
        @bitCast(f32, scale),
    );
}

/// 
pub fn Vector2Multiply(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    return raylib.Vector2Multiply(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2Negate(
    v: Vector2,
) Vector2 {
    return raylib.Vector2Negate(
        @bitCast(raylib.Vector2, v),
    );
}

/// 
pub fn Vector2Divide(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    return raylib.Vector2Divide(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
    );
}

/// 
pub fn Vector2Normalize(
    v: Vector2,
) Vector2 {
    return raylib.Vector2Normalize(
        @bitCast(raylib.Vector2, v),
    );
}

/// 
pub fn Vector2Transform(
    v: Vector2,
    mat: Matrix,
) Vector2 {
    return raylib.Vector2Transform(
        @bitCast(raylib.Vector2, v),
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn Vector2Lerp(
    v1: Vector2,
    v2: Vector2,
    amount: f32,
) Vector2 {
    return raylib.Vector2Lerp(
        @bitCast(raylib.Vector2, v1),
        @bitCast(raylib.Vector2, v2),
        @bitCast(f32, amount),
    );
}

/// 
pub fn Vector2Reflect(
    v: Vector2,
    normal: Vector2,
) Vector2 {
    return raylib.Vector2Reflect(
        @bitCast(raylib.Vector2, v),
        @bitCast(raylib.Vector2, normal),
    );
}

/// 
pub fn Vector2Rotate(
    v: Vector2,
    angle: f32,
) Vector2 {
    return raylib.Vector2Rotate(
        @bitCast(raylib.Vector2, v),
        @bitCast(f32, angle),
    );
}

/// 
pub fn Vector2MoveTowards(
    v: Vector2,
    target: Vector2,
    maxDistance: f32,
) Vector2 {
    return raylib.Vector2MoveTowards(
        @bitCast(raylib.Vector2, v),
        @bitCast(raylib.Vector2, target),
        @bitCast(f32, maxDistance),
    );
}

/// 
pub fn Vector3Zero() Vector3 {
    return raylib.Vector3Zero();
}

/// 
pub fn Vector3One() Vector3 {
    return raylib.Vector3One();
}

/// 
pub fn Vector3Add(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Add(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3AddValue(
    v: Vector3,
    add: f32,
) Vector3 {
    return raylib.Vector3AddValue(
        @bitCast(raylib.Vector3, v),
        @bitCast(f32, add),
    );
}

/// 
pub fn Vector3Subtract(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Subtract(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3SubtractValue(
    v: Vector3,
    sub: f32,
) Vector3 {
    return raylib.Vector3SubtractValue(
        @bitCast(raylib.Vector3, v),
        @bitCast(f32, sub),
    );
}

/// 
pub fn Vector3Scale(
    v: Vector3,
    scalar: f32,
) Vector3 {
    return raylib.Vector3Scale(
        @bitCast(raylib.Vector3, v),
        @bitCast(f32, scalar),
    );
}

/// 
pub fn Vector3Multiply(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Multiply(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3CrossProduct(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3CrossProduct(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Perpendicular(
    v: Vector3,
) Vector3 {
    return raylib.Vector3Perpendicular(
        @bitCast(raylib.Vector3, v),
    );
}

/// 
pub fn Vector3Length(
    v: Vector3,
) f32 {
    return raylib.Vector3Length(
        @bitCast(Vector3, v),
    );
}

/// 
pub fn Vector3LengthSqr(
    v: Vector3,
) f32 {
    return raylib.Vector3LengthSqr(
        @bitCast(Vector3, v),
    );
}

/// 
pub fn Vector3DotProduct(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3DotProduct(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Distance(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3Distance(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3DistanceSqr(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3DistanceSqr(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Angle(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3Angle(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Negate(
    v: Vector3,
) Vector3 {
    return raylib.Vector3Negate(
        @bitCast(raylib.Vector3, v),
    );
}

/// 
pub fn Vector3Divide(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Divide(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Normalize(
    v: Vector3,
) Vector3 {
    return raylib.Vector3Normalize(
        @bitCast(raylib.Vector3, v),
    );
}

/// 
pub fn Vector3OrthoNormalize(
    v1: *Vector3,
    v2: *Vector3,
) void {
    raylib.Vector3OrthoNormalize(
        @ptrCast([*c]raylib.Vector3, v1),
        @ptrCast([*c]raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Transform(
    v: Vector3,
    mat: Matrix,
) Vector3 {
    return raylib.Vector3Transform(
        @bitCast(raylib.Vector3, v),
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn Vector3RotateByQuaternion(
    v: Vector3,
    q: Quaternion,
) Vector3 {
    return raylib.Vector3RotateByQuaternion(
        @bitCast(raylib.Vector3, v),
        @bitCast(raylib.Quaternion, q),
    );
}

/// 
pub fn Vector3Lerp(
    v1: Vector3,
    v2: Vector3,
    amount: f32,
) Vector3 {
    return raylib.Vector3Lerp(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
        @bitCast(f32, amount),
    );
}

/// 
pub fn Vector3Reflect(
    v: Vector3,
    normal: Vector3,
) Vector3 {
    return raylib.Vector3Reflect(
        @bitCast(raylib.Vector3, v),
        @bitCast(raylib.Vector3, normal),
    );
}

/// 
pub fn Vector3Min(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Min(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Max(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Max(
        @bitCast(raylib.Vector3, v1),
        @bitCast(raylib.Vector3, v2),
    );
}

/// 
pub fn Vector3Barycenter(
    p: Vector3,
    a: Vector3,
    b: Vector3,
    c: Vector3,
) Vector3 {
    return raylib.Vector3Barycenter(
        @bitCast(raylib.Vector3, p),
        @bitCast(raylib.Vector3, a),
        @bitCast(raylib.Vector3, b),
        @bitCast(raylib.Vector3, c),
    );
}

/// 
pub fn Vector3Unproject(
    source: Vector3,
    projection: Matrix,
    view: Matrix,
) Vector3 {
    return raylib.Vector3Unproject(
        @bitCast(raylib.Vector3, source),
        @bitCast(raylib.Matrix, projection),
        @bitCast(raylib.Matrix, view),
    );
}

/// 
pub fn Vector3ToFloatV(
    v: Vector3,
) float3 {
    return raylib.Vector3ToFloatV(
        @bitCast(raylib.Vector3, v),
    );
}

/// 
pub fn MatrixDeterminant(
    mat: Matrix,
) f32 {
    return raylib.MatrixDeterminant(
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn MatrixTrace(
    mat: Matrix,
) f32 {
    return raylib.MatrixTrace(
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn MatrixTranspose(
    mat: Matrix,
) Matrix {
    return raylib.MatrixTranspose(
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn MatrixInvert(
    mat: Matrix,
) Matrix {
    return raylib.MatrixInvert(
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn MatrixIdentity() Matrix {
    return raylib.MatrixIdentity();
}

/// 
pub fn MatrixAdd(
    left: Matrix,
    right: Matrix,
) Matrix {
    return raylib.MatrixAdd(
        @bitCast(raylib.Matrix, left),
        @bitCast(raylib.Matrix, right),
    );
}

/// 
pub fn MatrixSubtract(
    left: Matrix,
    right: Matrix,
) Matrix {
    return raylib.MatrixSubtract(
        @bitCast(raylib.Matrix, left),
        @bitCast(raylib.Matrix, right),
    );
}

/// 
pub fn MatrixMultiply(
    left: Matrix,
    right: Matrix,
) Matrix {
    return raylib.MatrixMultiply(
        @bitCast(raylib.Matrix, left),
        @bitCast(raylib.Matrix, right),
    );
}

/// 
pub fn MatrixTranslate(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    return raylib.MatrixTranslate(
        @bitCast(f32, x),
        @bitCast(f32, y),
        @bitCast(f32, z),
    );
}

/// 
pub fn MatrixRotate(
    axis: Vector3,
    angle: f32,
) Matrix {
    return raylib.MatrixRotate(
        @bitCast(raylib.Vector3, axis),
        @bitCast(f32, angle),
    );
}

/// 
pub fn MatrixRotateX(
    angle: f32,
) Matrix {
    return raylib.MatrixRotateX(
        @bitCast(f32, angle),
    );
}

/// 
pub fn MatrixRotateY(
    angle: f32,
) Matrix {
    return raylib.MatrixRotateY(
        @bitCast(f32, angle),
    );
}

/// 
pub fn MatrixRotateZ(
    angle: f32,
) Matrix {
    return raylib.MatrixRotateZ(
        @bitCast(f32, angle),
    );
}

/// 
pub fn MatrixRotateXYZ(
    ang: Vector3,
) Matrix {
    return raylib.MatrixRotateXYZ(
        @bitCast(raylib.Vector3, ang),
    );
}

/// 
pub fn MatrixRotateZYX(
    ang: Vector3,
) Matrix {
    return raylib.MatrixRotateZYX(
        @bitCast(raylib.Vector3, ang),
    );
}

/// 
pub fn MatrixScale(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    return raylib.MatrixScale(
        @bitCast(f32, x),
        @bitCast(f32, y),
        @bitCast(f32, z),
    );
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
    return raylib.MatrixFrustum(
        @bitCast(f64, left),
        @bitCast(f64, right),
        @bitCast(f64, bottom),
        @bitCast(f64, top),
        @bitCast(f64, near),
        @bitCast(f64, far),
    );
}

/// 
pub fn MatrixPerspective(
    fovy: f64,
    aspect: f64,
    near: f64,
    far: f64,
) Matrix {
    return raylib.MatrixPerspective(
        @bitCast(f64, fovy),
        @bitCast(f64, aspect),
        @bitCast(f64, near),
        @bitCast(f64, far),
    );
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
    return raylib.MatrixOrtho(
        @bitCast(f64, left),
        @bitCast(f64, right),
        @bitCast(f64, bottom),
        @bitCast(f64, top),
        @bitCast(f64, near),
        @bitCast(f64, far),
    );
}

/// 
pub fn MatrixLookAt(
    eye: Vector3,
    target: Vector3,
    up: Vector3,
) Matrix {
    return raylib.MatrixLookAt(
        @bitCast(raylib.Vector3, eye),
        @bitCast(raylib.Vector3, target),
        @bitCast(raylib.Vector3, up),
    );
}

/// 
pub fn MatrixToFloatV(
    mat: Matrix,
) float16 {
    return raylib.MatrixToFloatV(
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn QuaternionAdd(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionAdd(
        @bitCast(raylib.Quaternion, q1),
        @bitCast(raylib.Quaternion, q2),
    );
}

/// 
pub fn QuaternionAddValue(
    q: Quaternion,
    add: f32,
) Quaternion {
    return raylib.QuaternionAddValue(
        @bitCast(raylib.Quaternion, q),
        @bitCast(f32, add),
    );
}

/// 
pub fn QuaternionSubtract(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionSubtract(
        @bitCast(raylib.Quaternion, q1),
        @bitCast(raylib.Quaternion, q2),
    );
}

/// 
pub fn QuaternionSubtractValue(
    q: Quaternion,
    sub: f32,
) Quaternion {
    return raylib.QuaternionSubtractValue(
        @bitCast(raylib.Quaternion, q),
        @bitCast(f32, sub),
    );
}

/// 
pub fn QuaternionIdentity() Quaternion {
    return raylib.QuaternionIdentity();
}

/// 
pub fn QuaternionLength(
    q: Quaternion,
) f32 {
    return raylib.QuaternionLength(
        @bitCast(raylib.Quaternion, q),
    );
}

/// 
pub fn QuaternionNormalize(
    q: Quaternion,
) Quaternion {
    return raylib.QuaternionNormalize(
        @bitCast(raylib.Quaternion, q),
    );
}

/// 
pub fn QuaternionInvert(
    q: Quaternion,
) Quaternion {
    return raylib.QuaternionInvert(
        @bitCast(raylib.Quaternion, q),
    );
}

/// 
pub fn QuaternionMultiply(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionMultiply(
        @bitCast(raylib.Quaternion, q1),
        @bitCast(raylib.Quaternion, q2),
    );
}

/// 
pub fn QuaternionScale(
    q: Quaternion,
    mul: f32,
) Quaternion {
    return raylib.QuaternionScale(
        @bitCast(raylib.Quaternion, q),
        @bitCast(f32, mul),
    );
}

/// 
pub fn QuaternionDivide(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionDivide(
        @bitCast(raylib.Quaternion, q1),
        @bitCast(raylib.Quaternion, q2),
    );
}

/// 
pub fn QuaternionLerp(
    q1: Quaternion,
    q2: Quaternion,
    amount: f32,
) Quaternion {
    return raylib.QuaternionLerp(
        @bitCast(raylib.Quaternion, q1),
        @bitCast(raylib.Quaternion, q2),
        @bitCast(f32, amount),
    );
}

/// 
pub fn QuaternionNlerp(
    q1: Quaternion,
    q2: Quaternion,
    amount: f32,
) Quaternion {
    return raylib.QuaternionNlerp(
        @bitCast(raylib.Quaternion, q1),
        @bitCast(raylib.Quaternion, q2),
        @bitCast(f32, amount),
    );
}

/// 
pub fn QuaternionSlerp(
    q1: Quaternion,
    q2: Quaternion,
    amount: f32,
) Quaternion {
    return raylib.QuaternionSlerp(
        @bitCast(raylib.Quaternion, q1),
        @bitCast(raylib.Quaternion, q2),
        @bitCast(f32, amount),
    );
}

/// 
pub fn QuaternionFromVector3ToVector3(
    from: Vector3,
    to: Vector3,
) Quaternion {
    return raylib.QuaternionFromVector3ToVector3(
        @bitCast(raylib.Vector3, from),
        @bitCast(raylib.Vector3, to),
    );
}

/// 
pub fn QuaternionFromMatrix(
    mat: Matrix,
) Quaternion {
    return raylib.QuaternionFromMatrix(
        @bitCast(raylib.Matrix, mat),
    );
}

/// 
pub fn QuaternionToMatrix(
    q: Quaternion,
) Matrix {
    return raylib.QuaternionToMatrix(
        @bitCast(raylib.Quaternion, q),
    );
}

/// 
pub fn QuaternionFromAxisAngle(
    axis: Vector3,
    angle: f32,
) Quaternion {
    return raylib.QuaternionFromAxisAngle(
        @bitCast(raylib.Vector3, axis),
        @bitCast(f32, angle),
    );
}

/// 
pub fn QuaternionToAxisAngle(
    q: Quaternion,
    outAxis: *Vector3,
    outAngle: []f32,
) void {
    raylib.QuaternionToAxisAngle(
        @bitCast(raylib.Quaternion, q),
        @ptrCast([*c]raylib.Vector3, outAxis),
        @ptrCast([*c]f32, outAngle.ptr),
    );
}

/// 
pub fn QuaternionFromEuler(
    pitch: f32,
    yaw: f32,
    roll: f32,
) Quaternion {
    return raylib.QuaternionFromEuler(
        @bitCast(f32, pitch),
        @bitCast(f32, yaw),
        @bitCast(f32, roll),
    );
}

/// 
pub fn QuaternionToEuler(
    q: Quaternion,
) Vector3 {
    return raylib.QuaternionToEuler(
        @bitCast(raylib.Quaternion, q),
    );
}

/// 
pub fn QuaternionTransform(
    q: Quaternion,
    mat: Matrix,
) Quaternion {
    return raylib.QuaternionTransform(
        @bitCast(raylib.Quaternion, q),
        @bitCast(raylib.Matrix, mat),
    );
}

/// Enable gui controls (global state)
pub fn GuiEnable() void {
    raylib.GuiEnable();
}

/// Disable gui controls (global state)
pub fn GuiDisable() void {
    raylib.GuiDisable();
}

/// Lock gui controls (global state)
pub fn GuiLock() void {
    raylib.GuiLock();
}

/// Unlock gui controls (global state)
pub fn GuiUnlock() void {
    raylib.GuiUnlock();
}

/// Check if gui is locked (global state)
pub fn GuiIsLocked() bool {
    return raylib.GuiIsLocked();
}

/// Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
pub fn GuiFade(
    alpha: f32,
) void {
    raylib.GuiFade(
        @bitCast(f32, alpha),
    );
}

/// Set gui state (global state)
pub fn GuiSetState(
    state: i32,
) void {
    raylib.GuiSetState(
        @intCast(c_int, state),
    );
}

/// Get gui state (global state)
pub fn GuiGetState() i32 {
    return raylib.GuiGetState();
}

/// Set gui custom font (global state)
pub fn GuiSetFont(
    font: Font,
) void {
    raylib.GuiSetFont(
        @bitCast(raylib.Font, font),
    );
}

/// Get gui custom font (global state)
pub fn GuiGetFont() Font {
    return raylib.GuiGetFont();
}

/// Set one style property
pub fn GuiSetStyle(
    control: i32,
    property: i32,
    value: i32,
) void {
    raylib.GuiSetStyle(
        @intCast(c_int, control),
        @intCast(c_int, property),
        @intCast(c_int, value),
    );
}

/// Get one style property
pub fn GuiGetStyle(
    control: i32,
    property: i32,
) i32 {
    return raylib.GuiGetStyle(
        @intCast(c_int, control),
        @intCast(c_int, property),
    );
}

/// Window Box control, shows a window that can be closed
pub fn GuiWindowBox(
    bounds: Rectangle,
    title: [:0]const u8,
) bool {
    return raylib.GuiWindowBox(
        @bitCast(raylib.Rectangle, bounds),
        title,
    );
}

/// Group Box control with text name
pub fn GuiGroupBox(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiGroupBox(
        @bitCast(raylib.Rectangle, bounds),
        text,
    );
}

/// Line separator control, could contain text
pub fn GuiLine(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiLine(
        @bitCast(raylib.Rectangle, bounds),
        text,
    );
}

/// Panel control, useful to group controls
pub fn GuiPanel(
    bounds: Rectangle,
) void {
    raylib.GuiPanel(
        @bitCast(raylib.Rectangle, bounds),
    );
}

/// Scroll Panel control
pub fn GuiScrollPanel(
    bounds: Rectangle,
    content: Rectangle,
    scroll: *Vector2,
) Rectangle {
    return raylib.GuiScrollPanel(
        @bitCast(raylib.Rectangle, bounds),
        @bitCast(raylib.Rectangle, content),
        @ptrCast([*c]raylib.Vector2, scroll),
    );
}

/// Label control, shows text
pub fn GuiLabel(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiLabel(
        @bitCast(raylib.Rectangle, bounds),
        text,
    );
}

/// Button control, returns true when clicked
pub fn GuiButton(
    bounds: Rectangle,
    text: [:0]const u8,
) bool {
    return raylib.GuiButton(
        @bitCast(raylib.Rectangle, bounds),
        text,
    );
}

/// Label button control, show true when clicked
pub fn GuiLabelButton(
    bounds: Rectangle,
    text: [:0]const u8,
) bool {
    return raylib.GuiLabelButton(
        @bitCast(raylib.Rectangle, bounds),
        text,
    );
}

/// Toggle Button control, returns true when active
pub fn GuiToggle(
    bounds: Rectangle,
    text: [:0]const u8,
    active: bool,
) bool {
    return raylib.GuiToggle(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @bitCast(bool, active),
    );
}

/// Toggle Group control, returns active toggle index
pub fn GuiToggleGroup(
    bounds: Rectangle,
    text: [:0]const u8,
    active: i32,
) i32 {
    return raylib.GuiToggleGroup(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @intCast(c_int, active),
    );
}

/// Check Box control, returns true when active
pub fn GuiCheckBox(
    bounds: Rectangle,
    text: [:0]const u8,
    checked: bool,
) bool {
    return raylib.GuiCheckBox(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @bitCast(bool, checked),
    );
}

/// Combo Box control, returns selected item index
pub fn GuiComboBox(
    bounds: Rectangle,
    text: [:0]const u8,
    active: i32,
) i32 {
    return raylib.GuiComboBox(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @intCast(c_int, active),
    );
}

/// Dropdown Box control, returns selected item
pub fn GuiDropdownBox(
    bounds: Rectangle,
    text: [:0]const u8,
    active: []i32,
    editMode: bool,
) bool {
    return raylib.GuiDropdownBox(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @ptrCast([*c]c_int, active.ptr),
        @bitCast(bool, editMode),
    );
}

/// Spinner control, returns selected value
pub fn GuiSpinner(
    bounds: Rectangle,
    text: [:0]const u8,
    value: []i32,
    minValue: i32,
    maxValue: i32,
    editMode: bool,
) bool {
    return raylib.GuiSpinner(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @ptrCast([*c]c_int, value.ptr),
        @intCast(c_int, minValue),
        @intCast(c_int, maxValue),
        @bitCast(bool, editMode),
    );
}

/// Value Box control, updates input text with numbers
pub fn GuiValueBox(
    bounds: Rectangle,
    text: [:0]const u8,
    value: []i32,
    minValue: i32,
    maxValue: i32,
    editMode: bool,
) bool {
    return raylib.GuiValueBox(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @ptrCast([*c]c_int, value.ptr),
        @intCast(c_int, minValue),
        @intCast(c_int, maxValue),
        @bitCast(bool, editMode),
    );
}

/// Text Box control, updates input text
pub fn GuiTextBox(
    bounds: Rectangle,
    text: [:0]const u8,
    textSize: i32,
    editMode: bool,
) bool {
    return raylib.GuiTextBox(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @intCast(c_int, textSize),
        @bitCast(bool, editMode),
    );
}

/// Text Box control with multiple lines
pub fn GuiTextBoxMulti(
    bounds: Rectangle,
    text: [:0]const u8,
    textSize: i32,
    editMode: bool,
) bool {
    return raylib.GuiTextBoxMulti(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @intCast(c_int, textSize),
        @bitCast(bool, editMode),
    );
}

/// Slider control, returns selected value
pub fn GuiSlider(
    bounds: Rectangle,
    textLeft: [:0]const u8,
    textRight: [:0]const u8,
    value: f32,
    minValue: f32,
    maxValue: f32,
) f32 {
    return raylib.GuiSlider(
        @bitCast(raylib.Rectangle, bounds),
        textLeft,
        textRight,
        @bitCast(f32, value),
        @bitCast(f32, minValue),
        @bitCast(f32, maxValue),
    );
}

/// Slider Bar control, returns selected value
pub fn GuiSliderBar(
    bounds: Rectangle,
    textLeft: [:0]const u8,
    textRight: [:0]const u8,
    value: f32,
    minValue: f32,
    maxValue: f32,
) f32 {
    return raylib.GuiSliderBar(
        @bitCast(raylib.Rectangle, bounds),
        textLeft,
        textRight,
        @bitCast(f32, value),
        @bitCast(f32, minValue),
        @bitCast(f32, maxValue),
    );
}

/// Progress Bar control, shows current progress value
pub fn GuiProgressBar(
    bounds: Rectangle,
    textLeft: [:0]const u8,
    textRight: [:0]const u8,
    value: f32,
    minValue: f32,
    maxValue: f32,
) f32 {
    return raylib.GuiProgressBar(
        @bitCast(raylib.Rectangle, bounds),
        textLeft,
        textRight,
        @bitCast(f32, value),
        @bitCast(f32, minValue),
        @bitCast(f32, maxValue),
    );
}

/// Status Bar control, shows info text
pub fn GuiStatusBar(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiStatusBar(
        @bitCast(raylib.Rectangle, bounds),
        text,
    );
}

/// Dummy control for placeholders
pub fn GuiDummyRec(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiDummyRec(
        @bitCast(raylib.Rectangle, bounds),
        text,
    );
}

/// Scroll Bar control
pub fn GuiScrollBar(
    bounds: Rectangle,
    value: i32,
    minValue: i32,
    maxValue: i32,
) i32 {
    return raylib.GuiScrollBar(
        @bitCast(raylib.Rectangle, bounds),
        @intCast(c_int, value),
        @intCast(c_int, minValue),
        @intCast(c_int, maxValue),
    );
}

/// Grid control
pub fn GuiGrid(
    bounds: Rectangle,
    spacing: f32,
    subdivs: i32,
) Vector2 {
    return raylib.GuiGrid(
        @bitCast(raylib.Rectangle, bounds),
        @bitCast(f32, spacing),
        @intCast(c_int, subdivs),
    );
}

/// List View control, returns selected list item index
pub fn GuiListView(
    bounds: Rectangle,
    text: [:0]const u8,
    scrollIndex: []i32,
    active: i32,
) i32 {
    return raylib.GuiListView(
        @bitCast(raylib.Rectangle, bounds),
        text,
        @ptrCast([*c]c_int, scrollIndex.ptr),
        @intCast(c_int, active),
    );
}

/// List View with extended parameters
pub fn GuiListViewEx(
    bounds: Rectangle,
    text: [*c][:0]const u8,
    count: i32,
    focus: []i32,
    scrollIndex: []i32,
    active: i32,
) i32 {
    return raylib.GuiListViewEx(
        @bitCast(raylib.Rectangle, bounds),
        @ptrCast([*c][:0]const u8, text),
        @intCast(c_int, count),
        @ptrCast([*c]c_int, focus.ptr),
        @ptrCast([*c]c_int, scrollIndex.ptr),
        @intCast(c_int, active),
    );
}

/// Message Box control, displays a message
pub fn GuiMessageBox(
    bounds: Rectangle,
    title: [:0]const u8,
    message: [:0]const u8,
    buttons: [:0]const u8,
) i32 {
    return raylib.GuiMessageBox(
        @bitCast(raylib.Rectangle, bounds),
        title,
        message,
        buttons,
    );
}

/// Text Input Box control, ask for text
pub fn GuiTextInputBox(
    bounds: Rectangle,
    title: [:0]const u8,
    message: [:0]const u8,
    buttons: [:0]const u8,
    text: [:0]const u8,
) i32 {
    return raylib.GuiTextInputBox(
        @bitCast(raylib.Rectangle, bounds),
        title,
        message,
        buttons,
        text,
    );
}

/// Color Picker control (multiple color controls)
pub fn GuiColorPicker(
    bounds: Rectangle,
    color: Color,
) Color {
    return raylib.GuiColorPicker(
        @bitCast(raylib.Rectangle, bounds),
        @bitCast(raylib.Color, color),
    );
}

/// Color Panel control
pub fn GuiColorPanel(
    bounds: Rectangle,
    color: Color,
) Color {
    return raylib.GuiColorPanel(
        @bitCast(raylib.Rectangle, bounds),
        @bitCast(raylib.Color, color),
    );
}

/// Color Bar Alpha control
pub fn GuiColorBarAlpha(
    bounds: Rectangle,
    alpha: f32,
) f32 {
    return raylib.GuiColorBarAlpha(
        @bitCast(raylib.Rectangle, bounds),
        @bitCast(f32, alpha),
    );
}

/// Color Bar Hue control
pub fn GuiColorBarHue(
    bounds: Rectangle,
    value: f32,
) f32 {
    return raylib.GuiColorBarHue(
        @bitCast(raylib.Rectangle, bounds),
        @bitCast(f32, value),
    );
}

/// Load style file over global style variable (.rgs)
pub fn GuiLoadStyle(
    fileName: [:0]const u8,
) void {
    raylib.GuiLoadStyle(
        fileName,
    );
}

/// Load style default over global style
pub fn GuiLoadStyleDefault() void {
    raylib.GuiLoadStyleDefault();
}

/// Load style from file (.rgs)
pub fn LoadGuiStyle(
    fileName: [:0]const u8,
) GuiStyle {
    return raylib.LoadGuiStyle(
        fileName,
    );
}

/// Unload style
pub fn UnloadGuiStyle(
    style: GuiStyle,
) void {
    raylib.UnloadGuiStyle(
        @bitCast(raylib.GuiStyle, style),
    );
}

/// Get text with icon id prepended (if supported)
pub fn GuiIconText(
    iconId: i32,
    text: [:0]const u8,
) [:0]const u8 {
    return raylib.GuiIconText(
        @intCast(c_int, iconId),
        text,
    );
}

/// 
pub fn GuiDrawIcon(
    iconId: i32,
    posX: i32,
    posY: i32,
    pixelSize: i32,
    color: Color,
) void {
    raylib.GuiDrawIcon(
        @intCast(c_int, iconId),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, pixelSize),
        @bitCast(raylib.Color, color),
    );
}

/// Get full icons data pointer
pub fn GuiGetIcons() [*c]c_uint {
    return raylib.GuiGetIcons();
}

/// Get icon bit data
pub fn GuiGetIconData(
    iconId: i32,
) [*c]c_uint {
    return raylib.GuiGetIconData(
        @intCast(c_int, iconId),
    );
}

/// Set icon bit data
pub fn GuiSetIconData(
    iconId: i32,
    data: []u32,
) void {
    raylib.GuiSetIconData(
        @intCast(c_int, iconId),
        @ptrCast([*c]c_uint, data.ptr),
    );
}

/// Set icon pixel value
pub fn GuiSetIconPixel(
    iconId: i32,
    x: i32,
    y: i32,
) void {
    raylib.GuiSetIconPixel(
        @intCast(c_int, iconId),
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}

/// Clear icon pixel value
pub fn GuiClearIconPixel(
    iconId: i32,
    x: i32,
    y: i32,
) void {
    raylib.GuiClearIconPixel(
        @intCast(c_int, iconId),
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}

/// Check icon pixel value
pub fn GuiCheckIconPixel(
    iconId: i32,
    x: i32,
    y: i32,
) bool {
    return raylib.GuiCheckIconPixel(
        @intCast(c_int, iconId),
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}
