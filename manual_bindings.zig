//! This file contains manual binding definitions for structs & functions.
//! When the generator ecounters one of this function- or struct names, it is skipped.
//! 
//! In these cases it is not decidable for the binding generator how the 
//! function arguments need to be interpreted (e.g.: pointer to one or many elements)

const raylib = @cImport({
    @cInclude("raylib/src/raylib.h");
});

const types = struct {
    usingnamespace @import("structs.zig");
    usingnamespace @import("enums.zig");
};

/// Load file data as byte array (read)
pub fn LoadFileData(
    fileName: []const u8,
) []const u8 {
    var bytesRead: u32 = undefined;

    const ptr: [*c]const u8 = raylib.LoadFileData(
        @ptrCast([*c]const u8, fileName.ptr),
        @ptrCast([*c]c_uint, &bytesRead),
    );

    return ptr[0..bytesRead];
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
) [*c]types.GlyphInfo {
    return raylib.LoadFontData(
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

/// 3D Quaternion (same as Vector4)
pub const Quaternion = types.Vector4;

/// Same layout as Texture
pub const TextureCubemap = types.Texture;

/// Same layout as RenderTexture
pub const RenderTexture2D = types.RenderTexture;

/// Alias for Camera3D
pub const Camera = types.Camera3D;

/// Transform, vectex transformation data
pub const Transform = extern struct {
    /// Translation
    translation: types.Vector3,
    /// Rotation
    rotation: Quaternion,
    /// Scale
    scale: types.Vector3,
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
    transform: types.Matrix,
    /// Number of meshes
    meshCount: i32,
    /// Number of materials
    materialCount: i32,
    /// Meshes array
    meshes: *types.Mesh,
    /// Materials array
    materials: *types.Material,
    /// Mesh material number
    meshMaterial: []i32,
    /// Number of bones
    boneCount: i32,
    /// Bones information (skeleton)
    bones: *types.BoneInfo,
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
    bones: *types.BoneInfo,
    /// Poses array by frame
    framePoses: [*c][*c]Transform,
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
