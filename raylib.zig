const std = @import("std");
const raylib = @cImport({
    @cDefine("RAYMATH_IMPLEMENTATION", {});
    @cInclude("raylib.h");
    @cInclude("raymath.h");
});

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub fn TraceLog(
    logLevel: i32,
    text: [*:0]const u8,
) void {
    mTraceLog(
        logLevel,
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
}

export fn mTraceLog(
    logLevel: i32,
    text: [*c]const u8,
) void {
    raylib.TraceLog(
        logLevel,
        text,
    );
}

/// Text formatting with variables (sprintf() style)
pub fn TextFormat(
    text: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mTextFormat(
            @intToPtr([*c]const u8, @ptrToInt(text)),
        ),
    );
}

export fn mTextFormat(
    text: [*c]const u8,
) [*c]const u8 {
    return raylib.TextFormat(
        text,
    );
}

/// 
pub fn Vector3Length(
    v: Vector3,
) f32 {
    var out: f32 = undefined;
    mVector3Length(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector3Length(
    out: [*c]f32,
    v: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Length(
        v.*,
    );
}

/// 
pub fn Vector3LengthSqr(
    v: Vector3,
) f32 {
    var out: f32 = undefined;
    mVector3LengthSqr(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector3LengthSqr(
    out: [*c]f32,
    v: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3LengthSqr(
        v.*,
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
) [*]const GlyphInfo {
    return @ptrCast(
        [*]GlyphInfo,
        mLoadFontData(
            @intToPtr([*c]const u8, @ptrToInt(fileData)),
            dataSize,
            fontSize,
            @ptrCast([*c]i32, fontChars),
            glyphCount,
            typ,
        ),
    );
}

export fn mLoadFontData(
    fileData: [*c]const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: [*c]i32,
    glyphCount: i32,
    typ: i32,
) [*c]const raylib.GlyphInfo {
    return raylib.LoadFontData(
        fileData,
        dataSize,
        fontSize,
        fontChars,
        glyphCount,
        typ,
    );
}

/// Initialize window and OpenGL context
pub fn InitWindow(
    width: i32,
    height: i32,
    title: [*:0]const u8,
) void {
    mInitWindow(
        width,
        height,
        @intToPtr([*c]const u8, @ptrToInt(title)),
    );
}

export fn mInitWindow(
    width: i32,
    height: i32,
    title: [*c]const u8,
) void {
    raylib.InitWindow(
        width,
        height,
        title,
    );
}

/// Check if KEY_ESCAPE pressed or Close icon pressed
pub fn WindowShouldClose() bool {
    var out: bool = undefined;
    mWindowShouldClose(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mWindowShouldClose(
    out: [*c]bool,
) void {
    out.* = raylib.WindowShouldClose();
}

/// Close window and unload OpenGL context
pub fn CloseWindow() void {
    mCloseWindow();
}

export fn mCloseWindow() void {
    raylib.CloseWindow();
}

/// Check if window has been initialized successfully
pub fn IsWindowReady() bool {
    var out: bool = undefined;
    mIsWindowReady(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsWindowReady(
    out: [*c]bool,
) void {
    out.* = raylib.IsWindowReady();
}

/// Check if window is currently fullscreen
pub fn IsWindowFullscreen() bool {
    var out: bool = undefined;
    mIsWindowFullscreen(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsWindowFullscreen(
    out: [*c]bool,
) void {
    out.* = raylib.IsWindowFullscreen();
}

/// Check if window is currently hidden (only PLATFORM_DESKTOP)
pub fn IsWindowHidden() bool {
    var out: bool = undefined;
    mIsWindowHidden(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsWindowHidden(
    out: [*c]bool,
) void {
    out.* = raylib.IsWindowHidden();
}

/// Check if window is currently minimized (only PLATFORM_DESKTOP)
pub fn IsWindowMinimized() bool {
    var out: bool = undefined;
    mIsWindowMinimized(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsWindowMinimized(
    out: [*c]bool,
) void {
    out.* = raylib.IsWindowMinimized();
}

/// Check if window is currently maximized (only PLATFORM_DESKTOP)
pub fn IsWindowMaximized() bool {
    var out: bool = undefined;
    mIsWindowMaximized(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsWindowMaximized(
    out: [*c]bool,
) void {
    out.* = raylib.IsWindowMaximized();
}

/// Check if window is currently focused (only PLATFORM_DESKTOP)
pub fn IsWindowFocused() bool {
    var out: bool = undefined;
    mIsWindowFocused(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsWindowFocused(
    out: [*c]bool,
) void {
    out.* = raylib.IsWindowFocused();
}

/// Check if window has been resized last frame
pub fn IsWindowResized() bool {
    var out: bool = undefined;
    mIsWindowResized(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsWindowResized(
    out: [*c]bool,
) void {
    out.* = raylib.IsWindowResized();
}

/// Check if one specific window flag is enabled
pub fn IsWindowState(
    flag: u32,
) bool {
    var out: bool = undefined;
    mIsWindowState(
        @ptrCast([*c]bool, &out),
        flag,
    );
    return out;
}

export fn mIsWindowState(
    out: [*c]bool,
    flag: u32,
) void {
    out.* = raylib.IsWindowState(
        flag,
    );
}

/// Set window configuration state using flags (only PLATFORM_DESKTOP)
pub fn SetWindowState(
    flags: u32,
) void {
    mSetWindowState(
        flags,
    );
}

export fn mSetWindowState(
    flags: u32,
) void {
    raylib.SetWindowState(
        flags,
    );
}

/// Clear window configuration state flags
pub fn ClearWindowState(
    flags: u32,
) void {
    mClearWindowState(
        flags,
    );
}

export fn mClearWindowState(
    flags: u32,
) void {
    raylib.ClearWindowState(
        flags,
    );
}

/// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
pub fn ToggleFullscreen() void {
    mToggleFullscreen();
}

export fn mToggleFullscreen() void {
    raylib.ToggleFullscreen();
}

/// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
pub fn MaximizeWindow() void {
    mMaximizeWindow();
}

export fn mMaximizeWindow() void {
    raylib.MaximizeWindow();
}

/// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
pub fn MinimizeWindow() void {
    mMinimizeWindow();
}

export fn mMinimizeWindow() void {
    raylib.MinimizeWindow();
}

/// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
pub fn RestoreWindow() void {
    mRestoreWindow();
}

export fn mRestoreWindow() void {
    raylib.RestoreWindow();
}

/// Set icon for window (only PLATFORM_DESKTOP)
pub fn SetWindowIcon(
    image: Image,
) void {
    mSetWindowIcon(
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
    );
}

export fn mSetWindowIcon(
    image: [*c]raylib.Image,
) void {
    raylib.SetWindowIcon(
        image.*,
    );
}

/// Set title for window (only PLATFORM_DESKTOP)
pub fn SetWindowTitle(
    title: [*:0]const u8,
) void {
    mSetWindowTitle(
        @intToPtr([*c]const u8, @ptrToInt(title)),
    );
}

export fn mSetWindowTitle(
    title: [*c]const u8,
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
    mSetWindowPosition(
        x,
        y,
    );
}

export fn mSetWindowPosition(
    x: i32,
    y: i32,
) void {
    raylib.SetWindowPosition(
        x,
        y,
    );
}

/// Set monitor for the current window (fullscreen mode)
pub fn SetWindowMonitor(
    monitor: i32,
) void {
    mSetWindowMonitor(
        monitor,
    );
}

export fn mSetWindowMonitor(
    monitor: i32,
) void {
    raylib.SetWindowMonitor(
        monitor,
    );
}

/// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub fn SetWindowMinSize(
    width: i32,
    height: i32,
) void {
    mSetWindowMinSize(
        width,
        height,
    );
}

export fn mSetWindowMinSize(
    width: i32,
    height: i32,
) void {
    raylib.SetWindowMinSize(
        width,
        height,
    );
}

/// Set window dimensions
pub fn SetWindowSize(
    width: i32,
    height: i32,
) void {
    mSetWindowSize(
        width,
        height,
    );
}

export fn mSetWindowSize(
    width: i32,
    height: i32,
) void {
    raylib.SetWindowSize(
        width,
        height,
    );
}

/// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
pub fn SetWindowOpacity(
    opacity: f32,
) void {
    mSetWindowOpacity(
        opacity,
    );
}

export fn mSetWindowOpacity(
    opacity: f32,
) void {
    raylib.SetWindowOpacity(
        opacity,
    );
}

/// Get current screen width
pub fn GetScreenWidth() i32 {
    var out: i32 = undefined;
    mGetScreenWidth(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetScreenWidth(
    out: [*c]i32,
) void {
    out.* = raylib.GetScreenWidth();
}

/// Get current screen height
pub fn GetScreenHeight() i32 {
    var out: i32 = undefined;
    mGetScreenHeight(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetScreenHeight(
    out: [*c]i32,
) void {
    out.* = raylib.GetScreenHeight();
}

/// Get current render width (it considers HiDPI)
pub fn GetRenderWidth() i32 {
    var out: i32 = undefined;
    mGetRenderWidth(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetRenderWidth(
    out: [*c]i32,
) void {
    out.* = raylib.GetRenderWidth();
}

/// Get current render height (it considers HiDPI)
pub fn GetRenderHeight() i32 {
    var out: i32 = undefined;
    mGetRenderHeight(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetRenderHeight(
    out: [*c]i32,
) void {
    out.* = raylib.GetRenderHeight();
}

/// Get number of connected monitors
pub fn GetMonitorCount() i32 {
    var out: i32 = undefined;
    mGetMonitorCount(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetMonitorCount(
    out: [*c]i32,
) void {
    out.* = raylib.GetMonitorCount();
}

/// Get current connected monitor
pub fn GetCurrentMonitor() i32 {
    var out: i32 = undefined;
    mGetCurrentMonitor(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetCurrentMonitor(
    out: [*c]i32,
) void {
    out.* = raylib.GetCurrentMonitor();
}

/// Get specified monitor position
pub fn GetMonitorPosition(
    monitor: i32,
) Vector2 {
    var out: Vector2 = undefined;
    mGetMonitorPosition(
        @ptrCast([*c]raylib.Vector2, &out),
        monitor,
    );
    return out;
}

export fn mGetMonitorPosition(
    out: [*c]raylib.Vector2,
    monitor: i32,
) void {
    out.* = raylib.GetMonitorPosition(
        monitor,
    );
}

/// Get specified monitor width (max available by monitor)
pub fn GetMonitorWidth(
    monitor: i32,
) i32 {
    var out: i32 = undefined;
    mGetMonitorWidth(
        @ptrCast([*c]i32, &out),
        monitor,
    );
    return out;
}

export fn mGetMonitorWidth(
    out: [*c]i32,
    monitor: i32,
) void {
    out.* = raylib.GetMonitorWidth(
        monitor,
    );
}

/// Get specified monitor height (max available by monitor)
pub fn GetMonitorHeight(
    monitor: i32,
) i32 {
    var out: i32 = undefined;
    mGetMonitorHeight(
        @ptrCast([*c]i32, &out),
        monitor,
    );
    return out;
}

export fn mGetMonitorHeight(
    out: [*c]i32,
    monitor: i32,
) void {
    out.* = raylib.GetMonitorHeight(
        monitor,
    );
}

/// Get specified monitor physical width in millimetres
pub fn GetMonitorPhysicalWidth(
    monitor: i32,
) i32 {
    var out: i32 = undefined;
    mGetMonitorPhysicalWidth(
        @ptrCast([*c]i32, &out),
        monitor,
    );
    return out;
}

export fn mGetMonitorPhysicalWidth(
    out: [*c]i32,
    monitor: i32,
) void {
    out.* = raylib.GetMonitorPhysicalWidth(
        monitor,
    );
}

/// Get specified monitor physical height in millimetres
pub fn GetMonitorPhysicalHeight(
    monitor: i32,
) i32 {
    var out: i32 = undefined;
    mGetMonitorPhysicalHeight(
        @ptrCast([*c]i32, &out),
        monitor,
    );
    return out;
}

export fn mGetMonitorPhysicalHeight(
    out: [*c]i32,
    monitor: i32,
) void {
    out.* = raylib.GetMonitorPhysicalHeight(
        monitor,
    );
}

/// Get specified monitor refresh rate
pub fn GetMonitorRefreshRate(
    monitor: i32,
) i32 {
    var out: i32 = undefined;
    mGetMonitorRefreshRate(
        @ptrCast([*c]i32, &out),
        monitor,
    );
    return out;
}

export fn mGetMonitorRefreshRate(
    out: [*c]i32,
    monitor: i32,
) void {
    out.* = raylib.GetMonitorRefreshRate(
        monitor,
    );
}

/// Get window position XY on monitor
pub fn GetWindowPosition() Vector2 {
    var out: Vector2 = undefined;
    mGetWindowPosition(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mGetWindowPosition(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.GetWindowPosition();
}

/// Get window scale DPI factor
pub fn GetWindowScaleDPI() Vector2 {
    var out: Vector2 = undefined;
    mGetWindowScaleDPI(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mGetWindowScaleDPI(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.GetWindowScaleDPI();
}

/// Get the human-readable, UTF-8 encoded name of the primary monitor
pub fn GetMonitorName(
    monitor: i32,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetMonitorName(
            monitor,
        ),
    );
}

export fn mGetMonitorName(
    monitor: i32,
) [*c]const u8 {
    return raylib.GetMonitorName(
        monitor,
    );
}

/// Set clipboard text content
pub fn SetClipboardText(
    text: [*:0]const u8,
) void {
    mSetClipboardText(
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
}

export fn mSetClipboardText(
    text: [*c]const u8,
) void {
    raylib.SetClipboardText(
        text,
    );
}

/// Get clipboard text content
pub fn GetClipboardText() [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetClipboardText(),
    );
}

export fn mGetClipboardText() [*c]const u8 {
    return raylib.GetClipboardText();
}

/// Swap back buffer with front buffer (screen drawing)
pub fn SwapScreenBuffer() void {
    mSwapScreenBuffer();
}

export fn mSwapScreenBuffer() void {
    raylib.SwapScreenBuffer();
}

/// Register all input events
pub fn PollInputEvents() void {
    mPollInputEvents();
}

export fn mPollInputEvents() void {
    raylib.PollInputEvents();
}

/// Wait for some milliseconds (halt program execution)
pub fn WaitTime(
    ms: f32,
) void {
    mWaitTime(
        ms,
    );
}

export fn mWaitTime(
    ms: f32,
) void {
    raylib.WaitTime(
        ms,
    );
}

/// Shows cursor
pub fn ShowCursor() void {
    mShowCursor();
}

export fn mShowCursor() void {
    raylib.ShowCursor();
}

/// Hides cursor
pub fn HideCursor() void {
    mHideCursor();
}

export fn mHideCursor() void {
    raylib.HideCursor();
}

/// Check if cursor is not visible
pub fn IsCursorHidden() bool {
    var out: bool = undefined;
    mIsCursorHidden(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsCursorHidden(
    out: [*c]bool,
) void {
    out.* = raylib.IsCursorHidden();
}

/// Enables cursor (unlock cursor)
pub fn EnableCursor() void {
    mEnableCursor();
}

export fn mEnableCursor() void {
    raylib.EnableCursor();
}

/// Disables cursor (lock cursor)
pub fn DisableCursor() void {
    mDisableCursor();
}

export fn mDisableCursor() void {
    raylib.DisableCursor();
}

/// Check if cursor is on the screen
pub fn IsCursorOnScreen() bool {
    var out: bool = undefined;
    mIsCursorOnScreen(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsCursorOnScreen(
    out: [*c]bool,
) void {
    out.* = raylib.IsCursorOnScreen();
}

/// Set background color (framebuffer clear color)
pub fn ClearBackground(
    color: Color,
) void {
    mClearBackground(
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mClearBackground(
    color: [*c]raylib.Color,
) void {
    raylib.ClearBackground(
        color.*,
    );
}

/// Setup canvas (framebuffer) to start drawing
pub fn BeginDrawing() void {
    mBeginDrawing();
}

export fn mBeginDrawing() void {
    raylib.BeginDrawing();
}

/// End canvas drawing and swap buffers (double buffering)
pub fn EndDrawing() void {
    mEndDrawing();
}

export fn mEndDrawing() void {
    raylib.EndDrawing();
}

/// Begin 2D mode with custom camera (2D)
pub fn BeginMode2D(
    camera: Camera2D,
) void {
    mBeginMode2D(
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
    );
}

export fn mBeginMode2D(
    camera: [*c]raylib.Camera2D,
) void {
    raylib.BeginMode2D(
        camera.*,
    );
}

/// Ends 2D mode with custom camera
pub fn EndMode2D() void {
    mEndMode2D();
}

export fn mEndMode2D() void {
    raylib.EndMode2D();
}

/// Begin 3D mode with custom camera (3D)
pub fn BeginMode3D(
    camera: Camera3D,
) void {
    mBeginMode3D(
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
    );
}

export fn mBeginMode3D(
    camera: [*c]raylib.Camera3D,
) void {
    raylib.BeginMode3D(
        camera.*,
    );
}

/// Ends 3D mode and returns to default 2D orthographic mode
pub fn EndMode3D() void {
    mEndMode3D();
}

export fn mEndMode3D() void {
    raylib.EndMode3D();
}

/// Begin drawing to render texture
pub fn BeginTextureMode(
    target: RenderTexture2D,
) void {
    mBeginTextureMode(
        @intToPtr([*c]raylib.RenderTexture2D, @ptrToInt(&target)),
    );
}

export fn mBeginTextureMode(
    target: [*c]raylib.RenderTexture2D,
) void {
    raylib.BeginTextureMode(
        target.*,
    );
}

/// Ends drawing to render texture
pub fn EndTextureMode() void {
    mEndTextureMode();
}

export fn mEndTextureMode() void {
    raylib.EndTextureMode();
}

/// Begin custom shader drawing
pub fn BeginShaderMode(
    shader: Shader,
) void {
    mBeginShaderMode(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
    );
}

export fn mBeginShaderMode(
    shader: [*c]raylib.Shader,
) void {
    raylib.BeginShaderMode(
        shader.*,
    );
}

/// End custom shader drawing (use default shader)
pub fn EndShaderMode() void {
    mEndShaderMode();
}

export fn mEndShaderMode() void {
    raylib.EndShaderMode();
}

/// Begin blending mode (alpha, additive, multiplied, subtract, custom)
pub fn BeginBlendMode(
    mode: i32,
) void {
    mBeginBlendMode(
        mode,
    );
}

export fn mBeginBlendMode(
    mode: i32,
) void {
    raylib.BeginBlendMode(
        mode,
    );
}

/// End blending mode (reset to default: alpha blending)
pub fn EndBlendMode() void {
    mEndBlendMode();
}

export fn mEndBlendMode() void {
    raylib.EndBlendMode();
}

/// Begin scissor mode (define screen area for following drawing)
pub fn BeginScissorMode(
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {
    mBeginScissorMode(
        x,
        y,
        width,
        height,
    );
}

export fn mBeginScissorMode(
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {
    raylib.BeginScissorMode(
        x,
        y,
        width,
        height,
    );
}

/// End scissor mode
pub fn EndScissorMode() void {
    mEndScissorMode();
}

export fn mEndScissorMode() void {
    raylib.EndScissorMode();
}

/// Begin stereo rendering (requires VR simulator)
pub fn BeginVrStereoMode(
    config: VrStereoConfig,
) void {
    mBeginVrStereoMode(
        @intToPtr([*c]raylib.VrStereoConfig, @ptrToInt(&config)),
    );
}

export fn mBeginVrStereoMode(
    config: [*c]raylib.VrStereoConfig,
) void {
    raylib.BeginVrStereoMode(
        config.*,
    );
}

/// End stereo rendering (requires VR simulator)
pub fn EndVrStereoMode() void {
    mEndVrStereoMode();
}

export fn mEndVrStereoMode() void {
    raylib.EndVrStereoMode();
}

/// Load VR stereo config for VR simulator device parameters
pub fn LoadVrStereoConfig(
    device: VrDeviceInfo,
) VrStereoConfig {
    var out: VrStereoConfig = undefined;
    mLoadVrStereoConfig(
        @ptrCast([*c]raylib.VrStereoConfig, &out),
        @intToPtr([*c]raylib.VrDeviceInfo, @ptrToInt(&device)),
    );
    return out;
}

export fn mLoadVrStereoConfig(
    out: [*c]raylib.VrStereoConfig,
    device: [*c]raylib.VrDeviceInfo,
) void {
    out.* = raylib.LoadVrStereoConfig(
        device.*,
    );
}

/// Unload VR stereo config
pub fn UnloadVrStereoConfig(
    config: VrStereoConfig,
) void {
    mUnloadVrStereoConfig(
        @intToPtr([*c]raylib.VrStereoConfig, @ptrToInt(&config)),
    );
}

export fn mUnloadVrStereoConfig(
    config: [*c]raylib.VrStereoConfig,
) void {
    raylib.UnloadVrStereoConfig(
        config.*,
    );
}

/// Load shader from files and bind default locations
pub fn LoadShader(
    vsFileName: [*:0]const u8,
    fsFileName: [*:0]const u8,
) Shader {
    var out: Shader = undefined;
    mLoadShader(
        @ptrCast([*c]raylib.Shader, &out),
        @intToPtr([*c]const u8, @ptrToInt(vsFileName)),
        @intToPtr([*c]const u8, @ptrToInt(fsFileName)),
    );
    return out;
}

export fn mLoadShader(
    out: [*c]raylib.Shader,
    vsFileName: [*c]const u8,
    fsFileName: [*c]const u8,
) void {
    out.* = raylib.LoadShader(
        vsFileName,
        fsFileName,
    );
}

/// Load shader from code strings and bind default locations
pub fn LoadShaderFromMemory(
    vsCode: [*:0]const u8,
    fsCode: [*:0]const u8,
) Shader {
    var out: Shader = undefined;
    mLoadShaderFromMemory(
        @ptrCast([*c]raylib.Shader, &out),
        @intToPtr([*c]const u8, @ptrToInt(vsCode)),
        @intToPtr([*c]const u8, @ptrToInt(fsCode)),
    );
    return out;
}

export fn mLoadShaderFromMemory(
    out: [*c]raylib.Shader,
    vsCode: [*c]const u8,
    fsCode: [*c]const u8,
) void {
    out.* = raylib.LoadShaderFromMemory(
        vsCode,
        fsCode,
    );
}

/// Get shader uniform location
pub fn GetShaderLocation(
    shader: Shader,
    uniformName: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mGetShaderLocation(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        @intToPtr([*c]const u8, @ptrToInt(uniformName)),
    );
    return out;
}

export fn mGetShaderLocation(
    out: [*c]i32,
    shader: [*c]raylib.Shader,
    uniformName: [*c]const u8,
) void {
    out.* = raylib.GetShaderLocation(
        shader.*,
        uniformName,
    );
}

/// Get shader attribute location
pub fn GetShaderLocationAttrib(
    shader: Shader,
    attribName: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mGetShaderLocationAttrib(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        @intToPtr([*c]const u8, @ptrToInt(attribName)),
    );
    return out;
}

export fn mGetShaderLocationAttrib(
    out: [*c]i32,
    shader: [*c]raylib.Shader,
    attribName: [*c]const u8,
) void {
    out.* = raylib.GetShaderLocationAttrib(
        shader.*,
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
    mSetShaderValue(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @ptrCast([*c]anyopaque, value),
        uniformType,
    );
}

export fn mSetShaderValue(
    shader: [*c]raylib.Shader,
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
) void {
    raylib.SetShaderValue(
        shader.*,
        locIndex,
        value,
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
    mSetShaderValueV(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @ptrCast([*c]anyopaque, value),
        uniformType,
        count,
    );
}

export fn mSetShaderValueV(
    shader: [*c]raylib.Shader,
    locIndex: i32,
    value: *anyopaque,
    uniformType: i32,
    count: i32,
) void {
    raylib.SetShaderValueV(
        shader.*,
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
    mSetShaderValueMatrix(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
}

export fn mSetShaderValueMatrix(
    shader: [*c]raylib.Shader,
    locIndex: i32,
    mat: [*c]raylib.Matrix,
) void {
    raylib.SetShaderValueMatrix(
        shader.*,
        locIndex,
        mat.*,
    );
}

/// Set shader uniform value for texture (sampler2d)
pub fn SetShaderValueTexture(
    shader: Shader,
    locIndex: i32,
    texture: Texture2D,
) void {
    mSetShaderValueTexture(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
        locIndex,
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
}

export fn mSetShaderValueTexture(
    shader: [*c]raylib.Shader,
    locIndex: i32,
    texture: [*c]raylib.Texture2D,
) void {
    raylib.SetShaderValueTexture(
        shader.*,
        locIndex,
        texture.*,
    );
}

/// Unload shader from GPU memory (VRAM)
pub fn UnloadShader(
    shader: Shader,
) void {
    mUnloadShader(
        @intToPtr([*c]raylib.Shader, @ptrToInt(&shader)),
    );
}

export fn mUnloadShader(
    shader: [*c]raylib.Shader,
) void {
    raylib.UnloadShader(
        shader.*,
    );
}

/// Get a ray trace from mouse position
pub fn GetMouseRay(
    mousePosition: Vector2,
    camera: Camera3D,
) Ray {
    var out: Ray = undefined;
    mGetMouseRay(
        @ptrCast([*c]raylib.Ray, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&mousePosition)),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
    );
    return out;
}

export fn mGetMouseRay(
    out: [*c]raylib.Ray,
    mousePosition: [*c]raylib.Vector2,
    camera: [*c]raylib.Camera3D,
) void {
    out.* = raylib.GetMouseRay(
        mousePosition.*,
        camera.*,
    );
}

/// Get camera transform matrix (view matrix)
pub fn GetCameraMatrix(
    camera: Camera3D,
) Matrix {
    var out: Matrix = undefined;
    mGetCameraMatrix(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
    );
    return out;
}

export fn mGetCameraMatrix(
    out: [*c]raylib.Matrix,
    camera: [*c]raylib.Camera3D,
) void {
    out.* = raylib.GetCameraMatrix(
        camera.*,
    );
}

/// Get camera 2d transform matrix
pub fn GetCameraMatrix2D(
    camera: Camera2D,
) Matrix {
    var out: Matrix = undefined;
    mGetCameraMatrix2D(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
    );
    return out;
}

export fn mGetCameraMatrix2D(
    out: [*c]raylib.Matrix,
    camera: [*c]raylib.Camera2D,
) void {
    out.* = raylib.GetCameraMatrix2D(
        camera.*,
    );
}

/// Get the screen space position for a 3d world space position
pub fn GetWorldToScreen(
    position: Vector3,
    camera: Camera3D,
) Vector2 {
    var out: Vector2 = undefined;
    mGetWorldToScreen(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
    );
    return out;
}

export fn mGetWorldToScreen(
    out: [*c]raylib.Vector2,
    position: [*c]raylib.Vector3,
    camera: [*c]raylib.Camera3D,
) void {
    out.* = raylib.GetWorldToScreen(
        position.*,
        camera.*,
    );
}

/// Get size position for a 3d world space position
pub fn GetWorldToScreenEx(
    position: Vector3,
    camera: Camera3D,
    width: i32,
    height: i32,
) Vector2 {
    var out: Vector2 = undefined;
    mGetWorldToScreenEx(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        width,
        height,
    );
    return out;
}

export fn mGetWorldToScreenEx(
    out: [*c]raylib.Vector2,
    position: [*c]raylib.Vector3,
    camera: [*c]raylib.Camera3D,
    width: i32,
    height: i32,
) void {
    out.* = raylib.GetWorldToScreenEx(
        position.*,
        camera.*,
        width,
        height,
    );
}

/// Get the screen space position for a 2d camera world space position
pub fn GetWorldToScreen2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {
    var out: Vector2 = undefined;
    mGetWorldToScreen2D(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
    );
    return out;
}

export fn mGetWorldToScreen2D(
    out: [*c]raylib.Vector2,
    position: [*c]raylib.Vector2,
    camera: [*c]raylib.Camera2D,
) void {
    out.* = raylib.GetWorldToScreen2D(
        position.*,
        camera.*,
    );
}

/// Get the world space position for a 2d camera screen space position
pub fn GetScreenToWorld2D(
    position: Vector2,
    camera: Camera2D,
) Vector2 {
    var out: Vector2 = undefined;
    mGetScreenToWorld2D(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Camera2D, @ptrToInt(&camera)),
    );
    return out;
}

export fn mGetScreenToWorld2D(
    out: [*c]raylib.Vector2,
    position: [*c]raylib.Vector2,
    camera: [*c]raylib.Camera2D,
) void {
    out.* = raylib.GetScreenToWorld2D(
        position.*,
        camera.*,
    );
}

/// Set target FPS (maximum)
pub fn SetTargetFPS(
    fps: i32,
) void {
    mSetTargetFPS(
        fps,
    );
}

export fn mSetTargetFPS(
    fps: i32,
) void {
    raylib.SetTargetFPS(
        fps,
    );
}

/// Get current FPS
pub fn GetFPS() i32 {
    var out: i32 = undefined;
    mGetFPS(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetFPS(
    out: [*c]i32,
) void {
    out.* = raylib.GetFPS();
}

/// Get time in seconds for last frame drawn (delta time)
pub fn GetFrameTime() f32 {
    var out: f32 = undefined;
    mGetFrameTime(
        @ptrCast([*c]f32, &out),
    );
    return out;
}

export fn mGetFrameTime(
    out: [*c]f32,
) void {
    out.* = raylib.GetFrameTime();
}

/// Get elapsed time in seconds since InitWindow()
pub fn GetTime() f64 {
    var out: f64 = undefined;
    mGetTime(
        @ptrCast([*c]f64, &out),
    );
    return out;
}

export fn mGetTime(
    out: [*c]f64,
) void {
    out.* = raylib.GetTime();
}

/// Get a random value between min and max (both included)
pub fn GetRandomValue(
    min: i32,
    max: i32,
) i32 {
    var out: i32 = undefined;
    mGetRandomValue(
        @ptrCast([*c]i32, &out),
        min,
        max,
    );
    return out;
}

export fn mGetRandomValue(
    out: [*c]i32,
    min: i32,
    max: i32,
) void {
    out.* = raylib.GetRandomValue(
        min,
        max,
    );
}

/// Set the seed for the random number generator
pub fn SetRandomSeed(
    seed: u32,
) void {
    mSetRandomSeed(
        seed,
    );
}

export fn mSetRandomSeed(
    seed: u32,
) void {
    raylib.SetRandomSeed(
        seed,
    );
}

/// Takes a screenshot of current screen (filename extension defines format)
pub fn TakeScreenshot(
    fileName: [*:0]const u8,
) void {
    mTakeScreenshot(
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
}

export fn mTakeScreenshot(
    fileName: [*c]const u8,
) void {
    raylib.TakeScreenshot(
        fileName,
    );
}

/// Setup init configuration flags (view FLAGS)
pub fn SetConfigFlags(
    flags: u32,
) void {
    mSetConfigFlags(
        flags,
    );
}

export fn mSetConfigFlags(
    flags: u32,
) void {
    raylib.SetConfigFlags(
        flags,
    );
}

/// Set the current threshold (minimum) log level
pub fn SetTraceLogLevel(
    logLevel: i32,
) void {
    mSetTraceLogLevel(
        logLevel,
    );
}

export fn mSetTraceLogLevel(
    logLevel: i32,
) void {
    raylib.SetTraceLogLevel(
        logLevel,
    );
}

/// Set custom file binary data loader
pub fn SetLoadFileDataCallback(
    callback: LoadFileDataCallback,
) void {
    mSetLoadFileDataCallback(
        callback,
    );
}

export fn mSetLoadFileDataCallback(
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
    mSetSaveFileDataCallback(
        callback,
    );
}

export fn mSetSaveFileDataCallback(
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
    mSetLoadFileTextCallback(
        callback,
    );
}

export fn mSetLoadFileTextCallback(
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
    mSetSaveFileTextCallback(
        callback,
    );
}

export fn mSetSaveFileTextCallback(
    callback: SaveFileTextCallback,
) void {
    raylib.SetSaveFileTextCallback(
        callback,
    );
}

/// Load file data as byte array (read)
pub fn LoadFileData(
    fileName: [*:0]const u8,
    bytesRead: [*]u32,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mLoadFileData(
            @intToPtr([*c]const u8, @ptrToInt(fileName)),
            @ptrCast([*c]u32, bytesRead),
        ),
    );
}

export fn mLoadFileData(
    fileName: [*c]const u8,
    bytesRead: [*c]u32,
) [*c]const u8 {
    return raylib.LoadFileData(
        fileName,
        bytesRead,
    );
}

/// Unload file data allocated by LoadFileData()
pub fn UnloadFileData(
    data: [*]u8,
) void {
    mUnloadFileData(
        @ptrCast([*c]u8, data),
    );
}

export fn mUnloadFileData(
    data: [*c]u8,
) void {
    raylib.UnloadFileData(
        data,
    );
}

/// Save data to file from byte array (write), returns true on success
pub fn SaveFileData(
    fileName: [*:0]const u8,
    data: *anyopaque,
    bytesToWrite: u32,
) bool {
    var out: bool = undefined;
    mSaveFileData(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        @ptrCast([*c]anyopaque, data),
        bytesToWrite,
    );
    return out;
}

export fn mSaveFileData(
    out: [*c]bool,
    fileName: [*c]const u8,
    data: *anyopaque,
    bytesToWrite: u32,
) void {
    out.* = raylib.SaveFileData(
        fileName,
        data,
        bytesToWrite,
    );
}

/// Load text data from file (read), returns a '\0' terminated string
pub fn LoadFileText(
    fileName: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mLoadFileText(
            @intToPtr([*c]const u8, @ptrToInt(fileName)),
        ),
    );
}

export fn mLoadFileText(
    fileName: [*c]const u8,
) [*c]const u8 {
    return raylib.LoadFileText(
        fileName,
    );
}

/// Unload file text data allocated by LoadFileText()
pub fn UnloadFileText(
    text: [*]u8,
) void {
    mUnloadFileText(
        @ptrCast([*c]u8, text),
    );
}

export fn mUnloadFileText(
    text: [*c]u8,
) void {
    raylib.UnloadFileText(
        text,
    );
}

/// Save text data to file (write), string must be '\0' terminated, returns true on success
pub fn SaveFileText(
    fileName: [*:0]const u8,
    text: [*]u8,
) bool {
    var out: bool = undefined;
    mSaveFileText(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        @ptrCast([*c]u8, text),
    );
    return out;
}

export fn mSaveFileText(
    out: [*c]bool,
    fileName: [*c]const u8,
    text: [*c]u8,
) void {
    out.* = raylib.SaveFileText(
        fileName,
        text,
    );
}

/// Check if file exists
pub fn FileExists(
    fileName: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mFileExists(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mFileExists(
    out: [*c]bool,
    fileName: [*c]const u8,
) void {
    out.* = raylib.FileExists(
        fileName,
    );
}

/// Check if a directory path exists
pub fn DirectoryExists(
    dirPath: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mDirectoryExists(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]const u8, @ptrToInt(dirPath)),
    );
    return out;
}

export fn mDirectoryExists(
    out: [*c]bool,
    dirPath: [*c]const u8,
) void {
    out.* = raylib.DirectoryExists(
        dirPath,
    );
}

/// Check file extension (including point: .png, .wav)
pub fn IsFileExtension(
    fileName: [*:0]const u8,
    ext: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mIsFileExtension(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        @intToPtr([*c]const u8, @ptrToInt(ext)),
    );
    return out;
}

export fn mIsFileExtension(
    out: [*c]bool,
    fileName: [*c]const u8,
    ext: [*c]const u8,
) void {
    out.* = raylib.IsFileExtension(
        fileName,
        ext,
    );
}

/// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub fn GetFileLength(
    fileName: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mGetFileLength(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mGetFileLength(
    out: [*c]i32,
    fileName: [*c]const u8,
) void {
    out.* = raylib.GetFileLength(
        fileName,
    );
}

/// Get pointer to extension for a filename string (includes dot: '.png')
pub fn GetFileExtension(
    fileName: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetFileExtension(
            @intToPtr([*c]const u8, @ptrToInt(fileName)),
        ),
    );
}

export fn mGetFileExtension(
    fileName: [*c]const u8,
) [*c]const u8 {
    return raylib.GetFileExtension(
        fileName,
    );
}

/// Get pointer to filename for a path string
pub fn GetFileName(
    filePath: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetFileName(
            @intToPtr([*c]const u8, @ptrToInt(filePath)),
        ),
    );
}

export fn mGetFileName(
    filePath: [*c]const u8,
) [*c]const u8 {
    return raylib.GetFileName(
        filePath,
    );
}

/// Get filename string without extension (uses static string)
pub fn GetFileNameWithoutExt(
    filePath: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetFileNameWithoutExt(
            @intToPtr([*c]const u8, @ptrToInt(filePath)),
        ),
    );
}

export fn mGetFileNameWithoutExt(
    filePath: [*c]const u8,
) [*c]const u8 {
    return raylib.GetFileNameWithoutExt(
        filePath,
    );
}

/// Get full path for a given fileName with path (uses static string)
pub fn GetDirectoryPath(
    filePath: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetDirectoryPath(
            @intToPtr([*c]const u8, @ptrToInt(filePath)),
        ),
    );
}

export fn mGetDirectoryPath(
    filePath: [*c]const u8,
) [*c]const u8 {
    return raylib.GetDirectoryPath(
        filePath,
    );
}

/// Get previous directory path for a given path (uses static string)
pub fn GetPrevDirectoryPath(
    dirPath: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetPrevDirectoryPath(
            @intToPtr([*c]const u8, @ptrToInt(dirPath)),
        ),
    );
}

export fn mGetPrevDirectoryPath(
    dirPath: [*c]const u8,
) [*c]const u8 {
    return raylib.GetPrevDirectoryPath(
        dirPath,
    );
}

/// Get current working directory (uses static string)
pub fn GetWorkingDirectory() [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetWorkingDirectory(),
    );
}

export fn mGetWorkingDirectory() [*c]const u8 {
    return raylib.GetWorkingDirectory();
}

/// Get the directory if the running application (uses static string)
pub fn GetApplicationDirectory() [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetApplicationDirectory(),
    );
}

export fn mGetApplicationDirectory() [*c]const u8 {
    return raylib.GetApplicationDirectory();
}

/// Clear directory files paths buffers (free memory)
pub fn ClearDirectoryFiles() void {
    mClearDirectoryFiles();
}

export fn mClearDirectoryFiles() void {
    raylib.ClearDirectoryFiles();
}

/// Change working directory, return true on success
pub fn ChangeDirectory(
    dir: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mChangeDirectory(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]const u8, @ptrToInt(dir)),
    );
    return out;
}

export fn mChangeDirectory(
    out: [*c]bool,
    dir: [*c]const u8,
) void {
    out.* = raylib.ChangeDirectory(
        dir,
    );
}

/// Check if a file has been dropped into window
pub fn IsFileDropped() bool {
    var out: bool = undefined;
    mIsFileDropped(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsFileDropped(
    out: [*c]bool,
) void {
    out.* = raylib.IsFileDropped();
}

/// Clear dropped files paths buffer (free memory)
pub fn ClearDroppedFiles() void {
    mClearDroppedFiles();
}

export fn mClearDroppedFiles() void {
    raylib.ClearDroppedFiles();
}

/// Get file modification time (last write time)
pub fn GetFileModTime(
    fileName: [*:0]const u8,
) i64 {
    var out: i64 = undefined;
    mGetFileModTime(
        @ptrCast([*c]i64, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mGetFileModTime(
    out: [*c]i64,
    fileName: [*c]const u8,
) void {
    out.* = raylib.GetFileModTime(
        fileName,
    );
}

/// Compress data (DEFLATE algorithm)
pub fn CompressData(
    data: [*:0]const u8,
    dataSize: i32,
    compDataSize: [*]i32,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mCompressData(
            @intToPtr([*c]const u8, @ptrToInt(data)),
            dataSize,
            @ptrCast([*c]i32, compDataSize),
        ),
    );
}

export fn mCompressData(
    data: [*c]const u8,
    dataSize: i32,
    compDataSize: [*c]i32,
) [*c]const u8 {
    return raylib.CompressData(
        data,
        dataSize,
        compDataSize,
    );
}

/// Decompress data (DEFLATE algorithm)
pub fn DecompressData(
    compData: [*:0]const u8,
    compDataSize: i32,
    dataSize: [*]i32,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mDecompressData(
            @intToPtr([*c]const u8, @ptrToInt(compData)),
            compDataSize,
            @ptrCast([*c]i32, dataSize),
        ),
    );
}

export fn mDecompressData(
    compData: [*c]const u8,
    compDataSize: i32,
    dataSize: [*c]i32,
) [*c]const u8 {
    return raylib.DecompressData(
        compData,
        compDataSize,
        dataSize,
    );
}

/// Encode data to Base64 string
pub fn EncodeDataBase64(
    data: [*:0]const u8,
    dataSize: i32,
    outputSize: [*]i32,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mEncodeDataBase64(
            @intToPtr([*c]const u8, @ptrToInt(data)),
            dataSize,
            @ptrCast([*c]i32, outputSize),
        ),
    );
}

export fn mEncodeDataBase64(
    data: [*c]const u8,
    dataSize: i32,
    outputSize: [*c]i32,
) [*c]const u8 {
    return raylib.EncodeDataBase64(
        data,
        dataSize,
        outputSize,
    );
}

/// Decode Base64 string data
pub fn DecodeDataBase64(
    data: [*:0]const u8,
    outputSize: [*]i32,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mDecodeDataBase64(
            @intToPtr([*c]const u8, @ptrToInt(data)),
            @ptrCast([*c]i32, outputSize),
        ),
    );
}

export fn mDecodeDataBase64(
    data: [*c]const u8,
    outputSize: [*c]i32,
) [*c]const u8 {
    return raylib.DecodeDataBase64(
        data,
        outputSize,
    );
}

/// Save integer value to storage file (to defined position), returns true on success
pub fn SaveStorageValue(
    position: u32,
    value: i32,
) bool {
    var out: bool = undefined;
    mSaveStorageValue(
        @ptrCast([*c]bool, &out),
        position,
        value,
    );
    return out;
}

export fn mSaveStorageValue(
    out: [*c]bool,
    position: u32,
    value: i32,
) void {
    out.* = raylib.SaveStorageValue(
        position,
        value,
    );
}

/// Load integer value from storage file (from defined position)
pub fn LoadStorageValue(
    position: u32,
) i32 {
    var out: i32 = undefined;
    mLoadStorageValue(
        @ptrCast([*c]i32, &out),
        position,
    );
    return out;
}

export fn mLoadStorageValue(
    out: [*c]i32,
    position: u32,
) void {
    out.* = raylib.LoadStorageValue(
        position,
    );
}

/// Open URL with default system browser (if available)
pub fn OpenURL(
    url: [*:0]const u8,
) void {
    mOpenURL(
        @intToPtr([*c]const u8, @ptrToInt(url)),
    );
}

export fn mOpenURL(
    url: [*c]const u8,
) void {
    raylib.OpenURL(
        url,
    );
}

/// Check if a key has been pressed once
pub fn IsKeyPressed(
    key: i32,
) bool {
    var out: bool = undefined;
    mIsKeyPressed(
        @ptrCast([*c]bool, &out),
        key,
    );
    return out;
}

export fn mIsKeyPressed(
    out: [*c]bool,
    key: i32,
) void {
    out.* = raylib.IsKeyPressed(
        key,
    );
}

/// Check if a key is being pressed
pub fn IsKeyDown(
    key: i32,
) bool {
    var out: bool = undefined;
    mIsKeyDown(
        @ptrCast([*c]bool, &out),
        key,
    );
    return out;
}

export fn mIsKeyDown(
    out: [*c]bool,
    key: i32,
) void {
    out.* = raylib.IsKeyDown(
        key,
    );
}

/// Check if a key has been released once
pub fn IsKeyReleased(
    key: i32,
) bool {
    var out: bool = undefined;
    mIsKeyReleased(
        @ptrCast([*c]bool, &out),
        key,
    );
    return out;
}

export fn mIsKeyReleased(
    out: [*c]bool,
    key: i32,
) void {
    out.* = raylib.IsKeyReleased(
        key,
    );
}

/// Check if a key is NOT being pressed
pub fn IsKeyUp(
    key: i32,
) bool {
    var out: bool = undefined;
    mIsKeyUp(
        @ptrCast([*c]bool, &out),
        key,
    );
    return out;
}

export fn mIsKeyUp(
    out: [*c]bool,
    key: i32,
) void {
    out.* = raylib.IsKeyUp(
        key,
    );
}

/// Set a custom key to exit program (default is ESC)
pub fn SetExitKey(
    key: i32,
) void {
    mSetExitKey(
        key,
    );
}

export fn mSetExitKey(
    key: i32,
) void {
    raylib.SetExitKey(
        key,
    );
}

/// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
pub fn GetKeyPressed() i32 {
    var out: i32 = undefined;
    mGetKeyPressed(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetKeyPressed(
    out: [*c]i32,
) void {
    out.* = raylib.GetKeyPressed();
}

/// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
pub fn GetCharPressed() i32 {
    var out: i32 = undefined;
    mGetCharPressed(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetCharPressed(
    out: [*c]i32,
) void {
    out.* = raylib.GetCharPressed();
}

/// Check if a gamepad is available
pub fn IsGamepadAvailable(
    gamepad: i32,
) bool {
    var out: bool = undefined;
    mIsGamepadAvailable(
        @ptrCast([*c]bool, &out),
        gamepad,
    );
    return out;
}

export fn mIsGamepadAvailable(
    out: [*c]bool,
    gamepad: i32,
) void {
    out.* = raylib.IsGamepadAvailable(
        gamepad,
    );
}

/// Get gamepad internal name id
pub fn GetGamepadName(
    gamepad: i32,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mGetGamepadName(
            gamepad,
        ),
    );
}

export fn mGetGamepadName(
    gamepad: i32,
) [*c]const u8 {
    return raylib.GetGamepadName(
        gamepad,
    );
}

/// Check if a gamepad button has been pressed once
pub fn IsGamepadButtonPressed(
    gamepad: i32,
    button: i32,
) bool {
    var out: bool = undefined;
    mIsGamepadButtonPressed(
        @ptrCast([*c]bool, &out),
        gamepad,
        button,
    );
    return out;
}

export fn mIsGamepadButtonPressed(
    out: [*c]bool,
    gamepad: i32,
    button: i32,
) void {
    out.* = raylib.IsGamepadButtonPressed(
        gamepad,
        button,
    );
}

/// Check if a gamepad button is being pressed
pub fn IsGamepadButtonDown(
    gamepad: i32,
    button: i32,
) bool {
    var out: bool = undefined;
    mIsGamepadButtonDown(
        @ptrCast([*c]bool, &out),
        gamepad,
        button,
    );
    return out;
}

export fn mIsGamepadButtonDown(
    out: [*c]bool,
    gamepad: i32,
    button: i32,
) void {
    out.* = raylib.IsGamepadButtonDown(
        gamepad,
        button,
    );
}

/// Check if a gamepad button has been released once
pub fn IsGamepadButtonReleased(
    gamepad: i32,
    button: i32,
) bool {
    var out: bool = undefined;
    mIsGamepadButtonReleased(
        @ptrCast([*c]bool, &out),
        gamepad,
        button,
    );
    return out;
}

export fn mIsGamepadButtonReleased(
    out: [*c]bool,
    gamepad: i32,
    button: i32,
) void {
    out.* = raylib.IsGamepadButtonReleased(
        gamepad,
        button,
    );
}

/// Check if a gamepad button is NOT being pressed
pub fn IsGamepadButtonUp(
    gamepad: i32,
    button: i32,
) bool {
    var out: bool = undefined;
    mIsGamepadButtonUp(
        @ptrCast([*c]bool, &out),
        gamepad,
        button,
    );
    return out;
}

export fn mIsGamepadButtonUp(
    out: [*c]bool,
    gamepad: i32,
    button: i32,
) void {
    out.* = raylib.IsGamepadButtonUp(
        gamepad,
        button,
    );
}

/// Get the last gamepad button pressed
pub fn GetGamepadButtonPressed() i32 {
    var out: i32 = undefined;
    mGetGamepadButtonPressed(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetGamepadButtonPressed(
    out: [*c]i32,
) void {
    out.* = raylib.GetGamepadButtonPressed();
}

/// Get gamepad axis count for a gamepad
pub fn GetGamepadAxisCount(
    gamepad: i32,
) i32 {
    var out: i32 = undefined;
    mGetGamepadAxisCount(
        @ptrCast([*c]i32, &out),
        gamepad,
    );
    return out;
}

export fn mGetGamepadAxisCount(
    out: [*c]i32,
    gamepad: i32,
) void {
    out.* = raylib.GetGamepadAxisCount(
        gamepad,
    );
}

/// Get axis movement value for a gamepad axis
pub fn GetGamepadAxisMovement(
    gamepad: i32,
    axis: i32,
) f32 {
    var out: f32 = undefined;
    mGetGamepadAxisMovement(
        @ptrCast([*c]f32, &out),
        gamepad,
        axis,
    );
    return out;
}

export fn mGetGamepadAxisMovement(
    out: [*c]f32,
    gamepad: i32,
    axis: i32,
) void {
    out.* = raylib.GetGamepadAxisMovement(
        gamepad,
        axis,
    );
}

/// Set internal gamepad mappings (SDL_GameControllerDB)
pub fn SetGamepadMappings(
    mappings: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mSetGamepadMappings(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(mappings)),
    );
    return out;
}

export fn mSetGamepadMappings(
    out: [*c]i32,
    mappings: [*c]const u8,
) void {
    out.* = raylib.SetGamepadMappings(
        mappings,
    );
}

/// Check if a mouse button has been pressed once
pub fn IsMouseButtonPressed(
    button: i32,
) bool {
    var out: bool = undefined;
    mIsMouseButtonPressed(
        @ptrCast([*c]bool, &out),
        button,
    );
    return out;
}

export fn mIsMouseButtonPressed(
    out: [*c]bool,
    button: i32,
) void {
    out.* = raylib.IsMouseButtonPressed(
        button,
    );
}

/// Check if a mouse button is being pressed
pub fn IsMouseButtonDown(
    button: i32,
) bool {
    var out: bool = undefined;
    mIsMouseButtonDown(
        @ptrCast([*c]bool, &out),
        button,
    );
    return out;
}

export fn mIsMouseButtonDown(
    out: [*c]bool,
    button: i32,
) void {
    out.* = raylib.IsMouseButtonDown(
        button,
    );
}

/// Check if a mouse button has been released once
pub fn IsMouseButtonReleased(
    button: i32,
) bool {
    var out: bool = undefined;
    mIsMouseButtonReleased(
        @ptrCast([*c]bool, &out),
        button,
    );
    return out;
}

export fn mIsMouseButtonReleased(
    out: [*c]bool,
    button: i32,
) void {
    out.* = raylib.IsMouseButtonReleased(
        button,
    );
}

/// Check if a mouse button is NOT being pressed
pub fn IsMouseButtonUp(
    button: i32,
) bool {
    var out: bool = undefined;
    mIsMouseButtonUp(
        @ptrCast([*c]bool, &out),
        button,
    );
    return out;
}

export fn mIsMouseButtonUp(
    out: [*c]bool,
    button: i32,
) void {
    out.* = raylib.IsMouseButtonUp(
        button,
    );
}

/// Get mouse position X
pub fn GetMouseX() i32 {
    var out: i32 = undefined;
    mGetMouseX(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetMouseX(
    out: [*c]i32,
) void {
    out.* = raylib.GetMouseX();
}

/// Get mouse position Y
pub fn GetMouseY() i32 {
    var out: i32 = undefined;
    mGetMouseY(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetMouseY(
    out: [*c]i32,
) void {
    out.* = raylib.GetMouseY();
}

/// Get mouse position XY
pub fn GetMousePosition() Vector2 {
    var out: Vector2 = undefined;
    mGetMousePosition(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mGetMousePosition(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.GetMousePosition();
}

/// Get mouse delta between frames
pub fn GetMouseDelta() Vector2 {
    var out: Vector2 = undefined;
    mGetMouseDelta(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mGetMouseDelta(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.GetMouseDelta();
}

/// Set mouse position XY
pub fn SetMousePosition(
    x: i32,
    y: i32,
) void {
    mSetMousePosition(
        x,
        y,
    );
}

export fn mSetMousePosition(
    x: i32,
    y: i32,
) void {
    raylib.SetMousePosition(
        x,
        y,
    );
}

/// Set mouse offset
pub fn SetMouseOffset(
    offsetX: i32,
    offsetY: i32,
) void {
    mSetMouseOffset(
        offsetX,
        offsetY,
    );
}

export fn mSetMouseOffset(
    offsetX: i32,
    offsetY: i32,
) void {
    raylib.SetMouseOffset(
        offsetX,
        offsetY,
    );
}

/// Set mouse scaling
pub fn SetMouseScale(
    scaleX: f32,
    scaleY: f32,
) void {
    mSetMouseScale(
        scaleX,
        scaleY,
    );
}

export fn mSetMouseScale(
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
    var out: f32 = undefined;
    mGetMouseWheelMove(
        @ptrCast([*c]f32, &out),
    );
    return out;
}

export fn mGetMouseWheelMove(
    out: [*c]f32,
) void {
    out.* = raylib.GetMouseWheelMove();
}

/// Set mouse cursor
pub fn SetMouseCursor(
    cursor: i32,
) void {
    mSetMouseCursor(
        cursor,
    );
}

export fn mSetMouseCursor(
    cursor: i32,
) void {
    raylib.SetMouseCursor(
        cursor,
    );
}

/// Get touch position X for touch point 0 (relative to screen size)
pub fn GetTouchX() i32 {
    var out: i32 = undefined;
    mGetTouchX(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetTouchX(
    out: [*c]i32,
) void {
    out.* = raylib.GetTouchX();
}

/// Get touch position Y for touch point 0 (relative to screen size)
pub fn GetTouchY() i32 {
    var out: i32 = undefined;
    mGetTouchY(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetTouchY(
    out: [*c]i32,
) void {
    out.* = raylib.GetTouchY();
}

/// Get touch position XY for a touch point index (relative to screen size)
pub fn GetTouchPosition(
    index: i32,
) Vector2 {
    var out: Vector2 = undefined;
    mGetTouchPosition(
        @ptrCast([*c]raylib.Vector2, &out),
        index,
    );
    return out;
}

export fn mGetTouchPosition(
    out: [*c]raylib.Vector2,
    index: i32,
) void {
    out.* = raylib.GetTouchPosition(
        index,
    );
}

/// Get touch point identifier for given index
pub fn GetTouchPointId(
    index: i32,
) i32 {
    var out: i32 = undefined;
    mGetTouchPointId(
        @ptrCast([*c]i32, &out),
        index,
    );
    return out;
}

export fn mGetTouchPointId(
    out: [*c]i32,
    index: i32,
) void {
    out.* = raylib.GetTouchPointId(
        index,
    );
}

/// Get number of touch points
pub fn GetTouchPointCount() i32 {
    var out: i32 = undefined;
    mGetTouchPointCount(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetTouchPointCount(
    out: [*c]i32,
) void {
    out.* = raylib.GetTouchPointCount();
}

/// Enable a set of gestures using flags
pub fn SetGesturesEnabled(
    flags: u32,
) void {
    mSetGesturesEnabled(
        flags,
    );
}

export fn mSetGesturesEnabled(
    flags: u32,
) void {
    raylib.SetGesturesEnabled(
        flags,
    );
}

/// Check if a gesture have been detected
pub fn IsGestureDetected(
    gesture: i32,
) bool {
    var out: bool = undefined;
    mIsGestureDetected(
        @ptrCast([*c]bool, &out),
        gesture,
    );
    return out;
}

export fn mIsGestureDetected(
    out: [*c]bool,
    gesture: i32,
) void {
    out.* = raylib.IsGestureDetected(
        gesture,
    );
}

/// Get latest detected gesture
pub fn GetGestureDetected() i32 {
    var out: i32 = undefined;
    mGetGestureDetected(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetGestureDetected(
    out: [*c]i32,
) void {
    out.* = raylib.GetGestureDetected();
}

/// Get gesture hold time in milliseconds
pub fn GetGestureHoldDuration() f32 {
    var out: f32 = undefined;
    mGetGestureHoldDuration(
        @ptrCast([*c]f32, &out),
    );
    return out;
}

export fn mGetGestureHoldDuration(
    out: [*c]f32,
) void {
    out.* = raylib.GetGestureHoldDuration();
}

/// Get gesture drag vector
pub fn GetGestureDragVector() Vector2 {
    var out: Vector2 = undefined;
    mGetGestureDragVector(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mGetGestureDragVector(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.GetGestureDragVector();
}

/// Get gesture drag angle
pub fn GetGestureDragAngle() f32 {
    var out: f32 = undefined;
    mGetGestureDragAngle(
        @ptrCast([*c]f32, &out),
    );
    return out;
}

export fn mGetGestureDragAngle(
    out: [*c]f32,
) void {
    out.* = raylib.GetGestureDragAngle();
}

/// Get gesture pinch delta
pub fn GetGesturePinchVector() Vector2 {
    var out: Vector2 = undefined;
    mGetGesturePinchVector(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mGetGesturePinchVector(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.GetGesturePinchVector();
}

/// Get gesture pinch angle
pub fn GetGesturePinchAngle() f32 {
    var out: f32 = undefined;
    mGetGesturePinchAngle(
        @ptrCast([*c]f32, &out),
    );
    return out;
}

export fn mGetGesturePinchAngle(
    out: [*c]f32,
) void {
    out.* = raylib.GetGesturePinchAngle();
}

/// Set camera mode (multiple camera modes available)
pub fn SetCameraMode(
    camera: Camera3D,
    mode: i32,
) void {
    mSetCameraMode(
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        mode,
    );
}

export fn mSetCameraMode(
    camera: [*c]raylib.Camera3D,
    mode: i32,
) void {
    raylib.SetCameraMode(
        camera.*,
        mode,
    );
}

/// Update camera position for selected mode
pub fn UpdateCamera(
    camera: [*]Camera3D,
) void {
    mUpdateCamera(
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(camera)),
    );
}

export fn mUpdateCamera(
    camera: [*c]raylib.Camera3D,
) void {
    raylib.UpdateCamera(
        camera,
    );
}

/// Set camera pan key to combine with mouse movement (free camera)
pub fn SetCameraPanControl(
    keyPan: i32,
) void {
    mSetCameraPanControl(
        keyPan,
    );
}

export fn mSetCameraPanControl(
    keyPan: i32,
) void {
    raylib.SetCameraPanControl(
        keyPan,
    );
}

/// Set camera alt key to combine with mouse movement (free camera)
pub fn SetCameraAltControl(
    keyAlt: i32,
) void {
    mSetCameraAltControl(
        keyAlt,
    );
}

export fn mSetCameraAltControl(
    keyAlt: i32,
) void {
    raylib.SetCameraAltControl(
        keyAlt,
    );
}

/// Set camera smooth zoom key to combine with mouse (free camera)
pub fn SetCameraSmoothZoomControl(
    keySmoothZoom: i32,
) void {
    mSetCameraSmoothZoomControl(
        keySmoothZoom,
    );
}

export fn mSetCameraSmoothZoomControl(
    keySmoothZoom: i32,
) void {
    raylib.SetCameraSmoothZoomControl(
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
    mSetCameraMoveControls(
        keyFront,
        keyBack,
        keyRight,
        keyLeft,
        keyUp,
        keyDown,
    );
}

export fn mSetCameraMoveControls(
    keyFront: i32,
    keyBack: i32,
    keyRight: i32,
    keyLeft: i32,
    keyUp: i32,
    keyDown: i32,
) void {
    raylib.SetCameraMoveControls(
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
    mSetShapesTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
    );
}

export fn mSetShapesTexture(
    texture: [*c]raylib.Texture2D,
    source: [*c]raylib.Rectangle,
) void {
    raylib.SetShapesTexture(
        texture.*,
        source.*,
    );
}

/// Draw a pixel
pub fn DrawPixel(
    posX: i32,
    posY: i32,
    color: Color,
) void {
    mDrawPixel(
        posX,
        posY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawPixel(
    posX: i32,
    posY: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawPixel(
        posX,
        posY,
        color.*,
    );
}

/// Draw a pixel (Vector version)
pub fn DrawPixelV(
    position: Vector2,
    color: Color,
) void {
    mDrawPixelV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawPixelV(
    position: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.DrawPixelV(
        position.*,
        color.*,
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
    mDrawLine(
        startPosX,
        startPosY,
        endPosX,
        endPosY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLine(
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLine(
        startPosX,
        startPosY,
        endPosX,
        endPosY,
        color.*,
    );
}

/// Draw a line (Vector version)
pub fn DrawLineV(
    startPos: Vector2,
    endPos: Vector2,
    color: Color,
) void {
    mDrawLineV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLineV(
    startPos: [*c]raylib.Vector2,
    endPos: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLineV(
        startPos.*,
        endPos.*,
        color.*,
    );
}

/// Draw a line defining thickness
pub fn DrawLineEx(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    mDrawLineEx(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLineEx(
    startPos: [*c]raylib.Vector2,
    endPos: [*c]raylib.Vector2,
    thick: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLineEx(
        startPos.*,
        endPos.*,
        thick,
        color.*,
    );
}

/// Draw a line using cubic-bezier curves in-out
pub fn DrawLineBezier(
    startPos: Vector2,
    endPos: Vector2,
    thick: f32,
    color: Color,
) void {
    mDrawLineBezier(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLineBezier(
    startPos: [*c]raylib.Vector2,
    endPos: [*c]raylib.Vector2,
    thick: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLineBezier(
        startPos.*,
        endPos.*,
        thick,
        color.*,
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
    mDrawLineBezierQuad(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&controlPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLineBezierQuad(
    startPos: [*c]raylib.Vector2,
    endPos: [*c]raylib.Vector2,
    controlPos: [*c]raylib.Vector2,
    thick: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLineBezierQuad(
        startPos.*,
        endPos.*,
        controlPos.*,
        thick,
        color.*,
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
    mDrawLineBezierCubic(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startControlPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endControlPos)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLineBezierCubic(
    startPos: [*c]raylib.Vector2,
    endPos: [*c]raylib.Vector2,
    startControlPos: [*c]raylib.Vector2,
    endControlPos: [*c]raylib.Vector2,
    thick: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLineBezierCubic(
        startPos.*,
        endPos.*,
        startControlPos.*,
        endControlPos.*,
        thick,
        color.*,
    );
}

/// Draw lines sequence
pub fn DrawLineStrip(
    points: [*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    mDrawLineStrip(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(points)),
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLineStrip(
    points: [*c]raylib.Vector2,
    pointCount: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLineStrip(
        points,
        pointCount,
        color.*,
    );
}

/// Draw a color-filled circle
pub fn DrawCircle(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {
    mDrawCircle(
        centerX,
        centerY,
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCircle(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCircle(
        centerX,
        centerY,
        radius,
        color.*,
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
    mDrawCircleSector(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCircleSector(
    center: [*c]raylib.Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCircleSector(
        center.*,
        radius,
        startAngle,
        endAngle,
        segments,
        color.*,
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
    mDrawCircleSectorLines(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCircleSectorLines(
    center: [*c]raylib.Vector2,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCircleSectorLines(
        center.*,
        radius,
        startAngle,
        endAngle,
        segments,
        color.*,
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
    mDrawCircleGradient(
        centerX,
        centerY,
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color2)),
    );
}

export fn mDrawCircleGradient(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color1: [*c]raylib.Color,
    color2: [*c]raylib.Color,
) void {
    raylib.DrawCircleGradient(
        centerX,
        centerY,
        radius,
        color1.*,
        color2.*,
    );
}

/// Draw a color-filled circle (Vector version)
pub fn DrawCircleV(
    center: Vector2,
    radius: f32,
    color: Color,
) void {
    mDrawCircleV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCircleV(
    center: [*c]raylib.Vector2,
    radius: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCircleV(
        center.*,
        radius,
        color.*,
    );
}

/// Draw circle outline
pub fn DrawCircleLines(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: Color,
) void {
    mDrawCircleLines(
        centerX,
        centerY,
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCircleLines(
    centerX: i32,
    centerY: i32,
    radius: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCircleLines(
        centerX,
        centerY,
        radius,
        color.*,
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
    mDrawEllipse(
        centerX,
        centerY,
        radiusH,
        radiusV,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawEllipse(
    centerX: i32,
    centerY: i32,
    radiusH: f32,
    radiusV: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawEllipse(
        centerX,
        centerY,
        radiusH,
        radiusV,
        color.*,
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
    mDrawEllipseLines(
        centerX,
        centerY,
        radiusH,
        radiusV,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawEllipseLines(
    centerX: i32,
    centerY: i32,
    radiusH: f32,
    radiusV: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawEllipseLines(
        centerX,
        centerY,
        radiusH,
        radiusV,
        color.*,
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
    mDrawRing(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRing(
    center: [*c]raylib.Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRing(
        center.*,
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        color.*,
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
    mDrawRingLines(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRingLines(
    center: [*c]raylib.Vector2,
    innerRadius: f32,
    outerRadius: f32,
    startAngle: f32,
    endAngle: f32,
    segments: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRingLines(
        center.*,
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
        segments,
        color.*,
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
    mDrawRectangle(
        posX,
        posY,
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectangle(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectangle(
        posX,
        posY,
        width,
        height,
        color.*,
    );
}

/// Draw a color-filled rectangle (Vector version)
pub fn DrawRectangleV(
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    mDrawRectangleV(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectangleV(
    position: [*c]raylib.Vector2,
    size: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectangleV(
        position.*,
        size.*,
        color.*,
    );
}

/// Draw a color-filled rectangle
pub fn DrawRectangleRec(
    rec: Rectangle,
    color: Color,
) void {
    mDrawRectangleRec(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectangleRec(
    rec: [*c]raylib.Rectangle,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectangleRec(
        rec.*,
        color.*,
    );
}

/// Draw a color-filled rectangle with pro parameters
pub fn DrawRectanglePro(
    rec: Rectangle,
    origin: Vector2,
    rotation: f32,
    color: Color,
) void {
    mDrawRectanglePro(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectanglePro(
    rec: [*c]raylib.Rectangle,
    origin: [*c]raylib.Vector2,
    rotation: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectanglePro(
        rec.*,
        origin.*,
        rotation,
        color.*,
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
    mDrawRectangleGradientV(
        posX,
        posY,
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color2)),
    );
}

export fn mDrawRectangleGradientV(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color1: [*c]raylib.Color,
    color2: [*c]raylib.Color,
) void {
    raylib.DrawRectangleGradientV(
        posX,
        posY,
        width,
        height,
        color1.*,
        color2.*,
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
    mDrawRectangleGradientH(
        posX,
        posY,
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color2)),
    );
}

export fn mDrawRectangleGradientH(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color1: [*c]raylib.Color,
    color2: [*c]raylib.Color,
) void {
    raylib.DrawRectangleGradientH(
        posX,
        posY,
        width,
        height,
        color1.*,
        color2.*,
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
    mDrawRectangleGradientEx(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col1)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col2)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&col4)),
    );
}

export fn mDrawRectangleGradientEx(
    rec: [*c]raylib.Rectangle,
    col1: [*c]raylib.Color,
    col2: [*c]raylib.Color,
    col3: [*c]raylib.Color,
    col4: [*c]raylib.Color,
) void {
    raylib.DrawRectangleGradientEx(
        rec.*,
        col1.*,
        col2.*,
        col3.*,
        col4.*,
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
    mDrawRectangleLines(
        posX,
        posY,
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectangleLines(
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectangleLines(
        posX,
        posY,
        width,
        height,
        color.*,
    );
}

/// Draw rectangle outline with extended parameters
pub fn DrawRectangleLinesEx(
    rec: Rectangle,
    lineThick: f32,
    color: Color,
) void {
    mDrawRectangleLinesEx(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        lineThick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectangleLinesEx(
    rec: [*c]raylib.Rectangle,
    lineThick: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectangleLinesEx(
        rec.*,
        lineThick,
        color.*,
    );
}

/// Draw rectangle with rounded edges
pub fn DrawRectangleRounded(
    rec: Rectangle,
    roundness: f32,
    segments: i32,
    color: Color,
) void {
    mDrawRectangleRounded(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        roundness,
        segments,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectangleRounded(
    rec: [*c]raylib.Rectangle,
    roundness: f32,
    segments: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectangleRounded(
        rec.*,
        roundness,
        segments,
        color.*,
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
    mDrawRectangleRoundedLines(
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        roundness,
        segments,
        lineThick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRectangleRoundedLines(
    rec: [*c]raylib.Rectangle,
    roundness: f32,
    segments: i32,
    lineThick: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRectangleRoundedLines(
        rec.*,
        roundness,
        segments,
        lineThick,
        color.*,
    );
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {
    mDrawTriangle(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawTriangle(
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
    v3: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.DrawTriangle(
        v1.*,
        v2.*,
        v3.*,
        color.*,
    );
}

/// Draw triangle outline (vertex in counter-clockwise order!)
pub fn DrawTriangleLines(
    v1: Vector2,
    v2: Vector2,
    v3: Vector2,
    color: Color,
) void {
    mDrawTriangleLines(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawTriangleLines(
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
    v3: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.DrawTriangleLines(
        v1.*,
        v2.*,
        v3.*,
        color.*,
    );
}

/// Draw a triangle fan defined by points (first vertex is the center)
pub fn DrawTriangleFan(
    points: [*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    mDrawTriangleFan(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(points)),
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawTriangleFan(
    points: [*c]raylib.Vector2,
    pointCount: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawTriangleFan(
        points,
        pointCount,
        color.*,
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip(
    points: [*]Vector2,
    pointCount: i32,
    color: Color,
) void {
    mDrawTriangleStrip(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(points)),
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawTriangleStrip(
    points: [*c]raylib.Vector2,
    pointCount: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawTriangleStrip(
        points,
        pointCount,
        color.*,
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
    mDrawPoly(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        sides,
        radius,
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawPoly(
    center: [*c]raylib.Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawPoly(
        center.*,
        sides,
        radius,
        rotation,
        color.*,
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
    mDrawPolyLines(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        sides,
        radius,
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawPolyLines(
    center: [*c]raylib.Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawPolyLines(
        center.*,
        sides,
        radius,
        rotation,
        color.*,
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
    mDrawPolyLinesEx(
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        sides,
        radius,
        rotation,
        lineThick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawPolyLinesEx(
    center: [*c]raylib.Vector2,
    sides: i32,
    radius: f32,
    rotation: f32,
    lineThick: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawPolyLinesEx(
        center.*,
        sides,
        radius,
        rotation,
        lineThick,
        color.*,
    );
}

/// Check collision between two rectangles
pub fn CheckCollisionRecs(
    rec1: Rectangle,
    rec2: Rectangle,
) bool {
    var out: bool = undefined;
    mCheckCollisionRecs(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec1)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec2)),
    );
    return out;
}

export fn mCheckCollisionRecs(
    out: [*c]bool,
    rec1: [*c]raylib.Rectangle,
    rec2: [*c]raylib.Rectangle,
) void {
    out.* = raylib.CheckCollisionRecs(
        rec1.*,
        rec2.*,
    );
}

/// Check collision between two circles
pub fn CheckCollisionCircles(
    center1: Vector2,
    radius1: f32,
    center2: Vector2,
    radius2: f32,
) bool {
    var out: bool = undefined;
    mCheckCollisionCircles(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center1)),
        radius1,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center2)),
        radius2,
    );
    return out;
}

export fn mCheckCollisionCircles(
    out: [*c]bool,
    center1: [*c]raylib.Vector2,
    radius1: f32,
    center2: [*c]raylib.Vector2,
    radius2: f32,
) void {
    out.* = raylib.CheckCollisionCircles(
        center1.*,
        radius1,
        center2.*,
        radius2,
    );
}

/// Check collision between circle and rectangle
pub fn CheckCollisionCircleRec(
    center: Vector2,
    radius: f32,
    rec: Rectangle,
) bool {
    var out: bool = undefined;
    mCheckCollisionCircleRec(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
    );
    return out;
}

export fn mCheckCollisionCircleRec(
    out: [*c]bool,
    center: [*c]raylib.Vector2,
    radius: f32,
    rec: [*c]raylib.Rectangle,
) void {
    out.* = raylib.CheckCollisionCircleRec(
        center.*,
        radius,
        rec.*,
    );
}

/// Check if point is inside rectangle
pub fn CheckCollisionPointRec(
    point: Vector2,
    rec: Rectangle,
) bool {
    var out: bool = undefined;
    mCheckCollisionPointRec(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
    );
    return out;
}

export fn mCheckCollisionPointRec(
    out: [*c]bool,
    point: [*c]raylib.Vector2,
    rec: [*c]raylib.Rectangle,
) void {
    out.* = raylib.CheckCollisionPointRec(
        point.*,
        rec.*,
    );
}

/// Check if point is inside circle
pub fn CheckCollisionPointCircle(
    point: Vector2,
    center: Vector2,
    radius: f32,
) bool {
    var out: bool = undefined;
    mCheckCollisionPointCircle(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
    );
    return out;
}

export fn mCheckCollisionPointCircle(
    out: [*c]bool,
    point: [*c]raylib.Vector2,
    center: [*c]raylib.Vector2,
    radius: f32,
) void {
    out.* = raylib.CheckCollisionPointCircle(
        point.*,
        center.*,
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
    var out: bool = undefined;
    mCheckCollisionPointTriangle(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p3)),
    );
    return out;
}

export fn mCheckCollisionPointTriangle(
    out: [*c]bool,
    point: [*c]raylib.Vector2,
    p1: [*c]raylib.Vector2,
    p2: [*c]raylib.Vector2,
    p3: [*c]raylib.Vector2,
) void {
    out.* = raylib.CheckCollisionPointTriangle(
        point.*,
        p1.*,
        p2.*,
        p3.*,
    );
}

/// Check the collision between two lines defined by two points each, returns collision point by reference
pub fn CheckCollisionLines(
    startPos1: Vector2,
    endPos1: Vector2,
    startPos2: Vector2,
    endPos2: Vector2,
    collisionPoint: [*]Vector2,
) bool {
    var out: bool = undefined;
    mCheckCollisionLines(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&startPos2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&endPos2)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(collisionPoint)),
    );
    return out;
}

export fn mCheckCollisionLines(
    out: [*c]bool,
    startPos1: [*c]raylib.Vector2,
    endPos1: [*c]raylib.Vector2,
    startPos2: [*c]raylib.Vector2,
    endPos2: [*c]raylib.Vector2,
    collisionPoint: [*c]raylib.Vector2,
) void {
    out.* = raylib.CheckCollisionLines(
        startPos1.*,
        endPos1.*,
        startPos2.*,
        endPos2.*,
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
    var out: bool = undefined;
    mCheckCollisionPointLine(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&point)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&p2)),
        threshold,
    );
    return out;
}

export fn mCheckCollisionPointLine(
    out: [*c]bool,
    point: [*c]raylib.Vector2,
    p1: [*c]raylib.Vector2,
    p2: [*c]raylib.Vector2,
    threshold: i32,
) void {
    out.* = raylib.CheckCollisionPointLine(
        point.*,
        p1.*,
        p2.*,
        threshold,
    );
}

/// Get collision rectangle for two rectangles collision
pub fn GetCollisionRec(
    rec1: Rectangle,
    rec2: Rectangle,
) Rectangle {
    var out: Rectangle = undefined;
    mGetCollisionRec(
        @ptrCast([*c]raylib.Rectangle, &out),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec1)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec2)),
    );
    return out;
}

export fn mGetCollisionRec(
    out: [*c]raylib.Rectangle,
    rec1: [*c]raylib.Rectangle,
    rec2: [*c]raylib.Rectangle,
) void {
    out.* = raylib.GetCollisionRec(
        rec1.*,
        rec2.*,
    );
}

/// Load image from file into CPU memory (RAM)
pub fn LoadImage(
    fileName: [*:0]const u8,
) Image {
    var out: Image = undefined;
    mLoadImage(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mLoadImage(
    out: [*c]raylib.Image,
    fileName: [*c]const u8,
) void {
    out.* = raylib.LoadImage(
        fileName,
    );
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
    mLoadImageRaw(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        width,
        height,
        format,
        headerSize,
    );
    return out;
}

export fn mLoadImageRaw(
    out: [*c]raylib.Image,
    fileName: [*c]const u8,
    width: i32,
    height: i32,
    format: i32,
    headerSize: i32,
) void {
    out.* = raylib.LoadImageRaw(
        fileName,
        width,
        height,
        format,
        headerSize,
    );
}

/// Load image sequence from file (frames appended to image.data)
pub fn LoadImageAnim(
    fileName: [*:0]const u8,
    frames: [*]i32,
) Image {
    var out: Image = undefined;
    mLoadImageAnim(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        @ptrCast([*c]i32, frames),
    );
    return out;
}

export fn mLoadImageAnim(
    out: [*c]raylib.Image,
    fileName: [*c]const u8,
    frames: [*c]i32,
) void {
    out.* = raylib.LoadImageAnim(
        fileName,
        frames,
    );
}

/// Load image from memory buffer, fileType refers to extension: i.e. '.png'
pub fn LoadImageFromMemory(
    fileType: [*:0]const u8,
    fileData: [*:0]const u8,
    dataSize: i32,
) Image {
    var out: Image = undefined;
    mLoadImageFromMemory(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(fileData)),
        dataSize,
    );
    return out;
}

export fn mLoadImageFromMemory(
    out: [*c]raylib.Image,
    fileType: [*c]const u8,
    fileData: [*c]const u8,
    dataSize: i32,
) void {
    out.* = raylib.LoadImageFromMemory(
        fileType,
        fileData,
        dataSize,
    );
}

/// Load image from GPU texture data
pub fn LoadImageFromTexture(
    texture: Texture2D,
) Image {
    var out: Image = undefined;
    mLoadImageFromTexture(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
    return out;
}

export fn mLoadImageFromTexture(
    out: [*c]raylib.Image,
    texture: [*c]raylib.Texture2D,
) void {
    out.* = raylib.LoadImageFromTexture(
        texture.*,
    );
}

/// Load image from screen buffer and (screenshot)
pub fn LoadImageFromScreen() Image {
    var out: Image = undefined;
    mLoadImageFromScreen(
        @ptrCast([*c]raylib.Image, &out),
    );
    return out;
}

export fn mLoadImageFromScreen(
    out: [*c]raylib.Image,
) void {
    out.* = raylib.LoadImageFromScreen();
}

/// Unload image from CPU memory (RAM)
pub fn UnloadImage(
    image: Image,
) void {
    mUnloadImage(
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
    );
}

export fn mUnloadImage(
    image: [*c]raylib.Image,
) void {
    raylib.UnloadImage(
        image.*,
    );
}

/// Export image data to file, returns true on success
pub fn ExportImage(
    image: Image,
    fileName: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mExportImage(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mExportImage(
    out: [*c]bool,
    image: [*c]raylib.Image,
    fileName: [*c]const u8,
) void {
    out.* = raylib.ExportImage(
        image.*,
        fileName,
    );
}

/// Export image as code file defining an array of bytes, returns true on success
pub fn ExportImageAsCode(
    image: Image,
    fileName: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mExportImageAsCode(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mExportImageAsCode(
    out: [*c]bool,
    image: [*c]raylib.Image,
    fileName: [*c]const u8,
) void {
    out.* = raylib.ExportImageAsCode(
        image.*,
        fileName,
    );
}

/// Generate image: plain color
pub fn GenImageColor(
    width: i32,
    height: i32,
    color: Color,
) Image {
    var out: Image = undefined;
    mGenImageColor(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
    return out;
}

export fn mGenImageColor(
    out: [*c]raylib.Image,
    width: i32,
    height: i32,
    color: [*c]raylib.Color,
) void {
    out.* = raylib.GenImageColor(
        width,
        height,
        color.*,
    );
}

/// Generate image: vertical gradient
pub fn GenImageGradientV(
    width: i32,
    height: i32,
    top: Color,
    bottom: Color,
) Image {
    var out: Image = undefined;
    mGenImageGradientV(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&top)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&bottom)),
    );
    return out;
}

export fn mGenImageGradientV(
    out: [*c]raylib.Image,
    width: i32,
    height: i32,
    top: [*c]raylib.Color,
    bottom: [*c]raylib.Color,
) void {
    out.* = raylib.GenImageGradientV(
        width,
        height,
        top.*,
        bottom.*,
    );
}

/// Generate image: horizontal gradient
pub fn GenImageGradientH(
    width: i32,
    height: i32,
    left: Color,
    right: Color,
) Image {
    var out: Image = undefined;
    mGenImageGradientH(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&right)),
    );
    return out;
}

export fn mGenImageGradientH(
    out: [*c]raylib.Image,
    width: i32,
    height: i32,
    left: [*c]raylib.Color,
    right: [*c]raylib.Color,
) void {
    out.* = raylib.GenImageGradientH(
        width,
        height,
        left.*,
        right.*,
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
    var out: Image = undefined;
    mGenImageGradientRadial(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        density,
        @intToPtr([*c]raylib.Color, @ptrToInt(&inner)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&outer)),
    );
    return out;
}

export fn mGenImageGradientRadial(
    out: [*c]raylib.Image,
    width: i32,
    height: i32,
    density: f32,
    inner: [*c]raylib.Color,
    outer: [*c]raylib.Color,
) void {
    out.* = raylib.GenImageGradientRadial(
        width,
        height,
        density,
        inner.*,
        outer.*,
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
    var out: Image = undefined;
    mGenImageChecked(
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

export fn mGenImageChecked(
    out: [*c]raylib.Image,
    width: i32,
    height: i32,
    checksX: i32,
    checksY: i32,
    col1: [*c]raylib.Color,
    col2: [*c]raylib.Color,
) void {
    out.* = raylib.GenImageChecked(
        width,
        height,
        checksX,
        checksY,
        col1.*,
        col2.*,
    );
}

/// Generate image: white noise
pub fn GenImageWhiteNoise(
    width: i32,
    height: i32,
    factor: f32,
) Image {
    var out: Image = undefined;
    mGenImageWhiteNoise(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        factor,
    );
    return out;
}

export fn mGenImageWhiteNoise(
    out: [*c]raylib.Image,
    width: i32,
    height: i32,
    factor: f32,
) void {
    out.* = raylib.GenImageWhiteNoise(
        width,
        height,
        factor,
    );
}

/// Generate image: cellular algorithm, bigger tileSize means bigger cells
pub fn GenImageCellular(
    width: i32,
    height: i32,
    tileSize: i32,
) Image {
    var out: Image = undefined;
    mGenImageCellular(
        @ptrCast([*c]raylib.Image, &out),
        width,
        height,
        tileSize,
    );
    return out;
}

export fn mGenImageCellular(
    out: [*c]raylib.Image,
    width: i32,
    height: i32,
    tileSize: i32,
) void {
    out.* = raylib.GenImageCellular(
        width,
        height,
        tileSize,
    );
}

/// Create an image duplicate (useful for transformations)
pub fn ImageCopy(
    image: Image,
) Image {
    var out: Image = undefined;
    mImageCopy(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
    );
    return out;
}

export fn mImageCopy(
    out: [*c]raylib.Image,
    image: [*c]raylib.Image,
) void {
    out.* = raylib.ImageCopy(
        image.*,
    );
}

/// Create an image from another image piece
pub fn ImageFromImage(
    image: Image,
    rec: Rectangle,
) Image {
    var out: Image = undefined;
    mImageFromImage(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
    );
    return out;
}

export fn mImageFromImage(
    out: [*c]raylib.Image,
    image: [*c]raylib.Image,
    rec: [*c]raylib.Rectangle,
) void {
    out.* = raylib.ImageFromImage(
        image.*,
        rec.*,
    );
}

/// Create an image from text (default font)
pub fn ImageText(
    text: [*:0]const u8,
    fontSize: i32,
    color: Color,
) Image {
    var out: Image = undefined;
    mImageText(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
    return out;
}

export fn mImageText(
    out: [*c]raylib.Image,
    text: [*c]const u8,
    fontSize: i32,
    color: [*c]raylib.Color,
) void {
    out.* = raylib.ImageText(
        text,
        fontSize,
        color.*,
    );
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
    mImageTextEx(
        @ptrCast([*c]raylib.Image, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
    return out;
}

export fn mImageTextEx(
    out: [*c]raylib.Image,
    font: [*c]raylib.Font,
    text: [*c]const u8,
    fontSize: f32,
    spacing: f32,
    tint: [*c]raylib.Color,
) void {
    out.* = raylib.ImageTextEx(
        font.*,
        text,
        fontSize,
        spacing,
        tint.*,
    );
}

/// Convert image data to desired format
pub fn ImageFormat(
    image: [*]Image,
    newFormat: i32,
) void {
    mImageFormat(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        newFormat,
    );
}

export fn mImageFormat(
    image: [*c]raylib.Image,
    newFormat: i32,
) void {
    raylib.ImageFormat(
        image,
        newFormat,
    );
}

/// Convert image to POT (power-of-two)
pub fn ImageToPOT(
    image: [*]Image,
    fill: Color,
) void {
    mImageToPOT(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&fill)),
    );
}

export fn mImageToPOT(
    image: [*c]raylib.Image,
    fill: [*c]raylib.Color,
) void {
    raylib.ImageToPOT(
        image,
        fill.*,
    );
}

/// Crop an image to a defined rectangle
pub fn ImageCrop(
    image: [*]Image,
    crop: Rectangle,
) void {
    mImageCrop(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&crop)),
    );
}

export fn mImageCrop(
    image: [*c]raylib.Image,
    crop: [*c]raylib.Rectangle,
) void {
    raylib.ImageCrop(
        image,
        crop.*,
    );
}

/// Crop image depending on alpha value
pub fn ImageAlphaCrop(
    image: [*]Image,
    threshold: f32,
) void {
    mImageAlphaCrop(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        threshold,
    );
}

export fn mImageAlphaCrop(
    image: [*c]raylib.Image,
    threshold: f32,
) void {
    raylib.ImageAlphaCrop(
        image,
        threshold,
    );
}

/// Clear alpha channel to desired color
pub fn ImageAlphaClear(
    image: [*]Image,
    color: Color,
    threshold: f32,
) void {
    mImageAlphaClear(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        threshold,
    );
}

export fn mImageAlphaClear(
    image: [*c]raylib.Image,
    color: [*c]raylib.Color,
    threshold: f32,
) void {
    raylib.ImageAlphaClear(
        image,
        color.*,
        threshold,
    );
}

/// Apply alpha mask to image
pub fn ImageAlphaMask(
    image: [*]Image,
    alphaMask: Image,
) void {
    mImageAlphaMask(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        @intToPtr([*c]raylib.Image, @ptrToInt(&alphaMask)),
    );
}

export fn mImageAlphaMask(
    image: [*c]raylib.Image,
    alphaMask: [*c]raylib.Image,
) void {
    raylib.ImageAlphaMask(
        image,
        alphaMask.*,
    );
}

/// Premultiply alpha channel
pub fn ImageAlphaPremultiply(
    image: [*]Image,
) void {
    mImageAlphaPremultiply(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageAlphaPremultiply(
    image: [*c]raylib.Image,
) void {
    raylib.ImageAlphaPremultiply(
        image,
    );
}

/// Resize image (Bicubic scaling algorithm)
pub fn ImageResize(
    image: [*]Image,
    newWidth: i32,
    newHeight: i32,
) void {
    mImageResize(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        newWidth,
        newHeight,
    );
}

export fn mImageResize(
    image: [*c]raylib.Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.ImageResize(
        image,
        newWidth,
        newHeight,
    );
}

/// Resize image (Nearest-Neighbor scaling algorithm)
pub fn ImageResizeNN(
    image: [*]Image,
    newWidth: i32,
    newHeight: i32,
) void {
    mImageResizeNN(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        newWidth,
        newHeight,
    );
}

export fn mImageResizeNN(
    image: [*c]raylib.Image,
    newWidth: i32,
    newHeight: i32,
) void {
    raylib.ImageResizeNN(
        image,
        newWidth,
        newHeight,
    );
}

/// Resize canvas and fill with color
pub fn ImageResizeCanvas(
    image: [*]Image,
    newWidth: i32,
    newHeight: i32,
    offsetX: i32,
    offsetY: i32,
    fill: Color,
) void {
    mImageResizeCanvas(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        newWidth,
        newHeight,
        offsetX,
        offsetY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&fill)),
    );
}

export fn mImageResizeCanvas(
    image: [*c]raylib.Image,
    newWidth: i32,
    newHeight: i32,
    offsetX: i32,
    offsetY: i32,
    fill: [*c]raylib.Color,
) void {
    raylib.ImageResizeCanvas(
        image,
        newWidth,
        newHeight,
        offsetX,
        offsetY,
        fill.*,
    );
}

/// Compute all mipmap levels for a provided image
pub fn ImageMipmaps(
    image: [*]Image,
) void {
    mImageMipmaps(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageMipmaps(
    image: [*c]raylib.Image,
) void {
    raylib.ImageMipmaps(
        image,
    );
}

/// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub fn ImageDither(
    image: [*]Image,
    rBpp: i32,
    gBpp: i32,
    bBpp: i32,
    aBpp: i32,
) void {
    mImageDither(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        rBpp,
        gBpp,
        bBpp,
        aBpp,
    );
}

export fn mImageDither(
    image: [*c]raylib.Image,
    rBpp: i32,
    gBpp: i32,
    bBpp: i32,
    aBpp: i32,
) void {
    raylib.ImageDither(
        image,
        rBpp,
        gBpp,
        bBpp,
        aBpp,
    );
}

/// Flip image vertically
pub fn ImageFlipVertical(
    image: [*]Image,
) void {
    mImageFlipVertical(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageFlipVertical(
    image: [*c]raylib.Image,
) void {
    raylib.ImageFlipVertical(
        image,
    );
}

/// Flip image horizontally
pub fn ImageFlipHorizontal(
    image: [*]Image,
) void {
    mImageFlipHorizontal(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageFlipHorizontal(
    image: [*c]raylib.Image,
) void {
    raylib.ImageFlipHorizontal(
        image,
    );
}

/// Rotate image clockwise 90deg
pub fn ImageRotateCW(
    image: [*]Image,
) void {
    mImageRotateCW(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageRotateCW(
    image: [*c]raylib.Image,
) void {
    raylib.ImageRotateCW(
        image,
    );
}

/// Rotate image counter-clockwise 90deg
pub fn ImageRotateCCW(
    image: [*]Image,
) void {
    mImageRotateCCW(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageRotateCCW(
    image: [*c]raylib.Image,
) void {
    raylib.ImageRotateCCW(
        image,
    );
}

/// Modify image color: tint
pub fn ImageColorTint(
    image: [*]Image,
    color: Color,
) void {
    mImageColorTint(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageColorTint(
    image: [*c]raylib.Image,
    color: [*c]raylib.Color,
) void {
    raylib.ImageColorTint(
        image,
        color.*,
    );
}

/// Modify image color: invert
pub fn ImageColorInvert(
    image: [*]Image,
) void {
    mImageColorInvert(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageColorInvert(
    image: [*c]raylib.Image,
) void {
    raylib.ImageColorInvert(
        image,
    );
}

/// Modify image color: grayscale
pub fn ImageColorGrayscale(
    image: [*]Image,
) void {
    mImageColorGrayscale(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
    );
}

export fn mImageColorGrayscale(
    image: [*c]raylib.Image,
) void {
    raylib.ImageColorGrayscale(
        image,
    );
}

/// Modify image color: contrast (-100 to 100)
pub fn ImageColorContrast(
    image: [*]Image,
    contrast: f32,
) void {
    mImageColorContrast(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        contrast,
    );
}

export fn mImageColorContrast(
    image: [*c]raylib.Image,
    contrast: f32,
) void {
    raylib.ImageColorContrast(
        image,
        contrast,
    );
}

/// Modify image color: brightness (-255 to 255)
pub fn ImageColorBrightness(
    image: [*]Image,
    brightness: i32,
) void {
    mImageColorBrightness(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        brightness,
    );
}

export fn mImageColorBrightness(
    image: [*c]raylib.Image,
    brightness: i32,
) void {
    raylib.ImageColorBrightness(
        image,
        brightness,
    );
}

/// Modify image color: replace color
pub fn ImageColorReplace(
    image: [*]Image,
    color: Color,
    replace: Color,
) void {
    mImageColorReplace(
        @intToPtr([*c]raylib.Image, @ptrToInt(image)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&replace)),
    );
}

export fn mImageColorReplace(
    image: [*c]raylib.Image,
    color: [*c]raylib.Color,
    replace: [*c]raylib.Color,
) void {
    raylib.ImageColorReplace(
        image,
        color.*,
        replace.*,
    );
}

/// Load color data from image as a Color array (RGBA - 32bit)
pub fn LoadImageColors(
    image: Image,
) [*]const Color {
    return @ptrCast(
        [*]Color,
        mLoadImageColors(
            @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        ),
    );
}

export fn mLoadImageColors(
    image: [*c]raylib.Image,
) [*c]const raylib.Color {
    return raylib.LoadImageColors(
        image.*,
    );
}

/// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn LoadImagePalette(
    image: Image,
    maxPaletteSize: i32,
    colorCount: [*]i32,
) [*]const Color {
    return @ptrCast(
        [*]Color,
        mLoadImagePalette(
            @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
            maxPaletteSize,
            @ptrCast([*c]i32, colorCount),
        ),
    );
}

export fn mLoadImagePalette(
    image: [*c]raylib.Image,
    maxPaletteSize: i32,
    colorCount: [*c]i32,
) [*c]const raylib.Color {
    return raylib.LoadImagePalette(
        image.*,
        maxPaletteSize,
        colorCount,
    );
}

/// Unload color data loaded with LoadImageColors()
pub fn UnloadImageColors(
    colors: [*]Color,
) void {
    mUnloadImageColors(
        @intToPtr([*c]raylib.Color, @ptrToInt(colors)),
    );
}

export fn mUnloadImageColors(
    colors: [*c]raylib.Color,
) void {
    raylib.UnloadImageColors(
        colors,
    );
}

/// Unload colors palette loaded with LoadImagePalette()
pub fn UnloadImagePalette(
    colors: [*]Color,
) void {
    mUnloadImagePalette(
        @intToPtr([*c]raylib.Color, @ptrToInt(colors)),
    );
}

export fn mUnloadImagePalette(
    colors: [*c]raylib.Color,
) void {
    raylib.UnloadImagePalette(
        colors,
    );
}

/// Get image alpha border rectangle
pub fn GetImageAlphaBorder(
    image: Image,
    threshold: f32,
) Rectangle {
    var out: Rectangle = undefined;
    mGetImageAlphaBorder(
        @ptrCast([*c]raylib.Rectangle, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        threshold,
    );
    return out;
}

export fn mGetImageAlphaBorder(
    out: [*c]raylib.Rectangle,
    image: [*c]raylib.Image,
    threshold: f32,
) void {
    out.* = raylib.GetImageAlphaBorder(
        image.*,
        threshold,
    );
}

/// Get image pixel color at (x, y) position
pub fn GetImageColor(
    image: Image,
    x: i32,
    y: i32,
) Color {
    var out: Color = undefined;
    mGetImageColor(
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        x,
        y,
    );
    return out;
}

export fn mGetImageColor(
    out: [*c]raylib.Color,
    image: [*c]raylib.Image,
    x: i32,
    y: i32,
) void {
    out.* = raylib.GetImageColor(
        image.*,
        x,
        y,
    );
}

/// Clear image background with given color
pub fn ImageClearBackground(
    dst: [*]Image,
    color: Color,
) void {
    mImageClearBackground(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageClearBackground(
    dst: [*c]raylib.Image,
    color: [*c]raylib.Color,
) void {
    raylib.ImageClearBackground(
        dst,
        color.*,
    );
}

/// Draw pixel within an image
pub fn ImageDrawPixel(
    dst: [*]Image,
    posX: i32,
    posY: i32,
    color: Color,
) void {
    mImageDrawPixel(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        posX,
        posY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawPixel(
    dst: [*c]raylib.Image,
    posX: i32,
    posY: i32,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawPixel(
        dst,
        posX,
        posY,
        color.*,
    );
}

/// Draw pixel within an image (Vector version)
pub fn ImageDrawPixelV(
    dst: [*]Image,
    position: Vector2,
    color: Color,
) void {
    mImageDrawPixelV(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawPixelV(
    dst: [*c]raylib.Image,
    position: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawPixelV(
        dst,
        position.*,
        color.*,
    );
}

/// Draw line within an image
pub fn ImageDrawLine(
    dst: [*]Image,
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: Color,
) void {
    mImageDrawLine(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        startPosX,
        startPosY,
        endPosX,
        endPosY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawLine(
    dst: [*c]raylib.Image,
    startPosX: i32,
    startPosY: i32,
    endPosX: i32,
    endPosY: i32,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawLine(
        dst,
        startPosX,
        startPosY,
        endPosX,
        endPosY,
        color.*,
    );
}

/// Draw line within an image (Vector version)
pub fn ImageDrawLineV(
    dst: [*]Image,
    start: Vector2,
    end: Vector2,
    color: Color,
) void {
    mImageDrawLineV(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&start)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&end)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawLineV(
    dst: [*c]raylib.Image,
    start: [*c]raylib.Vector2,
    end: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawLineV(
        dst,
        start.*,
        end.*,
        color.*,
    );
}

/// Draw circle within an image
pub fn ImageDrawCircle(
    dst: [*]Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: Color,
) void {
    mImageDrawCircle(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        centerX,
        centerY,
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawCircle(
    dst: [*c]raylib.Image,
    centerX: i32,
    centerY: i32,
    radius: i32,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawCircle(
        dst,
        centerX,
        centerY,
        radius,
        color.*,
    );
}

/// Draw circle within an image (Vector version)
pub fn ImageDrawCircleV(
    dst: [*]Image,
    center: Vector2,
    radius: i32,
    color: Color,
) void {
    mImageDrawCircleV(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawCircleV(
    dst: [*c]raylib.Image,
    center: [*c]raylib.Vector2,
    radius: i32,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawCircleV(
        dst,
        center.*,
        radius,
        color.*,
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangle(
    dst: [*]Image,
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: Color,
) void {
    mImageDrawRectangle(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        posX,
        posY,
        width,
        height,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawRectangle(
    dst: [*c]raylib.Image,
    posX: i32,
    posY: i32,
    width: i32,
    height: i32,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawRectangle(
        dst,
        posX,
        posY,
        width,
        height,
        color.*,
    );
}

/// Draw rectangle within an image (Vector version)
pub fn ImageDrawRectangleV(
    dst: [*]Image,
    position: Vector2,
    size: Vector2,
    color: Color,
) void {
    mImageDrawRectangleV(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawRectangleV(
    dst: [*c]raylib.Image,
    position: [*c]raylib.Vector2,
    size: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawRectangleV(
        dst,
        position.*,
        size.*,
        color.*,
    );
}

/// Draw rectangle within an image
pub fn ImageDrawRectangleRec(
    dst: [*]Image,
    rec: Rectangle,
    color: Color,
) void {
    mImageDrawRectangleRec(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawRectangleRec(
    dst: [*c]raylib.Image,
    rec: [*c]raylib.Rectangle,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawRectangleRec(
        dst,
        rec.*,
        color.*,
    );
}

/// Draw rectangle lines within an image
pub fn ImageDrawRectangleLines(
    dst: [*]Image,
    rec: Rectangle,
    thick: i32,
    color: Color,
) void {
    mImageDrawRectangleLines(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        thick,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawRectangleLines(
    dst: [*c]raylib.Image,
    rec: [*c]raylib.Rectangle,
    thick: i32,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawRectangleLines(
        dst,
        rec.*,
        thick,
        color.*,
    );
}

/// Draw a source image within a destination image (tint applied to source)
pub fn ImageDraw(
    dst: [*]Image,
    src: Image,
    srcRec: Rectangle,
    dstRec: Rectangle,
    tint: Color,
) void {
    mImageDraw(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Image, @ptrToInt(&src)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&srcRec)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dstRec)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mImageDraw(
    dst: [*c]raylib.Image,
    src: [*c]raylib.Image,
    srcRec: [*c]raylib.Rectangle,
    dstRec: [*c]raylib.Rectangle,
    tint: [*c]raylib.Color,
) void {
    raylib.ImageDraw(
        dst,
        src.*,
        srcRec.*,
        dstRec.*,
        tint.*,
    );
}

/// Draw text (using default font) within an image (destination)
pub fn ImageDrawText(
    dst: [*]Image,
    text: [*:0]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: Color,
) void {
    mImageDrawText(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        posX,
        posY,
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mImageDrawText(
    dst: [*c]raylib.Image,
    text: [*c]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: [*c]raylib.Color,
) void {
    raylib.ImageDrawText(
        dst,
        text,
        posX,
        posY,
        fontSize,
        color.*,
    );
}

/// Draw text (custom sprite font) within an image (destination)
pub fn ImageDrawTextEx(
    dst: [*]Image,
    font: Font,
    text: [*:0]const u8,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    mImageDrawTextEx(
        @intToPtr([*c]raylib.Image, @ptrToInt(dst)),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mImageDrawTextEx(
    dst: [*c]raylib.Image,
    font: [*c]raylib.Font,
    text: [*c]const u8,
    position: [*c]raylib.Vector2,
    fontSize: f32,
    spacing: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.ImageDrawTextEx(
        dst,
        font.*,
        text,
        position.*,
        fontSize,
        spacing,
        tint.*,
    );
}

/// Load texture from file into GPU memory (VRAM)
pub fn LoadTexture(
    fileName: [*:0]const u8,
) Texture2D {
    var out: Texture2D = undefined;
    mLoadTexture(
        @ptrCast([*c]raylib.Texture2D, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mLoadTexture(
    out: [*c]raylib.Texture2D,
    fileName: [*c]const u8,
) void {
    out.* = raylib.LoadTexture(
        fileName,
    );
}

/// Load texture from image data
pub fn LoadTextureFromImage(
    image: Image,
) Texture2D {
    var out: Texture2D = undefined;
    mLoadTextureFromImage(
        @ptrCast([*c]raylib.Texture2D, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
    );
    return out;
}

export fn mLoadTextureFromImage(
    out: [*c]raylib.Texture2D,
    image: [*c]raylib.Image,
) void {
    out.* = raylib.LoadTextureFromImage(
        image.*,
    );
}

/// Load cubemap from image, multiple image cubemap layouts supported
pub fn LoadTextureCubemap(
    image: Image,
    layout: i32,
) Texture2D {
    var out: Texture2D = undefined;
    mLoadTextureCubemap(
        @ptrCast([*c]raylib.Texture2D, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        layout,
    );
    return out;
}

export fn mLoadTextureCubemap(
    out: [*c]raylib.Texture2D,
    image: [*c]raylib.Image,
    layout: i32,
) void {
    out.* = raylib.LoadTextureCubemap(
        image.*,
        layout,
    );
}

/// Load texture for rendering (framebuffer)
pub fn LoadRenderTexture(
    width: i32,
    height: i32,
) RenderTexture2D {
    var out: RenderTexture2D = undefined;
    mLoadRenderTexture(
        @ptrCast([*c]raylib.RenderTexture2D, &out),
        width,
        height,
    );
    return out;
}

export fn mLoadRenderTexture(
    out: [*c]raylib.RenderTexture2D,
    width: i32,
    height: i32,
) void {
    out.* = raylib.LoadRenderTexture(
        width,
        height,
    );
}

/// Unload texture from GPU memory (VRAM)
pub fn UnloadTexture(
    texture: Texture2D,
) void {
    mUnloadTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
}

export fn mUnloadTexture(
    texture: [*c]raylib.Texture2D,
) void {
    raylib.UnloadTexture(
        texture.*,
    );
}

/// Unload render texture from GPU memory (VRAM)
pub fn UnloadRenderTexture(
    target: RenderTexture2D,
) void {
    mUnloadRenderTexture(
        @intToPtr([*c]raylib.RenderTexture2D, @ptrToInt(&target)),
    );
}

export fn mUnloadRenderTexture(
    target: [*c]raylib.RenderTexture2D,
) void {
    raylib.UnloadRenderTexture(
        target.*,
    );
}

/// Update GPU texture with new data
pub fn UpdateTexture(
    texture: Texture2D,
    pixels: *anyopaque,
) void {
    mUpdateTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @ptrCast([*c]anyopaque, pixels),
    );
}

export fn mUpdateTexture(
    texture: [*c]raylib.Texture2D,
    pixels: *anyopaque,
) void {
    raylib.UpdateTexture(
        texture.*,
        pixels,
    );
}

/// Update GPU texture rectangle with new data
pub fn UpdateTextureRec(
    texture: Texture2D,
    rec: Rectangle,
    pixels: *anyopaque,
) void {
    mUpdateTextureRec(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&rec)),
        @ptrCast([*c]anyopaque, pixels),
    );
}

export fn mUpdateTextureRec(
    texture: [*c]raylib.Texture2D,
    rec: [*c]raylib.Rectangle,
    pixels: *anyopaque,
) void {
    raylib.UpdateTextureRec(
        texture.*,
        rec.*,
        pixels,
    );
}

/// Generate GPU mipmaps for a texture
pub fn GenTextureMipmaps(
    texture: [*]Texture2D,
) void {
    mGenTextureMipmaps(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(texture)),
    );
}

export fn mGenTextureMipmaps(
    texture: [*c]raylib.Texture2D,
) void {
    raylib.GenTextureMipmaps(
        texture,
    );
}

/// Set texture scaling filter mode
pub fn SetTextureFilter(
    texture: Texture2D,
    filter: i32,
) void {
    mSetTextureFilter(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        filter,
    );
}

export fn mSetTextureFilter(
    texture: [*c]raylib.Texture2D,
    filter: i32,
) void {
    raylib.SetTextureFilter(
        texture.*,
        filter,
    );
}

/// Set texture wrapping mode
pub fn SetTextureWrap(
    texture: Texture2D,
    wrap: i32,
) void {
    mSetTextureWrap(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        wrap,
    );
}

export fn mSetTextureWrap(
    texture: [*c]raylib.Texture2D,
    wrap: i32,
) void {
    raylib.SetTextureWrap(
        texture.*,
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
    mDrawTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        posX,
        posY,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTexture(
    texture: [*c]raylib.Texture2D,
    posX: i32,
    posY: i32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTexture(
        texture.*,
        posX,
        posY,
        tint.*,
    );
}

/// Draw a Texture2D with position defined as Vector2
pub fn DrawTextureV(
    texture: Texture2D,
    position: Vector2,
    tint: Color,
) void {
    mDrawTextureV(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextureV(
    texture: [*c]raylib.Texture2D,
    position: [*c]raylib.Vector2,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextureV(
        texture.*,
        position.*,
        tint.*,
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
    mDrawTextureEx(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        rotation,
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextureEx(
    texture: [*c]raylib.Texture2D,
    position: [*c]raylib.Vector2,
    rotation: f32,
    scale: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextureEx(
        texture.*,
        position.*,
        rotation,
        scale,
        tint.*,
    );
}

/// Draw a part of a texture defined by a rectangle
pub fn DrawTextureRec(
    texture: Texture2D,
    source: Rectangle,
    position: Vector2,
    tint: Color,
) void {
    mDrawTextureRec(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextureRec(
    texture: [*c]raylib.Texture2D,
    source: [*c]raylib.Rectangle,
    position: [*c]raylib.Vector2,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextureRec(
        texture.*,
        source.*,
        position.*,
        tint.*,
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
    mDrawTextureQuad(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&tiling)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&offset)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&quad)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextureQuad(
    texture: [*c]raylib.Texture2D,
    tiling: [*c]raylib.Vector2,
    offset: [*c]raylib.Vector2,
    quad: [*c]raylib.Rectangle,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextureQuad(
        texture.*,
        tiling.*,
        offset.*,
        quad.*,
        tint.*,
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
    mDrawTextureTiled(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dest)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextureTiled(
    texture: [*c]raylib.Texture2D,
    source: [*c]raylib.Rectangle,
    dest: [*c]raylib.Rectangle,
    origin: [*c]raylib.Vector2,
    rotation: f32,
    scale: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextureTiled(
        texture.*,
        source.*,
        dest.*,
        origin.*,
        rotation,
        scale,
        tint.*,
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
    mDrawTexturePro(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dest)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTexturePro(
    texture: [*c]raylib.Texture2D,
    source: [*c]raylib.Rectangle,
    dest: [*c]raylib.Rectangle,
    origin: [*c]raylib.Vector2,
    rotation: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTexturePro(
        texture.*,
        source.*,
        dest.*,
        origin.*,
        rotation,
        tint.*,
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
    mDrawTextureNPatch(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.NPatchInfo, @ptrToInt(&nPatchInfo)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&dest)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&origin)),
        rotation,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextureNPatch(
    texture: [*c]raylib.Texture2D,
    nPatchInfo: [*c]raylib.NPatchInfo,
    dest: [*c]raylib.Rectangle,
    origin: [*c]raylib.Vector2,
    rotation: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextureNPatch(
        texture.*,
        nPatchInfo.*,
        dest.*,
        origin.*,
        rotation,
        tint.*,
    );
}

/// Draw a textured polygon
pub fn DrawTexturePoly(
    texture: Texture2D,
    center: Vector2,
    points: [*]Vector2,
    texcoords: [*]Vector2,
    pointCount: i32,
    tint: Color,
) void {
    mDrawTexturePoly(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&center)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(points)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(texcoords)),
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTexturePoly(
    texture: [*c]raylib.Texture2D,
    center: [*c]raylib.Vector2,
    points: [*c]raylib.Vector2,
    texcoords: [*c]raylib.Vector2,
    pointCount: i32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTexturePoly(
        texture.*,
        center.*,
        points,
        texcoords,
        pointCount,
        tint.*,
    );
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn Fade(
    color: Color,
    alpha: f32,
) Color {
    var out: Color = undefined;
    mFade(
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        alpha,
    );
    return out;
}

export fn mFade(
    out: [*c]raylib.Color,
    color: [*c]raylib.Color,
    alpha: f32,
) void {
    out.* = raylib.Fade(
        color.*,
        alpha,
    );
}

/// Get hexadecimal value for a Color
pub fn ColorToInt(
    color: Color,
) i32 {
    var out: i32 = undefined;
    mColorToInt(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
    return out;
}

export fn mColorToInt(
    out: [*c]i32,
    color: [*c]raylib.Color,
) void {
    out.* = raylib.ColorToInt(
        color.*,
    );
}

/// Get Color normalized as float [0..1]
pub fn ColorNormalize(
    color: Color,
) Vector4 {
    var out: Vector4 = undefined;
    mColorNormalize(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
    return out;
}

export fn mColorNormalize(
    out: [*c]raylib.Vector4,
    color: [*c]raylib.Color,
) void {
    out.* = raylib.ColorNormalize(
        color.*,
    );
}

/// Get Color from normalized values [0..1]
pub fn ColorFromNormalized(
    normalized: Vector4,
) Color {
    var out: Color = undefined;
    mColorFromNormalized(
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&normalized)),
    );
    return out;
}

export fn mColorFromNormalized(
    out: [*c]raylib.Color,
    normalized: [*c]raylib.Vector4,
) void {
    out.* = raylib.ColorFromNormalized(
        normalized.*,
    );
}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn ColorToHSV(
    color: Color,
) Vector3 {
    var out: Vector3 = undefined;
    mColorToHSV(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
    return out;
}

export fn mColorToHSV(
    out: [*c]raylib.Vector3,
    color: [*c]raylib.Color,
) void {
    out.* = raylib.ColorToHSV(
        color.*,
    );
}

/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub fn ColorFromHSV(
    hue: f32,
    saturation: f32,
    value: f32,
) Color {
    var out: Color = undefined;
    mColorFromHSV(
        @ptrCast([*c]raylib.Color, &out),
        hue,
        saturation,
        value,
    );
    return out;
}

export fn mColorFromHSV(
    out: [*c]raylib.Color,
    hue: f32,
    saturation: f32,
    value: f32,
) void {
    out.* = raylib.ColorFromHSV(
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
    var out: Color = undefined;
    mColorAlpha(
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        alpha,
    );
    return out;
}

export fn mColorAlpha(
    out: [*c]raylib.Color,
    color: [*c]raylib.Color,
    alpha: f32,
) void {
    out.* = raylib.ColorAlpha(
        color.*,
        alpha,
    );
}

/// Get src alpha-blended into dst color with tint
pub fn ColorAlphaBlend(
    dst: Color,
    src: Color,
    tint: Color,
) Color {
    var out: Color = undefined;
    mColorAlphaBlend(
        @ptrCast([*c]raylib.Color, &out),
        @intToPtr([*c]raylib.Color, @ptrToInt(&dst)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&src)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
    return out;
}

export fn mColorAlphaBlend(
    out: [*c]raylib.Color,
    dst: [*c]raylib.Color,
    src: [*c]raylib.Color,
    tint: [*c]raylib.Color,
) void {
    out.* = raylib.ColorAlphaBlend(
        dst.*,
        src.*,
        tint.*,
    );
}

/// Get Color structure from hexadecimal value
pub fn GetColor(
    hexValue: u32,
) Color {
    var out: Color = undefined;
    mGetColor(
        @ptrCast([*c]raylib.Color, &out),
        hexValue,
    );
    return out;
}

export fn mGetColor(
    out: [*c]raylib.Color,
    hexValue: u32,
) void {
    out.* = raylib.GetColor(
        hexValue,
    );
}

/// Get Color from a source pixel pointer of certain format
pub fn GetPixelColor(
    srcPtr: *anyopaque,
    format: i32,
) Color {
    var out: Color = undefined;
    mGetPixelColor(
        @ptrCast([*c]raylib.Color, &out),
        @ptrCast([*c]anyopaque, srcPtr),
        format,
    );
    return out;
}

export fn mGetPixelColor(
    out: [*c]raylib.Color,
    srcPtr: *anyopaque,
    format: i32,
) void {
    out.* = raylib.GetPixelColor(
        srcPtr,
        format,
    );
}

/// Set color formatted into destination pixel pointer
pub fn SetPixelColor(
    dstPtr: *anyopaque,
    color: Color,
    format: i32,
) void {
    mSetPixelColor(
        @ptrCast([*c]anyopaque, dstPtr),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
        format,
    );
}

export fn mSetPixelColor(
    dstPtr: *anyopaque,
    color: [*c]raylib.Color,
    format: i32,
) void {
    raylib.SetPixelColor(
        dstPtr,
        color.*,
        format,
    );
}

/// Get pixel data size in bytes for certain format
pub fn GetPixelDataSize(
    width: i32,
    height: i32,
    format: i32,
) i32 {
    var out: i32 = undefined;
    mGetPixelDataSize(
        @ptrCast([*c]i32, &out),
        width,
        height,
        format,
    );
    return out;
}

export fn mGetPixelDataSize(
    out: [*c]i32,
    width: i32,
    height: i32,
    format: i32,
) void {
    out.* = raylib.GetPixelDataSize(
        width,
        height,
        format,
    );
}

/// Get the default Font
pub fn GetFontDefault() Font {
    var out: Font = undefined;
    mGetFontDefault(
        @ptrCast([*c]raylib.Font, &out),
    );
    return out;
}

export fn mGetFontDefault(
    out: [*c]raylib.Font,
) void {
    out.* = raylib.GetFontDefault();
}

/// Load font from file into GPU memory (VRAM)
pub fn LoadFont(
    fileName: [*:0]const u8,
) Font {
    var out: Font = undefined;
    mLoadFont(
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mLoadFont(
    out: [*c]raylib.Font,
    fileName: [*c]const u8,
) void {
    out.* = raylib.LoadFont(
        fileName,
    );
}

/// Load font from file with extended parameters, use NULL for fontChars and 0 for glyphCount to load the default character set
pub fn LoadFontEx(
    fileName: [*:0]const u8,
    fontSize: i32,
    fontChars: [*]i32,
    glyphCount: i32,
) Font {
    var out: Font = undefined;
    mLoadFontEx(
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
        fontSize,
        @ptrCast([*c]i32, fontChars),
        glyphCount,
    );
    return out;
}

export fn mLoadFontEx(
    out: [*c]raylib.Font,
    fileName: [*c]const u8,
    fontSize: i32,
    fontChars: [*c]i32,
    glyphCount: i32,
) void {
    out.* = raylib.LoadFontEx(
        fileName,
        fontSize,
        fontChars,
        glyphCount,
    );
}

/// Load font from Image (XNA style)
pub fn LoadFontFromImage(
    image: Image,
    key: Color,
    firstChar: i32,
) Font {
    var out: Font = undefined;
    mLoadFontFromImage(
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&image)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&key)),
        firstChar,
    );
    return out;
}

export fn mLoadFontFromImage(
    out: [*c]raylib.Font,
    image: [*c]raylib.Image,
    key: [*c]raylib.Color,
    firstChar: i32,
) void {
    out.* = raylib.LoadFontFromImage(
        image.*,
        key.*,
        firstChar,
    );
}

/// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
pub fn LoadFontFromMemory(
    fileType: [*:0]const u8,
    fileData: [*:0]const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: [*]i32,
    glyphCount: i32,
) Font {
    var out: Font = undefined;
    mLoadFontFromMemory(
        @ptrCast([*c]raylib.Font, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(fileData)),
        dataSize,
        fontSize,
        @ptrCast([*c]i32, fontChars),
        glyphCount,
    );
    return out;
}

export fn mLoadFontFromMemory(
    out: [*c]raylib.Font,
    fileType: [*c]const u8,
    fileData: [*c]const u8,
    dataSize: i32,
    fontSize: i32,
    fontChars: [*c]i32,
    glyphCount: i32,
) void {
    out.* = raylib.LoadFontFromMemory(
        fileType,
        fileData,
        dataSize,
        fontSize,
        fontChars,
        glyphCount,
    );
}

/// Unload font chars info data (RAM)
pub fn UnloadFontData(
    chars: [*]GlyphInfo,
    glyphCount: i32,
) void {
    mUnloadFontData(
        @intToPtr([*c]raylib.GlyphInfo, @ptrToInt(chars)),
        glyphCount,
    );
}

export fn mUnloadFontData(
    chars: [*c]raylib.GlyphInfo,
    glyphCount: i32,
) void {
    raylib.UnloadFontData(
        chars,
        glyphCount,
    );
}

/// Unload font from GPU memory (VRAM)
pub fn UnloadFont(
    font: Font,
) void {
    mUnloadFont(
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
    );
}

export fn mUnloadFont(
    font: [*c]raylib.Font,
) void {
    raylib.UnloadFont(
        font.*,
    );
}

/// Export font as code file, returns true on success
pub fn ExportFontAsCode(
    font: Font,
    fileName: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mExportFontAsCode(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mExportFontAsCode(
    out: [*c]bool,
    font: [*c]raylib.Font,
    fileName: [*c]const u8,
) void {
    out.* = raylib.ExportFontAsCode(
        font.*,
        fileName,
    );
}

/// Draw current FPS
pub fn DrawFPS(
    posX: i32,
    posY: i32,
) void {
    mDrawFPS(
        posX,
        posY,
    );
}

export fn mDrawFPS(
    posX: i32,
    posY: i32,
) void {
    raylib.DrawFPS(
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
    mDrawText(
        @intToPtr([*c]const u8, @ptrToInt(text)),
        posX,
        posY,
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawText(
    text: [*c]const u8,
    posX: i32,
    posY: i32,
    fontSize: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawText(
        text,
        posX,
        posY,
        fontSize,
        color.*,
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
    mDrawTextEx(
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextEx(
    font: [*c]raylib.Font,
    text: [*c]const u8,
    position: [*c]raylib.Vector2,
    fontSize: f32,
    spacing: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextEx(
        font.*,
        text,
        position.*,
        fontSize,
        spacing,
        tint.*,
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
    mDrawTextPro(
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

export fn mDrawTextPro(
    font: [*c]raylib.Font,
    text: [*c]const u8,
    position: [*c]raylib.Vector2,
    origin: [*c]raylib.Vector2,
    rotation: f32,
    fontSize: f32,
    spacing: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextPro(
        font.*,
        text,
        position.*,
        origin.*,
        rotation,
        fontSize,
        spacing,
        tint.*,
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
    mDrawTextCodepoint(
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        codepoint,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextCodepoint(
    font: [*c]raylib.Font,
    codepoint: i32,
    position: [*c]raylib.Vector2,
    fontSize: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextCodepoint(
        font.*,
        codepoint,
        position.*,
        fontSize,
        tint.*,
    );
}

/// Draw multiple character (codepoint)
pub fn DrawTextCodepoints(
    font: Font,
    codepoints: [*]const i32,
    count: i32,
    position: Vector2,
    fontSize: f32,
    spacing: f32,
    tint: Color,
) void {
    mDrawTextCodepoints(
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const i32, @ptrToInt(codepoints)),
        count,
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&position)),
        fontSize,
        spacing,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawTextCodepoints(
    font: [*c]raylib.Font,
    codepoints: [*c]const i32,
    count: i32,
    position: [*c]raylib.Vector2,
    fontSize: f32,
    spacing: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawTextCodepoints(
        font.*,
        codepoints,
        count,
        position.*,
        fontSize,
        spacing,
        tint.*,
    );
}

/// Measure string width for default font
pub fn MeasureText(
    text: [*:0]const u8,
    fontSize: i32,
) i32 {
    var out: i32 = undefined;
    mMeasureText(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        fontSize,
    );
    return out;
}

export fn mMeasureText(
    out: [*c]i32,
    text: [*c]const u8,
    fontSize: i32,
) void {
    out.* = raylib.MeasureText(
        text,
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
    mMeasureTextEx(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        fontSize,
        spacing,
    );
    return out;
}

export fn mMeasureTextEx(
    out: [*c]raylib.Vector2,
    font: [*c]raylib.Font,
    text: [*c]const u8,
    fontSize: f32,
    spacing: f32,
) void {
    out.* = raylib.MeasureTextEx(
        font.*,
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
    var out: i32 = undefined;
    mGetGlyphIndex(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        codepoint,
    );
    return out;
}

export fn mGetGlyphIndex(
    out: [*c]i32,
    font: [*c]raylib.Font,
    codepoint: i32,
) void {
    out.* = raylib.GetGlyphIndex(
        font.*,
        codepoint,
    );
}

/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphInfo(
    font: Font,
    codepoint: i32,
) GlyphInfo {
    var out: GlyphInfo = undefined;
    mGetGlyphInfo(
        @ptrCast([*c]raylib.GlyphInfo, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        codepoint,
    );
    return out;
}

export fn mGetGlyphInfo(
    out: [*c]raylib.GlyphInfo,
    font: [*c]raylib.Font,
    codepoint: i32,
) void {
    out.* = raylib.GetGlyphInfo(
        font.*,
        codepoint,
    );
}

/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub fn GetGlyphAtlasRec(
    font: Font,
    codepoint: i32,
) Rectangle {
    var out: Rectangle = undefined;
    mGetGlyphAtlasRec(
        @ptrCast([*c]raylib.Rectangle, &out),
        @intToPtr([*c]raylib.Font, @ptrToInt(&font)),
        codepoint,
    );
    return out;
}

export fn mGetGlyphAtlasRec(
    out: [*c]raylib.Rectangle,
    font: [*c]raylib.Font,
    codepoint: i32,
) void {
    out.* = raylib.GetGlyphAtlasRec(
        font.*,
        codepoint,
    );
}

/// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
pub fn LoadCodepoints(
    text: [*:0]const u8,
    count: [*]i32,
) [*]const i32 {
    return @ptrCast(
        [*]i32,
        mLoadCodepoints(
            @intToPtr([*c]const u8, @ptrToInt(text)),
            @ptrCast([*c]i32, count),
        ),
    );
}

export fn mLoadCodepoints(
    text: [*c]const u8,
    count: [*c]i32,
) [*c]const i32 {
    return raylib.LoadCodepoints(
        text,
        count,
    );
}

/// Unload codepoints data from memory
pub fn UnloadCodepoints(
    codepoints: [*]i32,
) void {
    mUnloadCodepoints(
        @ptrCast([*c]i32, codepoints),
    );
}

export fn mUnloadCodepoints(
    codepoints: [*c]i32,
) void {
    raylib.UnloadCodepoints(
        codepoints,
    );
}

/// Get total number of codepoints in a UTF-8 encoded string
pub fn GetCodepointCount(
    text: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mGetCodepointCount(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
    return out;
}

export fn mGetCodepointCount(
    out: [*c]i32,
    text: [*c]const u8,
) void {
    out.* = raylib.GetCodepointCount(
        text,
    );
}

/// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn GetCodepoint(
    text: [*:0]const u8,
    bytesProcessed: [*]i32,
) i32 {
    var out: i32 = undefined;
    mGetCodepoint(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @ptrCast([*c]i32, bytesProcessed),
    );
    return out;
}

export fn mGetCodepoint(
    out: [*c]i32,
    text: [*c]const u8,
    bytesProcessed: [*c]i32,
) void {
    out.* = raylib.GetCodepoint(
        text,
        bytesProcessed,
    );
}

/// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
pub fn CodepointToUTF8(
    codepoint: i32,
    byteSize: [*]i32,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mCodepointToUTF8(
            codepoint,
            @ptrCast([*c]i32, byteSize),
        ),
    );
}

export fn mCodepointToUTF8(
    codepoint: i32,
    byteSize: [*c]i32,
) [*c]const u8 {
    return raylib.CodepointToUTF8(
        codepoint,
        byteSize,
    );
}

/// Encode text as codepoints array into UTF-8 text string (WARNING: memory must be freed!)
pub fn TextCodepointsToUTF8(
    codepoints: [*]const i32,
    length: i32,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mTextCodepointsToUTF8(
            @intToPtr([*c]const i32, @ptrToInt(codepoints)),
            length,
        ),
    );
}

export fn mTextCodepointsToUTF8(
    codepoints: [*c]const i32,
    length: i32,
) [*c]const u8 {
    return raylib.TextCodepointsToUTF8(
        codepoints,
        length,
    );
}

/// Copy one string to another, returns bytes copied
pub fn TextCopy(
    dst: [*]u8,
    src: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mTextCopy(
        @ptrCast([*c]i32, &out),
        @ptrCast([*c]u8, dst),
        @intToPtr([*c]const u8, @ptrToInt(src)),
    );
    return out;
}

export fn mTextCopy(
    out: [*c]i32,
    dst: [*c]u8,
    src: [*c]const u8,
) void {
    out.* = raylib.TextCopy(
        dst,
        src,
    );
}

/// Check if two text string are equal
pub fn TextIsEqual(
    text1: [*:0]const u8,
    text2: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mTextIsEqual(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]const u8, @ptrToInt(text1)),
        @intToPtr([*c]const u8, @ptrToInt(text2)),
    );
    return out;
}

export fn mTextIsEqual(
    out: [*c]bool,
    text1: [*c]const u8,
    text2: [*c]const u8,
) void {
    out.* = raylib.TextIsEqual(
        text1,
        text2,
    );
}

/// Get text length, checks for '\0' ending
pub fn TextLength(
    text: [*:0]const u8,
) u32 {
    var out: u32 = undefined;
    mTextLength(
        @ptrCast([*c]u32, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
    return out;
}

export fn mTextLength(
    out: [*c]u32,
    text: [*c]const u8,
) void {
    out.* = raylib.TextLength(
        text,
    );
}

/// Get a piece of a text string
pub fn TextSubtext(
    text: [*:0]const u8,
    position: i32,
    length: i32,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mTextSubtext(
            @intToPtr([*c]const u8, @ptrToInt(text)),
            position,
            length,
        ),
    );
}

export fn mTextSubtext(
    text: [*c]const u8,
    position: i32,
    length: i32,
) [*c]const u8 {
    return raylib.TextSubtext(
        text,
        position,
        length,
    );
}

/// Replace text string (WARNING: memory must be freed!)
pub fn TextReplace(
    text: [*]u8,
    replace: [*:0]const u8,
    by: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mTextReplace(
            @ptrCast([*c]u8, text),
            @intToPtr([*c]const u8, @ptrToInt(replace)),
            @intToPtr([*c]const u8, @ptrToInt(by)),
        ),
    );
}

export fn mTextReplace(
    text: [*c]u8,
    replace: [*c]const u8,
    by: [*c]const u8,
) [*c]const u8 {
    return raylib.TextReplace(
        text,
        replace,
        by,
    );
}

/// Insert text in a position (WARNING: memory must be freed!)
pub fn TextInsert(
    text: [*:0]const u8,
    insert: [*:0]const u8,
    position: i32,
) [*]const u8 {
    return @ptrCast(
        [*]u8,
        mTextInsert(
            @intToPtr([*c]const u8, @ptrToInt(text)),
            @intToPtr([*c]const u8, @ptrToInt(insert)),
            position,
        ),
    );
}

export fn mTextInsert(
    text: [*c]const u8,
    insert: [*c]const u8,
    position: i32,
) [*c]const u8 {
    return raylib.TextInsert(
        text,
        insert,
        position,
    );
}

/// Find first text occurrence within a string
pub fn TextFindIndex(
    text: [*:0]const u8,
    find: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mTextFindIndex(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
        @intToPtr([*c]const u8, @ptrToInt(find)),
    );
    return out;
}

export fn mTextFindIndex(
    out: [*c]i32,
    text: [*c]const u8,
    find: [*c]const u8,
) void {
    out.* = raylib.TextFindIndex(
        text,
        find,
    );
}

/// Get upper case version of provided string
pub fn TextToUpper(
    text: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mTextToUpper(
            @intToPtr([*c]const u8, @ptrToInt(text)),
        ),
    );
}

export fn mTextToUpper(
    text: [*c]const u8,
) [*c]const u8 {
    return raylib.TextToUpper(
        text,
    );
}

/// Get lower case version of provided string
pub fn TextToLower(
    text: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mTextToLower(
            @intToPtr([*c]const u8, @ptrToInt(text)),
        ),
    );
}

export fn mTextToLower(
    text: [*c]const u8,
) [*c]const u8 {
    return raylib.TextToLower(
        text,
    );
}

/// Get Pascal case notation version of provided string
pub fn TextToPascal(
    text: [*:0]const u8,
) [*]const u8 {
    return @ptrCast(
        [*:0]const u8,
        mTextToPascal(
            @intToPtr([*c]const u8, @ptrToInt(text)),
        ),
    );
}

export fn mTextToPascal(
    text: [*c]const u8,
) [*c]const u8 {
    return raylib.TextToPascal(
        text,
    );
}

/// Get integer value from text (negative values not supported)
pub fn TextToInteger(
    text: [*:0]const u8,
) i32 {
    var out: i32 = undefined;
    mTextToInteger(
        @ptrCast([*c]i32, &out),
        @intToPtr([*c]const u8, @ptrToInt(text)),
    );
    return out;
}

export fn mTextToInteger(
    out: [*c]i32,
    text: [*c]const u8,
) void {
    out.* = raylib.TextToInteger(
        text,
    );
}

/// Draw a line in 3D world space
pub fn DrawLine3D(
    startPos: Vector3,
    endPos: Vector3,
    color: Color,
) void {
    mDrawLine3D(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&endPos)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawLine3D(
    startPos: [*c]raylib.Vector3,
    endPos: [*c]raylib.Vector3,
    color: [*c]raylib.Color,
) void {
    raylib.DrawLine3D(
        startPos.*,
        endPos.*,
        color.*,
    );
}

/// Draw a point in 3D space, actually a small line
pub fn DrawPoint3D(
    position: Vector3,
    color: Color,
) void {
    mDrawPoint3D(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawPoint3D(
    position: [*c]raylib.Vector3,
    color: [*c]raylib.Color,
) void {
    raylib.DrawPoint3D(
        position.*,
        color.*,
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
    mDrawCircle3D(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center)),
        radius,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&rotationAxis)),
        rotationAngle,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCircle3D(
    center: [*c]raylib.Vector3,
    radius: f32,
    rotationAxis: [*c]raylib.Vector3,
    rotationAngle: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCircle3D(
        center.*,
        radius,
        rotationAxis.*,
        rotationAngle,
        color.*,
    );
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn DrawTriangle3D(
    v1: Vector3,
    v2: Vector3,
    v3: Vector3,
    color: Color,
) void {
    mDrawTriangle3D(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v3)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawTriangle3D(
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
    v3: [*c]raylib.Vector3,
    color: [*c]raylib.Color,
) void {
    raylib.DrawTriangle3D(
        v1.*,
        v2.*,
        v3.*,
        color.*,
    );
}

/// Draw a triangle strip defined by points
pub fn DrawTriangleStrip3D(
    points: [*]Vector3,
    pointCount: i32,
    color: Color,
) void {
    mDrawTriangleStrip3D(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(points)),
        pointCount,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawTriangleStrip3D(
    points: [*c]raylib.Vector3,
    pointCount: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawTriangleStrip3D(
        points,
        pointCount,
        color.*,
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
    mDrawCube(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCube(
    position: [*c]raylib.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCube(
        position.*,
        width,
        height,
        length,
        color.*,
    );
}

/// Draw cube (Vector version)
pub fn DrawCubeV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    mDrawCubeV(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCubeV(
    position: [*c]raylib.Vector3,
    size: [*c]raylib.Vector3,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCubeV(
        position.*,
        size.*,
        color.*,
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
    mDrawCubeWires(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCubeWires(
    position: [*c]raylib.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCubeWires(
        position.*,
        width,
        height,
        length,
        color.*,
    );
}

/// Draw cube wires (Vector version)
pub fn DrawCubeWiresV(
    position: Vector3,
    size: Vector3,
    color: Color,
) void {
    mDrawCubeWiresV(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCubeWiresV(
    position: [*c]raylib.Vector3,
    size: [*c]raylib.Vector3,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCubeWiresV(
        position.*,
        size.*,
        color.*,
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
    mDrawCubeTexture(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCubeTexture(
    texture: [*c]raylib.Texture2D,
    position: [*c]raylib.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCubeTexture(
        texture.*,
        position.*,
        width,
        height,
        length,
        color.*,
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
    mDrawCubeTextureRec(
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        width,
        height,
        length,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCubeTextureRec(
    texture: [*c]raylib.Texture2D,
    source: [*c]raylib.Rectangle,
    position: [*c]raylib.Vector3,
    width: f32,
    height: f32,
    length: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCubeTextureRec(
        texture.*,
        source.*,
        position.*,
        width,
        height,
        length,
        color.*,
    );
}

/// Draw sphere
pub fn DrawSphere(
    centerPos: Vector3,
    radius: f32,
    color: Color,
) void {
    mDrawSphere(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        radius,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawSphere(
    centerPos: [*c]raylib.Vector3,
    radius: f32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawSphere(
        centerPos.*,
        radius,
        color.*,
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
    mDrawSphereEx(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        radius,
        rings,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawSphereEx(
    centerPos: [*c]raylib.Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawSphereEx(
        centerPos.*,
        radius,
        rings,
        slices,
        color.*,
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
    mDrawSphereWires(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        radius,
        rings,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawSphereWires(
    centerPos: [*c]raylib.Vector3,
    radius: f32,
    rings: i32,
    slices: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawSphereWires(
        centerPos.*,
        radius,
        rings,
        slices,
        color.*,
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
    mDrawCylinder(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        radiusTop,
        radiusBottom,
        height,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCylinder(
    position: [*c]raylib.Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCylinder(
        position.*,
        radiusTop,
        radiusBottom,
        height,
        slices,
        color.*,
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
    mDrawCylinderEx(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&endPos)),
        startRadius,
        endRadius,
        sides,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCylinderEx(
    startPos: [*c]raylib.Vector3,
    endPos: [*c]raylib.Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCylinderEx(
        startPos.*,
        endPos.*,
        startRadius,
        endRadius,
        sides,
        color.*,
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
    mDrawCylinderWires(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        radiusTop,
        radiusBottom,
        height,
        slices,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCylinderWires(
    position: [*c]raylib.Vector3,
    radiusTop: f32,
    radiusBottom: f32,
    height: f32,
    slices: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCylinderWires(
        position.*,
        radiusTop,
        radiusBottom,
        height,
        slices,
        color.*,
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
    mDrawCylinderWiresEx(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&startPos)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&endPos)),
        startRadius,
        endRadius,
        sides,
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawCylinderWiresEx(
    startPos: [*c]raylib.Vector3,
    endPos: [*c]raylib.Vector3,
    startRadius: f32,
    endRadius: f32,
    sides: i32,
    color: [*c]raylib.Color,
) void {
    raylib.DrawCylinderWiresEx(
        startPos.*,
        endPos.*,
        startRadius,
        endRadius,
        sides,
        color.*,
    );
}

/// Draw a plane XZ
pub fn DrawPlane(
    centerPos: Vector3,
    size: Vector2,
    color: Color,
) void {
    mDrawPlane(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&centerPos)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawPlane(
    centerPos: [*c]raylib.Vector3,
    size: [*c]raylib.Vector2,
    color: [*c]raylib.Color,
) void {
    raylib.DrawPlane(
        centerPos.*,
        size.*,
        color.*,
    );
}

/// Draw a ray line
pub fn DrawRay(
    ray: Ray,
    color: Color,
) void {
    mDrawRay(
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawRay(
    ray: [*c]raylib.Ray,
    color: [*c]raylib.Color,
) void {
    raylib.DrawRay(
        ray.*,
        color.*,
    );
}

/// Draw a grid (centered at (0, 0, 0))
pub fn DrawGrid(
    slices: i32,
    spacing: f32,
) void {
    mDrawGrid(
        slices,
        spacing,
    );
}

export fn mDrawGrid(
    slices: i32,
    spacing: f32,
) void {
    raylib.DrawGrid(
        slices,
        spacing,
    );
}

/// Load model from files (meshes and materials)
pub fn LoadModel(
    fileName: [*:0]const u8,
) Model {
    var out: Model = undefined;
    mLoadModel(
        @ptrCast([*c]raylib.Model, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mLoadModel(
    out: [*c]raylib.Model,
    fileName: [*c]const u8,
) void {
    out.* = raylib.LoadModel(
        fileName,
    );
}

/// Load model from generated mesh (default material)
pub fn LoadModelFromMesh(
    mesh: Mesh,
) Model {
    var out: Model = undefined;
    mLoadModelFromMesh(
        @ptrCast([*c]raylib.Model, &out),
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
    );
    return out;
}

export fn mLoadModelFromMesh(
    out: [*c]raylib.Model,
    mesh: [*c]raylib.Mesh,
) void {
    out.* = raylib.LoadModelFromMesh(
        mesh.*,
    );
}

/// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn UnloadModel(
    model: Model,
) void {
    mUnloadModel(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
    );
}

export fn mUnloadModel(
    model: [*c]raylib.Model,
) void {
    raylib.UnloadModel(
        model.*,
    );
}

/// Unload model (but not meshes) from memory (RAM and/or VRAM)
pub fn UnloadModelKeepMeshes(
    model: Model,
) void {
    mUnloadModelKeepMeshes(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
    );
}

export fn mUnloadModelKeepMeshes(
    model: [*c]raylib.Model,
) void {
    raylib.UnloadModelKeepMeshes(
        model.*,
    );
}

/// Compute model bounding box limits (considers all meshes)
pub fn GetModelBoundingBox(
    model: Model,
) BoundingBox {
    var out: BoundingBox = undefined;
    mGetModelBoundingBox(
        @ptrCast([*c]raylib.BoundingBox, &out),
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
    );
    return out;
}

export fn mGetModelBoundingBox(
    out: [*c]raylib.BoundingBox,
    model: [*c]raylib.Model,
) void {
    out.* = raylib.GetModelBoundingBox(
        model.*,
    );
}

/// Draw a model (with texture if set)
pub fn DrawModel(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {
    mDrawModel(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawModel(
    model: [*c]raylib.Model,
    position: [*c]raylib.Vector3,
    scale: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawModel(
        model.*,
        position.*,
        scale,
        tint.*,
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
    mDrawModelEx(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&rotationAxis)),
        rotationAngle,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&scale)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawModelEx(
    model: [*c]raylib.Model,
    position: [*c]raylib.Vector3,
    rotationAxis: [*c]raylib.Vector3,
    rotationAngle: f32,
    scale: [*c]raylib.Vector3,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawModelEx(
        model.*,
        position.*,
        rotationAxis.*,
        rotationAngle,
        scale.*,
        tint.*,
    );
}

/// Draw a model wires (with texture if set)
pub fn DrawModelWires(
    model: Model,
    position: Vector3,
    scale: f32,
    tint: Color,
) void {
    mDrawModelWires(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        scale,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawModelWires(
    model: [*c]raylib.Model,
    position: [*c]raylib.Vector3,
    scale: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawModelWires(
        model.*,
        position.*,
        scale,
        tint.*,
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
    mDrawModelWiresEx(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&rotationAxis)),
        rotationAngle,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&scale)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawModelWiresEx(
    model: [*c]raylib.Model,
    position: [*c]raylib.Vector3,
    rotationAxis: [*c]raylib.Vector3,
    rotationAngle: f32,
    scale: [*c]raylib.Vector3,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawModelWiresEx(
        model.*,
        position.*,
        rotationAxis.*,
        rotationAngle,
        scale.*,
        tint.*,
    );
}

/// Draw bounding box (wires)
pub fn DrawBoundingBox(
    box: BoundingBox,
    color: Color,
) void {
    mDrawBoundingBox(
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&color)),
    );
}

export fn mDrawBoundingBox(
    box: [*c]raylib.BoundingBox,
    color: [*c]raylib.Color,
) void {
    raylib.DrawBoundingBox(
        box.*,
        color.*,
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
    mDrawBillboard(
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        size,
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawBillboard(
    camera: [*c]raylib.Camera3D,
    texture: [*c]raylib.Texture2D,
    position: [*c]raylib.Vector3,
    size: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawBillboard(
        camera.*,
        texture.*,
        position.*,
        size,
        tint.*,
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
    mDrawBillboardRec(
        @intToPtr([*c]raylib.Camera3D, @ptrToInt(&camera)),
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
        @intToPtr([*c]raylib.Rectangle, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&position)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&size)),
        @intToPtr([*c]raylib.Color, @ptrToInt(&tint)),
    );
}

export fn mDrawBillboardRec(
    camera: [*c]raylib.Camera3D,
    texture: [*c]raylib.Texture2D,
    source: [*c]raylib.Rectangle,
    position: [*c]raylib.Vector3,
    size: [*c]raylib.Vector2,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawBillboardRec(
        camera.*,
        texture.*,
        source.*,
        position.*,
        size.*,
        tint.*,
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
    mDrawBillboardPro(
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

export fn mDrawBillboardPro(
    camera: [*c]raylib.Camera3D,
    texture: [*c]raylib.Texture2D,
    source: [*c]raylib.Rectangle,
    position: [*c]raylib.Vector3,
    up: [*c]raylib.Vector3,
    size: [*c]raylib.Vector2,
    origin: [*c]raylib.Vector2,
    rotation: f32,
    tint: [*c]raylib.Color,
) void {
    raylib.DrawBillboardPro(
        camera.*,
        texture.*,
        source.*,
        position.*,
        up.*,
        size.*,
        origin.*,
        rotation,
        tint.*,
    );
}

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
pub fn UploadMesh(
    mesh: [*]Mesh,
    dynamic: bool,
) void {
    mUploadMesh(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(mesh)),
        dynamic,
    );
}

export fn mUploadMesh(
    mesh: [*c]raylib.Mesh,
    dynamic: bool,
) void {
    raylib.UploadMesh(
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
    mUpdateMeshBuffer(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        index,
        @ptrCast([*c]anyopaque, data),
        dataSize,
        offset,
    );
}

export fn mUpdateMeshBuffer(
    mesh: [*c]raylib.Mesh,
    index: i32,
    data: *anyopaque,
    dataSize: i32,
    offset: i32,
) void {
    raylib.UpdateMeshBuffer(
        mesh.*,
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
    mUnloadMesh(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
    );
}

export fn mUnloadMesh(
    mesh: [*c]raylib.Mesh,
) void {
    raylib.UnloadMesh(
        mesh.*,
    );
}

/// Draw a 3d mesh with material and transform
pub fn DrawMesh(
    mesh: Mesh,
    material: Material,
    transform: Matrix,
) void {
    mDrawMesh(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]raylib.Material, @ptrToInt(&material)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&transform)),
    );
}

export fn mDrawMesh(
    mesh: [*c]raylib.Mesh,
    material: [*c]raylib.Material,
    transform: [*c]raylib.Matrix,
) void {
    raylib.DrawMesh(
        mesh.*,
        material.*,
        transform.*,
    );
}

/// Draw multiple mesh instances with material and different transforms
pub fn DrawMeshInstanced(
    mesh: Mesh,
    material: Material,
    transforms: [*]const Matrix,
    instances: i32,
) void {
    mDrawMeshInstanced(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]raylib.Material, @ptrToInt(&material)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(transforms)),
        instances,
    );
}

export fn mDrawMeshInstanced(
    mesh: [*c]raylib.Mesh,
    material: [*c]raylib.Material,
    transforms: [*c]raylib.Matrix,
    instances: i32,
) void {
    raylib.DrawMeshInstanced(
        mesh.*,
        material.*,
        transforms,
        instances,
    );
}

/// Export mesh data to file, returns true on success
pub fn ExportMesh(
    mesh: Mesh,
    fileName: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mExportMesh(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mExportMesh(
    out: [*c]bool,
    mesh: [*c]raylib.Mesh,
    fileName: [*c]const u8,
) void {
    out.* = raylib.ExportMesh(
        mesh.*,
        fileName,
    );
}

/// Compute mesh bounding box limits
pub fn GetMeshBoundingBox(
    mesh: Mesh,
) BoundingBox {
    var out: BoundingBox = undefined;
    mGetMeshBoundingBox(
        @ptrCast([*c]raylib.BoundingBox, &out),
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
    );
    return out;
}

export fn mGetMeshBoundingBox(
    out: [*c]raylib.BoundingBox,
    mesh: [*c]raylib.Mesh,
) void {
    out.* = raylib.GetMeshBoundingBox(
        mesh.*,
    );
}

/// Compute mesh tangents
pub fn GenMeshTangents(
    mesh: [*]Mesh,
) void {
    mGenMeshTangents(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(mesh)),
    );
}

export fn mGenMeshTangents(
    mesh: [*c]raylib.Mesh,
) void {
    raylib.GenMeshTangents(
        mesh,
    );
}

/// Compute mesh binormals
pub fn GenMeshBinormals(
    mesh: [*]Mesh,
) void {
    mGenMeshBinormals(
        @intToPtr([*c]raylib.Mesh, @ptrToInt(mesh)),
    );
}

export fn mGenMeshBinormals(
    mesh: [*c]raylib.Mesh,
) void {
    raylib.GenMeshBinormals(
        mesh,
    );
}

/// Generate polygonal mesh
pub fn GenMeshPoly(
    sides: i32,
    radius: f32,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshPoly(
        @ptrCast([*c]raylib.Mesh, &out),
        sides,
        radius,
    );
    return out;
}

export fn mGenMeshPoly(
    out: [*c]raylib.Mesh,
    sides: i32,
    radius: f32,
) void {
    out.* = raylib.GenMeshPoly(
        sides,
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
    var out: Mesh = undefined;
    mGenMeshPlane(
        @ptrCast([*c]raylib.Mesh, &out),
        width,
        length,
        resX,
        resZ,
    );
    return out;
}

export fn mGenMeshPlane(
    out: [*c]raylib.Mesh,
    width: f32,
    length: f32,
    resX: i32,
    resZ: i32,
) void {
    out.* = raylib.GenMeshPlane(
        width,
        length,
        resX,
        resZ,
    );
}

/// Generate cuboid mesh
pub fn GenMeshCube(
    width: f32,
    height: f32,
    length: f32,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshCube(
        @ptrCast([*c]raylib.Mesh, &out),
        width,
        height,
        length,
    );
    return out;
}

export fn mGenMeshCube(
    out: [*c]raylib.Mesh,
    width: f32,
    height: f32,
    length: f32,
) void {
    out.* = raylib.GenMeshCube(
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
    var out: Mesh = undefined;
    mGenMeshSphere(
        @ptrCast([*c]raylib.Mesh, &out),
        radius,
        rings,
        slices,
    );
    return out;
}

export fn mGenMeshSphere(
    out: [*c]raylib.Mesh,
    radius: f32,
    rings: i32,
    slices: i32,
) void {
    out.* = raylib.GenMeshSphere(
        radius,
        rings,
        slices,
    );
}

/// Generate half-sphere mesh (no bottom cap)
pub fn GenMeshHemiSphere(
    radius: f32,
    rings: i32,
    slices: i32,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshHemiSphere(
        @ptrCast([*c]raylib.Mesh, &out),
        radius,
        rings,
        slices,
    );
    return out;
}

export fn mGenMeshHemiSphere(
    out: [*c]raylib.Mesh,
    radius: f32,
    rings: i32,
    slices: i32,
) void {
    out.* = raylib.GenMeshHemiSphere(
        radius,
        rings,
        slices,
    );
}

/// Generate cylinder mesh
pub fn GenMeshCylinder(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshCylinder(
        @ptrCast([*c]raylib.Mesh, &out),
        radius,
        height,
        slices,
    );
    return out;
}

export fn mGenMeshCylinder(
    out: [*c]raylib.Mesh,
    radius: f32,
    height: f32,
    slices: i32,
) void {
    out.* = raylib.GenMeshCylinder(
        radius,
        height,
        slices,
    );
}

/// Generate cone/pyramid mesh
pub fn GenMeshCone(
    radius: f32,
    height: f32,
    slices: i32,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshCone(
        @ptrCast([*c]raylib.Mesh, &out),
        radius,
        height,
        slices,
    );
    return out;
}

export fn mGenMeshCone(
    out: [*c]raylib.Mesh,
    radius: f32,
    height: f32,
    slices: i32,
) void {
    out.* = raylib.GenMeshCone(
        radius,
        height,
        slices,
    );
}

/// Generate torus mesh
pub fn GenMeshTorus(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshTorus(
        @ptrCast([*c]raylib.Mesh, &out),
        radius,
        size,
        radSeg,
        sides,
    );
    return out;
}

export fn mGenMeshTorus(
    out: [*c]raylib.Mesh,
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) void {
    out.* = raylib.GenMeshTorus(
        radius,
        size,
        radSeg,
        sides,
    );
}

/// Generate trefoil knot mesh
pub fn GenMeshKnot(
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshKnot(
        @ptrCast([*c]raylib.Mesh, &out),
        radius,
        size,
        radSeg,
        sides,
    );
    return out;
}

export fn mGenMeshKnot(
    out: [*c]raylib.Mesh,
    radius: f32,
    size: f32,
    radSeg: i32,
    sides: i32,
) void {
    out.* = raylib.GenMeshKnot(
        radius,
        size,
        radSeg,
        sides,
    );
}

/// Generate heightmap mesh from image data
pub fn GenMeshHeightmap(
    heightmap: Image,
    size: Vector3,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshHeightmap(
        @ptrCast([*c]raylib.Mesh, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&heightmap)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&size)),
    );
    return out;
}

export fn mGenMeshHeightmap(
    out: [*c]raylib.Mesh,
    heightmap: [*c]raylib.Image,
    size: [*c]raylib.Vector3,
) void {
    out.* = raylib.GenMeshHeightmap(
        heightmap.*,
        size.*,
    );
}

/// Generate cubes-based map mesh from image data
pub fn GenMeshCubicmap(
    cubicmap: Image,
    cubeSize: Vector3,
) Mesh {
    var out: Mesh = undefined;
    mGenMeshCubicmap(
        @ptrCast([*c]raylib.Mesh, &out),
        @intToPtr([*c]raylib.Image, @ptrToInt(&cubicmap)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&cubeSize)),
    );
    return out;
}

export fn mGenMeshCubicmap(
    out: [*c]raylib.Mesh,
    cubicmap: [*c]raylib.Image,
    cubeSize: [*c]raylib.Vector3,
) void {
    out.* = raylib.GenMeshCubicmap(
        cubicmap.*,
        cubeSize.*,
    );
}

/// Load materials from model file
pub fn LoadMaterials(
    fileName: [*:0]const u8,
    materialCount: [*]i32,
) [*]const Material {
    return @ptrCast(
        [*]Material,
        mLoadMaterials(
            @intToPtr([*c]const u8, @ptrToInt(fileName)),
            @ptrCast([*c]i32, materialCount),
        ),
    );
}

export fn mLoadMaterials(
    fileName: [*c]const u8,
    materialCount: [*c]i32,
) [*c]const raylib.Material {
    return raylib.LoadMaterials(
        fileName,
        materialCount,
    );
}

/// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub fn LoadMaterialDefault() Material {
    var out: Material = undefined;
    mLoadMaterialDefault(
        @ptrCast([*c]raylib.Material, &out),
    );
    return out;
}

export fn mLoadMaterialDefault(
    out: [*c]raylib.Material,
) void {
    out.* = raylib.LoadMaterialDefault();
}

/// Unload material from GPU memory (VRAM)
pub fn UnloadMaterial(
    material: Material,
) void {
    mUnloadMaterial(
        @intToPtr([*c]raylib.Material, @ptrToInt(&material)),
    );
}

export fn mUnloadMaterial(
    material: [*c]raylib.Material,
) void {
    raylib.UnloadMaterial(
        material.*,
    );
}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn SetMaterialTexture(
    material: [*]Material,
    mapType: i32,
    texture: Texture2D,
) void {
    mSetMaterialTexture(
        @intToPtr([*c]raylib.Material, @ptrToInt(material)),
        mapType,
        @intToPtr([*c]raylib.Texture2D, @ptrToInt(&texture)),
    );
}

export fn mSetMaterialTexture(
    material: [*c]raylib.Material,
    mapType: i32,
    texture: [*c]raylib.Texture2D,
) void {
    raylib.SetMaterialTexture(
        material,
        mapType,
        texture.*,
    );
}

/// Set material for a mesh
pub fn SetModelMeshMaterial(
    model: [*]Model,
    meshId: i32,
    materialId: i32,
) void {
    mSetModelMeshMaterial(
        @intToPtr([*c]raylib.Model, @ptrToInt(model)),
        meshId,
        materialId,
    );
}

export fn mSetModelMeshMaterial(
    model: [*c]raylib.Model,
    meshId: i32,
    materialId: i32,
) void {
    raylib.SetModelMeshMaterial(
        model,
        meshId,
        materialId,
    );
}

/// Load model animations from file
pub fn LoadModelAnimations(
    fileName: [*:0]const u8,
    animCount: [*]u32,
) [*]const ModelAnimation {
    return @ptrCast(
        [*]ModelAnimation,
        mLoadModelAnimations(
            @intToPtr([*c]const u8, @ptrToInt(fileName)),
            @ptrCast([*c]u32, animCount),
        ),
    );
}

export fn mLoadModelAnimations(
    fileName: [*c]const u8,
    animCount: [*c]u32,
) [*c]const raylib.ModelAnimation {
    return raylib.LoadModelAnimations(
        fileName,
        animCount,
    );
}

/// Update model animation pose
pub fn UpdateModelAnimation(
    model: Model,
    anim: ModelAnimation,
    frame: i32,
) void {
    mUpdateModelAnimation(
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.ModelAnimation, @ptrToInt(&anim)),
        frame,
    );
}

export fn mUpdateModelAnimation(
    model: [*c]raylib.Model,
    anim: [*c]raylib.ModelAnimation,
    frame: i32,
) void {
    raylib.UpdateModelAnimation(
        model.*,
        anim.*,
        frame,
    );
}

/// Unload animation data
pub fn UnloadModelAnimation(
    anim: ModelAnimation,
) void {
    mUnloadModelAnimation(
        @intToPtr([*c]raylib.ModelAnimation, @ptrToInt(&anim)),
    );
}

export fn mUnloadModelAnimation(
    anim: [*c]raylib.ModelAnimation,
) void {
    raylib.UnloadModelAnimation(
        anim.*,
    );
}

/// Unload animation array data
pub fn UnloadModelAnimations(
    animations: [*]ModelAnimation,
    count: u32,
) void {
    mUnloadModelAnimations(
        @intToPtr([*c]raylib.ModelAnimation, @ptrToInt(animations)),
        count,
    );
}

export fn mUnloadModelAnimations(
    animations: [*c]raylib.ModelAnimation,
    count: u32,
) void {
    raylib.UnloadModelAnimations(
        animations,
        count,
    );
}

/// Check model animation skeleton match
pub fn IsModelAnimationValid(
    model: Model,
    anim: ModelAnimation,
) bool {
    var out: bool = undefined;
    mIsModelAnimationValid(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Model, @ptrToInt(&model)),
        @intToPtr([*c]raylib.ModelAnimation, @ptrToInt(&anim)),
    );
    return out;
}

export fn mIsModelAnimationValid(
    out: [*c]bool,
    model: [*c]raylib.Model,
    anim: [*c]raylib.ModelAnimation,
) void {
    out.* = raylib.IsModelAnimationValid(
        model.*,
        anim.*,
    );
}

/// Check collision between two spheres
pub fn CheckCollisionSpheres(
    center1: Vector3,
    radius1: f32,
    center2: Vector3,
    radius2: f32,
) bool {
    var out: bool = undefined;
    mCheckCollisionSpheres(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center1)),
        radius1,
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center2)),
        radius2,
    );
    return out;
}

export fn mCheckCollisionSpheres(
    out: [*c]bool,
    center1: [*c]raylib.Vector3,
    radius1: f32,
    center2: [*c]raylib.Vector3,
    radius2: f32,
) void {
    out.* = raylib.CheckCollisionSpheres(
        center1.*,
        radius1,
        center2.*,
        radius2,
    );
}

/// Check collision between two bounding boxes
pub fn CheckCollisionBoxes(
    box1: BoundingBox,
    box2: BoundingBox,
) bool {
    var out: bool = undefined;
    mCheckCollisionBoxes(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box1)),
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box2)),
    );
    return out;
}

export fn mCheckCollisionBoxes(
    out: [*c]bool,
    box1: [*c]raylib.BoundingBox,
    box2: [*c]raylib.BoundingBox,
) void {
    out.* = raylib.CheckCollisionBoxes(
        box1.*,
        box2.*,
    );
}

/// Check collision between box and sphere
pub fn CheckCollisionBoxSphere(
    box: BoundingBox,
    center: Vector3,
    radius: f32,
) bool {
    var out: bool = undefined;
    mCheckCollisionBoxSphere(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center)),
        radius,
    );
    return out;
}

export fn mCheckCollisionBoxSphere(
    out: [*c]bool,
    box: [*c]raylib.BoundingBox,
    center: [*c]raylib.Vector3,
    radius: f32,
) void {
    out.* = raylib.CheckCollisionBoxSphere(
        box.*,
        center.*,
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
    mGetRayCollisionSphere(
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&center)),
        radius,
    );
    return out;
}

export fn mGetRayCollisionSphere(
    out: [*c]raylib.RayCollision,
    ray: [*c]raylib.Ray,
    center: [*c]raylib.Vector3,
    radius: f32,
) void {
    out.* = raylib.GetRayCollisionSphere(
        ray.*,
        center.*,
        radius,
    );
}

/// Get collision info between ray and box
pub fn GetRayCollisionBox(
    ray: Ray,
    box: BoundingBox,
) RayCollision {
    var out: RayCollision = undefined;
    mGetRayCollisionBox(
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.BoundingBox, @ptrToInt(&box)),
    );
    return out;
}

export fn mGetRayCollisionBox(
    out: [*c]raylib.RayCollision,
    ray: [*c]raylib.Ray,
    box: [*c]raylib.BoundingBox,
) void {
    out.* = raylib.GetRayCollisionBox(
        ray.*,
        box.*,
    );
}

/// Get collision info between ray and mesh
pub fn GetRayCollisionMesh(
    ray: Ray,
    mesh: Mesh,
    transform: Matrix,
) RayCollision {
    var out: RayCollision = undefined;
    mGetRayCollisionMesh(
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Mesh, @ptrToInt(&mesh)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&transform)),
    );
    return out;
}

export fn mGetRayCollisionMesh(
    out: [*c]raylib.RayCollision,
    ray: [*c]raylib.Ray,
    mesh: [*c]raylib.Mesh,
    transform: [*c]raylib.Matrix,
) void {
    out.* = raylib.GetRayCollisionMesh(
        ray.*,
        mesh.*,
        transform.*,
    );
}

/// Get collision info between ray and triangle
pub fn GetRayCollisionTriangle(
    ray: Ray,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
) RayCollision {
    var out: RayCollision = undefined;
    mGetRayCollisionTriangle(
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p2)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p3)),
    );
    return out;
}

export fn mGetRayCollisionTriangle(
    out: [*c]raylib.RayCollision,
    ray: [*c]raylib.Ray,
    p1: [*c]raylib.Vector3,
    p2: [*c]raylib.Vector3,
    p3: [*c]raylib.Vector3,
) void {
    out.* = raylib.GetRayCollisionTriangle(
        ray.*,
        p1.*,
        p2.*,
        p3.*,
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
    var out: RayCollision = undefined;
    mGetRayCollisionQuad(
        @ptrCast([*c]raylib.RayCollision, &out),
        @intToPtr([*c]raylib.Ray, @ptrToInt(&ray)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p2)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p3)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p4)),
    );
    return out;
}

export fn mGetRayCollisionQuad(
    out: [*c]raylib.RayCollision,
    ray: [*c]raylib.Ray,
    p1: [*c]raylib.Vector3,
    p2: [*c]raylib.Vector3,
    p3: [*c]raylib.Vector3,
    p4: [*c]raylib.Vector3,
) void {
    out.* = raylib.GetRayCollisionQuad(
        ray.*,
        p1.*,
        p2.*,
        p3.*,
        p4.*,
    );
}

/// Initialize audio device and context
pub fn InitAudioDevice() void {
    mInitAudioDevice();
}

export fn mInitAudioDevice() void {
    raylib.InitAudioDevice();
}

/// Close the audio device and context
pub fn CloseAudioDevice() void {
    mCloseAudioDevice();
}

export fn mCloseAudioDevice() void {
    raylib.CloseAudioDevice();
}

/// Check if audio device has been initialized successfully
pub fn IsAudioDeviceReady() bool {
    var out: bool = undefined;
    mIsAudioDeviceReady(
        @ptrCast([*c]bool, &out),
    );
    return out;
}

export fn mIsAudioDeviceReady(
    out: [*c]bool,
) void {
    out.* = raylib.IsAudioDeviceReady();
}

/// Set master volume (listener)
pub fn SetMasterVolume(
    volume: f32,
) void {
    mSetMasterVolume(
        volume,
    );
}

export fn mSetMasterVolume(
    volume: f32,
) void {
    raylib.SetMasterVolume(
        volume,
    );
}

/// Load wave data from file
pub fn LoadWave(
    fileName: [*:0]const u8,
) Wave {
    var out: Wave = undefined;
    mLoadWave(
        @ptrCast([*c]raylib.Wave, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mLoadWave(
    out: [*c]raylib.Wave,
    fileName: [*c]const u8,
) void {
    out.* = raylib.LoadWave(
        fileName,
    );
}

/// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
pub fn LoadWaveFromMemory(
    fileType: [*:0]const u8,
    fileData: [*:0]const u8,
    dataSize: i32,
) Wave {
    var out: Wave = undefined;
    mLoadWaveFromMemory(
        @ptrCast([*c]raylib.Wave, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(fileData)),
        dataSize,
    );
    return out;
}

export fn mLoadWaveFromMemory(
    out: [*c]raylib.Wave,
    fileType: [*c]const u8,
    fileData: [*c]const u8,
    dataSize: i32,
) void {
    out.* = raylib.LoadWaveFromMemory(
        fileType,
        fileData,
        dataSize,
    );
}

/// Load sound from file
pub fn LoadSound(
    fileName: [*:0]const u8,
) Sound {
    var out: Sound = undefined;
    mLoadSound(
        @ptrCast([*c]raylib.Sound, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mLoadSound(
    out: [*c]raylib.Sound,
    fileName: [*c]const u8,
) void {
    out.* = raylib.LoadSound(
        fileName,
    );
}

/// Load sound from wave data
pub fn LoadSoundFromWave(
    wave: Wave,
) Sound {
    var out: Sound = undefined;
    mLoadSoundFromWave(
        @ptrCast([*c]raylib.Sound, &out),
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
    );
    return out;
}

export fn mLoadSoundFromWave(
    out: [*c]raylib.Sound,
    wave: [*c]raylib.Wave,
) void {
    out.* = raylib.LoadSoundFromWave(
        wave.*,
    );
}

/// Update sound buffer with new data
pub fn UpdateSound(
    sound: Sound,
    data: *anyopaque,
    sampleCount: i32,
) void {
    mUpdateSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        @ptrCast([*c]anyopaque, data),
        sampleCount,
    );
}

export fn mUpdateSound(
    sound: [*c]raylib.Sound,
    data: *anyopaque,
    sampleCount: i32,
) void {
    raylib.UpdateSound(
        sound.*,
        data,
        sampleCount,
    );
}

/// Unload wave data
pub fn UnloadWave(
    wave: Wave,
) void {
    mUnloadWave(
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
    );
}

export fn mUnloadWave(
    wave: [*c]raylib.Wave,
) void {
    raylib.UnloadWave(
        wave.*,
    );
}

/// Unload sound
pub fn UnloadSound(
    sound: Sound,
) void {
    mUnloadSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

export fn mUnloadSound(
    sound: [*c]raylib.Sound,
) void {
    raylib.UnloadSound(
        sound.*,
    );
}

/// Export wave data to file, returns true on success
pub fn ExportWave(
    wave: Wave,
    fileName: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mExportWave(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mExportWave(
    out: [*c]bool,
    wave: [*c]raylib.Wave,
    fileName: [*c]const u8,
) void {
    out.* = raylib.ExportWave(
        wave.*,
        fileName,
    );
}

/// Export wave sample data to code (.h), returns true on success
pub fn ExportWaveAsCode(
    wave: Wave,
    fileName: [*:0]const u8,
) bool {
    var out: bool = undefined;
    mExportWaveAsCode(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mExportWaveAsCode(
    out: [*c]bool,
    wave: [*c]raylib.Wave,
    fileName: [*c]const u8,
) void {
    out.* = raylib.ExportWaveAsCode(
        wave.*,
        fileName,
    );
}

/// Play a sound
pub fn PlaySound(
    sound: Sound,
) void {
    mPlaySound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

export fn mPlaySound(
    sound: [*c]raylib.Sound,
) void {
    raylib.PlaySound(
        sound.*,
    );
}

/// Stop playing a sound
pub fn StopSound(
    sound: Sound,
) void {
    mStopSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

export fn mStopSound(
    sound: [*c]raylib.Sound,
) void {
    raylib.StopSound(
        sound.*,
    );
}

/// Pause a sound
pub fn PauseSound(
    sound: Sound,
) void {
    mPauseSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

export fn mPauseSound(
    sound: [*c]raylib.Sound,
) void {
    raylib.PauseSound(
        sound.*,
    );
}

/// Resume a paused sound
pub fn ResumeSound(
    sound: Sound,
) void {
    mResumeSound(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

export fn mResumeSound(
    sound: [*c]raylib.Sound,
) void {
    raylib.ResumeSound(
        sound.*,
    );
}

/// Play a sound (using multichannel buffer pool)
pub fn PlaySoundMulti(
    sound: Sound,
) void {
    mPlaySoundMulti(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
}

export fn mPlaySoundMulti(
    sound: [*c]raylib.Sound,
) void {
    raylib.PlaySoundMulti(
        sound.*,
    );
}

/// Stop any sound playing (using multichannel buffer pool)
pub fn StopSoundMulti() void {
    mStopSoundMulti();
}

export fn mStopSoundMulti() void {
    raylib.StopSoundMulti();
}

/// Get number of sounds playing in the multichannel
pub fn GetSoundsPlaying() i32 {
    var out: i32 = undefined;
    mGetSoundsPlaying(
        @ptrCast([*c]i32, &out),
    );
    return out;
}

export fn mGetSoundsPlaying(
    out: [*c]i32,
) void {
    out.* = raylib.GetSoundsPlaying();
}

/// Check if a sound is currently playing
pub fn IsSoundPlaying(
    sound: Sound,
) bool {
    var out: bool = undefined;
    mIsSoundPlaying(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
    );
    return out;
}

export fn mIsSoundPlaying(
    out: [*c]bool,
    sound: [*c]raylib.Sound,
) void {
    out.* = raylib.IsSoundPlaying(
        sound.*,
    );
}

/// Set volume for a sound (1.0 is max level)
pub fn SetSoundVolume(
    sound: Sound,
    volume: f32,
) void {
    mSetSoundVolume(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        volume,
    );
}

export fn mSetSoundVolume(
    sound: [*c]raylib.Sound,
    volume: f32,
) void {
    raylib.SetSoundVolume(
        sound.*,
        volume,
    );
}

/// Set pitch for a sound (1.0 is base level)
pub fn SetSoundPitch(
    sound: Sound,
    pitch: f32,
) void {
    mSetSoundPitch(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        pitch,
    );
}

export fn mSetSoundPitch(
    sound: [*c]raylib.Sound,
    pitch: f32,
) void {
    raylib.SetSoundPitch(
        sound.*,
        pitch,
    );
}

/// Set pan for a sound (0.5 is center)
pub fn SetSoundPan(
    sound: Sound,
    pan: f32,
) void {
    mSetSoundPan(
        @intToPtr([*c]raylib.Sound, @ptrToInt(&sound)),
        pan,
    );
}

export fn mSetSoundPan(
    sound: [*c]raylib.Sound,
    pan: f32,
) void {
    raylib.SetSoundPan(
        sound.*,
        pan,
    );
}

/// Copy a wave to a new wave
pub fn WaveCopy(
    wave: Wave,
) Wave {
    var out: Wave = undefined;
    mWaveCopy(
        @ptrCast([*c]raylib.Wave, &out),
        @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
    );
    return out;
}

export fn mWaveCopy(
    out: [*c]raylib.Wave,
    wave: [*c]raylib.Wave,
) void {
    out.* = raylib.WaveCopy(
        wave.*,
    );
}

/// Crop a wave to defined samples range
pub fn WaveCrop(
    wave: [*]Wave,
    initSample: i32,
    finalSample: i32,
) void {
    mWaveCrop(
        @intToPtr([*c]raylib.Wave, @ptrToInt(wave)),
        initSample,
        finalSample,
    );
}

export fn mWaveCrop(
    wave: [*c]raylib.Wave,
    initSample: i32,
    finalSample: i32,
) void {
    raylib.WaveCrop(
        wave,
        initSample,
        finalSample,
    );
}

/// Convert wave data to desired format
pub fn WaveFormat(
    wave: [*]Wave,
    sampleRate: i32,
    sampleSize: i32,
    channels: i32,
) void {
    mWaveFormat(
        @intToPtr([*c]raylib.Wave, @ptrToInt(wave)),
        sampleRate,
        sampleSize,
        channels,
    );
}

export fn mWaveFormat(
    wave: [*c]raylib.Wave,
    sampleRate: i32,
    sampleSize: i32,
    channels: i32,
) void {
    raylib.WaveFormat(
        wave,
        sampleRate,
        sampleSize,
        channels,
    );
}

/// Load samples data from wave as a 32bit float data array
pub fn LoadWaveSamples(
    wave: Wave,
) [*]const f32 {
    return @ptrCast(
        [*]f32,
        mLoadWaveSamples(
            @intToPtr([*c]raylib.Wave, @ptrToInt(&wave)),
        ),
    );
}

export fn mLoadWaveSamples(
    wave: [*c]raylib.Wave,
) [*c]const f32 {
    return raylib.LoadWaveSamples(
        wave.*,
    );
}

/// Unload samples data loaded with LoadWaveSamples()
pub fn UnloadWaveSamples(
    samples: [*]f32,
) void {
    mUnloadWaveSamples(
        @ptrCast([*c]f32, samples),
    );
}

export fn mUnloadWaveSamples(
    samples: [*c]f32,
) void {
    raylib.UnloadWaveSamples(
        samples,
    );
}

/// Load music stream from file
pub fn LoadMusicStream(
    fileName: [*:0]const u8,
) Music {
    var out: Music = undefined;
    mLoadMusicStream(
        @ptrCast([*c]raylib.Music, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileName)),
    );
    return out;
}

export fn mLoadMusicStream(
    out: [*c]raylib.Music,
    fileName: [*c]const u8,
) void {
    out.* = raylib.LoadMusicStream(
        fileName,
    );
}

/// Load music stream from data
pub fn LoadMusicStreamFromMemory(
    fileType: [*:0]const u8,
    data: [*:0]const u8,
    dataSize: i32,
) Music {
    var out: Music = undefined;
    mLoadMusicStreamFromMemory(
        @ptrCast([*c]raylib.Music, &out),
        @intToPtr([*c]const u8, @ptrToInt(fileType)),
        @intToPtr([*c]const u8, @ptrToInt(data)),
        dataSize,
    );
    return out;
}

export fn mLoadMusicStreamFromMemory(
    out: [*c]raylib.Music,
    fileType: [*c]const u8,
    data: [*c]const u8,
    dataSize: i32,
) void {
    out.* = raylib.LoadMusicStreamFromMemory(
        fileType,
        data,
        dataSize,
    );
}

/// Unload music stream
pub fn UnloadMusicStream(
    music: Music,
) void {
    mUnloadMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

export fn mUnloadMusicStream(
    music: [*c]raylib.Music,
) void {
    raylib.UnloadMusicStream(
        music.*,
    );
}

/// Start music playing
pub fn PlayMusicStream(
    music: Music,
) void {
    mPlayMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

export fn mPlayMusicStream(
    music: [*c]raylib.Music,
) void {
    raylib.PlayMusicStream(
        music.*,
    );
}

/// Check if music is playing
pub fn IsMusicStreamPlaying(
    music: Music,
) bool {
    var out: bool = undefined;
    mIsMusicStreamPlaying(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
    return out;
}

export fn mIsMusicStreamPlaying(
    out: [*c]bool,
    music: [*c]raylib.Music,
) void {
    out.* = raylib.IsMusicStreamPlaying(
        music.*,
    );
}

/// Updates buffers for music streaming
pub fn UpdateMusicStream(
    music: Music,
) void {
    mUpdateMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

export fn mUpdateMusicStream(
    music: [*c]raylib.Music,
) void {
    raylib.UpdateMusicStream(
        music.*,
    );
}

/// Stop music playing
pub fn StopMusicStream(
    music: Music,
) void {
    mStopMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

export fn mStopMusicStream(
    music: [*c]raylib.Music,
) void {
    raylib.StopMusicStream(
        music.*,
    );
}

/// Pause music playing
pub fn PauseMusicStream(
    music: Music,
) void {
    mPauseMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

export fn mPauseMusicStream(
    music: [*c]raylib.Music,
) void {
    raylib.PauseMusicStream(
        music.*,
    );
}

/// Resume playing paused music
pub fn ResumeMusicStream(
    music: Music,
) void {
    mResumeMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
}

export fn mResumeMusicStream(
    music: [*c]raylib.Music,
) void {
    raylib.ResumeMusicStream(
        music.*,
    );
}

/// Seek music to a position (in seconds)
pub fn SeekMusicStream(
    music: Music,
    position: f32,
) void {
    mSeekMusicStream(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        position,
    );
}

export fn mSeekMusicStream(
    music: [*c]raylib.Music,
    position: f32,
) void {
    raylib.SeekMusicStream(
        music.*,
        position,
    );
}

/// Set volume for music (1.0 is max level)
pub fn SetMusicVolume(
    music: Music,
    volume: f32,
) void {
    mSetMusicVolume(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        volume,
    );
}

export fn mSetMusicVolume(
    music: [*c]raylib.Music,
    volume: f32,
) void {
    raylib.SetMusicVolume(
        music.*,
        volume,
    );
}

/// Set pitch for a music (1.0 is base level)
pub fn SetMusicPitch(
    music: Music,
    pitch: f32,
) void {
    mSetMusicPitch(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        pitch,
    );
}

export fn mSetMusicPitch(
    music: [*c]raylib.Music,
    pitch: f32,
) void {
    raylib.SetMusicPitch(
        music.*,
        pitch,
    );
}

/// Set pan for a music (0.5 is center)
pub fn SetMusicPan(
    music: Music,
    pan: f32,
) void {
    mSetMusicPan(
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
        pan,
    );
}

export fn mSetMusicPan(
    music: [*c]raylib.Music,
    pan: f32,
) void {
    raylib.SetMusicPan(
        music.*,
        pan,
    );
}

/// Get music time length (in seconds)
pub fn GetMusicTimeLength(
    music: Music,
) f32 {
    var out: f32 = undefined;
    mGetMusicTimeLength(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
    return out;
}

export fn mGetMusicTimeLength(
    out: [*c]f32,
    music: [*c]raylib.Music,
) void {
    out.* = raylib.GetMusicTimeLength(
        music.*,
    );
}

/// Get current music time played (in seconds)
pub fn GetMusicTimePlayed(
    music: Music,
) f32 {
    var out: f32 = undefined;
    mGetMusicTimePlayed(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Music, @ptrToInt(&music)),
    );
    return out;
}

export fn mGetMusicTimePlayed(
    out: [*c]f32,
    music: [*c]raylib.Music,
) void {
    out.* = raylib.GetMusicTimePlayed(
        music.*,
    );
}

/// Load audio stream (to stream raw audio pcm data)
pub fn LoadAudioStream(
    sampleRate: u32,
    sampleSize: u32,
    channels: u32,
) AudioStream {
    var out: AudioStream = undefined;
    mLoadAudioStream(
        @ptrCast([*c]raylib.AudioStream, &out),
        sampleRate,
        sampleSize,
        channels,
    );
    return out;
}

export fn mLoadAudioStream(
    out: [*c]raylib.AudioStream,
    sampleRate: u32,
    sampleSize: u32,
    channels: u32,
) void {
    out.* = raylib.LoadAudioStream(
        sampleRate,
        sampleSize,
        channels,
    );
}

/// Unload audio stream and free memory
pub fn UnloadAudioStream(
    stream: AudioStream,
) void {
    mUnloadAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

export fn mUnloadAudioStream(
    stream: [*c]raylib.AudioStream,
) void {
    raylib.UnloadAudioStream(
        stream.*,
    );
}

/// Update audio stream buffers with data
pub fn UpdateAudioStream(
    stream: AudioStream,
    data: *anyopaque,
    frameCount: i32,
) void {
    mUpdateAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        @ptrCast([*c]anyopaque, data),
        frameCount,
    );
}

export fn mUpdateAudioStream(
    stream: [*c]raylib.AudioStream,
    data: *anyopaque,
    frameCount: i32,
) void {
    raylib.UpdateAudioStream(
        stream.*,
        data,
        frameCount,
    );
}

/// Check if any audio stream buffers requires refill
pub fn IsAudioStreamProcessed(
    stream: AudioStream,
) bool {
    var out: bool = undefined;
    mIsAudioStreamProcessed(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
    return out;
}

export fn mIsAudioStreamProcessed(
    out: [*c]bool,
    stream: [*c]raylib.AudioStream,
) void {
    out.* = raylib.IsAudioStreamProcessed(
        stream.*,
    );
}

/// Play audio stream
pub fn PlayAudioStream(
    stream: AudioStream,
) void {
    mPlayAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

export fn mPlayAudioStream(
    stream: [*c]raylib.AudioStream,
) void {
    raylib.PlayAudioStream(
        stream.*,
    );
}

/// Pause audio stream
pub fn PauseAudioStream(
    stream: AudioStream,
) void {
    mPauseAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

export fn mPauseAudioStream(
    stream: [*c]raylib.AudioStream,
) void {
    raylib.PauseAudioStream(
        stream.*,
    );
}

/// Resume audio stream
pub fn ResumeAudioStream(
    stream: AudioStream,
) void {
    mResumeAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

export fn mResumeAudioStream(
    stream: [*c]raylib.AudioStream,
) void {
    raylib.ResumeAudioStream(
        stream.*,
    );
}

/// Check if audio stream is playing
pub fn IsAudioStreamPlaying(
    stream: AudioStream,
) bool {
    var out: bool = undefined;
    mIsAudioStreamPlaying(
        @ptrCast([*c]bool, &out),
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
    return out;
}

export fn mIsAudioStreamPlaying(
    out: [*c]bool,
    stream: [*c]raylib.AudioStream,
) void {
    out.* = raylib.IsAudioStreamPlaying(
        stream.*,
    );
}

/// Stop audio stream
pub fn StopAudioStream(
    stream: AudioStream,
) void {
    mStopAudioStream(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
    );
}

export fn mStopAudioStream(
    stream: [*c]raylib.AudioStream,
) void {
    raylib.StopAudioStream(
        stream.*,
    );
}

/// Set volume for audio stream (1.0 is max level)
pub fn SetAudioStreamVolume(
    stream: AudioStream,
    volume: f32,
) void {
    mSetAudioStreamVolume(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        volume,
    );
}

export fn mSetAudioStreamVolume(
    stream: [*c]raylib.AudioStream,
    volume: f32,
) void {
    raylib.SetAudioStreamVolume(
        stream.*,
        volume,
    );
}

/// Set pitch for audio stream (1.0 is base level)
pub fn SetAudioStreamPitch(
    stream: AudioStream,
    pitch: f32,
) void {
    mSetAudioStreamPitch(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        pitch,
    );
}

export fn mSetAudioStreamPitch(
    stream: [*c]raylib.AudioStream,
    pitch: f32,
) void {
    raylib.SetAudioStreamPitch(
        stream.*,
        pitch,
    );
}

/// Set pan for audio stream (0.5 is centered)
pub fn SetAudioStreamPan(
    stream: AudioStream,
    pan: f32,
) void {
    mSetAudioStreamPan(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        pan,
    );
}

export fn mSetAudioStreamPan(
    stream: [*c]raylib.AudioStream,
    pan: f32,
) void {
    raylib.SetAudioStreamPan(
        stream.*,
        pan,
    );
}

/// Default size for new audio streams
pub fn SetAudioStreamBufferSizeDefault(
    size: i32,
) void {
    mSetAudioStreamBufferSizeDefault(
        size,
    );
}

export fn mSetAudioStreamBufferSizeDefault(
    size: i32,
) void {
    raylib.SetAudioStreamBufferSizeDefault(
        size,
    );
}

/// Audio thread callback to request new data
pub fn SetAudioStreamCallback(
    stream: AudioStream,
    callback: AudioCallback,
) void {
    mSetAudioStreamCallback(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        callback,
    );
}

export fn mSetAudioStreamCallback(
    stream: [*c]raylib.AudioStream,
    callback: AudioCallback,
) void {
    raylib.SetAudioStreamCallback(
        stream.*,
        callback,
    );
}

/// 
pub fn AttachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    mAttachAudioStreamProcessor(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        processor,
    );
}

export fn mAttachAudioStreamProcessor(
    stream: [*c]raylib.AudioStream,
    processor: AudioCallback,
) void {
    raylib.AttachAudioStreamProcessor(
        stream.*,
        processor,
    );
}

/// 
pub fn DetachAudioStreamProcessor(
    stream: AudioStream,
    processor: AudioCallback,
) void {
    mDetachAudioStreamProcessor(
        @intToPtr([*c]raylib.AudioStream, @ptrToInt(&stream)),
        processor,
    );
}

export fn mDetachAudioStreamProcessor(
    stream: [*c]raylib.AudioStream,
    processor: AudioCallback,
) void {
    raylib.DetachAudioStreamProcessor(
        stream.*,
        processor,
    );
}

/// 
pub fn Clamp(
    value: f32,
    min: f32,
    max: f32,
) f32 {
    var out: f32 = undefined;
    mClamp(
        @ptrCast([*c]f32, &out),
        value,
        min,
        max,
    );
    return out;
}

export fn mClamp(
    out: [*c]f32,
    value: f32,
    min: f32,
    max: f32,
) void {
    out.* = raylib.Clamp(
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
    var out: f32 = undefined;
    mLerp(
        @ptrCast([*c]f32, &out),
        start,
        end,
        amount,
    );
    return out;
}

export fn mLerp(
    out: [*c]f32,
    start: f32,
    end: f32,
    amount: f32,
) void {
    out.* = raylib.Lerp(
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
    var out: f32 = undefined;
    mNormalize(
        @ptrCast([*c]f32, &out),
        value,
        start,
        end,
    );
    return out;
}

export fn mNormalize(
    out: [*c]f32,
    value: f32,
    start: f32,
    end: f32,
) void {
    out.* = raylib.Normalize(
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
    var out: f32 = undefined;
    mRemap(
        @ptrCast([*c]f32, &out),
        value,
        inputStart,
        inputEnd,
        outputStart,
        outputEnd,
    );
    return out;
}

export fn mRemap(
    out: [*c]f32,
    value: f32,
    inputStart: f32,
    inputEnd: f32,
    outputStart: f32,
    outputEnd: f32,
) void {
    out.* = raylib.Remap(
        value,
        inputStart,
        inputEnd,
        outputStart,
        outputEnd,
    );
}

/// 
pub fn Vector2Zero() Vector2 {
    var out: Vector2 = undefined;
    mVector2Zero(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mVector2Zero(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Zero();
}

/// 
pub fn Vector2One() Vector2 {
    var out: Vector2 = undefined;
    mVector2One(
        @ptrCast([*c]raylib.Vector2, &out),
    );
    return out;
}

export fn mVector2One(
    out: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2One();
}

/// 
pub fn Vector2Add(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Add(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2Add(
    out: [*c]raylib.Vector2,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Add(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2AddValue(
    v: Vector2,
    add: f32,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2AddValue(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        add,
    );
    return out;
}

export fn mVector2AddValue(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
    add: f32,
) void {
    out.* = raylib.Vector2AddValue(
        v.*,
        add,
    );
}

/// 
pub fn Vector2Subtract(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Subtract(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2Subtract(
    out: [*c]raylib.Vector2,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Subtract(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2SubtractValue(
    v: Vector2,
    sub: f32,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2SubtractValue(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        sub,
    );
    return out;
}

export fn mVector2SubtractValue(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
    sub: f32,
) void {
    out.* = raylib.Vector2SubtractValue(
        v.*,
        sub,
    );
}

/// 
pub fn Vector2Length(
    v: Vector2,
) f32 {
    var out: f32 = undefined;
    mVector2Length(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector2Length(
    out: [*c]f32,
    v: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Length(
        v.*,
    );
}

/// 
pub fn Vector2LengthSqr(
    v: Vector2,
) f32 {
    var out: f32 = undefined;
    mVector2LengthSqr(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector2LengthSqr(
    out: [*c]f32,
    v: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2LengthSqr(
        v.*,
    );
}

/// 
pub fn Vector2DotProduct(
    v1: Vector2,
    v2: Vector2,
) f32 {
    var out: f32 = undefined;
    mVector2DotProduct(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2DotProduct(
    out: [*c]f32,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2DotProduct(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2Distance(
    v1: Vector2,
    v2: Vector2,
) f32 {
    var out: f32 = undefined;
    mVector2Distance(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2Distance(
    out: [*c]f32,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Distance(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2DistanceSqr(
    v1: Vector2,
    v2: Vector2,
) f32 {
    var out: f32 = undefined;
    mVector2DistanceSqr(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2DistanceSqr(
    out: [*c]f32,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2DistanceSqr(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2Angle(
    v1: Vector2,
    v2: Vector2,
) f32 {
    var out: f32 = undefined;
    mVector2Angle(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2Angle(
    out: [*c]f32,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Angle(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2Scale(
    v: Vector2,
    scale: f32,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Scale(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        scale,
    );
    return out;
}

export fn mVector2Scale(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
    scale: f32,
) void {
    out.* = raylib.Vector2Scale(
        v.*,
        scale,
    );
}

/// 
pub fn Vector2Multiply(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Multiply(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2Multiply(
    out: [*c]raylib.Vector2,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Multiply(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2Negate(
    v: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Negate(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector2Negate(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Negate(
        v.*,
    );
}

/// 
pub fn Vector2Divide(
    v1: Vector2,
    v2: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Divide(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector2Divide(
    out: [*c]raylib.Vector2,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Divide(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector2Normalize(
    v: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Normalize(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector2Normalize(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Normalize(
        v.*,
    );
}

/// 
pub fn Vector2Transform(
    v: Vector2,
    mat: Matrix,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Transform(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mVector2Transform(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.Vector2Transform(
        v.*,
        mat.*,
    );
}

/// 
pub fn Vector2Lerp(
    v1: Vector2,
    v2: Vector2,
    amount: f32,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Lerp(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v2)),
        amount,
    );
    return out;
}

export fn mVector2Lerp(
    out: [*c]raylib.Vector2,
    v1: [*c]raylib.Vector2,
    v2: [*c]raylib.Vector2,
    amount: f32,
) void {
    out.* = raylib.Vector2Lerp(
        v1.*,
        v2.*,
        amount,
    );
}

/// 
pub fn Vector2Reflect(
    v: Vector2,
    normal: Vector2,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Reflect(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&normal)),
    );
    return out;
}

export fn mVector2Reflect(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
    normal: [*c]raylib.Vector2,
) void {
    out.* = raylib.Vector2Reflect(
        v.*,
        normal.*,
    );
}

/// 
pub fn Vector2Rotate(
    v: Vector2,
    angle: f32,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2Rotate(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        angle,
    );
    return out;
}

export fn mVector2Rotate(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
    angle: f32,
) void {
    out.* = raylib.Vector2Rotate(
        v.*,
        angle,
    );
}

/// 
pub fn Vector2MoveTowards(
    v: Vector2,
    target: Vector2,
    maxDistance: f32,
) Vector2 {
    var out: Vector2 = undefined;
    mVector2MoveTowards(
        @ptrCast([*c]raylib.Vector2, &out),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector2, @ptrToInt(&target)),
        maxDistance,
    );
    return out;
}

export fn mVector2MoveTowards(
    out: [*c]raylib.Vector2,
    v: [*c]raylib.Vector2,
    target: [*c]raylib.Vector2,
    maxDistance: f32,
) void {
    out.* = raylib.Vector2MoveTowards(
        v.*,
        target.*,
        maxDistance,
    );
}

/// 
pub fn Vector3Zero() Vector3 {
    var out: Vector3 = undefined;
    mVector3Zero(
        @ptrCast([*c]raylib.Vector3, &out),
    );
    return out;
}

export fn mVector3Zero(
    out: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Zero();
}

/// 
pub fn Vector3One() Vector3 {
    var out: Vector3 = undefined;
    mVector3One(
        @ptrCast([*c]raylib.Vector3, &out),
    );
    return out;
}

export fn mVector3One(
    out: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3One();
}

/// 
pub fn Vector3Add(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Add(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Add(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Add(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3AddValue(
    v: Vector3,
    add: f32,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3AddValue(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        add,
    );
    return out;
}

export fn mVector3AddValue(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
    add: f32,
) void {
    out.* = raylib.Vector3AddValue(
        v.*,
        add,
    );
}

/// 
pub fn Vector3Subtract(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Subtract(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Subtract(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Subtract(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3SubtractValue(
    v: Vector3,
    sub: f32,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3SubtractValue(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        sub,
    );
    return out;
}

export fn mVector3SubtractValue(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
    sub: f32,
) void {
    out.* = raylib.Vector3SubtractValue(
        v.*,
        sub,
    );
}

/// 
pub fn Vector3Scale(
    v: Vector3,
    scalar: f32,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Scale(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        scalar,
    );
    return out;
}

export fn mVector3Scale(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
    scalar: f32,
) void {
    out.* = raylib.Vector3Scale(
        v.*,
        scalar,
    );
}

/// 
pub fn Vector3Multiply(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Multiply(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Multiply(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Multiply(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3CrossProduct(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3CrossProduct(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3CrossProduct(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3CrossProduct(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3Perpendicular(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Perpendicular(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector3Perpendicular(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Perpendicular(
        v.*,
    );
}

/// 
pub fn Vector3DotProduct(
    v1: Vector3,
    v2: Vector3,
) f32 {
    var out: f32 = undefined;
    mVector3DotProduct(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3DotProduct(
    out: [*c]f32,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3DotProduct(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3Distance(
    v1: Vector3,
    v2: Vector3,
) f32 {
    var out: f32 = undefined;
    mVector3Distance(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Distance(
    out: [*c]f32,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Distance(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3DistanceSqr(
    v1: Vector3,
    v2: Vector3,
) f32 {
    var out: f32 = undefined;
    mVector3DistanceSqr(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3DistanceSqr(
    out: [*c]f32,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3DistanceSqr(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3Angle(
    v1: Vector3,
    v2: Vector3,
) f32 {
    var out: f32 = undefined;
    mVector3Angle(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Angle(
    out: [*c]f32,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Angle(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3Negate(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Negate(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector3Negate(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Negate(
        v.*,
    );
}

/// 
pub fn Vector3Divide(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Divide(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Divide(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Divide(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3Normalize(
    v: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Normalize(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector3Normalize(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Normalize(
        v.*,
    );
}

/// 
pub fn Vector3OrthoNormalize(
    v1: [*]Vector3,
    v2: [*]Vector3,
) void {
    mVector3OrthoNormalize(
        @intToPtr([*c]raylib.Vector3, @ptrToInt(v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(v2)),
    );
}

export fn mVector3OrthoNormalize(
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    raylib.Vector3OrthoNormalize(
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
    mVector3Transform(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mVector3Transform(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.Vector3Transform(
        v.*,
        mat.*,
    );
}

/// 
pub fn Vector3RotateByQuaternion(
    v: Vector3,
    q: Vector4,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3RotateByQuaternion(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
    return out;
}

export fn mVector3RotateByQuaternion(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
    q: [*c]raylib.Vector4,
) void {
    out.* = raylib.Vector3RotateByQuaternion(
        v.*,
        q.*,
    );
}

/// 
pub fn Vector3Lerp(
    v1: Vector3,
    v2: Vector3,
    amount: f32,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Lerp(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
        amount,
    );
    return out;
}

export fn mVector3Lerp(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
    amount: f32,
) void {
    out.* = raylib.Vector3Lerp(
        v1.*,
        v2.*,
        amount,
    );
}

/// 
pub fn Vector3Reflect(
    v: Vector3,
    normal: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Reflect(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&normal)),
    );
    return out;
}

export fn mVector3Reflect(
    out: [*c]raylib.Vector3,
    v: [*c]raylib.Vector3,
    normal: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Reflect(
        v.*,
        normal.*,
    );
}

/// 
pub fn Vector3Min(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Min(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Min(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Min(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3Max(
    v1: Vector3,
    v2: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Max(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v1)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v2)),
    );
    return out;
}

export fn mVector3Max(
    out: [*c]raylib.Vector3,
    v1: [*c]raylib.Vector3,
    v2: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Max(
        v1.*,
        v2.*,
    );
}

/// 
pub fn Vector3Barycenter(
    p: Vector3,
    a: Vector3,
    b: Vector3,
    c: Vector3,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Barycenter(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&p)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&a)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&b)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&c)),
    );
    return out;
}

export fn mVector3Barycenter(
    out: [*c]raylib.Vector3,
    p: [*c]raylib.Vector3,
    a: [*c]raylib.Vector3,
    b: [*c]raylib.Vector3,
    c: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3Barycenter(
        p.*,
        a.*,
        b.*,
        c.*,
    );
}

/// 
pub fn Vector3Unproject(
    source: Vector3,
    projection: Matrix,
    view: Matrix,
) Vector3 {
    var out: Vector3 = undefined;
    mVector3Unproject(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&source)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&projection)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&view)),
    );
    return out;
}

export fn mVector3Unproject(
    out: [*c]raylib.Vector3,
    source: [*c]raylib.Vector3,
    projection: [*c]raylib.Matrix,
    view: [*c]raylib.Matrix,
) void {
    out.* = raylib.Vector3Unproject(
        source.*,
        projection.*,
        view.*,
    );
}

/// 
pub fn Vector3ToFloatV(
    v: Vector3,
) float3 {
    var out: float3 = undefined;
    mVector3ToFloatV(
        @ptrCast([*c]raylib.float3, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&v)),
    );
    return out;
}

export fn mVector3ToFloatV(
    out: [*c]raylib.float3,
    v: [*c]raylib.Vector3,
) void {
    out.* = raylib.Vector3ToFloatV(
        v.*,
    );
}

/// 
pub fn MatrixDeterminant(
    mat: Matrix,
) f32 {
    var out: f32 = undefined;
    mMatrixDeterminant(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mMatrixDeterminant(
    out: [*c]f32,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixDeterminant(
        mat.*,
    );
}

/// 
pub fn MatrixTrace(
    mat: Matrix,
) f32 {
    var out: f32 = undefined;
    mMatrixTrace(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mMatrixTrace(
    out: [*c]f32,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixTrace(
        mat.*,
    );
}

/// 
pub fn MatrixTranspose(
    mat: Matrix,
) Matrix {
    var out: Matrix = undefined;
    mMatrixTranspose(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mMatrixTranspose(
    out: [*c]raylib.Matrix,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixTranspose(
        mat.*,
    );
}

/// 
pub fn MatrixInvert(
    mat: Matrix,
) Matrix {
    var out: Matrix = undefined;
    mMatrixInvert(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mMatrixInvert(
    out: [*c]raylib.Matrix,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixInvert(
        mat.*,
    );
}

/// 
pub fn MatrixIdentity() Matrix {
    var out: Matrix = undefined;
    mMatrixIdentity(
        @ptrCast([*c]raylib.Matrix, &out),
    );
    return out;
}

export fn mMatrixIdentity(
    out: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixIdentity();
}

/// 
pub fn MatrixAdd(
    left: Matrix,
    right: Matrix,
) Matrix {
    var out: Matrix = undefined;
    mMatrixAdd(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
    );
    return out;
}

export fn mMatrixAdd(
    out: [*c]raylib.Matrix,
    left: [*c]raylib.Matrix,
    right: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixAdd(
        left.*,
        right.*,
    );
}

/// 
pub fn MatrixSubtract(
    left: Matrix,
    right: Matrix,
) Matrix {
    var out: Matrix = undefined;
    mMatrixSubtract(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
    );
    return out;
}

export fn mMatrixSubtract(
    out: [*c]raylib.Matrix,
    left: [*c]raylib.Matrix,
    right: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixSubtract(
        left.*,
        right.*,
    );
}

/// 
pub fn MatrixMultiply(
    left: Matrix,
    right: Matrix,
) Matrix {
    var out: Matrix = undefined;
    mMatrixMultiply(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&left)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&right)),
    );
    return out;
}

export fn mMatrixMultiply(
    out: [*c]raylib.Matrix,
    left: [*c]raylib.Matrix,
    right: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixMultiply(
        left.*,
        right.*,
    );
}

/// 
pub fn MatrixTranslate(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    var out: Matrix = undefined;
    mMatrixTranslate(
        @ptrCast([*c]raylib.Matrix, &out),
        x,
        y,
        z,
    );
    return out;
}

export fn mMatrixTranslate(
    out: [*c]raylib.Matrix,
    x: f32,
    y: f32,
    z: f32,
) void {
    out.* = raylib.MatrixTranslate(
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
    var out: Matrix = undefined;
    mMatrixRotate(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&axis)),
        angle,
    );
    return out;
}

export fn mMatrixRotate(
    out: [*c]raylib.Matrix,
    axis: [*c]raylib.Vector3,
    angle: f32,
) void {
    out.* = raylib.MatrixRotate(
        axis.*,
        angle,
    );
}

/// 
pub fn MatrixRotateX(
    angle: f32,
) Matrix {
    var out: Matrix = undefined;
    mMatrixRotateX(
        @ptrCast([*c]raylib.Matrix, &out),
        angle,
    );
    return out;
}

export fn mMatrixRotateX(
    out: [*c]raylib.Matrix,
    angle: f32,
) void {
    out.* = raylib.MatrixRotateX(
        angle,
    );
}

/// 
pub fn MatrixRotateY(
    angle: f32,
) Matrix {
    var out: Matrix = undefined;
    mMatrixRotateY(
        @ptrCast([*c]raylib.Matrix, &out),
        angle,
    );
    return out;
}

export fn mMatrixRotateY(
    out: [*c]raylib.Matrix,
    angle: f32,
) void {
    out.* = raylib.MatrixRotateY(
        angle,
    );
}

/// 
pub fn MatrixRotateZ(
    angle: f32,
) Matrix {
    var out: Matrix = undefined;
    mMatrixRotateZ(
        @ptrCast([*c]raylib.Matrix, &out),
        angle,
    );
    return out;
}

export fn mMatrixRotateZ(
    out: [*c]raylib.Matrix,
    angle: f32,
) void {
    out.* = raylib.MatrixRotateZ(
        angle,
    );
}

/// 
pub fn MatrixRotateXYZ(
    ang: Vector3,
) Matrix {
    var out: Matrix = undefined;
    mMatrixRotateXYZ(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&ang)),
    );
    return out;
}

export fn mMatrixRotateXYZ(
    out: [*c]raylib.Matrix,
    ang: [*c]raylib.Vector3,
) void {
    out.* = raylib.MatrixRotateXYZ(
        ang.*,
    );
}

/// 
pub fn MatrixRotateZYX(
    ang: Vector3,
) Matrix {
    var out: Matrix = undefined;
    mMatrixRotateZYX(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&ang)),
    );
    return out;
}

export fn mMatrixRotateZYX(
    out: [*c]raylib.Matrix,
    ang: [*c]raylib.Vector3,
) void {
    out.* = raylib.MatrixRotateZYX(
        ang.*,
    );
}

/// 
pub fn MatrixScale(
    x: f32,
    y: f32,
    z: f32,
) Matrix {
    var out: Matrix = undefined;
    mMatrixScale(
        @ptrCast([*c]raylib.Matrix, &out),
        x,
        y,
        z,
    );
    return out;
}

export fn mMatrixScale(
    out: [*c]raylib.Matrix,
    x: f32,
    y: f32,
    z: f32,
) void {
    out.* = raylib.MatrixScale(
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
) Matrix {
    var out: Matrix = undefined;
    mMatrixFrustum(
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

export fn mMatrixFrustum(
    out: [*c]raylib.Matrix,
    left: f64,
    right: f64,
    bottom: f64,
    top: f64,
    near: f64,
    far: f64,
) void {
    out.* = raylib.MatrixFrustum(
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
) Matrix {
    var out: Matrix = undefined;
    mMatrixPerspective(
        @ptrCast([*c]raylib.Matrix, &out),
        fovy,
        aspect,
        near,
        far,
    );
    return out;
}

export fn mMatrixPerspective(
    out: [*c]raylib.Matrix,
    fovy: f64,
    aspect: f64,
    near: f64,
    far: f64,
) void {
    out.* = raylib.MatrixPerspective(
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
) Matrix {
    var out: Matrix = undefined;
    mMatrixOrtho(
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

export fn mMatrixOrtho(
    out: [*c]raylib.Matrix,
    left: f64,
    right: f64,
    bottom: f64,
    top: f64,
    near: f64,
    far: f64,
) void {
    out.* = raylib.MatrixOrtho(
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
    var out: Matrix = undefined;
    mMatrixLookAt(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&eye)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&target)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&up)),
    );
    return out;
}

export fn mMatrixLookAt(
    out: [*c]raylib.Matrix,
    eye: [*c]raylib.Vector3,
    target: [*c]raylib.Vector3,
    up: [*c]raylib.Vector3,
) void {
    out.* = raylib.MatrixLookAt(
        eye.*,
        target.*,
        up.*,
    );
}

/// 
pub fn MatrixToFloatV(
    mat: Matrix,
) float16 {
    var out: float16 = undefined;
    mMatrixToFloatV(
        @ptrCast([*c]raylib.float16, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mMatrixToFloatV(
    out: [*c]raylib.float16,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.MatrixToFloatV(
        mat.*,
    );
}

/// 
pub fn QuaternionAdd(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionAdd(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
    );
    return out;
}

export fn mQuaternionAdd(
    out: [*c]raylib.Vector4,
    q1: [*c]raylib.Vector4,
    q2: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionAdd(
        q1.*,
        q2.*,
    );
}

/// 
pub fn QuaternionAddValue(
    q: Vector4,
    add: f32,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionAddValue(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        add,
    );
    return out;
}

export fn mQuaternionAddValue(
    out: [*c]raylib.Vector4,
    q: [*c]raylib.Vector4,
    add: f32,
) void {
    out.* = raylib.QuaternionAddValue(
        q.*,
        add,
    );
}

/// 
pub fn QuaternionSubtract(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionSubtract(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
    );
    return out;
}

export fn mQuaternionSubtract(
    out: [*c]raylib.Vector4,
    q1: [*c]raylib.Vector4,
    q2: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionSubtract(
        q1.*,
        q2.*,
    );
}

/// 
pub fn QuaternionSubtractValue(
    q: Vector4,
    sub: f32,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionSubtractValue(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        sub,
    );
    return out;
}

export fn mQuaternionSubtractValue(
    out: [*c]raylib.Vector4,
    q: [*c]raylib.Vector4,
    sub: f32,
) void {
    out.* = raylib.QuaternionSubtractValue(
        q.*,
        sub,
    );
}

/// 
pub fn QuaternionIdentity() Vector4 {
    var out: Vector4 = undefined;
    mQuaternionIdentity(
        @ptrCast([*c]raylib.Vector4, &out),
    );
    return out;
}

export fn mQuaternionIdentity(
    out: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionIdentity();
}

/// 
pub fn QuaternionLength(
    q: Vector4,
) f32 {
    var out: f32 = undefined;
    mQuaternionLength(
        @ptrCast([*c]f32, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
    return out;
}

export fn mQuaternionLength(
    out: [*c]f32,
    q: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionLength(
        q.*,
    );
}

/// 
pub fn QuaternionNormalize(
    q: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionNormalize(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
    return out;
}

export fn mQuaternionNormalize(
    out: [*c]raylib.Vector4,
    q: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionNormalize(
        q.*,
    );
}

/// 
pub fn QuaternionInvert(
    q: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionInvert(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
    return out;
}

export fn mQuaternionInvert(
    out: [*c]raylib.Vector4,
    q: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionInvert(
        q.*,
    );
}

/// 
pub fn QuaternionMultiply(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionMultiply(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
    );
    return out;
}

export fn mQuaternionMultiply(
    out: [*c]raylib.Vector4,
    q1: [*c]raylib.Vector4,
    q2: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionMultiply(
        q1.*,
        q2.*,
    );
}

/// 
pub fn QuaternionScale(
    q: Vector4,
    mul: f32,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionScale(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        mul,
    );
    return out;
}

export fn mQuaternionScale(
    out: [*c]raylib.Vector4,
    q: [*c]raylib.Vector4,
    mul: f32,
) void {
    out.* = raylib.QuaternionScale(
        q.*,
        mul,
    );
}

/// 
pub fn QuaternionDivide(
    q1: Vector4,
    q2: Vector4,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionDivide(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
    );
    return out;
}

export fn mQuaternionDivide(
    out: [*c]raylib.Vector4,
    q1: [*c]raylib.Vector4,
    q2: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionDivide(
        q1.*,
        q2.*,
    );
}

/// 
pub fn QuaternionLerp(
    q1: Vector4,
    q2: Vector4,
    amount: f32,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionLerp(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
        amount,
    );
    return out;
}

export fn mQuaternionLerp(
    out: [*c]raylib.Vector4,
    q1: [*c]raylib.Vector4,
    q2: [*c]raylib.Vector4,
    amount: f32,
) void {
    out.* = raylib.QuaternionLerp(
        q1.*,
        q2.*,
        amount,
    );
}

/// 
pub fn QuaternionNlerp(
    q1: Vector4,
    q2: Vector4,
    amount: f32,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionNlerp(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
        amount,
    );
    return out;
}

export fn mQuaternionNlerp(
    out: [*c]raylib.Vector4,
    q1: [*c]raylib.Vector4,
    q2: [*c]raylib.Vector4,
    amount: f32,
) void {
    out.* = raylib.QuaternionNlerp(
        q1.*,
        q2.*,
        amount,
    );
}

/// 
pub fn QuaternionSlerp(
    q1: Vector4,
    q2: Vector4,
    amount: f32,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionSlerp(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q1)),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q2)),
        amount,
    );
    return out;
}

export fn mQuaternionSlerp(
    out: [*c]raylib.Vector4,
    q1: [*c]raylib.Vector4,
    q2: [*c]raylib.Vector4,
    amount: f32,
) void {
    out.* = raylib.QuaternionSlerp(
        q1.*,
        q2.*,
        amount,
    );
}

/// 
pub fn QuaternionFromVector3ToVector3(
    from: Vector3,
    to: Vector3,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionFromVector3ToVector3(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&from)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&to)),
    );
    return out;
}

export fn mQuaternionFromVector3ToVector3(
    out: [*c]raylib.Vector4,
    from: [*c]raylib.Vector3,
    to: [*c]raylib.Vector3,
) void {
    out.* = raylib.QuaternionFromVector3ToVector3(
        from.*,
        to.*,
    );
}

/// 
pub fn QuaternionFromMatrix(
    mat: Matrix,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionFromMatrix(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mQuaternionFromMatrix(
    out: [*c]raylib.Vector4,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.QuaternionFromMatrix(
        mat.*,
    );
}

/// 
pub fn QuaternionToMatrix(
    q: Vector4,
) Matrix {
    var out: Matrix = undefined;
    mQuaternionToMatrix(
        @ptrCast([*c]raylib.Matrix, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
    return out;
}

export fn mQuaternionToMatrix(
    out: [*c]raylib.Matrix,
    q: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionToMatrix(
        q.*,
    );
}

/// 
pub fn QuaternionFromAxisAngle(
    axis: Vector3,
    angle: f32,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionFromAxisAngle(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(&axis)),
        angle,
    );
    return out;
}

export fn mQuaternionFromAxisAngle(
    out: [*c]raylib.Vector4,
    axis: [*c]raylib.Vector3,
    angle: f32,
) void {
    out.* = raylib.QuaternionFromAxisAngle(
        axis.*,
        angle,
    );
}

/// 
pub fn QuaternionToAxisAngle(
    q: Vector4,
    outAxis: [*]Vector3,
    outAngle: [*]f32,
) void {
    mQuaternionToAxisAngle(
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        @intToPtr([*c]raylib.Vector3, @ptrToInt(outAxis)),
        @ptrCast([*c]f32, outAngle),
    );
}

export fn mQuaternionToAxisAngle(
    q: [*c]raylib.Vector4,
    outAxis: [*c]raylib.Vector3,
    outAngle: [*c]f32,
) void {
    raylib.QuaternionToAxisAngle(
        q.*,
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
    mQuaternionFromEuler(
        @ptrCast([*c]raylib.Vector4, &out),
        pitch,
        yaw,
        roll,
    );
    return out;
}

export fn mQuaternionFromEuler(
    out: [*c]raylib.Vector4,
    pitch: f32,
    yaw: f32,
    roll: f32,
) void {
    out.* = raylib.QuaternionFromEuler(
        pitch,
        yaw,
        roll,
    );
}

/// 
pub fn QuaternionToEuler(
    q: Vector4,
) Vector3 {
    var out: Vector3 = undefined;
    mQuaternionToEuler(
        @ptrCast([*c]raylib.Vector3, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
    );
    return out;
}

export fn mQuaternionToEuler(
    out: [*c]raylib.Vector3,
    q: [*c]raylib.Vector4,
) void {
    out.* = raylib.QuaternionToEuler(
        q.*,
    );
}

/// 
pub fn QuaternionTransform(
    q: Vector4,
    mat: Matrix,
) Vector4 {
    var out: Vector4 = undefined;
    mQuaternionTransform(
        @ptrCast([*c]raylib.Vector4, &out),
        @intToPtr([*c]raylib.Vector4, @ptrToInt(&q)),
        @intToPtr([*c]raylib.Matrix, @ptrToInt(&mat)),
    );
    return out;
}

export fn mQuaternionTransform(
    out: [*c]raylib.Vector4,
    q: [*c]raylib.Vector4,
    mat: [*c]raylib.Matrix,
) void {
    out.* = raylib.QuaternionTransform(
        q.*,
        mat.*,
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
    recs: [*]Rectangle,
    /// Glyphs info data
    glyphs: [*]GlyphInfo,
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
    vertices: [*]f32,
    /// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords: [*]f32,
    /// Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
    texcoords2: [*]f32,
    /// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    normals: [*]f32,
    /// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    tangents: [*]f32,
    /// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    colors: [*]u8,
    /// Vertex indices (in case vertex data comes indexed)
    indices: [*]u16,
    /// Animated vertex positions (after bones transformations)
    animVertices: [*]f32,
    /// Animated normals (after bones transformations)
    animNormals: [*]f32,
    /// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    boneIds: [*]u8,
    /// Vertex bone weight, up to 4 bones influence by vertex (skinning)
    boneWeights: [*]f32,
    /// OpenGL Vertex Array Object id
    vaoId: u32,
    /// OpenGL Vertex Buffer Objects id (default vertex data)
    vboId: [*]u32,
};

/// Shader
pub const Shader = extern struct {
    /// Shader program id
    id: u32,
    /// Shader locations array (RL_MAX_SHADER_LOCATIONS)
    locs: [*]i32,
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
    maps: [*]MaterialMap,
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
    meshes: [*]Mesh,
    /// Materials array
    materials: [*]Material,
    /// Mesh material number
    meshMaterial: [*]i32,
    /// Number of bones
    boneCount: i32,
    /// Bones information (skeleton)
    bones: [*]BoneInfo,
    /// Bones base transformation (pose)
    bindPose: [*]Transform,
};

/// ModelAnimation
pub const ModelAnimation = extern struct {
    /// Number of bones
    boneCount: i32,
    /// Number of animation frames
    frameCount: i32,
    /// Bones information (skeleton)
    bones: [*]BoneInfo,
    /// Poses array by frame
    framePoses: [*]Transform,
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
    /// Key: Android menu button
    KEY_MENU = 82,
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

pub const RectangleI = extern struct {
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

pub const Vector2i = extern struct {
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

    pub fn fromAngleAxis(axis: Vector3, angle: f32) @This() {
        return QuaternionFromAxisAngle(axis, angle);
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

pub fn randomF32(rng: std.rand.Random, min: f32, max: f32) f32 {
    return rng.float(f32) * (max - min) + min;
}

//--- functions -----------------------------------------------------------------------------------

/// Load style from file (.rgs)
pub fn LoadGuiStyle(_: [*:0]const u8) u32 {
    @panic("LoadGuiStyle is not implemented");
    //return raylib.LoadGuiStyle(fileName);
}

/// Unload style
pub fn UnloadGuiStyle(_: u32) void {
    @panic("UnloadGuiStyle is not implemented");
    // raylib.UnloadGuiStyle(style);
}

pub fn TextSplit() void {
    @panic("use std lib for that");
}
pub fn TextJoin() void {
    @panic("use std lib for that");
}
pub fn TextAppend() void {
    @panic("use std lib for that");
}

/// Set custom trace log
pub fn SetTraceLogCallback(
    _: TraceLogCallback,
) void {
    @panic("use log.zig for that");
}

/// Text Box control with multiple lines
pub fn GuiTextBoxMulti(_: Rectangle, _: [*]u8, _: i32, _: bool) bool {
    @panic("this gets translated wrong with cImport");
}

/// List View with extended parameters
pub fn GuiListViewEx(
    _: Rectangle,
    _: [*]const [*:0]const u8,
    _: i32,
    _: [*]i32,
    _: [*]i32,
    _: i32,
) i32 {
    @panic("TODO: link with raygui somehow");
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

/// Get dropped files names (memory should be freed)
pub fn GetDroppedFiles(
    count: [*]i32,
) [*]const [*]const u8 {
    return @ptrCast(
        [*]u8,
        mGetDroppedFiles(
            @ptrCast([*c]i32, count),
        ),
    );
}
export fn mGetDroppedFiles(
    count: [*c]i32,
) [*c]const [*c]const u8 {
    return raylib.GetDroppedFiles(
        count,
    );
}

/// Get filenames in a directory path (memory should be freed)
pub fn GetDirectoryFiles(
    dirPath: [*:0]const u8,
    count: [*]i32,
) [*]const [*]const u8 {
    return @ptrCast(
        [*]u8,
        mGetDirectoryFiles(
            @ptrCast([*c]u8, dirPath),
            @ptrCast([*c]i32, count),
        ),
    );
}
export fn mGetDirectoryFiles(
    dirPath: [*c]u8,
    count: [*c]i32,
) [*c]const [*c]const u8 {
    return raylib.GetDirectoryFiles(
        dirPath,
        count,
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
