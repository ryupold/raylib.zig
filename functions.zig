const raylib = @cImport({
    @cInclude("raylib/src/raylib.h");
});

usingnamespace @import("structs.zig");
usingnamespace @import("enums.zig");

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
        image,
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
        opacity,
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
        ms,
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
        color,
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
        camera,
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
        camera,
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
        target,
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
        shader,
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
        config,
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
        device,
    );
}

/// Unload VR stereo config
pub fn UnloadVrStereoConfig(
    config: VrStereoConfig,
) void {
    raylib.UnloadVrStereoConfig(
        config,
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
        shader,
        uniformName,
    );
}

/// Get shader attribute location
pub fn GetShaderLocationAttrib(
    shader: Shader,
    attribName: [:0]const u8,
) i32 {
    return raylib.GetShaderLocationAttrib(
        shader,
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
        shader,
        @intCast(c_int, locIndex),
        value,
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
        shader,
        @intCast(c_int, locIndex),
        value,
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
        shader,
        @intCast(c_int, locIndex),
        mat,
    );
}

/// Set shader uniform value for texture (sampler2d)
pub fn SetShaderValueTexture(
    shader: Shader,
    locIndex: i32,
    texture: Texture2D,
) void {
    raylib.SetShaderValueTexture(
        shader,
        @intCast(c_int, locIndex),
        texture,
    );
}

/// Unload shader from GPU memory (VRAM)
pub fn UnloadShader(
    shader: Shader,
) void {
    raylib.UnloadShader(
        shader,
    );
}

/// Get a ray trace from mouse position
pub fn GetMouseRay(
    mousePosition: Vector2,
    camera: Camera,
) Ray {
    return raylib.GetMouseRay(
        mousePosition,
        camera,
    );
}

/// Get camera transform matrix (view matrix)
pub fn GetCameraMatrix(
    camera: Camera,
) Matrix {
    return raylib.GetCameraMatrix(
        camera,
    );
}

/// Get camera 2d transform matrix
pub fn GetCameraMatrix2D(
    camera: Camera2D,
) Matrix {
    return raylib.GetCameraMatrix2D(
        camera,
    );
}

/// Get the screen space position for a 3d world space position
pub fn GetWorldToScreen(
    position: Vector3,
    camera: Camera,
) Vector2 {
    return raylib.GetWorldToScreen(
        position,
        camera,
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
        position,
        camera,
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
        position,
        camera,
    );
}

/// Get the world space position for a 2d camera screen space position
pub fn GetScreenToWorld2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {
    return raylib.GetScreenToWorld2D(
        position,
        camera,
    );
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
pub fn GetTime() double {
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
        ptr,
        @intCast(c_int, size),
    );
}

/// Internal memory free
pub fn MemFree(
    ptr: *anyopaque,
) void {
    raylib.MemFree(
        ptr,
    );
}

/// Set custom trace log
pub fn SetTraceLogCallback(
    callback: TraceLogCallback,
) void {
    raylib.SetTraceLogCallback(
        callback,
    );
}

/// Set custom file binary data loader
pub fn SetLoadFileDataCallback(
    callback: LoadFileDataCallback,
) void {
    raylib.SetLoadFileDataCallback(
        callback,
    );
}

/// Set custom file binary data saver
pub fn SetSaveFileDataCallback(
    callback: SaveFileDataCallback,
) void {
    raylib.SetSaveFileDataCallback(
        callback,
    );
}

/// Set custom file text data loader
pub fn SetLoadFileTextCallback(
    callback: LoadFileTextCallback,
) void {
    raylib.SetLoadFileTextCallback(
        callback,
    );
}

/// Set custom file text data saver
pub fn SetSaveFileTextCallback(
    callback: SaveFileTextCallback,
) void {
    raylib.SetSaveFileTextCallback(
        callback,
    );
}

/// Unload file data allocated by LoadFileData()
pub fn UnloadFileData(
    data: [:0]const u8,
) void {
    raylib.UnloadFileData(
        data,
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
        data,
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
) [*c][*c]char {
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
) [*c][*c]char {
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
) long {
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
    return raylib.GetMousePosition();
}

/// Get mouse delta between frames
pub fn GetMouseDelta() Vector2 {
    return raylib.GetMouseDelta();
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
        scaleX,
        scaleY,
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
    return raylib.GetTouchPosition(
        @intCast(c_int, index),
    );
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
    return raylib.GetGestureDragVector();
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
        camera,
        @intCast(c_int, mode),
    );
}

/// Update camera position for selected mode
pub fn UpdateCamera(
    camera: *Camera,
) void {
    raylib.UpdateCamera(
        @ptrCast([*c]Camera, camera),
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
    texture: Texture2D,
    source: Rectangle,
) void {
    raylib.SetShapesTexture(
        texture,
        source,
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
        color,
    );
}

/// Draw a pixel (Vector version)
pub fn DrawPixelV(
    position: Vector2,
    color: Color,
) void {
    raylib.DrawPixelV(
        position,
        color,
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
        color,
    );
}

/// Draw a line (Vector version)
pub fn DrawLineV(
    startPos: Vector2,
    endPos: Vector2,
    color: Color,
) void {
    raylib.DrawLineV(
        startPos,
        endPos,
        color,
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
        startPos,
        endPos,
        thick,
        color,
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
        startPos,
        endPos,
        thick,
        color,
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
        startPos,
        endPos,
        controlPos,
        thick,
        color,
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
        startPos,
        endPos,
        startControlPos,
        endControlPos,
        thick,
        color,
    );
}

/// Draw lines sequence
pub fn DrawLineStrip(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawLineStrip(
        @ptrCast([*c]Vector2, points),
        @intCast(c_int, pointCount),
        color,
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
        radius,
        color,
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
        center,
        radius,
        startAngle,
        endAngle,
        @intCast(c_int, segments),
        color,
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
        center,
        radius,
        startAngle,
        endAngle,
        @intCast(c_int, segments),
        color,
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
        radius,
        color1,
        color2,
    );
}

/// Draw a color-filled circle (Vector version)
pub fn DrawCircleV(
    center: Vector2,
    radius: f32,
    color: Color,
) void {
    raylib.DrawCircleV(
        center,
        radius,
        color,
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
        radius,
        color,
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
        radiusH,
        radiusV,
        color,
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
        radiusH,
        radiusV,
        color,
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
        center,
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        @intCast(c_int, segments),
        color,
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
        center,
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        @intCast(c_int, segments),
        color,
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
        color,
    );
}

/// Draw a color-filled rectangle (Vector version)
pub fn DrawRectangleV(
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    raylib.DrawRectangleV(
        position,
        size,
        color,
    );
}

/// Draw a color-filled rectangle
pub fn DrawRectangleRec(
    rec: Rectangle,
    color: Color,
) void {
    raylib.DrawRectangleRec(
        rec,
        color,
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
        rec,
        origin,
        rotation,
        color,
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
        color1,
        color2,
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
        color1,
        color2,
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
        rec,
        col1,
        col2,
        col3,
        col4,
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
        color,
    );
}

/// Draw rectangle outline with extended parameters
pub fn DrawRectangleLinesEx(
    rec: Rectangle,
    lineThick: f32,
    color: Color,
) void {
    raylib.DrawRectangleLinesEx(
        rec,
        lineThick,
        color,
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
        rec,
        roundness,
        @intCast(c_int, segments),
        color,
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
        rec,
        roundness,
        @intCast(c_int, segments),
        lineThick,
        color,
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
        v1,
        v2,
        v3,
        color,
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
        v1,
        v2,
        v3,
        color,
    );
}

/// Draw a triangle fan defined by points (first vertex is the center)
pub fn DrawTriangleFan(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawTriangleFan(
        @ptrCast([*c]Vector2, points),
        @intCast(c_int, pointCount),
        color,
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip(
    points: *Vector2,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawTriangleStrip(
        @ptrCast([*c]Vector2, points),
        @intCast(c_int, pointCount),
        color,
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
        center,
        @intCast(c_int, sides),
        radius,
        rotation,
        color,
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
        center,
        @intCast(c_int, sides),
        radius,
        rotation,
        color,
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
        center,
        @intCast(c_int, sides),
        radius,
        rotation,
        lineThick,
        color,
    );
}

/// Check collision between two rectangles
pub fn CheckCollisionRecs(
    rec1: Rectangle,
    rec2: Rectangle,
) bool {
    return raylib.CheckCollisionRecs(
        rec1,
        rec2,
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
        center1,
        radius1,
        center2,
        radius2,
    );
}

/// Check collision between circle and rectangle
pub fn CheckCollisionCircleRec(
    center: Vector2,
    radius: f32,
    rec: Rectangle,
) bool {
    return raylib.CheckCollisionCircleRec(
        center,
        radius,
        rec,
    );
}

/// Check if point is inside rectangle
pub fn CheckCollisionPointRec(
    point: Vector2,
    rec: Rectangle,
) bool {
    return raylib.CheckCollisionPointRec(
        point,
        rec,
    );
}

/// Check if point is inside circle
pub fn CheckCollisionPointCircle(
    point: Vector2,
    center: Vector2,
    radius: f32,
) bool {
    return raylib.CheckCollisionPointCircle(
        point,
        center,
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
    return raylib.CheckCollisionPointTriangle(
        point,
        p1,
        p2,
        p3,
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
        startPos1,
        endPos1,
        startPos2,
        endPos2,
        @ptrCast([*c]Vector2, collisionPoint),
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
        point,
        p1,
        p2,
        @intCast(c_int, threshold),
    );
}

/// Get collision rectangle for two rectangles collision
pub fn GetCollisionRec(
    rec1: Rectangle,
    rec2: Rectangle,
) Rectangle {
    return raylib.GetCollisionRec(
        rec1,
        rec2,
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
    texture: Texture2D,
) Image {
    return raylib.LoadImageFromTexture(
        texture,
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
        image,
    );
}

/// Export image data to file, returns true on success
pub fn ExportImage(
    image: Image,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportImage(
        image,
        fileName,
    );
}

/// Export image as code file defining an array of bytes, returns true on success
pub fn ExportImageAsCode(
    image: Image,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportImageAsCode(
        image,
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
        color,
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
        top,
        bottom,
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
        left,
        right,
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
        density,
        inner,
        outer,
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
        col1,
        col2,
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
        factor,
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
        image,
    );
}

/// Create an image from another image piece
pub fn ImageFromImage(
    image: Image,
    rec: Rectangle,
) Image {
    return raylib.ImageFromImage(
        image,
        rec,
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
        color,
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
        font,
        text,
        fontSize,
        spacing,
        tint,
    );
}

/// Convert image data to desired format
pub fn ImageFormat(
    image: *Image,
    newFormat: i32,
) void {
    raylib.ImageFormat(
        @ptrCast([*c]Image, image),
        @intCast(c_int, newFormat),
    );
}

/// Convert image to POT (power-of-two)
pub fn ImageToPOT(
    image: *Image,
    fill: Color,
) void {
    raylib.ImageToPOT(
        @ptrCast([*c]Image, image),
        fill,
    );
}

/// Crop an image to a defined rectangle
pub fn ImageCrop(
    image: *Image,
    crop: Rectangle,
) void {
    raylib.ImageCrop(
        @ptrCast([*c]Image, image),
        crop,
    );
}

/// Crop image depending on alpha value
pub fn ImageAlphaCrop(
    image: *Image,
    threshold: f32,
) void {
    raylib.ImageAlphaCrop(
        @ptrCast([*c]Image, image),
        threshold,
    );
}

/// Clear alpha channel to desired color
pub fn ImageAlphaClear(
    image: *Image,
    color: Color,
    threshold: f32,
) void {
    raylib.ImageAlphaClear(
        @ptrCast([*c]Image, image),
        color,
        threshold,
    );
}

/// Apply alpha mask to image
pub fn ImageAlphaMask(
    image: *Image,
    alphaMask: Image,
) void {
    raylib.ImageAlphaMask(
        @ptrCast([*c]Image, image),
        alphaMask,
    );
}

/// Premultiply alpha channel
pub fn ImageAlphaPremultiply(
    image: *Image,
) void {
    raylib.ImageAlphaPremultiply(
        @ptrCast([*c]Image, image),
    );
}

/// Resize image (Bicubic scaling algorithm)
pub fn ImageResize(
    image: *Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.ImageResize(
        @ptrCast([*c]Image, image),
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
        @ptrCast([*c]Image, image),
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
        @ptrCast([*c]Image, image),
        @intCast(c_int, newWidth),
        @intCast(c_int, newHeight),
        @intCast(c_int, offsetX),
        @intCast(c_int, offsetY),
        fill,
    );
}

/// Compute all mipmap levels for a provided image
pub fn ImageMipmaps(
    image: *Image,
) void {
    raylib.ImageMipmaps(
        @ptrCast([*c]Image, image),
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
        @ptrCast([*c]Image, image),
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
        @ptrCast([*c]Image, image),
    );
}

/// Flip image horizontally
pub fn ImageFlipHorizontal(
    image: *Image,
) void {
    raylib.ImageFlipHorizontal(
        @ptrCast([*c]Image, image),
    );
}

/// Rotate image clockwise 90deg
pub fn ImageRotateCW(
    image: *Image,
) void {
    raylib.ImageRotateCW(
        @ptrCast([*c]Image, image),
    );
}

/// Rotate image counter-clockwise 90deg
pub fn ImageRotateCCW(
    image: *Image,
) void {
    raylib.ImageRotateCCW(
        @ptrCast([*c]Image, image),
    );
}

/// Modify image color: tint
pub fn ImageColorTint(
    image: *Image,
    color: Color,
) void {
    raylib.ImageColorTint(
        @ptrCast([*c]Image, image),
        color,
    );
}

/// Modify image color: invert
pub fn ImageColorInvert(
    image: *Image,
) void {
    raylib.ImageColorInvert(
        @ptrCast([*c]Image, image),
    );
}

/// Modify image color: grayscale
pub fn ImageColorGrayscale(
    image: *Image,
) void {
    raylib.ImageColorGrayscale(
        @ptrCast([*c]Image, image),
    );
}

/// Modify image color: contrast (-100 to 100)
pub fn ImageColorContrast(
    image: *Image,
    contrast: f32,
) void {
    raylib.ImageColorContrast(
        @ptrCast([*c]Image, image),
        contrast,
    );
}

/// Modify image color: brightness (-255 to 255)
pub fn ImageColorBrightness(
    image: *Image,
    brightness: i32,
) void {
    raylib.ImageColorBrightness(
        @ptrCast([*c]Image, image),
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
        @ptrCast([*c]Image, image),
        color,
        replace,
    );
}

/// Load color data from image as a Color array (RGBA - 32bit)
pub fn LoadImageColors(
    image: Image,
) [*c]Color {
    return raylib.LoadImageColors(
        image,
    );
}

/// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn LoadImagePalette(
    image: Image,
    maxPaletteSize: i32,
    colorCount: []i32,
) [*c]Color {
    return raylib.LoadImagePalette(
        image,
        @intCast(c_int, maxPaletteSize),
        @ptrCast([*c]c_int, colorCount.ptr),
    );
}

/// Unload color data loaded with LoadImageColors()
pub fn UnloadImageColors(
    colors: *Color,
) void {
    raylib.UnloadImageColors(
        @ptrCast([*c]Color, colors),
    );
}

/// Unload colors palette loaded with LoadImagePalette()
pub fn UnloadImagePalette(
    colors: *Color,
) void {
    raylib.UnloadImagePalette(
        @ptrCast([*c]Color, colors),
    );
}

/// Get image alpha border rectangle
pub fn GetImageAlphaBorder(
    image: Image,
    threshold: f32,
) Rectangle {
    return raylib.GetImageAlphaBorder(
        image,
        threshold,
    );
}

/// Get image pixel color at (x, y) position
pub fn GetImageColor(
    image: Image,
    x: i32,
    y: i32,
) Color {
    return raylib.GetImageColor(
        image,
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
        @ptrCast([*c]Image, dst),
        color,
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
        @ptrCast([*c]Image, dst),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        color,
    );
}

/// Draw pixel within an image (Vector version)
pub fn ImageDrawPixelV(
    dst: *Image,
    position: Vector2,
    color: Color,
) void {
    raylib.ImageDrawPixelV(
        @ptrCast([*c]Image, dst),
        position,
        color,
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
        @ptrCast([*c]Image, dst),
        @intCast(c_int, startPosX),
        @intCast(c_int, startPosY),
        @intCast(c_int, endPosX),
        @intCast(c_int, endPosY),
        color,
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
        @ptrCast([*c]Image, dst),
        start,
        end,
        color,
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
        @ptrCast([*c]Image, dst),
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @intCast(c_int, radius),
        color,
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
        @ptrCast([*c]Image, dst),
        center,
        @intCast(c_int, radius),
        color,
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
        @ptrCast([*c]Image, dst),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, width),
        @intCast(c_int, height),
        color,
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
        @ptrCast([*c]Image, dst),
        position,
        size,
        color,
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangleRec(
    dst: *Image,
    rec: Rectangle,
    color: Color,
) void {
    raylib.ImageDrawRectangleRec(
        @ptrCast([*c]Image, dst),
        rec,
        color,
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
        @ptrCast([*c]Image, dst),
        rec,
        @intCast(c_int, thick),
        color,
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
        @ptrCast([*c]Image, dst),
        src,
        srcRec,
        dstRec,
        tint,
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
        @ptrCast([*c]Image, dst),
        text,
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, fontSize),
        color,
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
        @ptrCast([*c]Image, dst),
        font,
        text,
        position,
        fontSize,
        spacing,
        tint,
    );
}

/// Load texture from file into GPU memory (VRAM)
pub fn LoadTexture(
    fileName: [:0]const u8,
) Texture2D {
    return raylib.LoadTexture(
        fileName,
    );
}

/// Load texture from image data
pub fn LoadTextureFromImage(
    image: Image,
) Texture2D {
    return raylib.LoadTextureFromImage(
        image,
    );
}

/// Load cubemap from image, multiple image cubemap layouts supported
pub fn LoadTextureCubemap(
    image: Image,
    layout: i32,
) TextureCubemap {
    return raylib.LoadTextureCubemap(
        image,
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
    texture: Texture2D,
) void {
    raylib.UnloadTexture(
        texture,
    );
}

/// Unload render texture from GPU memory (VRAM)
pub fn UnloadRenderTexture(
    target: RenderTexture2D,
) void {
    raylib.UnloadRenderTexture(
        target,
    );
}

/// Update GPU texture with new data
pub fn UpdateTexture(
    texture: Texture2D,
    pixels: *anyopaque,
) void {
    raylib.UpdateTexture(
        texture,
        pixels,
    );
}

/// Update GPU texture rectangle with new data
pub fn UpdateTextureRec(
    texture: Texture2D,
    rec: Rectangle,
    pixels: *anyopaque,
) void {
    raylib.UpdateTextureRec(
        texture,
        rec,
        pixels,
    );
}

/// Generate GPU mipmaps for a texture
pub fn GenTextureMipmaps(
    texture: *Texture2D,
) void {
    raylib.GenTextureMipmaps(
        @ptrCast([*c]Texture2D, texture),
    );
}

/// Set texture scaling filter mode
pub fn SetTextureFilter(
    texture: Texture2D,
    filter: i32,
) void {
    raylib.SetTextureFilter(
        texture,
        @intCast(c_int, filter),
    );
}

/// Set texture wrapping mode
pub fn SetTextureWrap(
    texture: Texture2D,
    wrap: i32,
) void {
    raylib.SetTextureWrap(
        texture,
        @intCast(c_int, wrap),
    );
}

/// Draw a Texture2D
pub fn DrawTexture(
    texture: Texture2D,
    posX: i32,
    posY: i32,
    tint: Color,
) void {
    raylib.DrawTexture(
        texture,
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        tint,
    );
}

/// Draw a Texture2D with position defined as Vector2
pub fn DrawTextureV(
    texture: Texture2D,
    position: Vector2,
    tint: Color,
) void {
    raylib.DrawTextureV(
        texture,
        position,
        tint,
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
    raylib.DrawTextureEx(
        texture,
        position,
        rotation,
        scale,
        tint,
    );
}

/// Draw a part of a texture defined by a rectangle
pub fn DrawTextureRec(
    texture: Texture2D,
    source: Rectangle,
    position: Vector2,
    tint: Color,
) void {
    raylib.DrawTextureRec(
        texture,
        source,
        position,
        tint,
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
    raylib.DrawTextureQuad(
        texture,
        tiling,
        offset,
        quad,
        tint,
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
    raylib.DrawTextureTiled(
        texture,
        source,
        dest,
        origin,
        rotation,
        scale,
        tint,
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
    raylib.DrawTexturePro(
        texture,
        source,
        dest,
        origin,
        rotation,
        tint,
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
    raylib.DrawTextureNPatch(
        texture,
        nPatchInfo,
        dest,
        origin,
        rotation,
        tint,
    );
}

/// Draw a textured polygon
pub fn DrawTexturePoly(
    texture: Texture2D,
    center: Vector2,
    points: *Vector2,
    texcoords: *Vector2,
    pointCount: i32,
    tint: Color,
) void {
    raylib.DrawTexturePoly(
        texture,
        center,
        @ptrCast([*c]Vector2, points),
        @ptrCast([*c]Vector2, texcoords),
        @intCast(c_int, pointCount),
        tint,
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn Fade(
    color: Color,
    alpha: f32,
) Color {
    return raylib.Fade(
        color,
        alpha,
    );
}

/// Get hexadecimal value for a Color
pub fn ColorToInt(
    color: Color,
) i32 {
    return raylib.ColorToInt(
        color,
    );
}

/// Get Color normalized as float [0..1]
pub fn ColorNormalize(
    color: Color,
) Vector4 {
    return raylib.ColorNormalize(
        color,
    );
}

/// Get Color from normalized values [0..1]
pub fn ColorFromNormalized(
    normalized: Vector4,
) Color {
    return raylib.ColorFromNormalized(
        normalized,
    );
}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn ColorToHSV(
    color: Color,
) Vector3 {
    return raylib.ColorToHSV(
        color,
    );
}

/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub fn ColorFromHSV(
    hue: f32,
    saturation: f32,
    value: f32,
) Color {
    return raylib.ColorFromHSV(
        hue,
        saturation,
        value,
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn ColorAlpha(
    color: Color,
    alpha: f32,
) Color {
    return raylib.ColorAlpha(
        color,
        alpha,
    );
}

/// Get src alpha-blended into dst color with tint
pub fn ColorAlphaBlend(
    dst: Color,
    src: Color,
    tint: Color,
) Color {
    return raylib.ColorAlphaBlend(
        dst,
        src,
        tint,
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
        srcPtr,
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
        dstPtr,
        color,
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
        image,
        key,
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

/// Load font data for further use
pub fn LoadFontData(
    fileData: [:0]const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: []i32,
    glyphCount: i32,
    type: i32,
) [*c]GlyphInfo {
    return raylib.LoadFontData(
        fileData,
        @intCast(c_int, dataSize),
        @intCast(c_int, fontSize),
        @ptrCast([*c]c_int, fontChars.ptr),
        @intCast(c_int, glyphCount),
        @intCast(c_int, type),
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
        @ptrCast([*c]const GlyphInfo, chars),
        @ptrCast([*c][*c]Rectangle, recs),
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
        @ptrCast([*c]GlyphInfo, chars),
        @intCast(c_int, glyphCount),
    );
}

/// Unload font from GPU memory (VRAM)
pub fn UnloadFont(
    font: Font,
) void {
    raylib.UnloadFont(
        font,
    );
}

/// Export font as code file, returns true on success
pub fn ExportFontAsCode(
    font: Font,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportFontAsCode(
        font,
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
        color,
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
        font,
        text,
        position,
        fontSize,
        spacing,
        tint,
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
        font,
        text,
        position,
        origin,
        rotation,
        fontSize,
        spacing,
        tint,
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
        font,
        @intCast(c_int, codepoint),
        position,
        fontSize,
        tint,
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
        font,
        @ptrCast([*c]c_int, codepoints.ptr),
        @intCast(c_int, count),
        position,
        fontSize,
        spacing,
        tint,
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
        font,
        text,
        fontSize,
        spacing,
    );
}

/// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphIndex(
    font: Font,
    codepoint: i32,
) i32 {
    return raylib.GetGlyphIndex(
        font,
        @intCast(c_int, codepoint),
    );
}

/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphInfo(
    font: Font,
    codepoint: i32,
) GlyphInfo {
    return raylib.GetGlyphInfo(
        font,
        @intCast(c_int, codepoint),
    );
}

/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphAtlasRec(
    font: Font,
    codepoint: i32,
) Rectangle {
    return raylib.GetGlyphAtlasRec(
        font,
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
        startPos,
        endPos,
        color,
    );
}

/// Draw a point in 3D space, actually a small line
pub fn DrawPoint3D(
    position: Vector3,
    color: Color,
) void {
    raylib.DrawPoint3D(
        position,
        color,
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
        center,
        radius,
        rotationAxis,
        rotationAngle,
        color,
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
        v1,
        v2,
        v3,
        color,
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip3D(
    points: *Vector3,
    pointCount: i32,
    color: Color,
) void {
    raylib.DrawTriangleStrip3D(
        @ptrCast([*c]Vector3, points),
        @intCast(c_int, pointCount),
        color,
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
        position,
        width,
        height,
        length,
        color,
    );
}

/// Draw cube (Vector version)
pub fn DrawCubeV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.DrawCubeV(
        position,
        size,
        color,
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
        position,
        width,
        height,
        length,
        color,
    );
}

/// Draw cube wires (Vector version)
pub fn DrawCubeWiresV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    raylib.DrawCubeWiresV(
        position,
        size,
        color,
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
    raylib.DrawCubeTexture(
        texture,
        position,
        width,
        height,
        length,
        color,
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
    raylib.DrawCubeTextureRec(
        texture,
        source,
        position,
        width,
        height,
        length,
        color,
    );
}

/// Draw sphere
pub fn DrawSphere(
    centerPos: Vector3,
    radius: f32,
    color: Color,
) void {
    raylib.DrawSphere(
        centerPos,
        radius,
        color,
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
        centerPos,
        radius,
        @intCast(c_int, rings),
        @intCast(c_int, slices),
        color,
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
        centerPos,
        radius,
        @intCast(c_int, rings),
        @intCast(c_int, slices),
        color,
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
        position,
        radiusTop,
        radiusBottom,
        height,
        @intCast(c_int, slices),
        color,
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
        startPos,
        endPos,
        startRadius,
        endRadius,
        @intCast(c_int, sides),
        color,
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
        position,
        radiusTop,
        radiusBottom,
        height,
        @intCast(c_int, slices),
        color,
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
        startPos,
        endPos,
        startRadius,
        endRadius,
        @intCast(c_int, sides),
        color,
    );
}

/// Draw a plane XZ
pub fn DrawPlane(
    centerPos: Vector3,
    size: Vector2,
    color: Color,
) void {
    raylib.DrawPlane(
        centerPos,
        size,
        color,
    );
}

/// Draw a ray line
pub fn DrawRay(
    ray: Ray,
    color: Color,
) void {
    raylib.DrawRay(
        ray,
        color,
    );
}

/// Draw a grid (centered at (0, 0, 0))
pub fn DrawGrid(
    slices: i32,
    spacing: f32,
) void {
    raylib.DrawGrid(
        @intCast(c_int, slices),
        spacing,
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
        mesh,
    );
}

/// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn UnloadModel(
    model: Model,
) void {
    raylib.UnloadModel(
        model,
    );
}

/// Unload model (but not meshes) from memory (RAM and/or VRAM)
pub fn UnloadModelKeepMeshes(
    model: Model,
) void {
    raylib.UnloadModelKeepMeshes(
        model,
    );
}

/// Compute model bounding box limits (considers all meshes)
pub fn GetModelBoundingBox(
    model: Model,
) BoundingBox {
    return raylib.GetModelBoundingBox(
        model,
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
        model,
        position,
        scale,
        tint,
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
        model,
        position,
        rotationAxis,
        rotationAngle,
        scale,
        tint,
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
        model,
        position,
        scale,
        tint,
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
        model,
        position,
        rotationAxis,
        rotationAngle,
        scale,
        tint,
    );
}

/// Draw bounding box (wires)
pub fn DrawBoundingBox(
    box: BoundingBox,
    color: Color,
) void {
    raylib.DrawBoundingBox(
        box,
        color,
    );
}

/// Draw a billboard texture
pub fn DrawBillboard(
    camera: Camera,
    texture: Texture2D,
    position: Vector3,
    size: f32,
    tint: Color,
) void {
    raylib.DrawBillboard(
        camera,
        texture,
        position,
        size,
        tint,
    );
}

/// Draw a billboard texture defined by source
pub fn DrawBillboardRec(
    camera: Camera,
    texture: Texture2D,
    source: Rectangle,
    position: Vector3,
    size: Vector2,
    tint: Color,
) void {
    raylib.DrawBillboardRec(
        camera,
        texture,
        source,
        position,
        size,
        tint,
    );
}

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
) void {
    raylib.DrawBillboardPro(
        camera,
        texture,
        source,
        position,
        up,
        size,
        origin,
        rotation,
        tint,
    );
}

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
pub fn UploadMesh(
    mesh: *Mesh,
    dynamic: bool,
) void {
    raylib.UploadMesh(
        @ptrCast([*c]Mesh, mesh),
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
    raylib.UpdateMeshBuffer(
        mesh,
        @intCast(c_int, index),
        data,
        @intCast(c_int, dataSize),
        @intCast(c_int, offset),
    );
}

/// Unload mesh data from CPU and GPU
pub fn UnloadMesh(
    mesh: Mesh,
) void {
    raylib.UnloadMesh(
        mesh,
    );
}

/// Draw a 3d mesh with material and transform
pub fn DrawMesh(
    mesh: Mesh,
    material: Material,
    transform: Matrix,
) void {
    raylib.DrawMesh(
        mesh,
        material,
        transform,
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
        mesh,
        material,
        @ptrCast([*c]const Matrix, transforms),
        @intCast(c_int, instances),
    );
}

/// Export mesh data to file, returns true on success
pub fn ExportMesh(
    mesh: Mesh,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportMesh(
        mesh,
        fileName,
    );
}

/// Compute mesh bounding box limits
pub fn GetMeshBoundingBox(
    mesh: Mesh,
) BoundingBox {
    return raylib.GetMeshBoundingBox(
        mesh,
    );
}

/// Compute mesh tangents
pub fn GenMeshTangents(
    mesh: *Mesh,
) void {
    raylib.GenMeshTangents(
        @ptrCast([*c]Mesh, mesh),
    );
}

/// Compute mesh binormals
pub fn GenMeshBinormals(
    mesh: *Mesh,
) void {
    raylib.GenMeshBinormals(
        @ptrCast([*c]Mesh, mesh),
    );
}

/// Generate polygonal mesh
pub fn GenMeshPoly(
    sides: i32,
    radius: f32,
) Mesh {
    return raylib.GenMeshPoly(
        @intCast(c_int, sides),
        radius,
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
        width,
        length,
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
        width,
        height,
        length,
    );
}

/// Generate sphere mesh (standard sphere)
pub fn GenMeshSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {
    return raylib.GenMeshSphere(
        radius,
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
        radius,
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
        radius,
        height,
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
        radius,
        height,
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
        radius,
        size,
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
        radius,
        size,
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
        heightmap,
        size,
    );
}

/// Generate cubes-based map mesh from image data
pub fn GenMeshCubicmap(
    cubicmap: Image,
    cubeSize: Vector3,
) Mesh {
    return raylib.GenMeshCubicmap(
        cubicmap,
        cubeSize,
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
        material,
    );
}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn SetMaterialTexture(
    material: *Material,
    mapType: i32,
    texture: Texture2D,
) void {
    raylib.SetMaterialTexture(
        @ptrCast([*c]Material, material),
        @intCast(c_int, mapType),
        texture,
    );
}

/// Set material for a mesh
pub fn SetModelMeshMaterial(
    model: *Model,
    meshId: i32,
    materialId: i32,
) void {
    raylib.SetModelMeshMaterial(
        @ptrCast([*c]Model, model),
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
        model,
        anim,
        @intCast(c_int, frame),
    );
}

/// Unload animation data
pub fn UnloadModelAnimation(
    anim: ModelAnimation,
) void {
    raylib.UnloadModelAnimation(
        anim,
    );
}

/// Unload animation array data
pub fn UnloadModelAnimations(
    animations: *ModelAnimation,
    count: u32,
) void {
    raylib.UnloadModelAnimations(
        @ptrCast([*c]ModelAnimation, animations),
        @intCast(c_uint, count),
    );
}

/// Check model animation skeleton match
pub fn IsModelAnimationValid(
    model: Model,
    anim: ModelAnimation,
) bool {
    return raylib.IsModelAnimationValid(
        model,
        anim,
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
        center1,
        radius1,
        center2,
        radius2,
    );
}

/// Check collision between two bounding boxes
pub fn CheckCollisionBoxes(
    box1: BoundingBox,
    box2: BoundingBox,
) bool {
    return raylib.CheckCollisionBoxes(
        box1,
        box2,
    );
}

/// Check collision between box and sphere
pub fn CheckCollisionBoxSphere(
    box: BoundingBox,
    center: Vector3,
    radius: f32,
) bool {
    return raylib.CheckCollisionBoxSphere(
        box,
        center,
        radius,
    );
}

/// Get collision info between ray and sphere
pub fn GetRayCollisionSphere(
    ray: Ray,
    center: Vector3,
    radius: f32,
) RayCollision {
    return raylib.GetRayCollisionSphere(
        ray,
        center,
        radius,
    );
}

/// Get collision info between ray and box
pub fn GetRayCollisionBox(
    ray: Ray,
    box: BoundingBox,
) RayCollision {
    return raylib.GetRayCollisionBox(
        ray,
        box,
    );
}

/// Get collision info between ray and mesh
pub fn GetRayCollisionMesh(
    ray: Ray,
    mesh: Mesh,
    transform: Matrix,
) RayCollision {
    return raylib.GetRayCollisionMesh(
        ray,
        mesh,
        transform,
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
        ray,
        p1,
        p2,
        p3,
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
        ray,
        p1,
        p2,
        p3,
        p4,
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
        volume,
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
        wave,
    );
}

/// Update sound buffer with new data
pub fn UpdateSound(
    sound: Sound,
    data: *anyopaque,
    sampleCount: i32,
) void {
    raylib.UpdateSound(
        sound,
        data,
        @intCast(c_int, sampleCount),
    );
}

/// Unload wave data
pub fn UnloadWave(
    wave: Wave,
) void {
    raylib.UnloadWave(
        wave,
    );
}

/// Unload sound
pub fn UnloadSound(
    sound: Sound,
) void {
    raylib.UnloadSound(
        sound,
    );
}

/// Export wave data to file, returns true on success
pub fn ExportWave(
    wave: Wave,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportWave(
        wave,
        fileName,
    );
}

/// Export wave sample data to code (.h), returns true on success
pub fn ExportWaveAsCode(
    wave: Wave,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportWaveAsCode(
        wave,
        fileName,
    );
}

/// Play a sound
pub fn PlaySound(
    sound: Sound,
) void {
    raylib.PlaySound(
        sound,
    );
}

/// Stop playing a sound
pub fn StopSound(
    sound: Sound,
) void {
    raylib.StopSound(
        sound,
    );
}

/// Pause a sound
pub fn PauseSound(
    sound: Sound,
) void {
    raylib.PauseSound(
        sound,
    );
}

/// Resume a paused sound
pub fn ResumeSound(
    sound: Sound,
) void {
    raylib.ResumeSound(
        sound,
    );
}

/// Play a sound (using multichannel buffer pool)
pub fn PlaySoundMulti(
    sound: Sound,
) void {
    raylib.PlaySoundMulti(
        sound,
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
        sound,
    );
}

/// Set volume for a sound (1.0 is max level)
pub fn SetSoundVolume(
    sound: Sound,
    volume: f32,
) void {
    raylib.SetSoundVolume(
        sound,
        volume,
    );
}

/// Set pitch for a sound (1.0 is base level)
pub fn SetSoundPitch(
    sound: Sound,
    pitch: f32,
) void {
    raylib.SetSoundPitch(
        sound,
        pitch,
    );
}

/// Set pan for a sound (0.5 is center)
pub fn SetSoundPan(
    sound: Sound,
    pan: f32,
) void {
    raylib.SetSoundPan(
        sound,
        pan,
    );
}

/// Copy a wave to a new wave
pub fn WaveCopy(
    wave: Wave,
) Wave {
    return raylib.WaveCopy(
        wave,
    );
}

/// Crop a wave to defined samples range
pub fn WaveCrop(
    wave: *Wave,
    initSample: i32,
    finalSample: i32,
) void {
    raylib.WaveCrop(
        @ptrCast([*c]Wave, wave),
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
        @ptrCast([*c]Wave, wave),
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
        wave,
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
        music,
    );
}

/// Start music playing
pub fn PlayMusicStream(
    music: Music,
) void {
    raylib.PlayMusicStream(
        music,
    );
}

/// Check if music is playing
pub fn IsMusicStreamPlaying(
    music: Music,
) bool {
    return raylib.IsMusicStreamPlaying(
        music,
    );
}

/// Updates buffers for music streaming
pub fn UpdateMusicStream(
    music: Music,
) void {
    raylib.UpdateMusicStream(
        music,
    );
}

/// Stop music playing
pub fn StopMusicStream(
    music: Music,
) void {
    raylib.StopMusicStream(
        music,
    );
}

/// Pause music playing
pub fn PauseMusicStream(
    music: Music,
) void {
    raylib.PauseMusicStream(
        music,
    );
}

/// Resume playing paused music
pub fn ResumeMusicStream(
    music: Music,
) void {
    raylib.ResumeMusicStream(
        music,
    );
}

/// Seek music to a position (in seconds)
pub fn SeekMusicStream(
    music: Music,
    position: f32,
) void {
    raylib.SeekMusicStream(
        music,
        position,
    );
}

/// Set volume for music (1.0 is max level)
pub fn SetMusicVolume(
    music: Music,
    volume: f32,
) void {
    raylib.SetMusicVolume(
        music,
        volume,
    );
}

/// Set pitch for a music (1.0 is base level)
pub fn SetMusicPitch(
    music: Music,
    pitch: f32,
) void {
    raylib.SetMusicPitch(
        music,
        pitch,
    );
}

/// Set pan for a music (0.5 is center)
pub fn SetMusicPan(
    music: Music,
    pan: f32,
) void {
    raylib.SetMusicPan(
        music,
        pan,
    );
}

/// Get music time length (in seconds)
pub fn GetMusicTimeLength(
    music: Music,
) f32 {
    return raylib.GetMusicTimeLength(
        music,
    );
}

/// Get current music time played (in seconds)
pub fn GetMusicTimePlayed(
    music: Music,
) f32 {
    return raylib.GetMusicTimePlayed(
        music,
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
        stream,
    );
}

/// Update audio stream buffers with data
pub fn UpdateAudioStream(
    stream: AudioStream,
    data: *anyopaque,
    frameCount: i32,
) void {
    raylib.UpdateAudioStream(
        stream,
        data,
        @intCast(c_int, frameCount),
    );
}

/// Check if any audio stream buffers requires refill
pub fn IsAudioStreamProcessed(
    stream: AudioStream,
) bool {
    return raylib.IsAudioStreamProcessed(
        stream,
    );
}

/// Play audio stream
pub fn PlayAudioStream(
    stream: AudioStream,
) void {
    raylib.PlayAudioStream(
        stream,
    );
}

/// Pause audio stream
pub fn PauseAudioStream(
    stream: AudioStream,
) void {
    raylib.PauseAudioStream(
        stream,
    );
}

/// Resume audio stream
pub fn ResumeAudioStream(
    stream: AudioStream,
) void {
    raylib.ResumeAudioStream(
        stream,
    );
}

/// Check if audio stream is playing
pub fn IsAudioStreamPlaying(
    stream: AudioStream,
) bool {
    return raylib.IsAudioStreamPlaying(
        stream,
    );
}

/// Stop audio stream
pub fn StopAudioStream(
    stream: AudioStream,
) void {
    raylib.StopAudioStream(
        stream,
    );
}

/// Set volume for audio stream (1.0 is max level)
pub fn SetAudioStreamVolume(
    stream: AudioStream,
    volume: f32,
) void {
    raylib.SetAudioStreamVolume(
        stream,
        volume,
    );
}

/// Set pitch for audio stream (1.0 is base level)
pub fn SetAudioStreamPitch(
    stream: AudioStream,
    pitch: f32,
) void {
    raylib.SetAudioStreamPitch(
        stream,
        pitch,
    );
}

/// Set pan for audio stream (0.5 is centered)
pub fn SetAudioStreamPan(
    stream: AudioStream,
    pan: f32,
) void {
    raylib.SetAudioStreamPan(
        stream,
        pan,
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
        stream,
        callback,
    );
}

/// 
pub fn AttachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.AttachAudioStreamProcessor(
        stream,
        processor,
    );
}

/// 
pub fn DetachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    raylib.DetachAudioStreamProcessor(
        stream,
        processor,
    );
}

/// 
pub fn Clamp(
    value: f32,
    min: f32,
    max: f32,
) f32 {
    return raylib.Clamp(
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
    return raylib.Lerp(
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
    return raylib.Normalize(
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
    return raylib.Remap(
        value,
        inputStart,
        inputEnd,
        outputStart,
        outputEnd,
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
        v1,
        v2,
    );
}

/// 
pub fn Vector2AddValue(
    v: Vector2,
    add: f32,
) Vector2 {
    return raylib.Vector2AddValue(
        v,
        add,
    );
}

/// 
pub fn Vector2Subtract(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    return raylib.Vector2Subtract(
        v1,
        v2,
    );
}

/// 
pub fn Vector2SubtractValue(
    v: Vector2,
    sub: f32,
) Vector2 {
    return raylib.Vector2SubtractValue(
        v,
        sub,
    );
}

/// 
pub fn Vector2Length(
    v: Vector2,
) f32 {
    return raylib.Vector2Length(
        v,
    );
}

/// 
pub fn Vector2LengthSqr(
    v: Vector2,
) f32 {
    return raylib.Vector2LengthSqr(
        v,
    );
}

/// 
pub fn Vector2DotProduct(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2DotProduct(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Distance(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2Distance(
        v1,
        v2,
    );
}

/// 
pub fn Vector2DistanceSqr(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2DistanceSqr(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Angle(
    v1: Vector2,
    v2: Vector2,
) f32 {
    return raylib.Vector2Angle(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Scale(
    v: Vector2,
    scale: f32,
) Vector2 {
    return raylib.Vector2Scale(
        v,
        scale,
    );
}

/// 
pub fn Vector2Multiply(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    return raylib.Vector2Multiply(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Negate(
    v: Vector2,
) Vector2 {
    return raylib.Vector2Negate(
        v,
    );
}

/// 
pub fn Vector2Divide(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    return raylib.Vector2Divide(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Normalize(
    v: Vector2,
) Vector2 {
    return raylib.Vector2Normalize(
        v,
    );
}

/// 
pub fn Vector2Transform(
    v: Vector2,
    mat: Matrix,
) Vector2 {
    return raylib.Vector2Transform(
        v,
        mat,
    );
}

/// 
pub fn Vector2Lerp(
    v1: Vector2,
    v2: Vector2,
    amount: f32,
) Vector2 {
    return raylib.Vector2Lerp(
        v1,
        v2,
        amount,
    );
}

/// 
pub fn Vector2Reflect(
    v: Vector2,
    normal: Vector2,
) Vector2 {
    return raylib.Vector2Reflect(
        v,
        normal,
    );
}

/// 
pub fn Vector2Rotate(
    v: Vector2,
    angle: f32,
) Vector2 {
    return raylib.Vector2Rotate(
        v,
        angle,
    );
}

/// 
pub fn Vector2MoveTowards(
    v: Vector2,
    target: Vector2,
    maxDistance: f32,
) Vector2 {
    return raylib.Vector2MoveTowards(
        v,
        target,
        maxDistance,
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
        v1,
        v2,
    );
}

/// 
pub fn Vector3AddValue(
    v: Vector3,
    add: f32,
) Vector3 {
    return raylib.Vector3AddValue(
        v,
        add,
    );
}

/// 
pub fn Vector3Subtract(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Subtract(
        v1,
        v2,
    );
}

/// 
pub fn Vector3SubtractValue(
    v: Vector3,
    sub: f32,
) Vector3 {
    return raylib.Vector3SubtractValue(
        v,
        sub,
    );
}

/// 
pub fn Vector3Scale(
    v: Vector3,
    scalar: f32,
) Vector3 {
    return raylib.Vector3Scale(
        v,
        scalar,
    );
}

/// 
pub fn Vector3Multiply(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Multiply(
        v1,
        v2,
    );
}

/// 
pub fn Vector3CrossProduct(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3CrossProduct(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Perpendicular(
    v: Vector3,
) Vector3 {
    return raylib.Vector3Perpendicular(
        v,
    );
}

/// 
pub fn Vector3Length(
    v: Vector3,
) f32 {
    return raylib.Vector3Length(
        v,
    );
}

/// 
pub fn Vector3LengthSqr(
    v: Vector3,
) f32 {
    return raylib.Vector3LengthSqr(
        v,
    );
}

/// 
pub fn Vector3DotProduct(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3DotProduct(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Distance(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3Distance(
        v1,
        v2,
    );
}

/// 
pub fn Vector3DistanceSqr(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3DistanceSqr(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Angle(
    v1: Vector3,
    v2: Vector3,
) f32 {
    return raylib.Vector3Angle(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Negate(
    v: Vector3,
) Vector3 {
    return raylib.Vector3Negate(
        v,
    );
}

/// 
pub fn Vector3Divide(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Divide(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Normalize(
    v: Vector3,
) Vector3 {
    return raylib.Vector3Normalize(
        v,
    );
}

/// 
pub fn Vector3OrthoNormalize(
    v1: *Vector3,
    v2: *Vector3,
) void {
    raylib.Vector3OrthoNormalize(
        @ptrCast([*c]Vector3, v1),
        @ptrCast([*c]Vector3, v2),
    );
}

/// 
pub fn Vector3Transform(
    v: Vector3,
    mat: Matrix,
) Vector3 {
    return raylib.Vector3Transform(
        v,
        mat,
    );
}

/// 
pub fn Vector3RotateByQuaternion(
    v: Vector3,
    q: Quaternion,
) Vector3 {
    return raylib.Vector3RotateByQuaternion(
        v,
        q,
    );
}

/// 
pub fn Vector3Lerp(
    v1: Vector3,
    v2: Vector3,
    amount: f32,
) Vector3 {
    return raylib.Vector3Lerp(
        v1,
        v2,
        amount,
    );
}

/// 
pub fn Vector3Reflect(
    v: Vector3,
    normal: Vector3,
) Vector3 {
    return raylib.Vector3Reflect(
        v,
        normal,
    );
}

/// 
pub fn Vector3Min(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Min(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Max(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    return raylib.Vector3Max(
        v1,
        v2,
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
        p,
        a,
        b,
        c,
    );
}

/// 
pub fn Vector3Unproject(
    source: Vector3,
    projection: Matrix,
    view: Matrix,
) Vector3 {
    return raylib.Vector3Unproject(
        source,
        projection,
        view,
    );
}

/// 
pub fn Vector3ToFloatV(
    v: Vector3,
) float3 {
    return raylib.Vector3ToFloatV(
        v,
    );
}

/// 
pub fn MatrixDeterminant(
    mat: Matrix,
) f32 {
    return raylib.MatrixDeterminant(
        mat,
    );
}

/// 
pub fn MatrixTrace(
    mat: Matrix,
) f32 {
    return raylib.MatrixTrace(
        mat,
    );
}

/// 
pub fn MatrixTranspose(
    mat: Matrix,
) Matrix {
    return raylib.MatrixTranspose(
        mat,
    );
}

/// 
pub fn MatrixInvert(
    mat: Matrix,
) Matrix {
    return raylib.MatrixInvert(
        mat,
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
        left,
        right,
    );
}

/// 
pub fn MatrixSubtract(
    left: Matrix,
    right: Matrix,
) Matrix {
    return raylib.MatrixSubtract(
        left,
        right,
    );
}

/// 
pub fn MatrixMultiply(
    left: Matrix,
    right: Matrix,
) Matrix {
    return raylib.MatrixMultiply(
        left,
        right,
    );
}

/// 
pub fn MatrixTranslate(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    return raylib.MatrixTranslate(
        x,
        y,
        z,
    );
}

/// 
pub fn MatrixRotate(
    axis: Vector3,
    angle: f32,
) Matrix {
    return raylib.MatrixRotate(
        axis,
        angle,
    );
}

/// 
pub fn MatrixRotateX(
    angle: f32,
) Matrix {
    return raylib.MatrixRotateX(
        angle,
    );
}

/// 
pub fn MatrixRotateY(
    angle: f32,
) Matrix {
    return raylib.MatrixRotateY(
        angle,
    );
}

/// 
pub fn MatrixRotateZ(
    angle: f32,
) Matrix {
    return raylib.MatrixRotateZ(
        angle,
    );
}

/// 
pub fn MatrixRotateXYZ(
    ang: Vector3,
) Matrix {
    return raylib.MatrixRotateXYZ(
        ang,
    );
}

/// 
pub fn MatrixRotateZYX(
    ang: Vector3,
) Matrix {
    return raylib.MatrixRotateZYX(
        ang,
    );
}

/// 
pub fn MatrixScale(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    return raylib.MatrixScale(
        x,
        y,
        z,
    );
}

/// 
pub fn MatrixFrustum(
    left: double,
    right: double,
    bottom: double,
    top: double,
    near: double,
    far: double,
) Matrix {
    return raylib.MatrixFrustum(
        left,
        right,
        bottom,
        top,
        near,
        far,
    );
}

/// 
pub fn MatrixPerspective(
    fovy: double,
    aspect: double,
    near: double,
    far: double,
) Matrix {
    return raylib.MatrixPerspective(
        fovy,
        aspect,
        near,
        far,
    );
}

/// 
pub fn MatrixOrtho(
    left: double,
    right: double,
    bottom: double,
    top: double,
    near: double,
    far: double,
) Matrix {
    return raylib.MatrixOrtho(
        left,
        right,
        bottom,
        top,
        near,
        far,
    );
}

/// 
pub fn MatrixLookAt(
    eye: Vector3,
    target: Vector3,
    up: Vector3,
) Matrix {
    return raylib.MatrixLookAt(
        eye,
        target,
        up,
    );
}

/// 
pub fn MatrixToFloatV(
    mat: Matrix,
) float16 {
    return raylib.MatrixToFloatV(
        mat,
    );
}

/// 
pub fn QuaternionAdd(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionAdd(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionAddValue(
    q: Quaternion,
    add: f32,
) Quaternion {
    return raylib.QuaternionAddValue(
        q,
        add,
    );
}

/// 
pub fn QuaternionSubtract(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionSubtract(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionSubtractValue(
    q: Quaternion,
    sub: f32,
) Quaternion {
    return raylib.QuaternionSubtractValue(
        q,
        sub,
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
        q,
    );
}

/// 
pub fn QuaternionNormalize(
    q: Quaternion,
) Quaternion {
    return raylib.QuaternionNormalize(
        q,
    );
}

/// 
pub fn QuaternionInvert(
    q: Quaternion,
) Quaternion {
    return raylib.QuaternionInvert(
        q,
    );
}

/// 
pub fn QuaternionMultiply(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionMultiply(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionScale(
    q: Quaternion,
    mul: f32,
) Quaternion {
    return raylib.QuaternionScale(
        q,
        mul,
    );
}

/// 
pub fn QuaternionDivide(
    q1: Quaternion,
    q2: Quaternion,
) Quaternion {
    return raylib.QuaternionDivide(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionLerp(
    q1: Quaternion,
    q2: Quaternion,
    amount: f32,
) Quaternion {
    return raylib.QuaternionLerp(
        q1,
        q2,
        amount,
    );
}

/// 
pub fn QuaternionNlerp(
    q1: Quaternion,
    q2: Quaternion,
    amount: f32,
) Quaternion {
    return raylib.QuaternionNlerp(
        q1,
        q2,
        amount,
    );
}

/// 
pub fn QuaternionSlerp(
    q1: Quaternion,
    q2: Quaternion,
    amount: f32,
) Quaternion {
    return raylib.QuaternionSlerp(
        q1,
        q2,
        amount,
    );
}

/// 
pub fn QuaternionFromVector3ToVector3(
    from: Vector3,
    to: Vector3,
) Quaternion {
    return raylib.QuaternionFromVector3ToVector3(
        from,
        to,
    );
}

/// 
pub fn QuaternionFromMatrix(
    mat: Matrix,
) Quaternion {
    return raylib.QuaternionFromMatrix(
        mat,
    );
}

/// 
pub fn QuaternionToMatrix(
    q: Quaternion,
) Matrix {
    return raylib.QuaternionToMatrix(
        q,
    );
}

/// 
pub fn QuaternionFromAxisAngle(
    axis: Vector3,
    angle: f32,
) Quaternion {
    return raylib.QuaternionFromAxisAngle(
        axis,
        angle,
    );
}

/// 
pub fn QuaternionToAxisAngle(
    q: Quaternion,
    outAxis: *Vector3,
    outAngle: []f32,
) void {
    raylib.QuaternionToAxisAngle(
        q,
        @ptrCast([*c]Vector3, outAxis),
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
        pitch,
        yaw,
        roll,
    );
}

/// 
pub fn QuaternionToEuler(
    q: Quaternion,
) Vector3 {
    return raylib.QuaternionToEuler(
        q,
    );
}

/// 
pub fn QuaternionTransform(
    q: Quaternion,
    mat: Matrix,
) Quaternion {
    return raylib.QuaternionTransform(
        q,
        mat,
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
        alpha,
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
        font,
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
        bounds,
        title,
    );
}

/// Group Box control with text name
pub fn GuiGroupBox(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiGroupBox(
        bounds,
        text,
    );
}

/// Line separator control, could contain text
pub fn GuiLine(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiLine(
        bounds,
        text,
    );
}

/// Panel control, useful to group controls
pub fn GuiPanel(
    bounds: Rectangle,
) void {
    raylib.GuiPanel(
        bounds,
    );
}

/// Scroll Panel control
pub fn GuiScrollPanel(
    bounds: Rectangle,
    content: Rectangle,
    scroll: *Vector2,
) Rectangle {
    return raylib.GuiScrollPanel(
        bounds,
        content,
        @ptrCast([*c]Vector2, scroll),
    );
}

/// Label control, shows text
pub fn GuiLabel(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiLabel(
        bounds,
        text,
    );
}

/// Button control, returns true when clicked
pub fn GuiButton(
    bounds: Rectangle,
    text: [:0]const u8,
) bool {
    return raylib.GuiButton(
        bounds,
        text,
    );
}

/// Label button control, show true when clicked
pub fn GuiLabelButton(
    bounds: Rectangle,
    text: [:0]const u8,
) bool {
    return raylib.GuiLabelButton(
        bounds,
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
        bounds,
        text,
        active,
    );
}

/// Toggle Group control, returns active toggle index
pub fn GuiToggleGroup(
    bounds: Rectangle,
    text: [:0]const u8,
    active: i32,
) i32 {
    return raylib.GuiToggleGroup(
        bounds,
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
        bounds,
        text,
        checked,
    );
}

/// Combo Box control, returns selected item index
pub fn GuiComboBox(
    bounds: Rectangle,
    text: [:0]const u8,
    active: i32,
) i32 {
    return raylib.GuiComboBox(
        bounds,
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
        bounds,
        text,
        @ptrCast([*c]c_int, active.ptr),
        editMode,
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
        bounds,
        text,
        @ptrCast([*c]c_int, value.ptr),
        @intCast(c_int, minValue),
        @intCast(c_int, maxValue),
        editMode,
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
        bounds,
        text,
        @ptrCast([*c]c_int, value.ptr),
        @intCast(c_int, minValue),
        @intCast(c_int, maxValue),
        editMode,
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
        bounds,
        text,
        @intCast(c_int, textSize),
        editMode,
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
        bounds,
        text,
        @intCast(c_int, textSize),
        editMode,
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
        bounds,
        textLeft,
        textRight,
        value,
        minValue,
        maxValue,
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
        bounds,
        textLeft,
        textRight,
        value,
        minValue,
        maxValue,
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
        bounds,
        textLeft,
        textRight,
        value,
        minValue,
        maxValue,
    );
}

/// Status Bar control, shows info text
pub fn GuiStatusBar(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiStatusBar(
        bounds,
        text,
    );
}

/// Dummy control for placeholders
pub fn GuiDummyRec(
    bounds: Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiDummyRec(
        bounds,
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
        bounds,
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
        bounds,
        spacing,
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
        bounds,
        text,
        @ptrCast([*c]c_int, scrollIndex.ptr),
        @intCast(c_int, active),
    );
}

/// List View with extended parameters
pub fn GuiListViewEx(
    bounds: Rectangle,
    text: [*c][*c]const char,
    count: i32,
    focus: []i32,
    scrollIndex: []i32,
    active: i32,
) i32 {
    return raylib.GuiListViewEx(
        bounds,
        @ptrCast([*c][*c]const char, text),
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
        bounds,
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
        bounds,
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
        bounds,
        color,
    );
}

/// Color Panel control
pub fn GuiColorPanel(
    bounds: Rectangle,
    color: Color,
) Color {
    return raylib.GuiColorPanel(
        bounds,
        color,
    );
}

/// Color Bar Alpha control
pub fn GuiColorBarAlpha(
    bounds: Rectangle,
    alpha: f32,
) f32 {
    return raylib.GuiColorBarAlpha(
        bounds,
        alpha,
    );
}

/// Color Bar Hue control
pub fn GuiColorBarHue(
    bounds: Rectangle,
    value: f32,
) f32 {
    return raylib.GuiColorBarHue(
        bounds,
        value,
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
        style,
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
        color,
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
