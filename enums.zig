/// System/Window config flags
pub const ConfigFlags = enum(c_int) {
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
pub const TraceLogLevel = enum(c_int) {
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
pub const KeyboardKey = enum(c_int) {
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
    /// Key: Android menu button
    KEY_MENU = 82,
    /// Key: Android volume up button
    KEY_VOLUME_UP = 24,
    /// Key: Android volume down button
    KEY_VOLUME_DOWN = 25,
};

/// Mouse buttons
pub const MouseButton = enum(c_int) {
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
pub const MouseCursor = enum(c_int) {
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
pub const GamepadButton = enum(c_int) {
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
pub const GamepadAxis = enum(c_int) {
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
pub const MaterialMapIndex = enum(c_int) {
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
pub const ShaderLocationIndex = enum(c_int) {
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
pub const ShaderUniformDataType = enum(c_int) {
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
pub const ShaderAttributeDataType = enum(c_int) {
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
pub const PixelFormat = enum(c_int) {
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
pub const TextureFilter = enum(c_int) {
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
pub const TextureWrap = enum(c_int) {
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
pub const CubemapLayout = enum(c_int) {
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
pub const FontType = enum(c_int) {
    /// Default font generation, anti-aliased
    FONT_DEFAULT = 0,
    /// Bitmap font generation, no anti-aliasing
    FONT_BITMAP = 1,
    /// SDF font generation, requires external shader
    FONT_SDF = 2,
};

/// Color blending modes (pre-defined)
pub const BlendMode = enum(c_int) {
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
pub const Gesture = enum(c_int) {
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
pub const CameraMode = enum(c_int) {
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
pub const CameraProjection = enum(c_int) {
    /// Perspective projection
    CAMERA_PERSPECTIVE = 0,
    /// Orthographic projection
    CAMERA_ORTHOGRAPHIC = 1,
};

/// N-patch layout
pub const NPatchLayout = enum(c_int) {
    /// Npatch layout: 3x3 tiles
    NPATCH_NINE_PATCH = 0,
    /// Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_VERTICAL = 1,
    /// Npatch layout: 3x1 tiles
    NPATCH_THREE_PATCH_HORIZONTAL = 2,
};

/// Gui control state
pub const GuiControlState = enum(c_int) {
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
pub const GuiTextAlignment = enum(c_int) {
    /// 
    GUI_TEXT_ALIGN_LEFT = 0,
    /// 
    GUI_TEXT_ALIGN_CENTER = 1,
    /// 
    GUI_TEXT_ALIGN_RIGHT = 2,
};

/// Gui controls
pub const GuiControl = enum(c_int) {
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
pub const GuiControlProperty = enum(c_int) {
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
pub const GuiDefaultProperty = enum(c_int) {
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
pub const GuiToggleProperty = enum(c_int) {
    /// 
    GROUP_PADDING = 16,
};

/// Slider/SliderBar
pub const GuiSliderProperty = enum(c_int) {
    /// 
    SLIDER_WIDTH = 16,
    /// 
    SLIDER_PADDING = 17,
};

/// ProgressBar
pub const GuiProgressBarProperty = enum(c_int) {
    /// 
    PROGRESS_PADDING = 16,
};

/// CheckBox
pub const GuiCheckBoxProperty = enum(c_int) {
    /// 
    CHECK_PADDING = 16,
};

/// ComboBox
pub const GuiComboBoxProperty = enum(c_int) {
    /// 
    COMBO_BUTTON_WIDTH = 16,
    /// 
    COMBO_BUTTON_PADDING = 17,
};

/// DropdownBox
pub const GuiDropdownBoxProperty = enum(c_int) {
    /// 
    ARROW_PADDING = 16,
    /// 
    DROPDOWN_ITEMS_PADDING = 17,
};

/// TextBox/TextBoxMulti/ValueBox/Spinner
pub const GuiTextBoxProperty = enum(c_int) {
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
pub const GuiSpinnerProperty = enum(c_int) {
    /// 
    SPIN_BUTTON_WIDTH = 16,
    /// 
    SPIN_BUTTON_PADDING = 17,
};

/// ScrollBar
pub const GuiScrollBarProperty = enum(c_int) {
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
pub const GuiScrollBarSide = enum(c_int) {
    /// 
    SCROLLBAR_LEFT_SIDE = 0,
    /// 
    SCROLLBAR_RIGHT_SIDE = 1,
};

/// ListView
pub const GuiListViewProperty = enum(c_int) {
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
pub const GuiColorPickerProperty = enum(c_int) {
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
pub const guiIconName = enum(c_int) {
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
