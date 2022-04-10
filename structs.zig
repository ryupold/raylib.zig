const types = @import("manual_bindings.zig");

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
    source: types.Rectangle,
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
    recs: *types.Rectangle,
    /// Glyphs info data
    glyphs: *GlyphInfo,
};

/// Camera, defines position/orientation in 3d space
pub const Camera3D = extern struct {
    /// Camera position
    position: types.Vector3,
    /// Camera target it looks-at
    target: types.Vector3,
    /// Camera up vector (rotation over its axis)
    up: types.Vector3,
    /// Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
    fovy: f32,
    /// Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
    projection: i32,
};

/// Camera2D, defines position/orientation in 2d space
pub const Camera2D = extern struct {
    /// Camera offset (displacement from target)
    offset: types.Vector2 = .{.x = 0, .y = 0},
    /// Camera target (rotation and zoom origin)
    target: types.Vector2,
    /// Camera rotation in degrees
    rotation: f32 = 0,
    /// Camera zoom (scaling), should be 1.0f by default
    zoom: f32 = 1,
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
    color: types.Color,
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
    position: types.Vector3,
    /// Ray direction
    direction: types.Vector3,
};

/// RayCollision, ray hit information
pub const RayCollision = extern struct {
    /// Did the ray hit something?
    hit: bool,
    /// Distance to nearest hit
    distance: f32,
    /// Point of nearest hit
    point: types.Vector3,
    /// Surface normal of hit
    normal: types.Vector3,
};

/// BoundingBox
pub const BoundingBox = extern struct {
    /// Minimum vertex box-corner
    min: types.Vector3,
    /// Maximum vertex box-corner
    max: types.Vector3,
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
