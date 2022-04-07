usingnamespace @import("enums.zig");
usingnamespace @import("structs.zig");

/// Initialize window and OpenGL context
pub fn InitWindow(
    width: i32,
    height: i32,
    title: []const u8,
) void {}

/// Check if KEY_ESCAPE pressed or Close icon pressed
pub fn WindowShouldClose() bool {}

/// Close window and unload OpenGL context
pub fn CloseWindow() void {}

/// Check if window has been initialized successfully
pub fn IsWindowReady() bool {}

/// Check if window is currently fullscreen
pub fn IsWindowFullscreen() bool {}

/// Check if window is currently hidden (only PLATFORM_DESKTOP)
pub fn IsWindowHidden() bool {}

/// Check if window is currently minimized (only PLATFORM_DESKTOP)
pub fn IsWindowMinimized() bool {}

/// Check if window is currently maximized (only PLATFORM_DESKTOP)
pub fn IsWindowMaximized() bool {}

/// Check if window is currently focused (only PLATFORM_DESKTOP)
pub fn IsWindowFocused() bool {}

/// Check if window has been resized last frame
pub fn IsWindowResized() bool {}

/// Check if one specific window flag is enabled
pub fn IsWindowState(
    flag: u32,
) bool {}

/// Set window configuration state using flags (only PLATFORM_DESKTOP)
pub fn SetWindowState(
    flags: u32,
) void {}

/// Clear window configuration state flags
pub fn ClearWindowState(
    flags: u32,
) void {}

/// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
pub fn ToggleFullscreen() void {}

/// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
pub fn MaximizeWindow() void {}

/// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
pub fn MinimizeWindow() void {}

/// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
pub fn RestoreWindow() void {}

/// Set icon for window (only PLATFORM_DESKTOP)
pub fn SetWindowIcon(
    image: Image,
) void {}

/// Set title for window (only PLATFORM_DESKTOP)
pub fn SetWindowTitle(
    title: []const u8,
) void {}

/// Set window position on screen (only PLATFORM_DESKTOP)
pub fn SetWindowPosition(
    x: i32,
    y: i32,
) void {}

/// Set monitor for the current window (fullscreen mode)
pub fn SetWindowMonitor(
    monitor: i32,
) void {}

/// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub fn SetWindowMinSize(
    width: i32,
    height: i32,
) void {}

/// Set window dimensions
pub fn SetWindowSize(
    width: i32,
    height: i32,
) void {}

/// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
pub fn SetWindowOpacity(
    opacity: f32,
) void {}

/// Get native window handle
pub fn GetWindowHandle() *anyopaque {}

/// Get current screen width
pub fn GetScreenWidth() i32 {}

/// Get current screen height
pub fn GetScreenHeight() i32 {}

/// Get current render width (it considers HiDPI)
pub fn GetRenderWidth() i32 {}

/// Get current render height (it considers HiDPI)
pub fn GetRenderHeight() i32 {}

/// Get number of connected monitors
pub fn GetMonitorCount() i32 {}

/// Get current connected monitor
pub fn GetCurrentMonitor() i32 {}

/// Get specified monitor position
pub fn GetMonitorPosition(
    monitor: i32,
) Vector2 {}

/// Get specified monitor width (max available by monitor)
pub fn GetMonitorWidth(
    monitor: i32,
) i32 {}

/// Get specified monitor height (max available by monitor)
pub fn GetMonitorHeight(
    monitor: i32,
) i32 {}

/// Get specified monitor physical width in millimetres
pub fn GetMonitorPhysicalWidth(
    monitor: i32,
) i32 {}

/// Get specified monitor physical height in millimetres
pub fn GetMonitorPhysicalHeight(
    monitor: i32,
) i32 {}

/// Get specified monitor refresh rate
pub fn GetMonitorRefreshRate(
    monitor: i32,
) i32 {}

/// Get window position XY on monitor
pub fn GetWindowPosition() Vector2 {}

/// Get window scale DPI factor
pub fn GetWindowScaleDPI() Vector2 {}

/// Get the human-readable, UTF-8 encoded name of the primary monitor
pub fn GetMonitorName(
    monitor: i32,
) []const u8 {}

/// Set clipboard text content
pub fn SetClipboardText(
    text: []const u8,
) void {}

/// Get clipboard text content
pub fn GetClipboardText() []const u8 {}

/// Swap back buffer with front buffer (screen drawing)
pub fn SwapScreenBuffer() void {}

/// Register all input events
pub fn PollInputEvents() void {}

/// Wait for some milliseconds (halt program execution)
pub fn WaitTime(
    ms: f32,
) void {}

/// Shows cursor
pub fn ShowCursor() void {}

/// Hides cursor
pub fn HideCursor() void {}

/// Check if cursor is not visible
pub fn IsCursorHidden() bool {}

/// Enables cursor (unlock cursor)
pub fn EnableCursor() void {}

/// Disables cursor (lock cursor)
pub fn DisableCursor() void {}

/// Check if cursor is on the screen
pub fn IsCursorOnScreen() bool {}

/// Set background color (framebuffer clear color)
pub fn ClearBackground(
    color: Color,
) void {}

/// Setup canvas (framebuffer) to start drawing
pub fn BeginDrawing() void {}

/// End canvas drawing and swap buffers (double buffering)
pub fn EndDrawing() void {}

/// Begin 2D mode with custom camera (2D)
pub fn BeginMode2D(
    camera: Camera2D,
) void {}

/// Ends 2D mode with custom camera
pub fn EndMode2D() void {}

/// Begin 3D mode with custom camera (3D)
pub fn BeginMode3D(
    camera: Camera3D,
) void {}

/// Ends 3D mode and returns to default 2D orthographic mode
pub fn EndMode3D() void {}

/// Begin drawing to render texture
pub fn BeginTextureMode(
    target: RenderTexture2D,
) void {}

/// Ends drawing to render texture
pub fn EndTextureMode() void {}

/// Begin custom shader drawing
pub fn BeginShaderMode(
    shader: Shader,
) void {}

/// End custom shader drawing (use default shader)
pub fn EndShaderMode() void {}

/// Begin blending mode (alpha, additive, multiplied, subtract, custom)
pub fn BeginBlendMode(
    mode: i32,
) void {}

/// End blending mode (reset to default: alpha blending)
pub fn EndBlendMode() void {}

/// Begin scissor mode (define screen area for following drawing)
pub fn BeginScissorMode(
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {}

/// End scissor mode
pub fn EndScissorMode() void {}

/// Begin stereo rendering (requires VR simulator)
pub fn BeginVrStereoMode(
    config: VrStereoConfig,
) void {}

/// End stereo rendering (requires VR simulator)
pub fn EndVrStereoMode() void {}

/// Load VR stereo config for VR simulator device parameters
pub fn LoadVrStereoConfig(
    device: VrDeviceInfo,
) VrStereoConfig {}

/// Unload VR stereo config
pub fn UnloadVrStereoConfig(
    config: VrStereoConfig,
) void {}

/// Load shader from files and bind default locations
pub fn LoadShader(
    vsFileName: []const u8,
    fsFileName: []const u8,
) Shader {}

/// Load shader from code strings and bind default locations
pub fn LoadShaderFromMemory(
    vsCode: []const u8,
    fsCode: []const u8,
) Shader {}

/// Get shader uniform location
pub fn GetShaderLocation(
    shader: Shader,
    uniformName: []const u8,
) i32 {}

/// Get shader attribute location
pub fn GetShaderLocationAttrib(
    shader: Shader,
    attribName: []const u8,
) i32 {}

/// Set shader uniform value
pub fn SetShaderValue(
    shader: Shader,
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
) void {}

/// Set shader uniform value vector
pub fn SetShaderValueV(
    shader: Shader,
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
    count: i32,
) void {}

/// Set shader uniform value (matrix 4x4)
pub fn SetShaderValueMatrix(
    shader: Shader,
    locIndex: i32,
    mat: Matrix,
) void {}

/// Set shader uniform value for texture (sampler2d)
pub fn SetShaderValueTexture(
    shader: Shader,
    locIndex: i32,
    texture: Texture2D,
) void {}

/// Unload shader from GPU memory (VRAM)
pub fn UnloadShader(
    shader: Shader,
) void {}

/// Get a ray trace from mouse position
pub fn GetMouseRay(
    mousePosition: Vector2,
    camera: Camera,
) Ray {}

/// Get camera transform matrix (view matrix)
pub fn GetCameraMatrix(
    camera: Camera,
) Matrix {}

/// Get camera 2d transform matrix
pub fn GetCameraMatrix2D(
    camera: Camera2D,
) Matrix {}

/// Get the screen space position for a 3d world space position
pub fn GetWorldToScreen(
    position: Vector3,
    camera: Camera,
) Vector2 {}

/// Get size position for a 3d world space position
pub fn GetWorldToScreenEx(
    position: Vector3,
    camera: Camera,
    width: i32,
    height: i32,
) Vector2 {}

/// Get the screen space position for a 2d camera world space position
pub fn GetWorldToScreen2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {}

/// Get the world space position for a 2d camera screen space position
pub fn GetScreenToWorld2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {}

/// Set target FPS (maximum)
pub fn SetTargetFPS(
    fps: i32,
) void {}

/// Get current FPS
pub fn GetFPS() i32 {}

/// Get time in seconds for last frame drawn (delta time)
pub fn GetFrameTime() f32 {}

/// Get elapsed time in seconds since InitWindow()
pub fn GetTime() double {}

/// Get a random value between min and max (both included)
pub fn GetRandomValue(
    min: i32,
    max: i32,
) i32 {}

/// Set the seed for the random number generator
pub fn SetRandomSeed(
    seed: u32,
) void {}

/// Takes a screenshot of current screen (filename extension defines format)
pub fn TakeScreenshot(
    fileName: []const u8,
) void {}

/// Setup init configuration flags (view FLAGS)
pub fn SetConfigFlags(
    flags: u32,
) void {}

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub fn TraceLog(
    logLevel: i32,
    text: []const u8,
) void {}

/// Set the current threshold (minimum) log level
pub fn SetTraceLogLevel(
    logLevel: i32,
) void {}

/// Internal memory allocator
pub fn MemAlloc(
    size: i32,
) *anyopaque {}

/// Internal memory reallocator
pub fn MemRealloc(
    ptr: *anyopaque,
    size: i32,
) *anyopaque {}

/// Internal memory free
pub fn MemFree(
    ptr: *anyopaque,
) void {}

/// Set custom trace log
pub fn SetTraceLogCallback(
    callback: TraceLogCallback,
) void {}

/// Set custom file binary data loader
pub fn SetLoadFileDataCallback(
    callback: LoadFileDataCallback,
) void {}

/// Set custom file binary data saver
pub fn SetSaveFileDataCallback(
    callback: SaveFileDataCallback,
) void {}

/// Set custom file text data loader
pub fn SetLoadFileTextCallback(
    callback: LoadFileTextCallback,
) void {}

/// Set custom file text data saver
pub fn SetSaveFileTextCallback(
    callback: SaveFileTextCallback,
) void {}

/// Load file data as byte array (read)
pub fn LoadFileData(
    fileName: []const u8,
    bytesRead: []u32,
) []const u8 {}

/// Unload file data allocated by LoadFileData()
pub fn UnloadFileData(
    data: []const u8,
) void {}

/// Save data to file from byte array (write), returns true on success
pub fn SaveFileData(
    fileName: []const u8,
    data: *anyopaque,
    bytesToWrite: u32,
) bool {}

/// Load text data from file (read), returns a '\0' terminated string
pub fn LoadFileText(
    fileName: []const u8,
) []const u8 {}

/// Unload file text data allocated by LoadFileText()
pub fn UnloadFileText(
    text: []const u8,
) void {}

/// Save text data to file (write), string must be '\0' terminated, returns true on success
pub fn SaveFileText(
    fileName: []const u8,
    text: []const u8,
) bool {}

/// Check if file exists
pub fn FileExists(
    fileName: []const u8,
) bool {}

/// Check if a directory path exists
pub fn DirectoryExists(
    dirPath: []const u8,
) bool {}

/// Check file extension (including point: .png, .wav)
pub fn IsFileExtension(
    fileName: []const u8,
    ext: []const u8,
) bool {}

/// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub fn GetFileLength(
    fileName: []const u8,
) i32 {}

/// Get pointer to extension for a filename string (includes dot: '.png')
pub fn GetFileExtension(
    fileName: []const u8,
) []const u8 {}

/// Get pointer to filename for a path string
pub fn GetFileName(
    filePath: []const u8,
) []const u8 {}

/// Get filename string without extension (uses static string)
pub fn GetFileNameWithoutExt(
    filePath: []const u8,
) []const u8 {}

/// Get full path for a given fileName with path (uses static string)
pub fn GetDirectoryPath(
    filePath: []const u8,
) []const u8 {}

/// Get previous directory path for a given path (uses static string)
pub fn GetPrevDirectoryPath(
    dirPath: []const u8,
) []const u8 {}

/// Get current working directory (uses static string)
pub fn GetWorkingDirectory() []const u8 {}

/// Get the directory if the running application (uses static string)
pub fn GetApplicationDirectory() []const u8 {}

/// Get filenames in a directory path (memory should be freed)
pub fn GetDirectoryFiles(
    dirPath: []const u8,
    count: []i32,
) []const []const u8 {}

/// Clear directory files paths buffers (free memory)
pub fn ClearDirectoryFiles() void {}

/// Change working directory, return true on success
pub fn ChangeDirectory(
    dir: []const u8,
) bool {}

/// Check if a file has been dropped into window
pub fn IsFileDropped() bool {}

/// Get dropped files names (memory should be freed)
pub fn GetDroppedFiles(
    count: []i32,
) []const []const u8 {}

/// Clear dropped files paths buffer (free memory)
pub fn ClearDroppedFiles() void {}

/// Get file modification time (last write time)
pub fn GetFileModTime(
    fileName: []const u8,
) i64 {}

/// Compress data (DEFLATE algorithm)
pub fn CompressData(
    data: []const u8,
    dataSize: i32,
    compDataSize: []i32,
) []const u8 {}

/// Decompress data (DEFLATE algorithm)
pub fn DecompressData(
    compData: []const u8,
    compDataSize: i32,
    dataSize: []i32,
) []const u8 {}

/// Encode data to Base64 string
pub fn EncodeDataBase64(
    data: []const u8,
    dataSize: i32,
    outputSize: []i32,
) []const u8 {}

/// Decode Base64 string data
pub fn DecodeDataBase64(
    data: []const u8,
    outputSize: []i32,
) []const u8 {}

/// Save integer value to storage file (to defined position), returns true on success
pub fn SaveStorageValue(
    position: u32,
    value: i32,
) bool {}

/// Load integer value from storage file (from defined position)
pub fn LoadStorageValue(
    position: u32,
) i32 {}

/// Open URL with default system browser (if available)
pub fn OpenURL(
    url: []const u8,
) void {}

/// Check if a key has been pressed once
pub fn IsKeyPressed(
    key: i32,
) bool {}

/// Check if a key is being pressed
pub fn IsKeyDown(
    key: i32,
) bool {}

/// Check if a key has been released once
pub fn IsKeyReleased(
    key: i32,
) bool {}

/// Check if a key is NOT being pressed
pub fn IsKeyUp(
    key: i32,
) bool {}

/// Set a custom key to exit program (default is ESC)
pub fn SetExitKey(
    key: i32,
) void {}

/// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
pub fn GetKeyPressed() i32 {}

/// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
pub fn GetCharPressed() i32 {}

/// Check if a gamepad is available
pub fn IsGamepadAvailable(
    gamepad: i32,
) bool {}

/// Get gamepad internal name id
pub fn GetGamepadName(
    gamepad: i32,
) []const u8 {}

/// Check if a gamepad button has been pressed once
pub fn IsGamepadButtonPressed(
    gamepad: i32,
    button: i32,
) bool {}

/// Check if a gamepad button is being pressed
pub fn IsGamepadButtonDown(
    gamepad: i32,
    button: i32,
) bool {}

/// Check if a gamepad button has been released once
pub fn IsGamepadButtonReleased(
    gamepad: i32,
    button: i32,
) bool {}

/// Check if a gamepad button is NOT being pressed
pub fn IsGamepadButtonUp(
    gamepad: i32,
    button: i32,
) bool {}

/// Get the last gamepad button pressed
pub fn GetGamepadButtonPressed() i32 {}

/// Get gamepad axis count for a gamepad
pub fn GetGamepadAxisCount(
    gamepad: i32,
) i32 {}

/// Get axis movement value for a gamepad axis
pub fn GetGamepadAxisMovement(
    gamepad: i32,
    axis: i32,
) f32 {}

/// Set internal gamepad mappings (SDL_GameControllerDB)
pub fn SetGamepadMappings(
    mappings: []const u8,
) i32 {}

/// Check if a mouse button has been pressed once
pub fn IsMouseButtonPressed(
    button: i32,
) bool {}

/// Check if a mouse button is being pressed
pub fn IsMouseButtonDown(
    button: i32,
) bool {}

/// Check if a mouse button has been released once
pub fn IsMouseButtonReleased(
    button: i32,
) bool {}

/// Check if a mouse button is NOT being pressed
pub fn IsMouseButtonUp(
    button: i32,
) bool {}

/// Get mouse position X
pub fn GetMouseX() i32 {}

/// Get mouse position Y
pub fn GetMouseY() i32 {}

/// Get mouse position XY
pub fn GetMousePosition() Vector2 {}

/// Get mouse delta between frames
pub fn GetMouseDelta() Vector2 {}

/// Set mouse position XY
pub fn SetMousePosition(
    x: i32,
    y: i32,
) void {}

/// Set mouse offset
pub fn SetMouseOffset(
    offsetX: i32,
    offsetY: i32,
) void {}

/// Set mouse scaling
pub fn SetMouseScale(
    scaleX: f32,
    scaleY: f32,
) void {}

/// Get mouse wheel movement Y
pub fn GetMouseWheelMove() f32 {}

/// Set mouse cursor
pub fn SetMouseCursor(
    cursor: i32,
) void {}

/// Get touch position X for touch point 0 (relative to screen size)
pub fn GetTouchX() i32 {}

/// Get touch position Y for touch point 0 (relative to screen size)
pub fn GetTouchY() i32 {}

/// Get touch position XY for a touch point index (relative to screen size)
pub fn GetTouchPosition(
    index: i32,
) Vector2 {}

/// Get touch point identifier for given index
pub fn GetTouchPointId(
    index: i32,
) i32 {}

/// Get number of touch points
pub fn GetTouchPointCount() i32 {}

/// Enable a set of gestures using flags
pub fn SetGesturesEnabled(
    flags: u32,
) void {}

/// Check if a gesture have been detected
pub fn IsGestureDetected(
    gesture: i32,
) bool {}

/// Get latest detected gesture
pub fn GetGestureDetected() i32 {}

/// Get gesture hold time in milliseconds
pub fn GetGestureHoldDuration() f32 {}

/// Get gesture drag vector
pub fn GetGestureDragVector() Vector2 {}

/// Get gesture drag angle
pub fn GetGestureDragAngle() f32 {}

/// Get gesture pinch delta
pub fn GetGesturePinchVector() Vector2 {}

/// Get gesture pinch angle
pub fn GetGesturePinchAngle() f32 {}

/// Set camera mode (multiple camera modes available)
pub fn SetCameraMode(
    camera: Camera,
    mode: i32,
) void {}

/// Update camera position for selected mode
pub fn UpdateCamera(
    camera: *Camera,
) void {}

/// Set camera pan key to combine with mouse movement (free camera)
pub fn SetCameraPanControl(
    keyPan: i32,
) void {}

/// Set camera alt key to combine with mouse movement (free camera)
pub fn SetCameraAltControl(
    keyAlt: i32,
) void {}

/// Set camera smooth zoom key to combine with mouse (free camera)
pub fn SetCameraSmoothZoomControl(
    keySmoothZoom: i32,
) void {}

/// Set camera move controls (1st person and 3rd person cameras)
pub fn SetCameraMoveControls(
    keyFront: i32,
    keyBack: i32,
    keyRight: i32,
    keyLeft: i32,
    keyUp: i32,
    keyDown: i32,
) void {}

/// Set texture and rectangle to be used on shapes drawing
pub fn SetShapesTexture(
    texture: Texture2D,
    source: Rectangle,
) void {}

/// Draw a pixel
pub fn DrawPixel(
    posX: i32,
    posY: i32,
    color: Color,
) void {}

/// Draw a pixel (Vector version)
pub fn DrawPixelV(
    position: Vector2,
    color: Color,
) void {}

/// Draw a line
pub fn DrawLine(
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: Color,
) void {}

/// Draw a line (Vector version)
pub fn DrawLineV(
    startPos: Vector2,
    endPos: Vector2,
    color: Color,
) void {}

/// Draw a line defining thickness
pub fn DrawLineEx(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {}

/// Draw a line using cubic-bezier curves in-out
pub fn DrawLineBezier(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {}

/// Draw line using quadratic bezier curves with a control point
pub fn DrawLineBezierQuad(
    startPos: Vector2,
    endPos: Vector2,
    controlPos: Vector2,
    thick: f32,
    color: Color,
) void {}

/// Draw line using cubic bezier curves with 2 control points
pub fn DrawLineBezierCubic(
    startPos: Vector2,
    endPos: Vector2,
    startControlPos: Vector2,
    endControlPos: Vector2,
    thick: f32,
    color: Color,
) void {}

/// Draw lines sequence
pub fn DrawLineStrip(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {}

/// Draw a color-filled circle
pub fn DrawCircle(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {}

/// Draw a piece of a circle
pub fn DrawCircleSector(
    center: Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {}

/// Draw circle sector outline
pub fn DrawCircleSectorLines(
    center: Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {}

/// Draw a gradient-filled circle
pub fn DrawCircleGradient(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color1: Color,
    color2: Color,
) void {}

/// Draw a color-filled circle (Vector version)
pub fn DrawCircleV(
    center: Vector2,
    radius: f32,
    color: Color,
) void {}

/// Draw circle outline
pub fn DrawCircleLines(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {}

/// Draw ellipse
pub fn DrawEllipse(
    centerX: i32,
    centerY: i32,
    radiusH: f32,
    radiusV: f32,
    color: Color,
) void {}

/// Draw ellipse outline
pub fn DrawEllipseLines(
    centerX: i32,
    centerY: i32,
    radiusH: f32,
    radiusV: f32,
    color: Color,
) void {}

/// Draw ring
pub fn DrawRing(
    center: Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {}

/// Draw ring outline
pub fn DrawRingLines(
    center: Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: Color,
) void {}

/// Draw a color-filled rectangle
pub fn DrawRectangle(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {}

/// Draw a color-filled rectangle (Vector version)
pub fn DrawRectangleV(
    position: Vector2,
    size: Vector2,
    color: Color,
) void {}

/// Draw a color-filled rectangle
pub fn DrawRectangleRec(
    rec: Rectangle,
    color: Color,
) void {}

/// Draw a color-filled rectangle with pro parameters
pub fn DrawRectanglePro(
    rec: Rectangle,
    origin: Vector2,
    rotation: f32,
    color: Color,
) void {}

/// Draw a vertical-gradient-filled rectangle
pub fn DrawRectangleGradientV(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color1: Color,
    color2: Color,
) void {}

/// Draw a horizontal-gradient-filled rectangle
pub fn DrawRectangleGradientH(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color1: Color,
    color2: Color,
) void {}

/// Draw a gradient-filled rectangle with custom vertex colors
pub fn DrawRectangleGradientEx(
    rec: Rectangle,
    col1: Color,
    col2: Color,
    col3: Color,
    col4: Color,
) void {}

/// Draw rectangle outline
pub fn DrawRectangleLines(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {}

/// Draw rectangle outline with extended parameters
pub fn DrawRectangleLinesEx(
    rec: Rectangle,
    lineThick: f32,
    color: Color,
) void {}

/// Draw rectangle with rounded edges
pub fn DrawRectangleRounded(
    rec: Rectangle,
    roundness: f32,
    segments: i32,
    color: Color,
) void {}

/// Draw rectangle with rounded edges outline
pub fn DrawRectangleRoundedLines(
    rec: Rectangle,
    roundness: f32,
    segments: i32,
    lineThick: f32,
    color: Color,
) void {}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {}

/// Draw triangle outline (vertex in counter-clockwise order!)
pub fn DrawTriangleLines(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {}

/// Draw a triangle fan defined by points (first vertex is the center)
pub fn DrawTriangleFan(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {}

/// Draw a regular polygon (Vector version)
pub fn DrawPoly(
    center: Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: Color,
) void {}

/// Draw a polygon outline of n sides
pub fn DrawPolyLines(
    center: Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: Color,
) void {}

/// Draw a polygon outline of n sides with extended parameters
pub fn DrawPolyLinesEx(
    center: Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    lineThick: f32,
    color: Color,
) void {}

/// Check collision between two rectangles
pub fn CheckCollisionRecs(
    rec1: Rectangle,
    rec2: Rectangle,
) bool {}

/// Check collision between two circles
pub fn CheckCollisionCircles(
    center1: Vector2,
    radius1: f32,
    center2: Vector2,
    radius2: f32,
) bool {}

/// Check collision between circle and rectangle
pub fn CheckCollisionCircleRec(
    center: Vector2,
    radius: f32,
    rec: Rectangle,
) bool {}

/// Check if point is inside rectangle
pub fn CheckCollisionPointRec(
    point: Vector2,
    rec: Rectangle,
) bool {}

/// Check if point is inside circle
pub fn CheckCollisionPointCircle(
    point: Vector2,
    center: Vector2,
    radius: f32,
) bool {}

/// Check if point is inside a triangle
pub fn CheckCollisionPointTriangle(
    point: Vector2,
    p1: Vector2,
    p2: Vector2,
    p3: Vector2,
) bool {}

/// Check the collision between two lines defined by two points each, returns collision point by reference
pub fn CheckCollisionLines(
    startPos1: Vector2,
    endPos1: Vector2,
    startPos2: Vector2,
    endPos2: Vector2,
    collisionPoint: *Vector2,
) bool {}

/// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub fn CheckCollisionPointLine(
    point: Vector2,
    p1: Vector2,
    p2: Vector2,
    threshold: i32,
) bool {}

/// Get collision rectangle for two rectangles collision
pub fn GetCollisionRec(
    rec1: Rectangle,
    rec2: Rectangle,
) Rectangle {}

/// Load image from file into CPU memory (RAM)
pub fn LoadImage(
    fileName: []const u8,
) Image {}

/// Load image from RAW file data
pub fn LoadImageRaw(
    fileName: []const u8,
    width: i32,
    height: i32,
    format: i32,
    headerSize: i32,
) Image {}

/// Load image sequence from file (frames appended to image.data)
pub fn LoadImageAnim(
    fileName: []const u8,
    frames: []i32,
) Image {}

/// Load image from memory buffer, fileType refers to extension: i.e. '.png'
pub fn LoadImageFromMemory(
    fileType: []const u8,
    fileData: []const u8,
    dataSize: i32,
) Image {}

/// Load image from GPU texture data
pub fn LoadImageFromTexture(
    texture: Texture2D,
) Image {}

/// Load image from screen buffer and (screenshot)
pub fn LoadImageFromScreen() Image {}

/// Unload image from CPU memory (RAM)
pub fn UnloadImage(
    image: Image,
) void {}

/// Export image data to file, returns true on success
pub fn ExportImage(
    image: Image,
    fileName: []const u8,
) bool {}

/// Export image as code file defining an array of bytes, returns true on success
pub fn ExportImageAsCode(
    image: Image,
    fileName: []const u8,
) bool {}

/// Generate image: plain color
pub fn GenImageColor(
    width: i32,
    height: i32,
    color: Color,
) Image {}

/// Generate image: vertical gradient
pub fn GenImageGradientV(
    width: i32,
    height: i32,
    top: Color,
    bottom: Color,
) Image {}

/// Generate image: horizontal gradient
pub fn GenImageGradientH(
    width: i32,
    height: i32,
    left: Color,
    right: Color,
) Image {}

/// Generate image: radial gradient
pub fn GenImageGradientRadial(
    width: i32,
    height: i32,
    density: f32,
    inner: Color,
    outer: Color,
) Image {}

/// Generate image: checked
pub fn GenImageChecked(
    width: i32,
    height: i32,
    checksX: i32,
    checksY: i32,
    col1: Color,
    col2: Color,
) Image {}

/// Generate image: white noise
pub fn GenImageWhiteNoise(
    width: i32,
    height: i32,
    factor: f32,
) Image {}

/// Generate image: cellular algorithm, bigger tileSize means bigger cells
pub fn GenImageCellular(
    width: i32,
    height: i32,
    tileSize: i32,
) Image {}

/// Create an image duplicate (useful for transformations)
pub fn ImageCopy(
    image: Image,
) Image {}

/// Create an image from another image piece
pub fn ImageFromImage(
    image: Image,
    rec: Rectangle,
) Image {}

/// Create an image from text (default font)
pub fn ImageText(
    text: []const u8,
    fontSize: i32,
    color: Color,
) Image {}

/// Create an image from text (custom sprite font)
pub fn ImageTextEx(
    font: Font,
    text: []const u8,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) Image {}

/// Convert image data to desired format
pub fn ImageFormat(
    image: *Image,
    newFormat: i32,
) void {}

/// Convert image to POT (power-of-two)
pub fn ImageToPOT(
    image: *Image,
    fill: Color,
) void {}

/// Crop an image to a defined rectangle
pub fn ImageCrop(
    image: *Image,
    crop: Rectangle,
) void {}

/// Crop image depending on alpha value
pub fn ImageAlphaCrop(
    image: *Image,
    threshold: f32,
) void {}

/// Clear alpha channel to desired color
pub fn ImageAlphaClear(
    image: *Image,
    color: Color,
    threshold: f32,
) void {}

/// Apply alpha mask to image
pub fn ImageAlphaMask(
    image: *Image,
    alphaMask: Image,
) void {}

/// Premultiply alpha channel
pub fn ImageAlphaPremultiply(
    image: *Image,
) void {}

/// Resize image (Bicubic scaling algorithm)
pub fn ImageResize(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
) void {}

/// Resize image (Nearest-Neighbor scaling algorithm)
pub fn ImageResizeNN(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
) void {}

/// Resize canvas and fill with color
pub fn ImageResizeCanvas(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
    offsetX: i32,
    offsetY: i32,
    fill: Color,
) void {}

/// Compute all mipmap levels for a provided image
pub fn ImageMipmaps(
    image: *Image,
) void {}

/// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub fn ImageDither(
    image: *Image,
    rBpp: i32,
    gBpp: i32,
    bBpp: i32,
    aBpp: i32,
) void {}

/// Flip image vertically
pub fn ImageFlipVertical(
    image: *Image,
) void {}

/// Flip image horizontally
pub fn ImageFlipHorizontal(
    image: *Image,
) void {}

/// Rotate image clockwise 90deg
pub fn ImageRotateCW(
    image: *Image,
) void {}

/// Rotate image counter-clockwise 90deg
pub fn ImageRotateCCW(
    image: *Image,
) void {}

/// Modify image color: tint
pub fn ImageColorTint(
    image: *Image,
    color: Color,
) void {}

/// Modify image color: invert
pub fn ImageColorInvert(
    image: *Image,
) void {}

/// Modify image color: grayscale
pub fn ImageColorGrayscale(
    image: *Image,
) void {}

/// Modify image color: contrast (-100 to 100)
pub fn ImageColorContrast(
    image: *Image,
    contrast: f32,
) void {}

/// Modify image color: brightness (-255 to 255)
pub fn ImageColorBrightness(
    image: *Image,
    brightness: i32,
) void {}

/// Modify image color: replace color
pub fn ImageColorReplace(
    image: *Image,
    color: Color,
    replace: Color,
) void {}

/// Load color data from image as a Color array (RGBA - 32bit)
pub fn LoadImageColors(
    image: Image,
) *Color {}

/// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn LoadImagePalette(
    image: Image,
    maxPaletteSize: i32,
    colorCount: []i32,
) *Color {}

/// Unload color data loaded with LoadImageColors()
pub fn UnloadImageColors(
    colors: *Color,
) void {}

/// Unload colors palette loaded with LoadImagePalette()
pub fn UnloadImagePalette(
    colors: *Color,
) void {}

/// Get image alpha border rectangle
pub fn GetImageAlphaBorder(
    image: Image,
    threshold: f32,
) Rectangle {}

/// Get image pixel color at (x, y) position
pub fn GetImageColor(
    image: Image,
    x: i32,
    y: i32,
) Color {}

/// Clear image background with given color
pub fn ImageClearBackground(
    dst: *Image,
    color: Color,
) void {}

/// Draw pixel within an image
pub fn ImageDrawPixel(
    dst: *Image,
    posX: i32,
    posY: i32,
    color: Color,
) void {}

/// Draw pixel within an image (Vector version)
pub fn ImageDrawPixelV(
    dst: *Image,
    position: Vector2,
    color: Color,
) void {}

/// Draw line within an image
pub fn ImageDrawLine(
    dst: *Image,
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: Color,
) void {}

/// Draw line within an image (Vector version)
pub fn ImageDrawLineV(
    dst: *Image,
    start: Vector2,
    end: Vector2,
    color: Color,
) void {}

/// Draw circle within an image
pub fn ImageDrawCircle(
    dst: *Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: Color,
) void {}

/// Draw circle within an image (Vector version)
pub fn ImageDrawCircleV(
    dst: *Image,
    center: Vector2,
    radius: i32,
    color: Color,
) void {}

/// Draw rectangle within an image
pub fn ImageDrawRectangle(
    dst: *Image,
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {}

/// Draw rectangle within an image (Vector version)
pub fn ImageDrawRectangleV(
    dst: *Image,
    position: Vector2,
    size: Vector2,
    color: Color,
) void {}

/// Draw rectangle within an image
pub fn ImageDrawRectangleRec(
    dst: *Image,
    rec: Rectangle,
    color: Color,
) void {}

/// Draw rectangle lines within an image
pub fn ImageDrawRectangleLines(
    dst: *Image,
    rec: Rectangle,
    thick: i32,
    color: Color,
) void {}

/// Draw a source image within a destination image (tint applied to source)
pub fn ImageDraw(
    dst: *Image,
    src: Image,
    srcRec: Rectangle,
    dstRec: Rectangle,
    tint: Color,
) void {}

/// Draw text (using default font) within an image (destination)
pub fn ImageDrawText(
    dst: *Image,
    text: []const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {}

/// Draw text (custom sprite font) within an image (destination)
pub fn ImageDrawTextEx(
    dst: *Image,
    font: Font,
    text: []const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {}

/// Load texture from file into GPU memory (VRAM)
pub fn LoadTexture(
    fileName: []const u8,
) Texture2D {}

/// Load texture from image data
pub fn LoadTextureFromImage(
    image: Image,
) Texture2D {}

/// Load cubemap from image, multiple image cubemap layouts supported
pub fn LoadTextureCubemap(
    image: Image,
    layout: i32,
) TextureCubemap {}

/// Load texture for rendering (framebuffer)
pub fn LoadRenderTexture(
    width: i32,
    height: i32,
) RenderTexture2D {}

/// Unload texture from GPU memory (VRAM)
pub fn UnloadTexture(
    texture: Texture2D,
) void {}

/// Unload render texture from GPU memory (VRAM)
pub fn UnloadRenderTexture(
    target: RenderTexture2D,
) void {}

/// Update GPU texture with new data
pub fn UpdateTexture(
    texture: Texture2D,
    pixels: *anyopaque,
) void {}

/// Update GPU texture rectangle with new data
pub fn UpdateTextureRec(
    texture: Texture2D,
    rec: Rectangle,
    pixels: *anyopaque,
) void {}

/// Generate GPU mipmaps for a texture
pub fn GenTextureMipmaps(
    texture: *Texture2D,
) void {}

/// Set texture scaling filter mode
pub fn SetTextureFilter(
    texture: Texture2D,
    filter: i32,
) void {}

/// Set texture wrapping mode
pub fn SetTextureWrap(
    texture: Texture2D,
    wrap: i32,
) void {}

/// Draw a Texture2D
pub fn DrawTexture(
    texture: Texture2D,
    posX: i32,
    posY: i32,
    tint: Color,
) void {}

/// Draw a Texture2D with position defined as Vector2
pub fn DrawTextureV(
    texture: Texture2D,
    position: Vector2,
    tint: Color,
) void {}

/// Draw a Texture2D with extended parameters
pub fn DrawTextureEx(
    texture: Texture2D,
    position: Vector2,
    rotation: f32,
    scale: f32,
    tint: Color,
) void {}

/// Draw a part of a texture defined by a rectangle
pub fn DrawTextureRec(
    texture: Texture2D,
    source: Rectangle,
    position: Vector2,
    tint: Color,
) void {}

/// Draw texture quad with tiling and offset parameters
pub fn DrawTextureQuad(
    texture: Texture2D,
    tiling: Vector2,
    offset: Vector2,
    quad: Rectangle,
    tint: Color,
) void {}

/// Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
pub fn DrawTextureTiled(
    texture: Texture2D,
    source: Rectangle,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    scale: f32,
    tint: Color,
) void {}

/// Draw a part of a texture defined by a rectangle with 'pro' parameters
pub fn DrawTexturePro(
    texture: Texture2D,
    source: Rectangle,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {}

/// Draws a texture (or part of it) that stretches or shrinks nicely
pub fn DrawTextureNPatch(
    texture: Texture2D,
    nPatchInfo: NPatchInfo,
    dest: Rectangle,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {}

/// Draw a textured polygon
pub fn DrawTexturePoly(
    texture: Texture2D,
    center: Vector2,
    points: *Vector2,
    texcoords: *Vector2,
    pointCount: i32,
    tint: Color,
) void {}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn Fade(
    color: Color,
    alpha: f32,
) Color {}

/// Get hexadecimal value for a Color
pub fn ColorToInt(
    color: Color,
) i32 {}

/// Get Color normalized as float [0..1]
pub fn ColorNormalize(
    color: Color,
) Vector4 {}

/// Get Color from normalized values [0..1]
pub fn ColorFromNormalized(
    normalized: Vector4,
) Color {}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn ColorToHSV(
    color: Color,
) Vector3 {}

/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub fn ColorFromHSV(
    hue: f32,
    saturation: f32,
    value: f32,
) Color {}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn ColorAlpha(
    color: Color,
    alpha: f32,
) Color {}

/// Get src alpha-blended into dst color with tint
pub fn ColorAlphaBlend(
    dst: Color,
    src: Color,
    tint: Color,
) Color {}

/// Get Color structure from hexadecimal value
pub fn GetColor(
    hexValue: u32,
) Color {}

/// Get Color from a source pixel pointer of certain format
pub fn GetPixelColor(
    srcPtr: *anyopaque,
    format: i32,
) Color {}

/// Set color formatted into destination pixel pointer
pub fn SetPixelColor(
    dstPtr: *anyopaque,
    color: Color,
    format: i32,
) void {}

/// Get pixel data size in bytes for certain format
pub fn GetPixelDataSize(
    width: i32,
    height: i32,
    format: i32,
) i32 {}

/// Get the default Font
pub fn GetFontDefault() Font {}

/// Load font from file into GPU memory (VRAM)
pub fn LoadFont(
    fileName: []const u8,
) Font {}

/// Load font from file with extended parameters, use NULL for fontChars and 0 for glyphCount to load the default character set
pub fn LoadFontEx(
    fileName: []const u8,
    fontSize: i32,
    fontChars: []i32,
    glyphCount: i32,
) Font {}

/// Load font from Image (XNA style)
pub fn LoadFontFromImage(
    image: Image,
    key: Color,
    firstChar: i32,
) Font {}

/// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
pub fn LoadFontFromMemory(
    fileType: []const u8,
    fileData: []const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: []i32,
    glyphCount: i32,
) Font {}

/// Load font data for further use
pub fn LoadFontData(
    fileData: []const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: []i32,
    glyphCount: i32,
    type: i32,
) *GlyphInfo {}

/// Generate image font atlas using chars info
pub fn GenImageFontAtlas(
    chars: *const GlyphInfo,
    recs: *const [*c]Rectangle,
    glyphCount: i32,
    fontSize: i32,
    padding: i32,
    packMethod: i32,
) Image {}

/// Unload font chars info data (RAM)
pub fn UnloadFontData(
    chars: *GlyphInfo,
    glyphCount: i32,
) void {}

/// Unload font from GPU memory (VRAM)
pub fn UnloadFont(
    font: Font,
) void {}

/// Export font as code file, returns true on success
pub fn ExportFontAsCode(
    font: Font,
    fileName: []const u8,
) bool {}

/// Draw current FPS
pub fn DrawFPS(
    posX: i32,
    posY: i32,
) void {}

/// Draw text (using default font)
pub fn DrawText(
    text: []const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {}

/// Draw text using font and additional parameters
pub fn DrawTextEx(
    font: Font,
    text: []const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {}

/// Draw text using Font and pro parameters (rotation)
pub fn DrawTextPro(
    font: Font,
    text: []const u8,
    position: Vector2,
    origin: Vector2,
    rotation: f32,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {}

/// Draw one character (codepoint)
pub fn DrawTextCodepoint(
    font: Font,
    codepoint: i32,
    position: Vector2,
    fontSize: f32,
    tint: Color,
) void {}

/// Draw multiple character (codepoint)
pub fn DrawTextCodepoints(
    font: Font,
    codepoints: []i32,
    count: i32,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {}

/// Measure string width for default font
pub fn MeasureText(
    text: []const u8,
    fontSize: i32,
) i32 {}

/// Measure string size for Font
pub fn MeasureTextEx(
    font: Font,
    text: []const u8,
    fontSize: f32,
    spacing: f32,
) Vector2 {}

/// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphIndex(
    font: Font,
    codepoint: i32,
) i32 {}

/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphInfo(
    font: Font,
    codepoint: i32,
) GlyphInfo {}

/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphAtlasRec(
    font: Font,
    codepoint: i32,
) Rectangle {}

/// Draw a line in 3D world space
pub fn DrawLine3D(
    startPos: Vector3,
    endPos: Vector3,
    color: Color,
) void {}

/// Draw a point in 3D space, actually a small line
pub fn DrawPoint3D(
    position: Vector3,
    color: Color,
) void {}

/// Draw a circle in 3D world space
pub fn DrawCircle3D(
    center: Vector3,
    radius: f32,
    rotationAxis: Vector3,
    rotationAngle: f32,
    color: Color,
) void {}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle3D(
    v1: Vector3,
    v2: Vector3,
    v3: Vector3,
    color: Color,
) void {}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip3D(
    points: *Vector3,
    pointCount: i32,
    color: Color,
) void {}

/// Draw cube
pub fn DrawCube(
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {}

/// Draw cube (Vector version)
pub fn DrawCubeV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {}

/// Draw cube wires
pub fn DrawCubeWires(
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {}

/// Draw cube wires (Vector version)
pub fn DrawCubeWiresV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {}

/// Draw cube textured
pub fn DrawCubeTexture(
    texture: Texture2D,
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {}

/// Draw cube with a region of a texture
pub fn DrawCubeTextureRec(
    texture: Texture2D,
    source: Rectangle,
    position: Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: Color,
) void {}

/// Draw sphere
pub fn DrawSphere(
    centerPos: Vector3,
    radius: f32,
    color: Color,
) void {}

/// Draw sphere with extended parameters
pub fn DrawSphereEx(
    centerPos: Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: Color,
) void {}

/// Draw sphere wires
pub fn DrawSphereWires(
    centerPos: Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: Color,
) void {}

/// Draw a cylinder/cone
pub fn DrawCylinder(
    position: Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: Color,
) void {}

/// Draw a cylinder with base at startPos and top at endPos
pub fn DrawCylinderEx(
    startPos: Vector3,
    endPos: Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: Color,
) void {}

/// Draw a cylinder/cone wires
pub fn DrawCylinderWires(
    position: Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: Color,
) void {}

/// Draw a cylinder wires with base at startPos and top at endPos
pub fn DrawCylinderWiresEx(
    startPos: Vector3,
    endPos: Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: Color,
) void {}

/// Draw a plane XZ
pub fn DrawPlane(
    centerPos: Vector3,
    size: Vector2,
    color: Color,
) void {}

/// Draw a ray line
pub fn DrawRay(
    ray: Ray,
    color: Color,
) void {}

/// Draw a grid (centered at (0, 0, 0))
pub fn DrawGrid(
    slices: i32,
    spacing: f32,
) void {}

/// Load model from files (meshes and materials)
pub fn LoadModel(
    fileName: []const u8,
) Model {}

/// Load model from generated mesh (default material)
pub fn LoadModelFromMesh(
    mesh: Mesh,
) Model {}

/// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn UnloadModel(
    model: Model,
) void {}

/// Unload model (but not meshes) from memory (RAM and/or VRAM)
pub fn UnloadModelKeepMeshes(
    model: Model,
) void {}

/// Compute model bounding box limits (considers all meshes)
pub fn GetModelBoundingBox(
    model: Model,
) BoundingBox {}

/// Draw a model (with texture if set)
pub fn DrawModel(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {}

/// Draw a model with extended parameters
pub fn DrawModelEx(
    model: Model,
    position: Vector3,
    rotationAxis: Vector3,
    rotationAngle: f32,
    scale: Vector3,
    tint: Color,
) void {}

/// Draw a model wires (with texture if set)
pub fn DrawModelWires(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {}

/// Draw a model wires (with texture if set) with extended parameters
pub fn DrawModelWiresEx(
    model: Model,
    position: Vector3,
    rotationAxis: Vector3,
    rotationAngle: f32,
    scale: Vector3,
    tint: Color,
) void {}

/// Draw bounding box (wires)
pub fn DrawBoundingBox(
    box: BoundingBox,
    color: Color,
) void {}

/// Draw a billboard texture
pub fn DrawBillboard(
    camera: Camera,
    texture: Texture2D,
    position: Vector3,
    size: f32,
    tint: Color,
) void {}

/// Draw a billboard texture defined by source
pub fn DrawBillboardRec(
    camera: Camera,
    texture: Texture2D,
    source: Rectangle,
    position: Vector3,
    size: Vector2,
    tint: Color,
) void {}

/// Draw a billboard texture defined by source and rotation
pub fn DrawBillboardPro(
    camera: Camera,
    texture: Texture2D,
    source: Rectangle,
    position: Vector3,
    up: Vector3,
    size: Vector2,
    origin: Vector2,
    rotation: f32,
    tint: Color,
) void {}

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
pub fn UploadMesh(
    mesh: *Mesh,
    dynamic: bool,
) void {}

/// Update mesh vertex data in GPU for a specific buffer index
pub fn UpdateMeshBuffer(
    mesh: Mesh,
    index: i32,
    data: *anyopaque,
    dataSize: i32,
    offset: i32,
) void {}

/// Unload mesh data from CPU and GPU
pub fn UnloadMesh(
    mesh: Mesh,
) void {}

/// Draw a 3d mesh with material and transform
pub fn DrawMesh(
    mesh: Mesh,
    material: Material,
    transform: Matrix,
) void {}

/// Draw multiple mesh instances with material and different transforms
pub fn DrawMeshInstanced(
    mesh: Mesh,
    material: Material,
    transforms: *const Matrix,
    instances: i32,
) void {}

/// Export mesh data to file, returns true on success
pub fn ExportMesh(
    mesh: Mesh,
    fileName: []const u8,
) bool {}

/// Compute mesh bounding box limits
pub fn GetMeshBoundingBox(
    mesh: Mesh,
) BoundingBox {}

/// Compute mesh tangents
pub fn GenMeshTangents(
    mesh: *Mesh,
) void {}

/// Compute mesh binormals
pub fn GenMeshBinormals(
    mesh: *Mesh,
) void {}

/// Generate polygonal mesh
pub fn GenMeshPoly(
    sides: i32,
    radius: f32,
) Mesh {}

/// Generate plane mesh (with subdivisions)
pub fn GenMeshPlane(
    width: f32,
    length: f32,
    resX: i32,
    resZ: i32,
) Mesh {}

/// Generate cuboid mesh
pub fn GenMeshCube(
    width: f32,
    height: f32,
    length: f32,
) Mesh {}

/// Generate sphere mesh (standard sphere)
pub fn GenMeshSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {}

/// Generate half-sphere mesh (no bottom cap)
pub fn GenMeshHemiSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {}

/// Generate cylinder mesh
pub fn GenMeshCylinder(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {}

/// Generate cone/pyramid mesh
pub fn GenMeshCone(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {}

/// Generate torus mesh
pub fn GenMeshTorus(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {}

/// Generate trefoil knot mesh
pub fn GenMeshKnot(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {}

/// Generate heightmap mesh from image data
pub fn GenMeshHeightmap(
    heightmap: Image,
    size: Vector3,
) Mesh {}

/// Generate cubes-based map mesh from image data
pub fn GenMeshCubicmap(
    cubicmap: Image,
    cubeSize: Vector3,
) Mesh {}

/// Load materials from model file
pub fn LoadMaterials(
    fileName: []const u8,
    materialCount: []i32,
) *Material {}

/// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub fn LoadMaterialDefault() Material {}

/// Unload material from GPU memory (VRAM)
pub fn UnloadMaterial(
    material: Material,
) void {}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn SetMaterialTexture(
    material: *Material,
    mapType: i32,
    texture: Texture2D,
) void {}

/// Set material for a mesh
pub fn SetModelMeshMaterial(
    model: *Model,
    meshId: i32,
    materialId: i32,
) void {}

/// Load model animations from file
pub fn LoadModelAnimations(
    fileName: []const u8,
    animCount: []u32,
) *ModelAnimation {}

/// Update model animation pose
pub fn UpdateModelAnimation(
    model: Model,
    anim: ModelAnimation,
    frame: i32,
) void {}

/// Unload animation data
pub fn UnloadModelAnimation(
    anim: ModelAnimation,
) void {}

/// Unload animation array data
pub fn UnloadModelAnimations(
    animations: *ModelAnimation,
    count: u32,
) void {}

/// Check model animation skeleton match
pub fn IsModelAnimationValid(
    model: Model,
    anim: ModelAnimation,
) bool {}

/// Check collision between two spheres
pub fn CheckCollisionSpheres(
    center1: Vector3,
    radius1: f32,
    center2: Vector3,
    radius2: f32,
) bool {}

/// Check collision between two bounding boxes
pub fn CheckCollisionBoxes(
    box1: BoundingBox,
    box2: BoundingBox,
) bool {}

/// Check collision between box and sphere
pub fn CheckCollisionBoxSphere(
    box: BoundingBox,
    center: Vector3,
    radius: f32,
) bool {}

/// Get collision info between ray and sphere
pub fn GetRayCollisionSphere(
    ray: Ray,
    center: Vector3,
    radius: f32,
) RayCollision {}

/// Get collision info between ray and box
pub fn GetRayCollisionBox(
    ray: Ray,
    box: BoundingBox,
) RayCollision {}

/// Get collision info between ray and mesh
pub fn GetRayCollisionMesh(
    ray: Ray,
    mesh: Mesh,
    transform: Matrix,
) RayCollision {}

/// Get collision info between ray and triangle
pub fn GetRayCollisionTriangle(
    ray: Ray,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
) RayCollision {}

/// Get collision info between ray and quad
pub fn GetRayCollisionQuad(
    ray: Ray,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
    p4: Vector3,
) RayCollision {}

/// Initialize audio device and context
pub fn InitAudioDevice() void {}

/// Close the audio device and context
pub fn CloseAudioDevice() void {}

/// Check if audio device has been initialized successfully
pub fn IsAudioDeviceReady() bool {}

/// Set master volume (listener)
pub fn SetMasterVolume(
    volume: f32,
) void {}

/// Load wave data from file
pub fn LoadWave(
    fileName: []const u8,
) Wave {}

/// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
pub fn LoadWaveFromMemory(
    fileType: []const u8,
    fileData: []const u8,
    dataSize: i32,
) Wave {}

/// Load sound from file
pub fn LoadSound(
    fileName: []const u8,
) Sound {}

/// Load sound from wave data
pub fn LoadSoundFromWave(
    wave: Wave,
) Sound {}

/// Update sound buffer with new data
pub fn UpdateSound(
    sound: Sound,
    data: *anyopaque,
    sampleCount: i32,
) void {}

/// Unload wave data
pub fn UnloadWave(
    wave: Wave,
) void {}

/// Unload sound
pub fn UnloadSound(
    sound: Sound,
) void {}

/// Export wave data to file, returns true on success
pub fn ExportWave(
    wave: Wave,
    fileName: []const u8,
) bool {}

/// Export wave sample data to code (.h), returns true on success
pub fn ExportWaveAsCode(
    wave: Wave,
    fileName: []const u8,
) bool {}

/// Play a sound
pub fn PlaySound(
    sound: Sound,
) void {}

/// Stop playing a sound
pub fn StopSound(
    sound: Sound,
) void {}

/// Pause a sound
pub fn PauseSound(
    sound: Sound,
) void {}

/// Resume a paused sound
pub fn ResumeSound(
    sound: Sound,
) void {}

/// Play a sound (using multichannel buffer pool)
pub fn PlaySoundMulti(
    sound: Sound,
) void {}

/// Stop any sound playing (using multichannel buffer pool)
pub fn StopSoundMulti() void {}

/// Get number of sounds playing in the multichannel
pub fn GetSoundsPlaying() i32 {}

/// Check if a sound is currently playing
pub fn IsSoundPlaying(
    sound: Sound,
) bool {}

/// Set volume for a sound (1.0 is max level)
pub fn SetSoundVolume(
    sound: Sound,
    volume: f32,
) void {}

/// Set pitch for a sound (1.0 is base level)
pub fn SetSoundPitch(
    sound: Sound,
    pitch: f32,
) void {}

/// Set pan for a sound (0.5 is center)
pub fn SetSoundPan(
    sound: Sound,
    pan: f32,
) void {}

/// Copy a wave to a new wave
pub fn WaveCopy(
    wave: Wave,
) Wave {}

/// Crop a wave to defined samples range
pub fn WaveCrop(
    wave: *Wave,
    initSample: i32,
    finalSample: i32,
) void {}

/// Convert wave data to desired format
pub fn WaveFormat(
    wave: *Wave,
    sampleRate: i32,
    sampleSize: i32,
    channels: i32,
) void {}

/// Load samples data from wave as a 32bit float data array
pub fn LoadWaveSamples(
    wave: Wave,
) []f32 {}

/// Unload samples data loaded with LoadWaveSamples()
pub fn UnloadWaveSamples(
    samples: []f32,
) void {}

/// Load music stream from file
pub fn LoadMusicStream(
    fileName: []const u8,
) Music {}

/// Load music stream from data
pub fn LoadMusicStreamFromMemory(
    fileType: []const u8,
    data: []const u8,
    dataSize: i32,
) Music {}

/// Unload music stream
pub fn UnloadMusicStream(
    music: Music,
) void {}

/// Start music playing
pub fn PlayMusicStream(
    music: Music,
) void {}

/// Check if music is playing
pub fn IsMusicStreamPlaying(
    music: Music,
) bool {}

/// Updates buffers for music streaming
pub fn UpdateMusicStream(
    music: Music,
) void {}

/// Stop music playing
pub fn StopMusicStream(
    music: Music,
) void {}

/// Pause music playing
pub fn PauseMusicStream(
    music: Music,
) void {}

/// Resume playing paused music
pub fn ResumeMusicStream(
    music: Music,
) void {}

/// Seek music to a position (in seconds)
pub fn SeekMusicStream(
    music: Music,
    position: f32,
) void {}

/// Set volume for music (1.0 is max level)
pub fn SetMusicVolume(
    music: Music,
    volume: f32,
) void {}

/// Set pitch for a music (1.0 is base level)
pub fn SetMusicPitch(
    music: Music,
    pitch: f32,
) void {}

/// Set pan for a music (0.5 is center)
pub fn SetMusicPan(
    music: Music,
    pan: f32,
) void {}

/// Get music time length (in seconds)
pub fn GetMusicTimeLength(
    music: Music,
) f32 {}

/// Get current music time played (in seconds)
pub fn GetMusicTimePlayed(
    music: Music,
) f32 {}

/// Load audio stream (to stream raw audio pcm data)
pub fn LoadAudioStream(
    sampleRate: u32,
    sampleSize: u32,
    channels: u32,
) AudioStream {}

/// Unload audio stream and free memory
pub fn UnloadAudioStream(
    stream: AudioStream,
) void {}

/// Update audio stream buffers with data
pub fn UpdateAudioStream(
    stream: AudioStream,
    data: *anyopaque,
    frameCount: i32,
) void {}

/// Check if any audio stream buffers requires refill
pub fn IsAudioStreamProcessed(
    stream: AudioStream,
) bool {}

/// Play audio stream
pub fn PlayAudioStream(
    stream: AudioStream,
) void {}

/// Pause audio stream
pub fn PauseAudioStream(
    stream: AudioStream,
) void {}

/// Resume audio stream
pub fn ResumeAudioStream(
    stream: AudioStream,
) void {}

/// Check if audio stream is playing
pub fn IsAudioStreamPlaying(
    stream: AudioStream,
) bool {}

/// Stop audio stream
pub fn StopAudioStream(
    stream: AudioStream,
) void {}

/// Set volume for audio stream (1.0 is max level)
pub fn SetAudioStreamVolume(
    stream: AudioStream,
    volume: f32,
) void {}

/// Set pitch for audio stream (1.0 is base level)
pub fn SetAudioStreamPitch(
    stream: AudioStream,
    pitch: f32,
) void {}

/// Set pan for audio stream (0.5 is centered)
pub fn SetAudioStreamPan(
    stream: AudioStream,
    pan: f32,
) void {}

/// Default size for new audio streams
pub fn SetAudioStreamBufferSizeDefault(
    size: i32,
) void {}

/// Audio thread callback to request new data
pub fn SetAudioStreamCallback(
    stream: AudioStream,
    callback: AudioCallback,
) void {}

/// 
pub fn AttachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {}

/// 
pub fn DetachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {}
