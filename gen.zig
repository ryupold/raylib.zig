const std = @import("std");
const r = @cImport({
    @cInclude("raylib_marshall.h");
});
const t = @import("types.zig");
const cPtr = t.asCPtr;

pub fn InitWindow(width: i32, height: i32, title: []const u8) void {
    r.mInitWindow(
        @intCast(c_int, width),
        @intCast(c_int, height),
        @ptrCast([*c]const u8, title.ptr),
    );
}

pub fn WindowShouldClose() bool {
    return r.mWindowShouldClose();
}

pub fn CloseWindow() void {
    r.mCloseWindow();
}

pub fn SetWindowPosition(x: i32, y: i32) void {
    r.mSetWindowPosition(
        @intCast(c_int, x),
        @intCast(c_int, y),
    );
}

pub fn SetWindowMonitor(monitor: i32) void {
    r.mSetWindowMonitor(
        @intCast(c_int, monitor),
    );
}

pub fn SetWindowMinSize(width: i32, height: i32) void {
    r.mSetWindowMinSize(
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

pub fn SetWindowSize(width: i32, height: i32) void {
    r.mSetWindowSize(
        @intCast(c_int, width),
        @intCast(c_int, height),
    );
}

pub fn GetScreenWidth() i32 {
    return r.mGetScreenWidth();
}

pub fn GetScreenHeight() i32 {
    return r.mGetScreenHeight();
}

pub fn IsCursorOnScreen() bool {
    return r.mIsCursorOnScreen();
}

pub fn ClearBackground(color: t.Color) void {
    var _color = color;

    r.mClearBackground(
        @ptrCast([*c]r.Color, &_color),
    );
}

pub fn BeginDrawing() void {
    r.mBeginDrawing();
}

pub fn EndDrawing() void {
    r.mEndDrawing();
}

pub fn BeginMode2D(camera: t.Camera2D) void {
    var _camera = camera;

    r.mBeginMode2D(
        @ptrCast([*c]r.Camera2D, &_camera),
    );
}

pub fn EndMode2D() void {
    r.mEndMode2D();
}

pub fn GetCameraMatrix2D(camera: t.Camera2D) t.Matrix {
    var _camera = camera;
    var _out: t.Matrix = undefined;

    r.mGetCameraMatrix2D(
        @ptrCast([*c]r.Matrix, &_out),
        @ptrCast([*c]r.Camera2D, &_camera),
    );
    return _out;
}

pub fn GetWorldToScreen2D(position: t.Vector2, camera: t.Camera2D) t.Vector2 {
    var _position = position;
    var _camera = camera;
    var _out: t.Vector2 = undefined;

    r.mGetWorldToScreen2D(
        @ptrCast([*c]r.Vector2, &_out),
        @ptrCast([*c]r.Vector2, &_position),
        @ptrCast([*c]r.Camera2D, &_camera),
    );
    return _out;
}

pub fn GetScreenToWorld2D(position: t.Vector2, camera: t.Camera2D) t.Vector2 {
    var _position = position;
    var _camera = camera;
    var _out: t.Vector2 = undefined;

    r.mGetScreenToWorld2D(
        @ptrCast([*c]r.Vector2, &_out),
        @ptrCast([*c]r.Vector2, &_position),
        @ptrCast([*c]r.Camera2D, &_camera),
    );
    return _out;
}

pub fn SetTargetFPS(fps: i32) void {
    r.mSetTargetFPS(
        @intCast(c_int, fps),
    );
}

pub fn GetFPS() i32 {
    return r.mGetFPS();
}

pub fn GetFrameTime() f32 {
    return r.mGetFrameTime();
}

pub fn GetTime() f64 {
    return r.mGetTime();
}

pub fn OpenURL(url: []const u8) void {
    r.mOpenURL(
        @ptrCast([*c]const u8, url.ptr),
    );
}

pub fn IsKeyPressed(key: i32) bool {
    return r.mIsKeyPressed(
        @intCast(c_int, key),
    );
}

pub fn IsKeyDown(key: i32) bool {
    return r.mIsKeyDown(
        @intCast(c_int, key),
    );
}

pub fn IsKeyReleased(key: i32) bool {
    return r.mIsKeyReleased(
        @intCast(c_int, key),
    );
}

pub fn IsKeyUp(key: i32) bool {
    return r.mIsKeyUp(
        @intCast(c_int, key),
    );
}

pub fn SetExitKey(key: i32) void {
    r.mSetExitKey(
        @intCast(c_int, key),
    );
}

pub fn GetKeyPressed() i32 {
    return r.mGetKeyPressed();
}

pub fn GetCharPressed() i32 {
    return r.mGetCharPressed();
}

pub fn IsMouseButtonPressed(button: i32) bool {
    return r.mIsMouseButtonPressed(
        @intCast(c_int, button),
    );
}

pub fn IsMouseButtonDown(button: i32) bool {
    return r.mIsMouseButtonDown(
        @intCast(c_int, button),
    );
}

pub fn IsMouseButtonReleased(button: i32) bool {
    return r.mIsMouseButtonReleased(
        @intCast(c_int, button),
    );
}

pub fn IsMouseButtonUp(button: i32) bool {
    return r.mIsMouseButtonUp(
        @intCast(c_int, button),
    );
}

pub fn GetMousePosition() t.Vector2 {
    var _out: t.Vector2 = undefined;

    r.mGetMousePosition(
        @ptrCast([*c]r.Vector2, &_out),
    );
    return _out;
}

pub fn GetMouseDelta() t.Vector2 {
    var _out: t.Vector2 = undefined;

    r.mGetMouseDelta(
        @ptrCast([*c]r.Vector2, &_out),
    );
    return _out;
}

pub fn SetMouseOffset(offsetX: i32, offsetY: i32) void {
    r.mSetMouseOffset(
        @intCast(c_int, offsetX),
        @intCast(c_int, offsetY),
    );
}

pub fn SetMouseScale(scaleX: f32, scaleY: f32) void {
    r.mSetMouseScale(
        scaleX,
        scaleY,
    );
}

pub fn GetMouseWheelMove() f32 {
    return r.mGetMouseWheelMove();
}

pub fn SetMouseCursor(cursor: i32) void {
    r.mSetMouseCursor(
        @intCast(c_int, cursor),
    );
}

pub fn GetTouchPosition(index: i32) t.Vector2 {
    var _out: t.Vector2 = undefined;

    r.mGetTouchPosition(
        @ptrCast([*c]r.Vector2, &_out),
        @intCast(c_int, index),
    );
    return _out;
}

pub fn GetTouchPointCount() i32 {
    return r.mGetTouchPointCount();
}

pub fn DrawLineEx(startPos: t.Vector2, endPos: t.Vector2, thick: f32, color: t.Color) void {
    var _startPos = startPos;
    var _endPos = endPos;
    var _color = color;

    r.mDrawLineEx(
        @ptrCast([*c]r.Vector2, &_startPos),
        @ptrCast([*c]r.Vector2, &_endPos),
        thick,
        @ptrCast([*c]r.Color, &_color),
    );
}

pub fn DrawRectanglePro(rec: t.Rectangle, origin: t.Vector2, rotation: f32, color: t.Color) void {
    var _rec = rec;
    var _origin = origin;
    var _color = color;

    r.mDrawRectanglePro(
        @ptrCast([*c]r.Rectangle, &_rec),
        @ptrCast([*c]r.Vector2, &_origin),
        rotation,
        @ptrCast([*c]r.Color, &_color),
    );
}

pub fn DrawTriangle(v1: t.Vector2, v2: t.Vector2, v3: t.Vector2, color: t.Color) void {
    var _v1 = v1;
    var _v2 = v2;
    var _v3 = v3;
    var _color = color;

    r.mDrawTriangle(
        @ptrCast([*c]r.Vector2, &_v1),
        @ptrCast([*c]r.Vector2, &_v2),
        @ptrCast([*c]r.Vector2, &_v3),
        @ptrCast([*c]r.Color, &_color),
    );
}

pub fn LoadTexture(fileName: []const u8) t.Texture2D {
    var _out: t.Texture2D = undefined;

    r.mLoadTexture(
        @ptrCast([*c]r.Texture2D, &_out),
        @ptrCast([*c]const u8, fileName.ptr),
    );
    return _out;
}

pub fn UnloadTexture(texture: t.Texture2D) void {
    var _texture = texture;

    r.mUnloadTexture(
        @ptrCast([*c]r.Texture2D, &_texture),
    );
}

pub fn DrawTextureEx(texture: t.Texture2D, position: t.Vector2, rotation: f32, scale: f32, tint: t.Color) void {
    var _texture = texture;
    var _position = position;
    var _tint = tint;

    r.mDrawTextureEx(
        @ptrCast([*c]r.Texture2D, &_texture),
        @ptrCast([*c]r.Vector2, &_position),
        rotation,
        scale,
        @ptrCast([*c]r.Color, &_tint),
    );
}

pub fn DrawTextureRec(texture: t.Texture2D, source: t.Rectangle, position: t.Vector2, tint: t.Color) void {
    var _texture = texture;
    var _source = source;
    var _position = position;
    var _tint = tint;

    r.mDrawTextureRec(
        @ptrCast([*c]r.Texture2D, &_texture),
        @ptrCast([*c]r.Rectangle, &_source),
        @ptrCast([*c]r.Vector2, &_position),
        @ptrCast([*c]r.Color, &_tint),
    );
}

pub fn DrawTexturePro(texture: t.Texture2D, source: t.Rectangle, dest: t.Rectangle, origin: t.Vector2, rotation: f32, tint: t.Color) void {
    var _texture = texture;
    var _source = source;
    var _dest = dest;
    var _origin = origin;
    var _tint = tint;

    r.mDrawTexturePro(
        @ptrCast([*c]r.Texture2D, &_texture),
        @ptrCast([*c]r.Rectangle, &_source),
        @ptrCast([*c]r.Rectangle, &_dest),
        @ptrCast([*c]r.Vector2, &_origin),
        rotation,
        @ptrCast([*c]r.Color, &_tint),
    );
}

pub fn DrawFPS(posX: i32, posY: i32) void {
    r.mDrawFPS(
        @intCast(c_int, posX),
        @intCast(c_int, posY),
    );
}

pub fn DrawText(text: []const u8, posX: i32, posY: i32, fontSize: i32, color: t.Color) void {
    var _color = color;

    r.mDrawText(
        @ptrCast([*c]const u8, text.ptr),
        @intCast(c_int, posX),
        @intCast(c_int, posY),
        @intCast(c_int, fontSize),
        @ptrCast([*c]r.Color, &_color),
    );
}

pub fn MatrixIdentity() t.Matrix {
    var _out: t.Matrix = undefined;

    r.mMatrixIdentity(
        @ptrCast([*c]r.Matrix, &_out),
    );
    return _out;
}

pub fn MatrixMultiply(left: t.Matrix, right: t.Matrix) t.Matrix {
    var _left = left;
    var _right = right;
    var _out: t.Matrix = undefined;

    r.mMatrixMultiply(
        @ptrCast([*c]r.Matrix, &_out),
        @ptrCast([*c]r.Matrix, &_left),
        @ptrCast([*c]r.Matrix, &_right),
    );
    return _out;
}

pub fn QuaternionFromMatrix(mat: t.Matrix) t.Quaternion {
    var _mat = mat;
    var _out: t.Quaternion = undefined;

    r.mQuaternionFromMatrix(
        @ptrCast([*c]r.Quaternion, &_out),
        @ptrCast([*c]r.Matrix, &_mat),
    );
    return _out;
}

pub fn QuaternionFromAxisAngle(axis: t.Vector3, angle: f32) t.Quaternion {
    var _axis = axis;
    var _out: t.Quaternion = undefined;

    r.mQuaternionFromAxisAngle(
        @ptrCast([*c]r.Quaternion, &_out),
        @ptrCast([*c]r.Vector3, &_axis),
        angle,
    );
    return _out;
}

pub fn QuaternionToAxisAngle(q: t.Quaternion, outAxis: *t.Vector3, outAngle: *f32) void {
    var _q = q;
    var _outAxis = outAxis;

    r.mQuaternionToAxisAngle(
        @ptrCast([*c]r.Quaternion, &_q),
        @ptrCast([*c]r.Vector3, _outAxis),
        outAngle,
    );
}
