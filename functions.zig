const raylib = @cImport({
    @cInclude("raylib/src/raylib.h");
});
const types = struct {
    usingnamespace @import("structs.zig");
    usingnamespace @import("enums.zig");
    usingnamespace @import("manual_bindings.zig");
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
    image: types.Image,
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
) types.Vector2 {
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
pub fn GetWindowPosition() types.Vector2 {
    return raylib.GetWindowPosition();
}

/// Get window scale DPI factor
pub fn GetWindowScaleDPI() types.Vector2 {
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
    color: types.Color,
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
    camera: types.Camera2D,
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
    camera: types.Camera3D,
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
    target: types.RenderTexture2D,
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
    shader: types.Shader,
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
    config: types.VrStereoConfig,
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
    device: types.VrDeviceInfo,
) types.VrStereoConfig {
    return raylib.LoadVrStereoConfig(
        device,
    );
}

/// Unload VR stereo config
pub fn UnloadVrStereoConfig(
    config: types.VrStereoConfig,
) void {
    raylib.UnloadVrStereoConfig(
        config,
    );
}

/// Load shader from files and bind default locations
pub fn LoadShader(
    vsFileName: [:0]const u8,
    fsFileName: [:0]const u8,
) types.Shader {
    return raylib.LoadShader(
        vsFileName,
        fsFileName,
    );
}

/// Load shader from code strings and bind default locations
pub fn LoadShaderFromMemory(
    vsCode: [:0]const u8,
    fsCode: [:0]const u8,
) types.Shader {
    return raylib.LoadShaderFromMemory(
        vsCode,
        fsCode,
    );
}

/// Get shader uniform location
pub fn GetShaderLocation(
    shader: types.Shader,
    uniformName: [:0]const u8,
) i32 {
    return raylib.GetShaderLocation(
        shader,
        uniformName,
    );
}

/// Get shader attribute location
pub fn GetShaderLocationAttrib(
    shader: types.Shader,
    attribName: [:0]const u8,
) i32 {
    return raylib.GetShaderLocationAttrib(
        shader,
        attribName,
    );
}

/// Set shader uniform value
pub fn SetShaderValue(
    shader: types.Shader,
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
    shader: types.Shader,
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
    shader: types.Shader,
    locIndex: i32,
    mat: types.Matrix,
) void {
    raylib.SetShaderValueMatrix(
        shader,
        @intCast(c_int, locIndex),
        mat,
    );
}

/// Set shader uniform value for texture (sampler2d)
pub fn SetShaderValueTexture(
    shader: types.Shader,
    locIndex: i32,
    texture: types.Texture2D,
) void {
    raylib.SetShaderValueTexture(
        shader,
        @intCast(c_int, locIndex),
        texture,
    );
}

/// Unload shader from GPU memory (VRAM)
pub fn UnloadShader(
    shader: types.Shader,
) void {
    raylib.UnloadShader(
        shader,
    );
}

/// Get a ray trace from mouse position
pub fn GetMouseRay(
    mousePosition: types.Vector2,
    camera: types.Camera,
) types.Ray {
    return raylib.GetMouseRay(
        mousePosition,
        camera,
    );
}

/// Get camera transform matrix (view matrix)
pub fn GetCameraMatrix(
    camera: types.Camera,
) types.Matrix {
    return raylib.GetCameraMatrix(
        camera,
    );
}

/// Get camera 2d transform matrix
pub fn GetCameraMatrix2D(
    camera: types.Camera2D,
) types.Matrix {
    return raylib.GetCameraMatrix2D(
        camera,
    );
}

/// Get the screen space position for a 3d world space position
pub fn GetWorldToScreen(
    position: types.Vector3,
    camera: types.Camera,
) types.Vector2 {
    return raylib.GetWorldToScreen(
        position,
        camera,
    );
}

/// Get size position for a 3d world space position
pub fn GetWorldToScreenEx(
    position: types.Vector3,
    camera: types.Camera,
    width: i32,
    height: i32,
) types.Vector2 {
    return raylib.GetWorldToScreenEx(
        position,
        camera,
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

/// Get the screen space position for a 2d camera world space position
pub fn GetWorldToScreen2D(
    position: types.Vector2,
    camera: types.Camera2D,
) types.Vector2 {
    return raylib.GetWorldToScreen2D(
        position,
        camera,
    );
}

/// Get the world space position for a 2d camera screen space position
pub fn GetScreenToWorld2D(
    position: types.Vector2,
    camera: types.Camera2D,
) types.Vector2 {
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
    callback: types.TraceLogCallback,
) void {
    raylib.SetTraceLogCallback(
        callback,
    );
}

/// Set custom file binary data loader
pub fn SetLoadFileDataCallback(
    callback: types.LoadFileDataCallback,
) void {
    raylib.SetLoadFileDataCallback(
        callback,
    );
}

/// Set custom file binary data saver
pub fn SetSaveFileDataCallback(
    callback: types.SaveFileDataCallback,
) void {
    raylib.SetSaveFileDataCallback(
        callback,
    );
}

/// Set custom file text data loader
pub fn SetLoadFileTextCallback(
    callback: types.LoadFileTextCallback,
) void {
    raylib.SetLoadFileTextCallback(
        callback,
    );
}

/// Set custom file text data saver
pub fn SetSaveFileTextCallback(
    callback: types.SaveFileTextCallback,
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
pub fn GetMousePosition() types.Vector2 {
    return raylib.GetMousePosition();
}

/// Get mouse delta between frames
pub fn GetMouseDelta() types.Vector2 {
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
) types.Vector2 {
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
pub fn GetGestureDragVector() types.Vector2 {
    return raylib.GetGestureDragVector();
}

/// Get gesture drag angle
pub fn GetGestureDragAngle() f32 {
    return raylib.GetGestureDragAngle();
}

/// Get gesture pinch delta
pub fn GetGesturePinchVector() types.Vector2 {
    return raylib.GetGesturePinchVector();
}

/// Get gesture pinch angle
pub fn GetGesturePinchAngle() f32 {
    return raylib.GetGesturePinchAngle();
}

/// Set camera mode (multiple camera modes available)
pub fn SetCameraMode(
    camera: types.Camera,
    mode: i32,
) void {
    raylib.SetCameraMode(
        camera,
        @intCast(c_int, mode),
    );
}

/// Update camera position for selected mode
pub fn UpdateCamera(
    camera: *types.Camera,
) void {
    raylib.UpdateCamera(
        @ptrCast([*c]types.Camera, camera),
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
    texture: types.Texture2D,
    source: types.Rectangle,
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
    color: types.Color,
) void {
    raylib.DrawPixel(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        color,
    );
}

/// Draw a pixel (Vector version)
pub fn DrawPixelV(
    position: types.Vector2,
    color: types.Color,
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
    color: types.Color,
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
    startPos: types.Vector2,
    endPos: types.Vector2,
    color: types.Color,
) void {
    raylib.DrawLineV(
        startPos,
        endPos,
        color,
    );
}

/// Draw a line defining thickness
pub fn DrawLineEx(
    startPos: types.Vector2,
    endPos: types.Vector2,
    thick: f32,
    color: types.Color,
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
    startPos: types.Vector2,
    endPos: types.Vector2,
    thick: f32,
    color: types.Color,
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
    startPos: types.Vector2,
    endPos: types.Vector2,
    controlPos: types.Vector2,
    thick: f32,
    color: types.Color,
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
    startPos: types.Vector2,
    endPos: types.Vector2,
    startControlPos: types.Vector2,
    endControlPos: types.Vector2,
    thick: f32,
    color: types.Color,
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
    points: *types.Vector2,
    pointCount: i32,
    color: types.Color,
) void {
    raylib.DrawLineStrip(
        @ptrCast([*c]types.Vector2, points),
        @intCast(c_int, pointCount),
        color,
    );
}

/// Draw a color-filled circle
pub fn DrawCircle(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: types.Color,
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
    center: types.Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: types.Color,
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
    center: types.Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: types.Color,
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
    color1: types.Color,
    color2: types.Color,
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
    center: types.Vector2,
    radius: f32,
    color: types.Color,
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
    color: types.Color,
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
    color: types.Color,
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
    color: types.Color,
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
    center: types.Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: types.Color,
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
    center: types.Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: types.Color,
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
    color: types.Color,
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
    position: types.Vector2,
    size: types.Vector2,
    color: types.Color,
) void {
    raylib.DrawRectangleV(
        position,
        size,
        color,
    );
}

/// Draw a color-filled rectangle
pub fn DrawRectangleRec(
    rec: types.Rectangle,
    color: types.Color,
) void {
    raylib.DrawRectangleRec(
        rec,
        color,
    );
}

/// Draw a color-filled rectangle with pro parameters
pub fn DrawRectanglePro(
    rec: types.Rectangle,
    origin: types.Vector2,
    rotation: f32,
    color: types.Color,
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
    color1: types.Color,
    color2: types.Color,
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
    color1: types.Color,
    color2: types.Color,
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
    rec: types.Rectangle,
    col1: types.Color,
    col2: types.Color,
    col3: types.Color,
    col4: types.Color,
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
    color: types.Color,
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
    rec: types.Rectangle,
    lineThick: f32,
    color: types.Color,
) void {
    raylib.DrawRectangleLinesEx(
        rec,
        lineThick,
        color,
    );
}

/// Draw rectangle with rounded edges
pub fn DrawRectangleRounded(
    rec: types.Rectangle,
    roundness: f32,
    segments: i32,
    color: types.Color,
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
    rec: types.Rectangle,
    roundness: f32,
    segments: i32,
    lineThick: f32,
    color: types.Color,
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
    v1: types.Vector2,
    v2: types.Vector2,
    v3: types.Vector2,
    color: types.Color,
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
    v1: types.Vector2,
    v2: types.Vector2,
    v3: types.Vector2,
    color: types.Color,
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
    points: *types.Vector2,
    pointCount: i32,
    color: types.Color,
) void {
    raylib.DrawTriangleFan(
        @ptrCast([*c]types.Vector2, points),
        @intCast(c_int, pointCount),
        color,
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip(
    points: *types.Vector2,
    pointCount: i32,
    color: types.Color,
) void {
    raylib.DrawTriangleStrip(
        @ptrCast([*c]types.Vector2, points),
        @intCast(c_int, pointCount),
        color,
    );
}

/// Draw a regular polygon (Vector version)
pub fn DrawPoly(
    center: types.Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: types.Color,
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
    center: types.Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: types.Color,
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
    center: types.Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    lineThick: f32,
    color: types.Color,
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
    rec1: types.Rectangle,
    rec2: types.Rectangle,
) bool {
    return raylib.CheckCollisionRecs(
        rec1,
        rec2,
    );
}

/// Check collision between two circles
pub fn CheckCollisionCircles(
    center1: types.Vector2,
    radius1: f32,
    center2: types.Vector2,
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
    center: types.Vector2,
    radius: f32,
    rec: types.Rectangle,
) bool {
    return raylib.CheckCollisionCircleRec(
        center,
        radius,
        rec,
    );
}

/// Check if point is inside rectangle
pub fn CheckCollisionPointRec(
    point: types.Vector2,
    rec: types.Rectangle,
) bool {
    return raylib.CheckCollisionPointRec(
        point,
        rec,
    );
}

/// Check if point is inside circle
pub fn CheckCollisionPointCircle(
    point: types.Vector2,
    center: types.Vector2,
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
    point: types.Vector2,
    p1: types.Vector2,
    p2: types.Vector2,
    p3: types.Vector2,
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
    startPos1: types.Vector2,
    endPos1: types.Vector2,
    startPos2: types.Vector2,
    endPos2: types.Vector2,
    collisionPoint: *types.Vector2,
) bool {
    return raylib.CheckCollisionLines(
        startPos1,
        endPos1,
        startPos2,
        endPos2,
        @ptrCast([*c]types.Vector2, collisionPoint),
    );
}

/// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub fn CheckCollisionPointLine(
    point: types.Vector2,
    p1: types.Vector2,
    p2: types.Vector2,
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
    rec1: types.Rectangle,
    rec2: types.Rectangle,
) types.Rectangle {
    return raylib.GetCollisionRec(
        rec1,
        rec2,
    );
}

/// Load image from file into CPU memory (RAM)
pub fn LoadImage(
    fileName: [:0]const u8,
) types.Image {
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
) types.Image {
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
) types.Image {
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
) types.Image {
    return raylib.LoadImageFromMemory(
        fileType,
        fileData,
        @intCast(c_int, dataSize),
    );
}

/// Load image from GPU texture data
pub fn LoadImageFromTexture(
    texture: types.Texture2D,
) types.Image {
    return raylib.LoadImageFromTexture(
        texture,
    );
}

/// Load image from screen buffer and (screenshot)
pub fn LoadImageFromScreen() types.Image {
    return raylib.LoadImageFromScreen();
}

/// Unload image from CPU memory (RAM)
pub fn UnloadImage(
    image: types.Image,
) void {
    raylib.UnloadImage(
        image,
    );
}

/// Export image data to file, returns true on success
pub fn ExportImage(
    image: types.Image,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportImage(
        image,
        fileName,
    );
}

/// Export image as code file defining an array of bytes, returns true on success
pub fn ExportImageAsCode(
    image: types.Image,
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
    color: types.Color,
) types.Image {
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
    top: types.Color,
    bottom: types.Color,
) types.Image {
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
    left: types.Color,
    right: types.Color,
) types.Image {
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
    inner: types.Color,
    outer: types.Color,
) types.Image {
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
    col1: types.Color,
    col2: types.Color,
) types.Image {
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
) types.Image {
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
) types.Image {
    return raylib.GenImageCellular(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @intCast(c_int, tileSize),
    );
}

/// Create an image duplicate (useful for transformations)
pub fn ImageCopy(
    image: types.Image,
) types.Image {
    return raylib.ImageCopy(
        image,
    );
}

/// Create an image from another image piece
pub fn ImageFromImage(
    image: types.Image,
    rec: types.Rectangle,
) types.Image {
    return raylib.ImageFromImage(
        image,
        rec,
    );
}

/// Create an image from text (default font)
pub fn ImageText(
    text: [:0]const u8,
    fontSize: i32,
    color: types.Color,
) types.Image {
    return raylib.ImageText(
        text,
        @intCast(c_int, fontSize),
        color,
    );
}

/// Create an image from text (custom sprite font)
pub fn ImageTextEx(
    font: types.Font,
    text: [:0]const u8,
    fontSize: f32,
    spacing: f32,
    tint: types.Color,
) types.Image {
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
    image: *types.Image,
    newFormat: i32,
) void {
    raylib.ImageFormat(
        @ptrCast([*c]types.Image, image),
        @intCast(c_int, newFormat),
    );
}

/// Convert image to POT (power-of-two)
pub fn ImageToPOT(
    image: *types.Image,
    fill: types.Color,
) void {
    raylib.ImageToPOT(
        @ptrCast([*c]types.Image, image),
        fill,
    );
}

/// Crop an image to a defined rectangle
pub fn ImageCrop(
    image: *types.Image,
    crop: types.Rectangle,
) void {
    raylib.ImageCrop(
        @ptrCast([*c]types.Image, image),
        crop,
    );
}

/// Crop image depending on alpha value
pub fn ImageAlphaCrop(
    image: *types.Image,
    threshold: f32,
) void {
    raylib.ImageAlphaCrop(
        @ptrCast([*c]types.Image, image),
        threshold,
    );
}

/// Clear alpha channel to desired color
pub fn ImageAlphaClear(
    image: *types.Image,
    color: types.Color,
    threshold: f32,
) void {
    raylib.ImageAlphaClear(
        @ptrCast([*c]types.Image, image),
        color,
        threshold,
    );
}

/// Apply alpha mask to image
pub fn ImageAlphaMask(
    image: *types.Image,
    alphaMask: types.Image,
) void {
    raylib.ImageAlphaMask(
        @ptrCast([*c]types.Image, image),
        alphaMask,
    );
}

/// Premultiply alpha channel
pub fn ImageAlphaPremultiply(
    image: *types.Image,
) void {
    raylib.ImageAlphaPremultiply(
        @ptrCast([*c]types.Image, image),
    );
}

/// Resize image (Bicubic scaling algorithm)
pub fn ImageResize(
    image: *types.Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.ImageResize(
        @ptrCast([*c]types.Image, image),
        @intCast(c_int, newWidth),
        @intCast(c_int, newHeight),
    );
}

/// Resize image (Nearest-Neighbor scaling algorithm)
pub fn ImageResizeNN(
    image: *types.Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.ImageResizeNN(
        @ptrCast([*c]types.Image, image),
        @intCast(c_int, newWidth),
        @intCast(c_int, newHeight),
    );
}

/// Resize canvas and fill with color
pub fn ImageResizeCanvas(
    image: *types.Image,
    newWidth: i32,
    newHeight: i32,
    offsetX: i32,
    offsetY: i32,
    fill: types.Color,
) void {
    raylib.ImageResizeCanvas(
        @ptrCast([*c]types.Image, image),
        @intCast(c_int, newWidth),
        @intCast(c_int, newHeight),
        @intCast(c_int, offsetX),
        @intCast(c_int, offsetY),
        fill,
    );
}

/// Compute all mipmap levels for a provided image
pub fn ImageMipmaps(
    image: *types.Image,
) void {
    raylib.ImageMipmaps(
        @ptrCast([*c]types.Image, image),
    );
}

/// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub fn ImageDither(
    image: *types.Image,
    rBpp: i32,
    gBpp: i32,
    bBpp: i32,
    aBpp: i32,
) void {
    raylib.ImageDither(
        @ptrCast([*c]types.Image, image),
        @intCast(c_int, rBpp),
        @intCast(c_int, gBpp),
        @intCast(c_int, bBpp),
        @intCast(c_int, aBpp),
    );
}

/// Flip image vertically
pub fn ImageFlipVertical(
    image: *types.Image,
) void {
    raylib.ImageFlipVertical(
        @ptrCast([*c]types.Image, image),
    );
}

/// Flip image horizontally
pub fn ImageFlipHorizontal(
    image: *types.Image,
) void {
    raylib.ImageFlipHorizontal(
        @ptrCast([*c]types.Image, image),
    );
}

/// Rotate image clockwise 90deg
pub fn ImageRotateCW(
    image: *types.Image,
) void {
    raylib.ImageRotateCW(
        @ptrCast([*c]types.Image, image),
    );
}

/// Rotate image counter-clockwise 90deg
pub fn ImageRotateCCW(
    image: *types.Image,
) void {
    raylib.ImageRotateCCW(
        @ptrCast([*c]types.Image, image),
    );
}

/// Modify image color: tint
pub fn ImageColorTint(
    image: *types.Image,
    color: types.Color,
) void {
    raylib.ImageColorTint(
        @ptrCast([*c]types.Image, image),
        color,
    );
}

/// Modify image color: invert
pub fn ImageColorInvert(
    image: *types.Image,
) void {
    raylib.ImageColorInvert(
        @ptrCast([*c]types.Image, image),
    );
}

/// Modify image color: grayscale
pub fn ImageColorGrayscale(
    image: *types.Image,
) void {
    raylib.ImageColorGrayscale(
        @ptrCast([*c]types.Image, image),
    );
}

/// Modify image color: contrast (-100 to 100)
pub fn ImageColorContrast(
    image: *types.Image,
    contrast: f32,
) void {
    raylib.ImageColorContrast(
        @ptrCast([*c]types.Image, image),
        contrast,
    );
}

/// Modify image color: brightness (-255 to 255)
pub fn ImageColorBrightness(
    image: *types.Image,
    brightness: i32,
) void {
    raylib.ImageColorBrightness(
        @ptrCast([*c]types.Image, image),
        @intCast(c_int, brightness),
    );
}

/// Modify image color: replace color
pub fn ImageColorReplace(
    image: *types.Image,
    color: types.Color,
    replace: types.Color,
) void {
    raylib.ImageColorReplace(
        @ptrCast([*c]types.Image, image),
        color,
        replace,
    );
}

/// Load color data from image as a Color array (RGBA - 32bit)
pub fn LoadImageColors(
    image: types.Image,
) [*c]types.Color {
    return raylib.LoadImageColors(
        image,
    );
}

/// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn LoadImagePalette(
    image: types.Image,
    maxPaletteSize: i32,
    colorCount: []i32,
) [*c]types.Color {
    return raylib.LoadImagePalette(
        image,
        @intCast(c_int, maxPaletteSize),
        @ptrCast([*c]c_int, colorCount.ptr),
    );
}

/// Unload color data loaded with LoadImageColors()
pub fn UnloadImageColors(
    colors: *types.Color,
) void {
    raylib.UnloadImageColors(
        @ptrCast([*c]types.Color, colors),
    );
}

/// Unload colors palette loaded with LoadImagePalette()
pub fn UnloadImagePalette(
    colors: *types.Color,
) void {
    raylib.UnloadImagePalette(
        @ptrCast([*c]types.Color, colors),
    );
}

/// Get image alpha border rectangle
pub fn GetImageAlphaBorder(
    image: types.Image,
    threshold: f32,
) types.Rectangle {
    return raylib.GetImageAlphaBorder(
        image,
        threshold,
    );
}

/// Get image pixel color at (x, y) position
pub fn GetImageColor(
    image: types.Image,
    x: i32,
    y: i32,
) types.Color {
    return raylib.GetImageColor(
        image,
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}

/// Clear image background with given color
pub fn ImageClearBackground(
    dst: *types.Image,
    color: types.Color,
) void {
    raylib.ImageClearBackground(
        @ptrCast([*c]types.Image, dst),
        color,
    );
}

/// Draw pixel within an image
pub fn ImageDrawPixel(
    dst: *types.Image,
    posX: i32,
    posY: i32,
    color: types.Color,
) void {
    raylib.ImageDrawPixel(
        @ptrCast([*c]types.Image, dst),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        color,
    );
}

/// Draw pixel within an image (Vector version)
pub fn ImageDrawPixelV(
    dst: *types.Image,
    position: types.Vector2,
    color: types.Color,
) void {
    raylib.ImageDrawPixelV(
        @ptrCast([*c]types.Image, dst),
        position,
        color,
    );
}

/// Draw line within an image
pub fn ImageDrawLine(
    dst: *types.Image,
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: types.Color,
) void {
    raylib.ImageDrawLine(
        @ptrCast([*c]types.Image, dst),
        @intCast(c_int, startPosX),
        @intCast(c_int, startPosY),
        @intCast(c_int, endPosX),
        @intCast(c_int, endPosY),
        color,
    );
}

/// Draw line within an image (Vector version)
pub fn ImageDrawLineV(
    dst: *types.Image,
    start: types.Vector2,
    end: types.Vector2,
    color: types.Color,
) void {
    raylib.ImageDrawLineV(
        @ptrCast([*c]types.Image, dst),
        start,
        end,
        color,
    );
}

/// Draw circle within an image
pub fn ImageDrawCircle(
    dst: *types.Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: types.Color,
) void {
    raylib.ImageDrawCircle(
        @ptrCast([*c]types.Image, dst),
        @intCast(c_int, centerX),
        @intCast(c_int, centerY),
        @intCast(c_int, radius),
        color,
    );
}

/// Draw circle within an image (Vector version)
pub fn ImageDrawCircleV(
    dst: *types.Image,
    center: types.Vector2,
    radius: i32,
    color: types.Color,
) void {
    raylib.ImageDrawCircleV(
        @ptrCast([*c]types.Image, dst),
        center,
        @intCast(c_int, radius),
        color,
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangle(
    dst: *types.Image,
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: types.Color,
) void {
    raylib.ImageDrawRectangle(
        @ptrCast([*c]types.Image, dst),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, width),
        @intCast(c_int, height),
        color,
    );
}

/// Draw rectangle within an image (Vector version)
pub fn ImageDrawRectangleV(
    dst: *types.Image,
    position: types.Vector2,
    size: types.Vector2,
    color: types.Color,
) void {
    raylib.ImageDrawRectangleV(
        @ptrCast([*c]types.Image, dst),
        position,
        size,
        color,
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangleRec(
    dst: *types.Image,
    rec: types.Rectangle,
    color: types.Color,
) void {
    raylib.ImageDrawRectangleRec(
        @ptrCast([*c]types.Image, dst),
        rec,
        color,
    );
}

/// Draw rectangle lines within an image
pub fn ImageDrawRectangleLines(
    dst: *types.Image,
    rec: types.Rectangle,
    thick: i32,
    color: types.Color,
) void {
    raylib.ImageDrawRectangleLines(
        @ptrCast([*c]types.Image, dst),
        rec,
        @intCast(c_int, thick),
        color,
    );
}

/// Draw a source image within a destination image (tint applied to source)
pub fn ImageDraw(
    dst: *types.Image,
    src: types.Image,
    srcRec: types.Rectangle,
    dstRec: types.Rectangle,
    tint: types.Color,
) void {
    raylib.ImageDraw(
        @ptrCast([*c]types.Image, dst),
        src,
        srcRec,
        dstRec,
        tint,
    );
}

/// Draw text (using default font) within an image (destination)
pub fn ImageDrawText(
    dst: *types.Image,
    text: [:0]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: types.Color,
) void {
    raylib.ImageDrawText(
        @ptrCast([*c]types.Image, dst),
        text,
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, fontSize),
        color,
    );
}

/// Draw text (custom sprite font) within an image (destination)
pub fn ImageDrawTextEx(
    dst: *types.Image,
    font: types.Font,
    text: [:0]const u8,
    position: types.Vector2,
    fontSize: f32,
    spacing: f32,
    tint: types.Color,
) void {
    raylib.ImageDrawTextEx(
        @ptrCast([*c]types.Image, dst),
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
) types.Texture2D {
    return raylib.LoadTexture(
        fileName,
    );
}

/// Load texture from image data
pub fn LoadTextureFromImage(
    image: types.Image,
) types.Texture2D {
    return raylib.LoadTextureFromImage(
        image,
    );
}

/// Load cubemap from image, multiple image cubemap layouts supported
pub fn LoadTextureCubemap(
    image: types.Image,
    layout: i32,
) types.TextureCubemap {
    return raylib.LoadTextureCubemap(
        image,
        @intCast(c_int, layout),
    );
}

/// Load texture for rendering (framebuffer)
pub fn LoadRenderTexture(
    width: i32,
    height: i32,
) types.RenderTexture2D {
    return raylib.LoadRenderTexture(
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

/// Unload texture from GPU memory (VRAM)
pub fn UnloadTexture(
    texture: types.Texture2D,
) void {
    raylib.UnloadTexture(
        texture,
    );
}

/// Unload render texture from GPU memory (VRAM)
pub fn UnloadRenderTexture(
    target: types.RenderTexture2D,
) void {
    raylib.UnloadRenderTexture(
        target,
    );
}

/// Update GPU texture with new data
pub fn UpdateTexture(
    texture: types.Texture2D,
    pixels: *anyopaque,
) void {
    raylib.UpdateTexture(
        texture,
        pixels,
    );
}

/// Update GPU texture rectangle with new data
pub fn UpdateTextureRec(
    texture: types.Texture2D,
    rec: types.Rectangle,
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
    texture: *types.Texture2D,
) void {
    raylib.GenTextureMipmaps(
        @ptrCast([*c]types.Texture2D, texture),
    );
}

/// Set texture scaling filter mode
pub fn SetTextureFilter(
    texture: types.Texture2D,
    filter: i32,
) void {
    raylib.SetTextureFilter(
        texture,
        @intCast(c_int, filter),
    );
}

/// Set texture wrapping mode
pub fn SetTextureWrap(
    texture: types.Texture2D,
    wrap: i32,
) void {
    raylib.SetTextureWrap(
        texture,
        @intCast(c_int, wrap),
    );
}

/// Draw a Texture2D
pub fn DrawTexture(
    texture: types.Texture2D,
    posX: i32,
    posY: i32,
    tint: types.Color,
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
    texture: types.Texture2D,
    position: types.Vector2,
    tint: types.Color,
) void {
    raylib.DrawTextureV(
        texture,
        position,
        tint,
    );
}

/// Draw a Texture2D with extended parameters
pub fn DrawTextureEx(
    texture: types.Texture2D,
    position: types.Vector2,
    rotation: f32,
    scale: f32,
    tint: types.Color,
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
    texture: types.Texture2D,
    source: types.Rectangle,
    position: types.Vector2,
    tint: types.Color,
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
    texture: types.Texture2D,
    tiling: types.Vector2,
    offset: types.Vector2,
    quad: types.Rectangle,
    tint: types.Color,
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
    texture: types.Texture2D,
    source: types.Rectangle,
    dest: types.Rectangle,
    origin: types.Vector2,
    rotation: f32,
    scale: f32,
    tint: types.Color,
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
    texture: types.Texture2D,
    source: types.Rectangle,
    dest: types.Rectangle,
    origin: types.Vector2,
    rotation: f32,
    tint: types.Color,
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
    texture: types.Texture2D,
    nPatchInfo: types.NPatchInfo,
    dest: types.Rectangle,
    origin: types.Vector2,
    rotation: f32,
    tint: types.Color,
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
    texture: types.Texture2D,
    center: types.Vector2,
    points: *types.Vector2,
    texcoords: *types.Vector2,
    pointCount: i32,
    tint: types.Color,
) void {
    raylib.DrawTexturePoly(
        texture,
        center,
        @ptrCast([*c]types.Vector2, points),
        @ptrCast([*c]types.Vector2, texcoords),
        @intCast(c_int, pointCount),
        tint,
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn Fade(
    color: types.Color,
    alpha: f32,
) types.Color {
    return raylib.Fade(
        color,
        alpha,
    );
}

/// Get hexadecimal value for a Color
pub fn ColorToInt(
    color: types.Color,
) i32 {
    return raylib.ColorToInt(
        color,
    );
}

/// Get Color normalized as float [0..1]
pub fn ColorNormalize(
    color: types.Color,
) types.Vector4 {
    return raylib.ColorNormalize(
        color,
    );
}

/// Get Color from normalized values [0..1]
pub fn ColorFromNormalized(
    normalized: types.Vector4,
) types.Color {
    return raylib.ColorFromNormalized(
        normalized,
    );
}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn ColorToHSV(
    color: types.Color,
) types.Vector3 {
    return raylib.ColorToHSV(
        color,
    );
}

/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub fn ColorFromHSV(
    hue: f32,
    saturation: f32,
    value: f32,
) types.Color {
    return raylib.ColorFromHSV(
        hue,
        saturation,
        value,
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn ColorAlpha(
    color: types.Color,
    alpha: f32,
) types.Color {
    return raylib.ColorAlpha(
        color,
        alpha,
    );
}

/// Get src alpha-blended into dst color with tint
pub fn ColorAlphaBlend(
    dst: types.Color,
    src: types.Color,
    tint: types.Color,
) types.Color {
    return raylib.ColorAlphaBlend(
        dst,
        src,
        tint,
    );
}

/// Get Color structure from hexadecimal value
pub fn GetColor(
    hexValue: u32,
) types.Color {
    return raylib.GetColor(
        @intCast(c_uint, hexValue),
    );
}

/// Get Color from a source pixel pointer of certain format
pub fn GetPixelColor(
    srcPtr: *anyopaque,
    format: i32,
) types.Color {
    return raylib.GetPixelColor(
        srcPtr,
        @intCast(c_int, format),
    );
}

/// Set color formatted into destination pixel pointer
pub fn SetPixelColor(
    dstPtr: *anyopaque,
    color: types.Color,
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
pub fn GetFontDefault() types.Font {
    return raylib.GetFontDefault();
}

/// Load font from file into GPU memory (VRAM)
pub fn LoadFont(
    fileName: [:0]const u8,
) types.Font {
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
) types.Font {
    return raylib.LoadFontEx(
        fileName,
        @intCast(c_int, fontSize),
        @ptrCast([*c]c_int, fontChars.ptr),
        @intCast(c_int, glyphCount),
    );
}

/// Load font from Image (XNA style)
pub fn LoadFontFromImage(
    image: types.Image,
    key: types.Color,
    firstChar: i32,
) types.Font {
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
) types.Font {
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
    chars: *const types.GlyphInfo,
    recs: [*c][*c]types.Rectangle,
    glyphCount: i32,
    fontSize: i32,
    padding: i32,
    packMethod: i32,
) types.Image {
    return raylib.GenImageFontAtlas(
        @ptrCast([*c]const types.GlyphInfo, chars),
        @ptrCast([*c][*c]types.Rectangle, recs),
        @intCast(c_int, glyphCount),
        @intCast(c_int, fontSize),
        @intCast(c_int, padding),
        @intCast(c_int, packMethod),
    );
}

/// Unload font chars info data (RAM)
pub fn UnloadFontData(
    chars: *types.GlyphInfo,
    glyphCount: i32,
) void {
    raylib.UnloadFontData(
        @ptrCast([*c]types.GlyphInfo, chars),
        @intCast(c_int, glyphCount),
    );
}

/// Unload font from GPU memory (VRAM)
pub fn UnloadFont(
    font: types.Font,
) void {
    raylib.UnloadFont(
        font,
    );
}

/// Export font as code file, returns true on success
pub fn ExportFontAsCode(
    font: types.Font,
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
    color: types.Color,
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
    font: types.Font,
    text: [:0]const u8,
    position: types.Vector2,
    fontSize: f32,
    spacing: f32,
    tint: types.Color,
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
    font: types.Font,
    text: [:0]const u8,
    position: types.Vector2,
    origin: types.Vector2,
    rotation: f32,
    fontSize: f32,
    spacing: f32,
    tint: types.Color,
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
    font: types.Font,
    codepoint: i32,
    position: types.Vector2,
    fontSize: f32,
    tint: types.Color,
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
    font: types.Font,
    codepoints: []i32,
    count: i32,
    position: types.Vector2,
    fontSize: f32,
    spacing: f32,
    tint: types.Color,
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
    font: types.Font,
    text: [:0]const u8,
    fontSize: f32,
    spacing: f32,
) types.Vector2 {
    return raylib.MeasureTextEx(
        font,
        text,
        fontSize,
        spacing,
    );
}

/// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphIndex(
    font: types.Font,
    codepoint: i32,
) i32 {
    return raylib.GetGlyphIndex(
        font,
        @intCast(c_int, codepoint),
    );
}

/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphInfo(
    font: types.Font,
    codepoint: i32,
) types.GlyphInfo {
    return raylib.GetGlyphInfo(
        font,
        @intCast(c_int, codepoint),
    );
}

/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphAtlasRec(
    font: types.Font,
    codepoint: i32,
) types.Rectangle {
    return raylib.GetGlyphAtlasRec(
        font,
        @intCast(c_int, codepoint),
    );
}

/// Draw a line in 3D world space
pub fn DrawLine3D(
    startPos: types.Vector3,
    endPos: types.Vector3,
    color: types.Color,
) void {
    raylib.DrawLine3D(
        startPos,
        endPos,
        color,
    );
}

/// Draw a point in 3D space, actually a small line
pub fn DrawPoint3D(
    position: types.Vector3,
    color: types.Color,
) void {
    raylib.DrawPoint3D(
        position,
        color,
    );
}

/// Draw a circle in 3D world space
pub fn DrawCircle3D(
    center: types.Vector3,
    radius: f32,
    rotationAxis: types.Vector3,
    rotationAngle: f32,
    color: types.Color,
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
    v1: types.Vector3,
    v2: types.Vector3,
    v3: types.Vector3,
    color: types.Color,
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
    points: *types.Vector3,
    pointCount: i32,
    color: types.Color,
) void {
    raylib.DrawTriangleStrip3D(
        @ptrCast([*c]types.Vector3, points),
        @intCast(c_int, pointCount),
        color,
    );
}

/// Draw cube
pub fn DrawCube(
    position: types.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: types.Color,
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
    position: types.Vector3,
    size: types.Vector3,
    color: types.Color,
) void {
    raylib.DrawCubeV(
        position,
        size,
        color,
    );
}

/// Draw cube wires
pub fn DrawCubeWires(
    position: types.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: types.Color,
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
    position: types.Vector3,
    size: types.Vector3,
    color: types.Color,
) void {
    raylib.DrawCubeWiresV(
        position,
        size,
        color,
    );
}

/// Draw cube textured
pub fn DrawCubeTexture(
    texture: types.Texture2D,
    position: types.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: types.Color,
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
    texture: types.Texture2D,
    source: types.Rectangle,
    position: types.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: types.Color,
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
    centerPos: types.Vector3,
    radius: f32,
    color: types.Color,
) void {
    raylib.DrawSphere(
        centerPos,
        radius,
        color,
    );
}

/// Draw sphere with extended parameters
pub fn DrawSphereEx(
    centerPos: types.Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: types.Color,
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
    centerPos: types.Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: types.Color,
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
    position: types.Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: types.Color,
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
    startPos: types.Vector3,
    endPos: types.Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: types.Color,
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
    position: types.Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: types.Color,
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
    startPos: types.Vector3,
    endPos: types.Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: types.Color,
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
    centerPos: types.Vector3,
    size: types.Vector2,
    color: types.Color,
) void {
    raylib.DrawPlane(
        centerPos,
        size,
        color,
    );
}

/// Draw a ray line
pub fn DrawRay(
    ray: types.Ray,
    color: types.Color,
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
) types.Model {
    return raylib.LoadModel(
        fileName,
    );
}

/// Load model from generated mesh (default material)
pub fn LoadModelFromMesh(
    mesh: types.Mesh,
) types.Model {
    return raylib.LoadModelFromMesh(
        mesh,
    );
}

/// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn UnloadModel(
    model: types.Model,
) void {
    raylib.UnloadModel(
        model,
    );
}

/// Unload model (but not meshes) from memory (RAM and/or VRAM)
pub fn UnloadModelKeepMeshes(
    model: types.Model,
) void {
    raylib.UnloadModelKeepMeshes(
        model,
    );
}

/// Compute model bounding box limits (considers all meshes)
pub fn GetModelBoundingBox(
    model: types.Model,
) types.BoundingBox {
    return raylib.GetModelBoundingBox(
        model,
    );
}

/// Draw a model (with texture if set)
pub fn DrawModel(
    model: types.Model,
    position: types.Vector3,
    scale: f32,
    tint: types.Color,
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
    model: types.Model,
    position: types.Vector3,
    rotationAxis: types.Vector3,
    rotationAngle: f32,
    scale: types.Vector3,
    tint: types.Color,
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
    model: types.Model,
    position: types.Vector3,
    scale: f32,
    tint: types.Color,
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
    model: types.Model,
    position: types.Vector3,
    rotationAxis: types.Vector3,
    rotationAngle: f32,
    scale: types.Vector3,
    tint: types.Color,
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
    box: types.BoundingBox,
    color: types.Color,
) void {
    raylib.DrawBoundingBox(
        box,
        color,
    );
}

/// Draw a billboard texture
pub fn DrawBillboard(
    camera: types.Camera,
    texture: types.Texture2D,
    position: types.Vector3,
    size: f32,
    tint: types.Color,
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
    camera: types.Camera,
    texture: types.Texture2D,
    source: types.Rectangle,
    position: types.Vector3,
    size: types.Vector2,
    tint: types.Color,
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
    camera: types.Camera,
    texture: types.Texture2D,
    source: types.Rectangle,
    position: types.Vector3,
    up: types.Vector3,
    size: types.Vector2,
    origin: types.Vector2,
    rotation: f32,
    tint: types.Color,
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
    mesh: *types.Mesh,
    dynamic: bool,
) void {
    raylib.UploadMesh(
        @ptrCast([*c]types.Mesh, mesh),
        dynamic,
    );
}

/// Update mesh vertex data in GPU for a specific buffer index
pub fn UpdateMeshBuffer(
    mesh: types.Mesh,
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
    mesh: types.Mesh,
) void {
    raylib.UnloadMesh(
        mesh,
    );
}

/// Draw a 3d mesh with material and transform
pub fn DrawMesh(
    mesh: types.Mesh,
    material: types.Material,
    transform: types.Matrix,
) void {
    raylib.DrawMesh(
        mesh,
        material,
        transform,
    );
}

/// Draw multiple mesh instances with material and different transforms
pub fn DrawMeshInstanced(
    mesh: types.Mesh,
    material: types.Material,
    transforms: *const types.Matrix,
    instances: i32,
) void {
    raylib.DrawMeshInstanced(
        mesh,
        material,
        @ptrCast([*c]const types.Matrix, transforms),
        @intCast(c_int, instances),
    );
}

/// Export mesh data to file, returns true on success
pub fn ExportMesh(
    mesh: types.Mesh,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportMesh(
        mesh,
        fileName,
    );
}

/// Compute mesh bounding box limits
pub fn GetMeshBoundingBox(
    mesh: types.Mesh,
) types.BoundingBox {
    return raylib.GetMeshBoundingBox(
        mesh,
    );
}

/// Compute mesh tangents
pub fn GenMeshTangents(
    mesh: *types.Mesh,
) void {
    raylib.GenMeshTangents(
        @ptrCast([*c]types.Mesh, mesh),
    );
}

/// Compute mesh binormals
pub fn GenMeshBinormals(
    mesh: *types.Mesh,
) void {
    raylib.GenMeshBinormals(
        @ptrCast([*c]types.Mesh, mesh),
    );
}

/// Generate polygonal mesh
pub fn GenMeshPoly(
    sides: i32,
    radius: f32,
) types.Mesh {
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
) types.Mesh {
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
) types.Mesh {
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
) types.Mesh {
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
) types.Mesh {
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
) types.Mesh {
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
) types.Mesh {
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
) types.Mesh {
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
) types.Mesh {
    return raylib.GenMeshKnot(
        radius,
        size,
        @intCast(c_int, radSeg),
        @intCast(c_int, sides),
    );
}

/// Generate heightmap mesh from image data
pub fn GenMeshHeightmap(
    heightmap: types.Image,
    size: types.Vector3,
) types.Mesh {
    return raylib.GenMeshHeightmap(
        heightmap,
        size,
    );
}

/// Generate cubes-based map mesh from image data
pub fn GenMeshCubicmap(
    cubicmap: types.Image,
    cubeSize: types.Vector3,
) types.Mesh {
    return raylib.GenMeshCubicmap(
        cubicmap,
        cubeSize,
    );
}

/// Load materials from model file
pub fn LoadMaterials(
    fileName: [:0]const u8,
    materialCount: []i32,
) [*c]types.Material {
    return raylib.LoadMaterials(
        fileName,
        @ptrCast([*c]c_int, materialCount.ptr),
    );
}

/// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub fn LoadMaterialDefault() types.Material {
    return raylib.LoadMaterialDefault();
}

/// Unload material from GPU memory (VRAM)
pub fn UnloadMaterial(
    material: types.Material,
) void {
    raylib.UnloadMaterial(
        material,
    );
}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn SetMaterialTexture(
    material: *types.Material,
    mapType: i32,
    texture: types.Texture2D,
) void {
    raylib.SetMaterialTexture(
        @ptrCast([*c]types.Material, material),
        @intCast(c_int, mapType),
        texture,
    );
}

/// Set material for a mesh
pub fn SetModelMeshMaterial(
    model: *types.Model,
    meshId: i32,
    materialId: i32,
) void {
    raylib.SetModelMeshMaterial(
        @ptrCast([*c]types.Model, model),
        @intCast(c_int, meshId),
        @intCast(c_int, materialId),
    );
}

/// Load model animations from file
pub fn LoadModelAnimations(
    fileName: [:0]const u8,
    animCount: []u32,
) [*c]types.ModelAnimation {
    return raylib.LoadModelAnimations(
        fileName,
        @ptrCast([*c]c_uint, animCount.ptr),
    );
}

/// Update model animation pose
pub fn UpdateModelAnimation(
    model: types.Model,
    anim: types.ModelAnimation,
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
    anim: types.ModelAnimation,
) void {
    raylib.UnloadModelAnimation(
        anim,
    );
}

/// Unload animation array data
pub fn UnloadModelAnimations(
    animations: *types.ModelAnimation,
    count: u32,
) void {
    raylib.UnloadModelAnimations(
        @ptrCast([*c]types.ModelAnimation, animations),
        @intCast(c_uint, count),
    );
}

/// Check model animation skeleton match
pub fn IsModelAnimationValid(
    model: types.Model,
    anim: types.ModelAnimation,
) bool {
    return raylib.IsModelAnimationValid(
        model,
        anim,
    );
}

/// Check collision between two spheres
pub fn CheckCollisionSpheres(
    center1: types.Vector3,
    radius1: f32,
    center2: types.Vector3,
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
    box1: types.BoundingBox,
    box2: types.BoundingBox,
) bool {
    return raylib.CheckCollisionBoxes(
        box1,
        box2,
    );
}

/// Check collision between box and sphere
pub fn CheckCollisionBoxSphere(
    box: types.BoundingBox,
    center: types.Vector3,
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
    ray: types.Ray,
    center: types.Vector3,
    radius: f32,
) types.RayCollision {
    return raylib.GetRayCollisionSphere(
        ray,
        center,
        radius,
    );
}

/// Get collision info between ray and box
pub fn GetRayCollisionBox(
    ray: types.Ray,
    box: types.BoundingBox,
) types.RayCollision {
    return raylib.GetRayCollisionBox(
        ray,
        box,
    );
}

/// Get collision info between ray and mesh
pub fn GetRayCollisionMesh(
    ray: types.Ray,
    mesh: types.Mesh,
    transform: types.Matrix,
) types.RayCollision {
    return raylib.GetRayCollisionMesh(
        ray,
        mesh,
        transform,
    );
}

/// Get collision info between ray and triangle
pub fn GetRayCollisionTriangle(
    ray: types.Ray,
    p1: types.Vector3,
    p2: types.Vector3,
    p3: types.Vector3,
) types.RayCollision {
    return raylib.GetRayCollisionTriangle(
        ray,
        p1,
        p2,
        p3,
    );
}

/// Get collision info between ray and quad
pub fn GetRayCollisionQuad(
    ray: types.Ray,
    p1: types.Vector3,
    p2: types.Vector3,
    p3: types.Vector3,
    p4: types.Vector3,
) types.RayCollision {
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
) types.Wave {
    return raylib.LoadWave(
        fileName,
    );
}

/// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
pub fn LoadWaveFromMemory(
    fileType: [:0]const u8,
    fileData: [:0]const u8,
    dataSize: i32,
) types.Wave {
    return raylib.LoadWaveFromMemory(
        fileType,
        fileData,
        @intCast(c_int, dataSize),
    );
}

/// Load sound from file
pub fn LoadSound(
    fileName: [:0]const u8,
) types.Sound {
    return raylib.LoadSound(
        fileName,
    );
}

/// Load sound from wave data
pub fn LoadSoundFromWave(
    wave: types.Wave,
) types.Sound {
    return raylib.LoadSoundFromWave(
        wave,
    );
}

/// Update sound buffer with new data
pub fn UpdateSound(
    sound: types.Sound,
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
    wave: types.Wave,
) void {
    raylib.UnloadWave(
        wave,
    );
}

/// Unload sound
pub fn UnloadSound(
    sound: types.Sound,
) void {
    raylib.UnloadSound(
        sound,
    );
}

/// Export wave data to file, returns true on success
pub fn ExportWave(
    wave: types.Wave,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportWave(
        wave,
        fileName,
    );
}

/// Export wave sample data to code (.h), returns true on success
pub fn ExportWaveAsCode(
    wave: types.Wave,
    fileName: [:0]const u8,
) bool {
    return raylib.ExportWaveAsCode(
        wave,
        fileName,
    );
}

/// Play a sound
pub fn PlaySound(
    sound: types.Sound,
) void {
    raylib.PlaySound(
        sound,
    );
}

/// Stop playing a sound
pub fn StopSound(
    sound: types.Sound,
) void {
    raylib.StopSound(
        sound,
    );
}

/// Pause a sound
pub fn PauseSound(
    sound: types.Sound,
) void {
    raylib.PauseSound(
        sound,
    );
}

/// Resume a paused sound
pub fn ResumeSound(
    sound: types.Sound,
) void {
    raylib.ResumeSound(
        sound,
    );
}

/// Play a sound (using multichannel buffer pool)
pub fn PlaySoundMulti(
    sound: types.Sound,
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
    sound: types.Sound,
) bool {
    return raylib.IsSoundPlaying(
        sound,
    );
}

/// Set volume for a sound (1.0 is max level)
pub fn SetSoundVolume(
    sound: types.Sound,
    volume: f32,
) void {
    raylib.SetSoundVolume(
        sound,
        volume,
    );
}

/// Set pitch for a sound (1.0 is base level)
pub fn SetSoundPitch(
    sound: types.Sound,
    pitch: f32,
) void {
    raylib.SetSoundPitch(
        sound,
        pitch,
    );
}

/// Set pan for a sound (0.5 is center)
pub fn SetSoundPan(
    sound: types.Sound,
    pan: f32,
) void {
    raylib.SetSoundPan(
        sound,
        pan,
    );
}

/// Copy a wave to a new wave
pub fn WaveCopy(
    wave: types.Wave,
) types.Wave {
    return raylib.WaveCopy(
        wave,
    );
}

/// Crop a wave to defined samples range
pub fn WaveCrop(
    wave: *types.Wave,
    initSample: i32,
    finalSample: i32,
) void {
    raylib.WaveCrop(
        @ptrCast([*c]types.Wave, wave),
        @intCast(c_int, initSample),
        @intCast(c_int, finalSample),
    );
}

/// Convert wave data to desired format
pub fn WaveFormat(
    wave: *types.Wave,
    sampleRate: i32,
    sampleSize: i32,
    channels: i32,
) void {
    raylib.WaveFormat(
        @ptrCast([*c]types.Wave, wave),
        @intCast(c_int, sampleRate),
        @intCast(c_int, sampleSize),
        @intCast(c_int, channels),
    );
}

/// Load samples data from wave as a 32bit float data array
pub fn LoadWaveSamples(
    wave: types.Wave,
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
) types.Music {
    return raylib.LoadMusicStream(
        fileName,
    );
}

/// Load music stream from data
pub fn LoadMusicStreamFromMemory(
    fileType: [:0]const u8,
    data: [:0]const u8,
    dataSize: i32,
) types.Music {
    return raylib.LoadMusicStreamFromMemory(
        fileType,
        data,
        @intCast(c_int, dataSize),
    );
}

/// Unload music stream
pub fn UnloadMusicStream(
    music: types.Music,
) void {
    raylib.UnloadMusicStream(
        music,
    );
}

/// Start music playing
pub fn PlayMusicStream(
    music: types.Music,
) void {
    raylib.PlayMusicStream(
        music,
    );
}

/// Check if music is playing
pub fn IsMusicStreamPlaying(
    music: types.Music,
) bool {
    return raylib.IsMusicStreamPlaying(
        music,
    );
}

/// Updates buffers for music streaming
pub fn UpdateMusicStream(
    music: types.Music,
) void {
    raylib.UpdateMusicStream(
        music,
    );
}

/// Stop music playing
pub fn StopMusicStream(
    music: types.Music,
) void {
    raylib.StopMusicStream(
        music,
    );
}

/// Pause music playing
pub fn PauseMusicStream(
    music: types.Music,
) void {
    raylib.PauseMusicStream(
        music,
    );
}

/// Resume playing paused music
pub fn ResumeMusicStream(
    music: types.Music,
) void {
    raylib.ResumeMusicStream(
        music,
    );
}

/// Seek music to a position (in seconds)
pub fn SeekMusicStream(
    music: types.Music,
    position: f32,
) void {
    raylib.SeekMusicStream(
        music,
        position,
    );
}

/// Set volume for music (1.0 is max level)
pub fn SetMusicVolume(
    music: types.Music,
    volume: f32,
) void {
    raylib.SetMusicVolume(
        music,
        volume,
    );
}

/// Set pitch for a music (1.0 is base level)
pub fn SetMusicPitch(
    music: types.Music,
    pitch: f32,
) void {
    raylib.SetMusicPitch(
        music,
        pitch,
    );
}

/// Set pan for a music (0.5 is center)
pub fn SetMusicPan(
    music: types.Music,
    pan: f32,
) void {
    raylib.SetMusicPan(
        music,
        pan,
    );
}

/// Get music time length (in seconds)
pub fn GetMusicTimeLength(
    music: types.Music,
) f32 {
    return raylib.GetMusicTimeLength(
        music,
    );
}

/// Get current music time played (in seconds)
pub fn GetMusicTimePlayed(
    music: types.Music,
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
) types.AudioStream {
    return raylib.LoadAudioStream(
        @intCast(c_uint, sampleRate),
        @intCast(c_uint, sampleSize),
        @intCast(c_uint, channels),
    );
}

/// Unload audio stream and free memory
pub fn UnloadAudioStream(
    stream: types.AudioStream,
) void {
    raylib.UnloadAudioStream(
        stream,
    );
}

/// Update audio stream buffers with data
pub fn UpdateAudioStream(
    stream: types.AudioStream,
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
    stream: types.AudioStream,
) bool {
    return raylib.IsAudioStreamProcessed(
        stream,
    );
}

/// Play audio stream
pub fn PlayAudioStream(
    stream: types.AudioStream,
) void {
    raylib.PlayAudioStream(
        stream,
    );
}

/// Pause audio stream
pub fn PauseAudioStream(
    stream: types.AudioStream,
) void {
    raylib.PauseAudioStream(
        stream,
    );
}

/// Resume audio stream
pub fn ResumeAudioStream(
    stream: types.AudioStream,
) void {
    raylib.ResumeAudioStream(
        stream,
    );
}

/// Check if audio stream is playing
pub fn IsAudioStreamPlaying(
    stream: types.AudioStream,
) bool {
    return raylib.IsAudioStreamPlaying(
        stream,
    );
}

/// Stop audio stream
pub fn StopAudioStream(
    stream: types.AudioStream,
) void {
    raylib.StopAudioStream(
        stream,
    );
}

/// Set volume for audio stream (1.0 is max level)
pub fn SetAudioStreamVolume(
    stream: types.AudioStream,
    volume: f32,
) void {
    raylib.SetAudioStreamVolume(
        stream,
        volume,
    );
}

/// Set pitch for audio stream (1.0 is base level)
pub fn SetAudioStreamPitch(
    stream: types.AudioStream,
    pitch: f32,
) void {
    raylib.SetAudioStreamPitch(
        stream,
        pitch,
    );
}

/// Set pan for audio stream (0.5 is centered)
pub fn SetAudioStreamPan(
    stream: types.AudioStream,
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
    stream: types.AudioStream,
    callback: types.AudioCallback,
) void {
    raylib.SetAudioStreamCallback(
        stream,
        callback,
    );
}

/// 
pub fn AttachAudioStreamProcessor(
    stream: types.AudioStream,
    processor: types.AudioCallback,
) void {
    raylib.AttachAudioStreamProcessor(
        stream,
        processor,
    );
}

/// 
pub fn DetachAudioStreamProcessor(
    stream: types.AudioStream,
    processor: types.AudioCallback,
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
pub fn Vector2Zero() types.Vector2 {
    return raylib.Vector2Zero();
}

/// 
pub fn Vector2One() types.Vector2 {
    return raylib.Vector2One();
}

/// 
pub fn Vector2Add(
    v1: types.Vector2,
    v2: types.Vector2,
) types.Vector2 {
    return raylib.Vector2Add(
        v1,
        v2,
    );
}

/// 
pub fn Vector2AddValue(
    v: types.Vector2,
    add: f32,
) types.Vector2 {
    return raylib.Vector2AddValue(
        v,
        add,
    );
}

/// 
pub fn Vector2Subtract(
    v1: types.Vector2,
    v2: types.Vector2,
) types.Vector2 {
    return raylib.Vector2Subtract(
        v1,
        v2,
    );
}

/// 
pub fn Vector2SubtractValue(
    v: types.Vector2,
    sub: f32,
) types.Vector2 {
    return raylib.Vector2SubtractValue(
        v,
        sub,
    );
}

/// 
pub fn Vector2Length(
    v: types.Vector2,
) f32 {
    return raylib.Vector2Length(
        v,
    );
}

/// 
pub fn Vector2LengthSqr(
    v: types.Vector2,
) f32 {
    return raylib.Vector2LengthSqr(
        v,
    );
}

/// 
pub fn Vector2DotProduct(
    v1: types.Vector2,
    v2: types.Vector2,
) f32 {
    return raylib.Vector2DotProduct(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Distance(
    v1: types.Vector2,
    v2: types.Vector2,
) f32 {
    return raylib.Vector2Distance(
        v1,
        v2,
    );
}

/// 
pub fn Vector2DistanceSqr(
    v1: types.Vector2,
    v2: types.Vector2,
) f32 {
    return raylib.Vector2DistanceSqr(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Angle(
    v1: types.Vector2,
    v2: types.Vector2,
) f32 {
    return raylib.Vector2Angle(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Scale(
    v: types.Vector2,
    scale: f32,
) types.Vector2 {
    return raylib.Vector2Scale(
        v,
        scale,
    );
}

/// 
pub fn Vector2Multiply(
    v1: types.Vector2,
    v2: types.Vector2,
) types.Vector2 {
    return raylib.Vector2Multiply(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Negate(
    v: types.Vector2,
) types.Vector2 {
    return raylib.Vector2Negate(
        v,
    );
}

/// 
pub fn Vector2Divide(
    v1: types.Vector2,
    v2: types.Vector2,
) types.Vector2 {
    return raylib.Vector2Divide(
        v1,
        v2,
    );
}

/// 
pub fn Vector2Normalize(
    v: types.Vector2,
) types.Vector2 {
    return raylib.Vector2Normalize(
        v,
    );
}

/// 
pub fn Vector2Transform(
    v: types.Vector2,
    mat: types.Matrix,
) types.Vector2 {
    return raylib.Vector2Transform(
        v,
        mat,
    );
}

/// 
pub fn Vector2Lerp(
    v1: types.Vector2,
    v2: types.Vector2,
    amount: f32,
) types.Vector2 {
    return raylib.Vector2Lerp(
        v1,
        v2,
        amount,
    );
}

/// 
pub fn Vector2Reflect(
    v: types.Vector2,
    normal: types.Vector2,
) types.Vector2 {
    return raylib.Vector2Reflect(
        v,
        normal,
    );
}

/// 
pub fn Vector2Rotate(
    v: types.Vector2,
    angle: f32,
) types.Vector2 {
    return raylib.Vector2Rotate(
        v,
        angle,
    );
}

/// 
pub fn Vector2MoveTowards(
    v: types.Vector2,
    target: types.Vector2,
    maxDistance: f32,
) types.Vector2 {
    return raylib.Vector2MoveTowards(
        v,
        target,
        maxDistance,
    );
}

/// 
pub fn Vector3Zero() types.Vector3 {
    return raylib.Vector3Zero();
}

/// 
pub fn Vector3One() types.Vector3 {
    return raylib.Vector3One();
}

/// 
pub fn Vector3Add(
    v1: types.Vector3,
    v2: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Add(
        v1,
        v2,
    );
}

/// 
pub fn Vector3AddValue(
    v: types.Vector3,
    add: f32,
) types.Vector3 {
    return raylib.Vector3AddValue(
        v,
        add,
    );
}

/// 
pub fn Vector3Subtract(
    v1: types.Vector3,
    v2: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Subtract(
        v1,
        v2,
    );
}

/// 
pub fn Vector3SubtractValue(
    v: types.Vector3,
    sub: f32,
) types.Vector3 {
    return raylib.Vector3SubtractValue(
        v,
        sub,
    );
}

/// 
pub fn Vector3Scale(
    v: types.Vector3,
    scalar: f32,
) types.Vector3 {
    return raylib.Vector3Scale(
        v,
        scalar,
    );
}

/// 
pub fn Vector3Multiply(
    v1: types.Vector3,
    v2: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Multiply(
        v1,
        v2,
    );
}

/// 
pub fn Vector3CrossProduct(
    v1: types.Vector3,
    v2: types.Vector3,
) types.Vector3 {
    return raylib.Vector3CrossProduct(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Perpendicular(
    v: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Perpendicular(
        v,
    );
}

/// 
pub fn Vector3Length(
    v: types.Vector3,
) f32 {
    return raylib.Vector3Length(
        v,
    );
}

/// 
pub fn Vector3LengthSqr(
    v: types.Vector3,
) f32 {
    return raylib.Vector3LengthSqr(
        v,
    );
}

/// 
pub fn Vector3DotProduct(
    v1: types.Vector3,
    v2: types.Vector3,
) f32 {
    return raylib.Vector3DotProduct(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Distance(
    v1: types.Vector3,
    v2: types.Vector3,
) f32 {
    return raylib.Vector3Distance(
        v1,
        v2,
    );
}

/// 
pub fn Vector3DistanceSqr(
    v1: types.Vector3,
    v2: types.Vector3,
) f32 {
    return raylib.Vector3DistanceSqr(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Angle(
    v1: types.Vector3,
    v2: types.Vector3,
) f32 {
    return raylib.Vector3Angle(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Negate(
    v: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Negate(
        v,
    );
}

/// 
pub fn Vector3Divide(
    v1: types.Vector3,
    v2: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Divide(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Normalize(
    v: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Normalize(
        v,
    );
}

/// 
pub fn Vector3OrthoNormalize(
    v1: *types.Vector3,
    v2: *types.Vector3,
) void {
    raylib.Vector3OrthoNormalize(
        @ptrCast([*c]types.Vector3, v1),
        @ptrCast([*c]types.Vector3, v2),
    );
}

/// 
pub fn Vector3Transform(
    v: types.Vector3,
    mat: types.Matrix,
) types.Vector3 {
    return raylib.Vector3Transform(
        v,
        mat,
    );
}

/// 
pub fn Vector3RotateByQuaternion(
    v: types.Vector3,
    q: types.Quaternion,
) types.Vector3 {
    return raylib.Vector3RotateByQuaternion(
        v,
        q,
    );
}

/// 
pub fn Vector3Lerp(
    v1: types.Vector3,
    v2: types.Vector3,
    amount: f32,
) types.Vector3 {
    return raylib.Vector3Lerp(
        v1,
        v2,
        amount,
    );
}

/// 
pub fn Vector3Reflect(
    v: types.Vector3,
    normal: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Reflect(
        v,
        normal,
    );
}

/// 
pub fn Vector3Min(
    v1: types.Vector3,
    v2: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Min(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Max(
    v1: types.Vector3,
    v2: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Max(
        v1,
        v2,
    );
}

/// 
pub fn Vector3Barycenter(
    p: types.Vector3,
    a: types.Vector3,
    b: types.Vector3,
    c: types.Vector3,
) types.Vector3 {
    return raylib.Vector3Barycenter(
        p,
        a,
        b,
        c,
    );
}

/// 
pub fn Vector3Unproject(
    source: types.Vector3,
    projection: types.Matrix,
    view: types.Matrix,
) types.Vector3 {
    return raylib.Vector3Unproject(
        source,
        projection,
        view,
    );
}

/// 
pub fn Vector3ToFloatV(
    v: types.Vector3,
) types.float3 {
    return raylib.Vector3ToFloatV(
        v,
    );
}

/// 
pub fn MatrixDeterminant(
    mat: types.Matrix,
) f32 {
    return raylib.MatrixDeterminant(
        mat,
    );
}

/// 
pub fn MatrixTrace(
    mat: types.Matrix,
) f32 {
    return raylib.MatrixTrace(
        mat,
    );
}

/// 
pub fn MatrixTranspose(
    mat: types.Matrix,
) types.Matrix {
    return raylib.MatrixTranspose(
        mat,
    );
}

/// 
pub fn MatrixInvert(
    mat: types.Matrix,
) types.Matrix {
    return raylib.MatrixInvert(
        mat,
    );
}

/// 
pub fn MatrixIdentity() types.Matrix {
    return raylib.MatrixIdentity();
}

/// 
pub fn MatrixAdd(
    left: types.Matrix,
    right: types.Matrix,
) types.Matrix {
    return raylib.MatrixAdd(
        left,
        right,
    );
}

/// 
pub fn MatrixSubtract(
    left: types.Matrix,
    right: types.Matrix,
) types.Matrix {
    return raylib.MatrixSubtract(
        left,
        right,
    );
}

/// 
pub fn MatrixMultiply(
    left: types.Matrix,
    right: types.Matrix,
) types.Matrix {
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
) types.Matrix {
    return raylib.MatrixTranslate(
        x,
        y,
        z,
    );
}

/// 
pub fn MatrixRotate(
    axis: types.Vector3,
    angle: f32,
) types.Matrix {
    return raylib.MatrixRotate(
        axis,
        angle,
    );
}

/// 
pub fn MatrixRotateX(
    angle: f32,
) types.Matrix {
    return raylib.MatrixRotateX(
        angle,
    );
}

/// 
pub fn MatrixRotateY(
    angle: f32,
) types.Matrix {
    return raylib.MatrixRotateY(
        angle,
    );
}

/// 
pub fn MatrixRotateZ(
    angle: f32,
) types.Matrix {
    return raylib.MatrixRotateZ(
        angle,
    );
}

/// 
pub fn MatrixRotateXYZ(
    ang: types.Vector3,
) types.Matrix {
    return raylib.MatrixRotateXYZ(
        ang,
    );
}

/// 
pub fn MatrixRotateZYX(
    ang: types.Vector3,
) types.Matrix {
    return raylib.MatrixRotateZYX(
        ang,
    );
}

/// 
pub fn MatrixScale(
    x: f32,
    y: f32,
    z: f32,
) types.Matrix {
    return raylib.MatrixScale(
        x,
        y,
        z,
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
) types.Matrix {
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
    fovy: f64,
    aspect: f64,
    near: f64,
    far: f64,
) types.Matrix {
    return raylib.MatrixPerspective(
        fovy,
        aspect,
        near,
        far,
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
) types.Matrix {
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
    eye: types.Vector3,
    target: types.Vector3,
    up: types.Vector3,
) types.Matrix {
    return raylib.MatrixLookAt(
        eye,
        target,
        up,
    );
}

/// 
pub fn MatrixToFloatV(
    mat: types.Matrix,
) types.float16 {
    return raylib.MatrixToFloatV(
        mat,
    );
}

/// 
pub fn QuaternionAdd(
    q1: types.Quaternion,
    q2: types.Quaternion,
) types.Quaternion {
    return raylib.QuaternionAdd(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionAddValue(
    q: types.Quaternion,
    add: f32,
) types.Quaternion {
    return raylib.QuaternionAddValue(
        q,
        add,
    );
}

/// 
pub fn QuaternionSubtract(
    q1: types.Quaternion,
    q2: types.Quaternion,
) types.Quaternion {
    return raylib.QuaternionSubtract(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionSubtractValue(
    q: types.Quaternion,
    sub: f32,
) types.Quaternion {
    return raylib.QuaternionSubtractValue(
        q,
        sub,
    );
}

/// 
pub fn QuaternionIdentity() types.Quaternion {
    return raylib.QuaternionIdentity();
}

/// 
pub fn QuaternionLength(
    q: types.Quaternion,
) f32 {
    return raylib.QuaternionLength(
        q,
    );
}

/// 
pub fn QuaternionNormalize(
    q: types.Quaternion,
) types.Quaternion {
    return raylib.QuaternionNormalize(
        q,
    );
}

/// 
pub fn QuaternionInvert(
    q: types.Quaternion,
) types.Quaternion {
    return raylib.QuaternionInvert(
        q,
    );
}

/// 
pub fn QuaternionMultiply(
    q1: types.Quaternion,
    q2: types.Quaternion,
) types.Quaternion {
    return raylib.QuaternionMultiply(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionScale(
    q: types.Quaternion,
    mul: f32,
) types.Quaternion {
    return raylib.QuaternionScale(
        q,
        mul,
    );
}

/// 
pub fn QuaternionDivide(
    q1: types.Quaternion,
    q2: types.Quaternion,
) types.Quaternion {
    return raylib.QuaternionDivide(
        q1,
        q2,
    );
}

/// 
pub fn QuaternionLerp(
    q1: types.Quaternion,
    q2: types.Quaternion,
    amount: f32,
) types.Quaternion {
    return raylib.QuaternionLerp(
        q1,
        q2,
        amount,
    );
}

/// 
pub fn QuaternionNlerp(
    q1: types.Quaternion,
    q2: types.Quaternion,
    amount: f32,
) types.Quaternion {
    return raylib.QuaternionNlerp(
        q1,
        q2,
        amount,
    );
}

/// 
pub fn QuaternionSlerp(
    q1: types.Quaternion,
    q2: types.Quaternion,
    amount: f32,
) types.Quaternion {
    return raylib.QuaternionSlerp(
        q1,
        q2,
        amount,
    );
}

/// 
pub fn QuaternionFromVector3ToVector3(
    from: types.Vector3,
    to: types.Vector3,
) types.Quaternion {
    return raylib.QuaternionFromVector3ToVector3(
        from,
        to,
    );
}

/// 
pub fn QuaternionFromMatrix(
    mat: types.Matrix,
) types.Quaternion {
    return raylib.QuaternionFromMatrix(
        mat,
    );
}

/// 
pub fn QuaternionToMatrix(
    q: types.Quaternion,
) types.Matrix {
    return raylib.QuaternionToMatrix(
        q,
    );
}

/// 
pub fn QuaternionFromAxisAngle(
    axis: types.Vector3,
    angle: f32,
) types.Quaternion {
    return raylib.QuaternionFromAxisAngle(
        axis,
        angle,
    );
}

/// 
pub fn QuaternionToAxisAngle(
    q: types.Quaternion,
    outAxis: *types.Vector3,
    outAngle: []f32,
) void {
    raylib.QuaternionToAxisAngle(
        q,
        @ptrCast([*c]types.Vector3, outAxis),
        @ptrCast([*c]f32, outAngle.ptr),
    );
}

/// 
pub fn QuaternionFromEuler(
    pitch: f32,
    yaw: f32,
    roll: f32,
) types.Quaternion {
    return raylib.QuaternionFromEuler(
        pitch,
        yaw,
        roll,
    );
}

/// 
pub fn QuaternionToEuler(
    q: types.Quaternion,
) types.Vector3 {
    return raylib.QuaternionToEuler(
        q,
    );
}

/// 
pub fn QuaternionTransform(
    q: types.Quaternion,
    mat: types.Matrix,
) types.Quaternion {
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
    font: types.Font,
) void {
    raylib.GuiSetFont(
        font,
    );
}

/// Get gui custom font (global state)
pub fn GuiGetFont() types.Font {
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
    bounds: types.Rectangle,
    title: [:0]const u8,
) bool {
    return raylib.GuiWindowBox(
        bounds,
        title,
    );
}

/// Group Box control with text name
pub fn GuiGroupBox(
    bounds: types.Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiGroupBox(
        bounds,
        text,
    );
}

/// Line separator control, could contain text
pub fn GuiLine(
    bounds: types.Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiLine(
        bounds,
        text,
    );
}

/// Panel control, useful to group controls
pub fn GuiPanel(
    bounds: types.Rectangle,
) void {
    raylib.GuiPanel(
        bounds,
    );
}

/// Scroll Panel control
pub fn GuiScrollPanel(
    bounds: types.Rectangle,
    content: types.Rectangle,
    scroll: *types.Vector2,
) types.Rectangle {
    return raylib.GuiScrollPanel(
        bounds,
        content,
        @ptrCast([*c]types.Vector2, scroll),
    );
}

/// Label control, shows text
pub fn GuiLabel(
    bounds: types.Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiLabel(
        bounds,
        text,
    );
}

/// Button control, returns true when clicked
pub fn GuiButton(
    bounds: types.Rectangle,
    text: [:0]const u8,
) bool {
    return raylib.GuiButton(
        bounds,
        text,
    );
}

/// Label button control, show true when clicked
pub fn GuiLabelButton(
    bounds: types.Rectangle,
    text: [:0]const u8,
) bool {
    return raylib.GuiLabelButton(
        bounds,
        text,
    );
}

/// Toggle Button control, returns true when active
pub fn GuiToggle(
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiStatusBar(
        bounds,
        text,
    );
}

/// Dummy control for placeholders
pub fn GuiDummyRec(
    bounds: types.Rectangle,
    text: [:0]const u8,
) void {
    raylib.GuiDummyRec(
        bounds,
        text,
    );
}

/// Scroll Bar control
pub fn GuiScrollBar(
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
    spacing: f32,
    subdivs: i32,
) types.Vector2 {
    return raylib.GuiGrid(
        bounds,
        spacing,
        @intCast(c_int, subdivs),
    );
}

/// List View control, returns selected list item index
pub fn GuiListView(
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
    text: [*c][:0]const u8,
    count: i32,
    focus: []i32,
    scrollIndex: []i32,
    active: i32,
) i32 {
    return raylib.GuiListViewEx(
        bounds,
        @ptrCast([*c][:0]const u8, text),
        @intCast(c_int, count),
        @ptrCast([*c]c_int, focus.ptr),
        @ptrCast([*c]c_int, scrollIndex.ptr),
        @intCast(c_int, active),
    );
}

/// Message Box control, displays a message
pub fn GuiMessageBox(
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
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
    bounds: types.Rectangle,
    color: types.Color,
) types.Color {
    return raylib.GuiColorPicker(
        bounds,
        color,
    );
}

/// Color Panel control
pub fn GuiColorPanel(
    bounds: types.Rectangle,
    color: types.Color,
) types.Color {
    return raylib.GuiColorPanel(
        bounds,
        color,
    );
}

/// Color Bar Alpha control
pub fn GuiColorBarAlpha(
    bounds: types.Rectangle,
    alpha: f32,
) f32 {
    return raylib.GuiColorBarAlpha(
        bounds,
        alpha,
    );
}

/// Color Bar Hue control
pub fn GuiColorBarHue(
    bounds: types.Rectangle,
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
) types.GuiStyle {
    return raylib.LoadGuiStyle(
        fileName,
    );
}

/// Unload style
pub fn UnloadGuiStyle(
    style: types.GuiStyle,
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
    color: types.Color,
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
