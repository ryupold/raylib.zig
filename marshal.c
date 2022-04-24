#include "raylib.h"
#include "raymath.h"
#include "extras/raygui.h"

void mInitWindow(int width, int height, const char * title)
{
	return InitWindow(width, height, title);
}

bool mWindowShouldClose(void)
{
	return WindowShouldClose();
}

void mCloseWindow(void)
{
	return CloseWindow();
}

bool mIsWindowReady(void)
{
	return IsWindowReady();
}

bool mIsWindowFullscreen(void)
{
	return IsWindowFullscreen();
}

bool mIsWindowHidden(void)
{
	return IsWindowHidden();
}

bool mIsWindowMinimized(void)
{
	return IsWindowMinimized();
}

bool mIsWindowMaximized(void)
{
	return IsWindowMaximized();
}

bool mIsWindowFocused(void)
{
	return IsWindowFocused();
}

bool mIsWindowResized(void)
{
	return IsWindowResized();
}

bool mIsWindowState(unsigned int flag)
{
	return IsWindowState(flag);
}

void mSetWindowState(unsigned int flags)
{
	return SetWindowState(flags);
}

void mClearWindowState(unsigned int flags)
{
	return ClearWindowState(flags);
}

void mToggleFullscreen(void)
{
	return ToggleFullscreen();
}

void mMaximizeWindow(void)
{
	return MaximizeWindow();
}

void mMinimizeWindow(void)
{
	return MinimizeWindow();
}

void mRestoreWindow(void)
{
	return RestoreWindow();
}

void mSetWindowIcon(Image *image)
{
	return SetWindowIcon(*image);
}

void mSetWindowTitle(const char * title)
{
	return SetWindowTitle(title);
}

void mSetWindowPosition(int x, int y)
{
	return SetWindowPosition(x, y);
}

void mSetWindowMonitor(int monitor)
{
	return SetWindowMonitor(monitor);
}

void mSetWindowMinSize(int width, int height)
{
	return SetWindowMinSize(width, height);
}

void mSetWindowSize(int width, int height)
{
	return SetWindowSize(width, height);
}

void mSetWindowOpacity(float opacity)
{
	return SetWindowOpacity(opacity);
}

int mGetScreenWidth(void)
{
	return GetScreenWidth();
}

int mGetScreenHeight(void)
{
	return GetScreenHeight();
}

int mGetRenderWidth(void)
{
	return GetRenderWidth();
}

int mGetRenderHeight(void)
{
	return GetRenderHeight();
}

int mGetMonitorCount(void)
{
	return GetMonitorCount();
}

int mGetCurrentMonitor(void)
{
	return GetCurrentMonitor();
}

void mGetMonitorPosition(Vector2 *out, int monitor)
{
	*out = GetMonitorPosition(monitor);
}

int mGetMonitorWidth(int monitor)
{
	return GetMonitorWidth(monitor);
}

int mGetMonitorHeight(int monitor)
{
	return GetMonitorHeight(monitor);
}

int mGetMonitorPhysicalWidth(int monitor)
{
	return GetMonitorPhysicalWidth(monitor);
}

int mGetMonitorPhysicalHeight(int monitor)
{
	return GetMonitorPhysicalHeight(monitor);
}

int mGetMonitorRefreshRate(int monitor)
{
	return GetMonitorRefreshRate(monitor);
}

void mGetWindowPosition(Vector2 *out)
{
	*out = GetWindowPosition();
}

void mGetWindowScaleDPI(Vector2 *out)
{
	*out = GetWindowScaleDPI();
}

const char * mGetMonitorName(int monitor)
{
	return GetMonitorName(monitor);
}

void mSetClipboardText(const char * text)
{
	return SetClipboardText(text);
}

const char * mGetClipboardText(void)
{
	return GetClipboardText();
}

void mSwapScreenBuffer(void)
{
	return SwapScreenBuffer();
}

void mPollInputEvents(void)
{
	return PollInputEvents();
}

void mWaitTime(float ms)
{
	return WaitTime(ms);
}

void mShowCursor(void)
{
	return ShowCursor();
}

void mHideCursor(void)
{
	return HideCursor();
}

bool mIsCursorHidden(void)
{
	return IsCursorHidden();
}

void mEnableCursor(void)
{
	return EnableCursor();
}

void mDisableCursor(void)
{
	return DisableCursor();
}

bool mIsCursorOnScreen(void)
{
	return IsCursorOnScreen();
}

void mClearBackground(Color *color)
{
	return ClearBackground(*color);
}

void mBeginDrawing(void)
{
	return BeginDrawing();
}

void mEndDrawing(void)
{
	return EndDrawing();
}

void mBeginMode2D(Camera2D *camera)
{
	return BeginMode2D(*camera);
}

void mEndMode2D(void)
{
	return EndMode2D();
}

void mBeginMode3D(Camera3D *camera)
{
	return BeginMode3D(*camera);
}

void mEndMode3D(void)
{
	return EndMode3D();
}

void mBeginTextureMode(RenderTexture2D *target)
{
	return BeginTextureMode(*target);
}

void mEndTextureMode(void)
{
	return EndTextureMode();
}

void mBeginShaderMode(Shader *shader)
{
	return BeginShaderMode(*shader);
}

void mEndShaderMode(void)
{
	return EndShaderMode();
}

void mBeginBlendMode(int mode)
{
	return BeginBlendMode(mode);
}

void mEndBlendMode(void)
{
	return EndBlendMode();
}

void mBeginScissorMode(int x, int y, int width, int height)
{
	return BeginScissorMode(x, y, width, height);
}

void mEndScissorMode(void)
{
	return EndScissorMode();
}

void mBeginVrStereoMode(VrStereoConfig *config)
{
	return BeginVrStereoMode(*config);
}

void mEndVrStereoMode(void)
{
	return EndVrStereoMode();
}

void mLoadVrStereoConfig(VrStereoConfig *out, VrDeviceInfo *device)
{
	*out = LoadVrStereoConfig(*device);
}

void mUnloadVrStereoConfig(VrStereoConfig *config)
{
	return UnloadVrStereoConfig(*config);
}

void mLoadShader(Shader *out, const char * vsFileName, const char * fsFileName)
{
	*out = LoadShader(vsFileName, fsFileName);
}

void mLoadShaderFromMemory(Shader *out, const char * vsCode, const char * fsCode)
{
	*out = LoadShaderFromMemory(vsCode, fsCode);
}

int mGetShaderLocation(Shader *shader, const char * uniformName)
{
	return GetShaderLocation(*shader, uniformName);
}

int mGetShaderLocationAttrib(Shader *shader, const char * attribName)
{
	return GetShaderLocationAttrib(*shader, attribName);
}

void mSetShaderValue(Shader *shader, int locIndex, const void * value, int uniformType)
{
	return SetShaderValue(*shader, locIndex, value, uniformType);
}

void mSetShaderValueV(Shader *shader, int locIndex, const void * value, int uniformType, int count)
{
	return SetShaderValueV(*shader, locIndex, value, uniformType, count);
}

void mSetShaderValueMatrix(Shader *shader, int locIndex, Matrix *mat)
{
	return SetShaderValueMatrix(*shader, locIndex, *mat);
}

void mSetShaderValueTexture(Shader *shader, int locIndex, Texture2D *texture)
{
	return SetShaderValueTexture(*shader, locIndex, *texture);
}

void mUnloadShader(Shader *shader)
{
	return UnloadShader(*shader);
}

void mGetMouseRay(Ray *out, Vector2 *mousePosition, Camera *camera)
{
	*out = GetMouseRay(*mousePosition, *camera);
}

void mGetCameraMatrix(Matrix *out, Camera *camera)
{
	*out = GetCameraMatrix(*camera);
}

void mGetCameraMatrix2D(Matrix *out, Camera2D *camera)
{
	*out = GetCameraMatrix2D(*camera);
}

void mGetWorldToScreen(Vector2 *out, Vector3 *position, Camera *camera)
{
	*out = GetWorldToScreen(*position, *camera);
}

void mGetWorldToScreenEx(Vector2 *out, Vector3 *position, Camera *camera, int width, int height)
{
	*out = GetWorldToScreenEx(*position, *camera, width, height);
}

void mGetWorldToScreen2D(Vector2 *out, Vector2 *position, Camera2D *camera)
{
	*out = GetWorldToScreen2D(*position, *camera);
}

void mGetScreenToWorld2D(Vector2 *out, Vector2 *position, Camera2D *camera)
{
	*out = GetScreenToWorld2D(*position, *camera);
}

void mSetTargetFPS(int fps)
{
	return SetTargetFPS(fps);
}

int mGetFPS(void)
{
	return GetFPS();
}

float mGetFrameTime(void)
{
	return GetFrameTime();
}

double mGetTime(void)
{
	return GetTime();
}

int mGetRandomValue(int min, int max)
{
	return GetRandomValue(min, max);
}

void mSetRandomSeed(unsigned int seed)
{
	return SetRandomSeed(seed);
}

void mTakeScreenshot(const char * fileName)
{
	return TakeScreenshot(fileName);
}

void mSetConfigFlags(unsigned int flags)
{
	return SetConfigFlags(flags);
}

void mSetTraceLogLevel(int logLevel)
{
	return SetTraceLogLevel(logLevel);
}

void mSetLoadFileDataCallback(LoadFileDataCallback *callback)
{
	return SetLoadFileDataCallback(*callback);
}

void mSetSaveFileDataCallback(SaveFileDataCallback *callback)
{
	return SetSaveFileDataCallback(*callback);
}

void mSetLoadFileTextCallback(LoadFileTextCallback *callback)
{
	return SetLoadFileTextCallback(*callback);
}

void mSetSaveFileTextCallback(SaveFileTextCallback *callback)
{
	return SetSaveFileTextCallback(*callback);
}

unsigned char * mLoadFileData(const char * fileName, unsigned int * bytesRead)
{
	return LoadFileData(fileName, bytesRead);
}

void mUnloadFileData(unsigned char * data)
{
	return UnloadFileData(data);
}

bool mSaveFileData(const char * fileName, void * data, unsigned int bytesToWrite)
{
	return SaveFileData(fileName, data, bytesToWrite);
}

char * mLoadFileText(const char * fileName)
{
	return LoadFileText(fileName);
}

void mUnloadFileText(char * text)
{
	return UnloadFileText(text);
}

bool mSaveFileText(const char * fileName, char * text)
{
	return SaveFileText(fileName, text);
}

bool mFileExists(const char * fileName)
{
	return FileExists(fileName);
}

bool mDirectoryExists(const char * dirPath)
{
	return DirectoryExists(dirPath);
}

bool mIsFileExtension(const char * fileName, const char * ext)
{
	return IsFileExtension(fileName, ext);
}

int mGetFileLength(const char * fileName)
{
	return GetFileLength(fileName);
}

const char * mGetFileExtension(const char * fileName)
{
	return GetFileExtension(fileName);
}

const char * mGetFileName(const char * filePath)
{
	return GetFileName(filePath);
}

const char * mGetFileNameWithoutExt(const char * filePath)
{
	return GetFileNameWithoutExt(filePath);
}

const char * mGetDirectoryPath(const char * filePath)
{
	return GetDirectoryPath(filePath);
}

const char * mGetPrevDirectoryPath(const char * dirPath)
{
	return GetPrevDirectoryPath(dirPath);
}

const char * mGetWorkingDirectory(void)
{
	return GetWorkingDirectory();
}

const char * mGetApplicationDirectory(void)
{
	return GetApplicationDirectory();
}

void mClearDirectoryFiles(void)
{
	return ClearDirectoryFiles();
}

bool mChangeDirectory(const char * dir)
{
	return ChangeDirectory(dir);
}

bool mIsFileDropped(void)
{
	return IsFileDropped();
}

void mClearDroppedFiles(void)
{
	return ClearDroppedFiles();
}

long mGetFileModTime(const char * fileName)
{
	return GetFileModTime(fileName);
}

unsigned char * mCompressData(const unsigned char * data, int dataSize, int * compDataSize)
{
	return CompressData(data, dataSize, compDataSize);
}

unsigned char * mDecompressData(const unsigned char * compData, int compDataSize, int * dataSize)
{
	return DecompressData(compData, compDataSize, dataSize);
}

char * mEncodeDataBase64(const unsigned char * data, int dataSize, int * outputSize)
{
	return EncodeDataBase64(data, dataSize, outputSize);
}

unsigned char * mDecodeDataBase64(const unsigned char * data, int * outputSize)
{
	return DecodeDataBase64(data, outputSize);
}

bool mSaveStorageValue(unsigned int position, int value)
{
	return SaveStorageValue(position, value);
}

int mLoadStorageValue(unsigned int position)
{
	return LoadStorageValue(position);
}

void mOpenURL(const char * url)
{
	return OpenURL(url);
}

bool mIsKeyPressed(int key)
{
	return IsKeyPressed(key);
}

bool mIsKeyDown(int key)
{
	return IsKeyDown(key);
}

bool mIsKeyReleased(int key)
{
	return IsKeyReleased(key);
}

bool mIsKeyUp(int key)
{
	return IsKeyUp(key);
}

void mSetExitKey(int key)
{
	return SetExitKey(key);
}

int mGetKeyPressed(void)
{
	return GetKeyPressed();
}

int mGetCharPressed(void)
{
	return GetCharPressed();
}

bool mIsGamepadAvailable(int gamepad)
{
	return IsGamepadAvailable(gamepad);
}

const char * mGetGamepadName(int gamepad)
{
	return GetGamepadName(gamepad);
}

bool mIsGamepadButtonPressed(int gamepad, int button)
{
	return IsGamepadButtonPressed(gamepad, button);
}

bool mIsGamepadButtonDown(int gamepad, int button)
{
	return IsGamepadButtonDown(gamepad, button);
}

bool mIsGamepadButtonReleased(int gamepad, int button)
{
	return IsGamepadButtonReleased(gamepad, button);
}

bool mIsGamepadButtonUp(int gamepad, int button)
{
	return IsGamepadButtonUp(gamepad, button);
}

int mGetGamepadButtonPressed(void)
{
	return GetGamepadButtonPressed();
}

int mGetGamepadAxisCount(int gamepad)
{
	return GetGamepadAxisCount(gamepad);
}

float mGetGamepadAxisMovement(int gamepad, int axis)
{
	return GetGamepadAxisMovement(gamepad, axis);
}

int mSetGamepadMappings(const char * mappings)
{
	return SetGamepadMappings(mappings);
}

bool mIsMouseButtonPressed(int button)
{
	return IsMouseButtonPressed(button);
}

bool mIsMouseButtonDown(int button)
{
	return IsMouseButtonDown(button);
}

bool mIsMouseButtonReleased(int button)
{
	return IsMouseButtonReleased(button);
}

bool mIsMouseButtonUp(int button)
{
	return IsMouseButtonUp(button);
}

int mGetMouseX(void)
{
	return GetMouseX();
}

int mGetMouseY(void)
{
	return GetMouseY();
}

void mGetMousePosition(Vector2 *out)
{
	*out = GetMousePosition();
}

void mGetMouseDelta(Vector2 *out)
{
	*out = GetMouseDelta();
}

void mSetMousePosition(int x, int y)
{
	return SetMousePosition(x, y);
}

void mSetMouseOffset(int offsetX, int offsetY)
{
	return SetMouseOffset(offsetX, offsetY);
}

void mSetMouseScale(float scaleX, float scaleY)
{
	return SetMouseScale(scaleX, scaleY);
}

float mGetMouseWheelMove(void)
{
	return GetMouseWheelMove();
}

void mSetMouseCursor(int cursor)
{
	return SetMouseCursor(cursor);
}

int mGetTouchX(void)
{
	return GetTouchX();
}

int mGetTouchY(void)
{
	return GetTouchY();
}

void mGetTouchPosition(Vector2 *out, int index)
{
	*out = GetTouchPosition(index);
}

int mGetTouchPointId(int index)
{
	return GetTouchPointId(index);
}

int mGetTouchPointCount(void)
{
	return GetTouchPointCount();
}

void mSetGesturesEnabled(unsigned int flags)
{
	return SetGesturesEnabled(flags);
}

bool mIsGestureDetected(int gesture)
{
	return IsGestureDetected(gesture);
}

int mGetGestureDetected(void)
{
	return GetGestureDetected();
}

float mGetGestureHoldDuration(void)
{
	return GetGestureHoldDuration();
}

void mGetGestureDragVector(Vector2 *out)
{
	*out = GetGestureDragVector();
}

float mGetGestureDragAngle(void)
{
	return GetGestureDragAngle();
}

void mGetGesturePinchVector(Vector2 *out)
{
	*out = GetGesturePinchVector();
}

float mGetGesturePinchAngle(void)
{
	return GetGesturePinchAngle();
}

void mSetCameraMode(Camera *camera, int mode)
{
	return SetCameraMode(*camera, mode);
}

void mUpdateCamera(Camera * camera)
{
	return UpdateCamera(camera);
}

void mSetCameraPanControl(int keyPan)
{
	return SetCameraPanControl(keyPan);
}

void mSetCameraAltControl(int keyAlt)
{
	return SetCameraAltControl(keyAlt);
}

void mSetCameraSmoothZoomControl(int keySmoothZoom)
{
	return SetCameraSmoothZoomControl(keySmoothZoom);
}

void mSetCameraMoveControls(int keyFront, int keyBack, int keyRight, int keyLeft, int keyUp, int keyDown)
{
	return SetCameraMoveControls(keyFront, keyBack, keyRight, keyLeft, keyUp, keyDown);
}

void mSetShapesTexture(Texture2D *texture, Rectangle *source)
{
	return SetShapesTexture(*texture, *source);
}

void mDrawPixel(int posX, int posY, Color *color)
{
	return DrawPixel(posX, posY, *color);
}

void mDrawPixelV(Vector2 *position, Color *color)
{
	return DrawPixelV(*position, *color);
}

void mDrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color *color)
{
	return DrawLine(startPosX, startPosY, endPosX, endPosY, *color);
}

void mDrawLineV(Vector2 *startPos, Vector2 *endPos, Color *color)
{
	return DrawLineV(*startPos, *endPos, *color);
}

void mDrawLineEx(Vector2 *startPos, Vector2 *endPos, float thick, Color *color)
{
	return DrawLineEx(*startPos, *endPos, thick, *color);
}

void mDrawLineBezier(Vector2 *startPos, Vector2 *endPos, float thick, Color *color)
{
	return DrawLineBezier(*startPos, *endPos, thick, *color);
}

void mDrawLineBezierQuad(Vector2 *startPos, Vector2 *endPos, Vector2 *controlPos, float thick, Color *color)
{
	return DrawLineBezierQuad(*startPos, *endPos, *controlPos, thick, *color);
}

void mDrawLineBezierCubic(Vector2 *startPos, Vector2 *endPos, Vector2 *startControlPos, Vector2 *endControlPos, float thick, Color *color)
{
	return DrawLineBezierCubic(*startPos, *endPos, *startControlPos, *endControlPos, thick, *color);
}

void mDrawLineStrip(Vector2 * points, int pointCount, Color *color)
{
	return DrawLineStrip(points, pointCount, *color);
}

void mDrawCircle(int centerX, int centerY, float radius, Color *color)
{
	return DrawCircle(centerX, centerY, radius, *color);
}

void mDrawCircleSector(Vector2 *center, float radius, float startAngle, float endAngle, int segments, Color *color)
{
	return DrawCircleSector(*center, radius, startAngle, endAngle, segments, *color);
}

void mDrawCircleSectorLines(Vector2 *center, float radius, float startAngle, float endAngle, int segments, Color *color)
{
	return DrawCircleSectorLines(*center, radius, startAngle, endAngle, segments, *color);
}

void mDrawCircleGradient(int centerX, int centerY, float radius, Color *color1, Color *color2)
{
	return DrawCircleGradient(centerX, centerY, radius, *color1, *color2);
}

void mDrawCircleV(Vector2 *center, float radius, Color *color)
{
	return DrawCircleV(*center, radius, *color);
}

void mDrawCircleLines(int centerX, int centerY, float radius, Color *color)
{
	return DrawCircleLines(centerX, centerY, radius, *color);
}

void mDrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color *color)
{
	return DrawEllipse(centerX, centerY, radiusH, radiusV, *color);
}

void mDrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color *color)
{
	return DrawEllipseLines(centerX, centerY, radiusH, radiusV, *color);
}

void mDrawRing(Vector2 *center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color *color)
{
	return DrawRing(*center, innerRadius, outerRadius, startAngle, endAngle, segments, *color);
}

void mDrawRingLines(Vector2 *center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color *color)
{
	return DrawRingLines(*center, innerRadius, outerRadius, startAngle, endAngle, segments, *color);
}

void mDrawRectangle(int posX, int posY, int width, int height, Color *color)
{
	return DrawRectangle(posX, posY, width, height, *color);
}

void mDrawRectangleV(Vector2 *position, Vector2 *size, Color *color)
{
	return DrawRectangleV(*position, *size, *color);
}

void mDrawRectangleRec(Rectangle *rec, Color *color)
{
	return DrawRectangleRec(*rec, *color);
}

void mDrawRectanglePro(Rectangle *rec, Vector2 *origin, float rotation, Color *color)
{
	return DrawRectanglePro(*rec, *origin, rotation, *color);
}

void mDrawRectangleGradientV(int posX, int posY, int width, int height, Color *color1, Color *color2)
{
	return DrawRectangleGradientV(posX, posY, width, height, *color1, *color2);
}

void mDrawRectangleGradientH(int posX, int posY, int width, int height, Color *color1, Color *color2)
{
	return DrawRectangleGradientH(posX, posY, width, height, *color1, *color2);
}

void mDrawRectangleGradientEx(Rectangle *rec, Color *col1, Color *col2, Color *col3, Color *col4)
{
	return DrawRectangleGradientEx(*rec, *col1, *col2, *col3, *col4);
}

void mDrawRectangleLines(int posX, int posY, int width, int height, Color *color)
{
	return DrawRectangleLines(posX, posY, width, height, *color);
}

void mDrawRectangleLinesEx(Rectangle *rec, float lineThick, Color *color)
{
	return DrawRectangleLinesEx(*rec, lineThick, *color);
}

void mDrawRectangleRounded(Rectangle *rec, float roundness, int segments, Color *color)
{
	return DrawRectangleRounded(*rec, roundness, segments, *color);
}

void mDrawRectangleRoundedLines(Rectangle *rec, float roundness, int segments, float lineThick, Color *color)
{
	return DrawRectangleRoundedLines(*rec, roundness, segments, lineThick, *color);
}

void mDrawTriangle(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color)
{
	return DrawTriangle(*v1, *v2, *v3, *color);
}

void mDrawTriangleLines(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color)
{
	return DrawTriangleLines(*v1, *v2, *v3, *color);
}

void mDrawTriangleFan(Vector2 * points, int pointCount, Color *color)
{
	return DrawTriangleFan(points, pointCount, *color);
}

void mDrawTriangleStrip(Vector2 * points, int pointCount, Color *color)
{
	return DrawTriangleStrip(points, pointCount, *color);
}

void mDrawPoly(Vector2 *center, int sides, float radius, float rotation, Color *color)
{
	return DrawPoly(*center, sides, radius, rotation, *color);
}

void mDrawPolyLines(Vector2 *center, int sides, float radius, float rotation, Color *color)
{
	return DrawPolyLines(*center, sides, radius, rotation, *color);
}

void mDrawPolyLinesEx(Vector2 *center, int sides, float radius, float rotation, float lineThick, Color *color)
{
	return DrawPolyLinesEx(*center, sides, radius, rotation, lineThick, *color);
}

bool mCheckCollisionRecs(Rectangle *rec1, Rectangle *rec2)
{
	return CheckCollisionRecs(*rec1, *rec2);
}

bool mCheckCollisionCircles(Vector2 *center1, float radius1, Vector2 *center2, float radius2)
{
	return CheckCollisionCircles(*center1, radius1, *center2, radius2);
}

bool mCheckCollisionCircleRec(Vector2 *center, float radius, Rectangle *rec)
{
	return CheckCollisionCircleRec(*center, radius, *rec);
}

bool mCheckCollisionPointRec(Vector2 *point, Rectangle *rec)
{
	return CheckCollisionPointRec(*point, *rec);
}

bool mCheckCollisionPointCircle(Vector2 *point, Vector2 *center, float radius)
{
	return CheckCollisionPointCircle(*point, *center, radius);
}

bool mCheckCollisionPointTriangle(Vector2 *point, Vector2 *p1, Vector2 *p2, Vector2 *p3)
{
	return CheckCollisionPointTriangle(*point, *p1, *p2, *p3);
}

bool mCheckCollisionLines(Vector2 *startPos1, Vector2 *endPos1, Vector2 *startPos2, Vector2 *endPos2, Vector2 * collisionPoint)
{
	return CheckCollisionLines(*startPos1, *endPos1, *startPos2, *endPos2, collisionPoint);
}

bool mCheckCollisionPointLine(Vector2 *point, Vector2 *p1, Vector2 *p2, int threshold)
{
	return CheckCollisionPointLine(*point, *p1, *p2, threshold);
}

void mGetCollisionRec(Rectangle *out, Rectangle *rec1, Rectangle *rec2)
{
	*out = GetCollisionRec(*rec1, *rec2);
}

void mLoadImage(Image *out, const char * fileName)
{
	*out = LoadImage(fileName);
}

void mLoadImageRaw(Image *out, const char * fileName, int width, int height, int format, int headerSize)
{
	*out = LoadImageRaw(fileName, width, height, format, headerSize);
}

void mLoadImageAnim(Image *out, const char * fileName, int * frames)
{
	*out = LoadImageAnim(fileName, frames);
}

void mLoadImageFromMemory(Image *out, const char * fileType, const unsigned char * fileData, int dataSize)
{
	*out = LoadImageFromMemory(fileType, fileData, dataSize);
}

void mLoadImageFromTexture(Image *out, Texture2D *texture)
{
	*out = LoadImageFromTexture(*texture);
}

void mLoadImageFromScreen(Image *out)
{
	*out = LoadImageFromScreen();
}

void mUnloadImage(Image *image)
{
	return UnloadImage(*image);
}

bool mExportImage(Image *image, const char * fileName)
{
	return ExportImage(*image, fileName);
}

bool mExportImageAsCode(Image *image, const char * fileName)
{
	return ExportImageAsCode(*image, fileName);
}

void mGenImageColor(Image *out, int width, int height, Color *color)
{
	*out = GenImageColor(width, height, *color);
}

void mGenImageGradientV(Image *out, int width, int height, Color *top, Color *bottom)
{
	*out = GenImageGradientV(width, height, *top, *bottom);
}

void mGenImageGradientH(Image *out, int width, int height, Color *left, Color *right)
{
	*out = GenImageGradientH(width, height, *left, *right);
}

void mGenImageGradientRadial(Image *out, int width, int height, float density, Color *inner, Color *outer)
{
	*out = GenImageGradientRadial(width, height, density, *inner, *outer);
}

void mGenImageChecked(Image *out, int width, int height, int checksX, int checksY, Color *col1, Color *col2)
{
	*out = GenImageChecked(width, height, checksX, checksY, *col1, *col2);
}

void mGenImageWhiteNoise(Image *out, int width, int height, float factor)
{
	*out = GenImageWhiteNoise(width, height, factor);
}

void mGenImageCellular(Image *out, int width, int height, int tileSize)
{
	*out = GenImageCellular(width, height, tileSize);
}

void mImageCopy(Image *out, Image *image)
{
	*out = ImageCopy(*image);
}

void mImageFromImage(Image *out, Image *image, Rectangle *rec)
{
	*out = ImageFromImage(*image, *rec);
}

void mImageText(Image *out, const char * text, int fontSize, Color *color)
{
	*out = ImageText(text, fontSize, *color);
}

void mImageTextEx(Image *out, Font *font, const char * text, float fontSize, float spacing, Color *tint)
{
	*out = ImageTextEx(*font, text, fontSize, spacing, *tint);
}

void mImageFormat(Image * image, int newFormat)
{
	return ImageFormat(image, newFormat);
}

void mImageToPOT(Image * image, Color *fill)
{
	return ImageToPOT(image, *fill);
}

void mImageCrop(Image * image, Rectangle *crop)
{
	return ImageCrop(image, *crop);
}

void mImageAlphaCrop(Image * image, float threshold)
{
	return ImageAlphaCrop(image, threshold);
}

void mImageAlphaClear(Image * image, Color *color, float threshold)
{
	return ImageAlphaClear(image, *color, threshold);
}

void mImageAlphaMask(Image * image, Image *alphaMask)
{
	return ImageAlphaMask(image, *alphaMask);
}

void mImageAlphaPremultiply(Image * image)
{
	return ImageAlphaPremultiply(image);
}

void mImageResize(Image * image, int newWidth, int newHeight)
{
	return ImageResize(image, newWidth, newHeight);
}

void mImageResizeNN(Image * image, int newWidth, int newHeight)
{
	return ImageResizeNN(image, newWidth, newHeight);
}

void mImageResizeCanvas(Image * image, int newWidth, int newHeight, int offsetX, int offsetY, Color *fill)
{
	return ImageResizeCanvas(image, newWidth, newHeight, offsetX, offsetY, *fill);
}

void mImageMipmaps(Image * image)
{
	return ImageMipmaps(image);
}

void mImageDither(Image * image, int rBpp, int gBpp, int bBpp, int aBpp)
{
	return ImageDither(image, rBpp, gBpp, bBpp, aBpp);
}

void mImageFlipVertical(Image * image)
{
	return ImageFlipVertical(image);
}

void mImageFlipHorizontal(Image * image)
{
	return ImageFlipHorizontal(image);
}

void mImageRotateCW(Image * image)
{
	return ImageRotateCW(image);
}

void mImageRotateCCW(Image * image)
{
	return ImageRotateCCW(image);
}

void mImageColorTint(Image * image, Color *color)
{
	return ImageColorTint(image, *color);
}

void mImageColorInvert(Image * image)
{
	return ImageColorInvert(image);
}

void mImageColorGrayscale(Image * image)
{
	return ImageColorGrayscale(image);
}

void mImageColorContrast(Image * image, float contrast)
{
	return ImageColorContrast(image, contrast);
}

void mImageColorBrightness(Image * image, int brightness)
{
	return ImageColorBrightness(image, brightness);
}

void mImageColorReplace(Image * image, Color *color, Color *replace)
{
	return ImageColorReplace(image, *color, *replace);
}

Color * mLoadImageColors(Image *image)
{
	return LoadImageColors(*image);
}

Color * mLoadImagePalette(Image *image, int maxPaletteSize, int * colorCount)
{
	return LoadImagePalette(*image, maxPaletteSize, colorCount);
}

void mUnloadImageColors(Color * colors)
{
	return UnloadImageColors(colors);
}

void mUnloadImagePalette(Color * colors)
{
	return UnloadImagePalette(colors);
}

void mGetImageAlphaBorder(Rectangle *out, Image *image, float threshold)
{
	*out = GetImageAlphaBorder(*image, threshold);
}

void mGetImageColor(Color *out, Image *image, int x, int y)
{
	*out = GetImageColor(*image, x, y);
}

void mImageClearBackground(Image * dst, Color *color)
{
	return ImageClearBackground(dst, *color);
}

void mImageDrawPixel(Image * dst, int posX, int posY, Color *color)
{
	return ImageDrawPixel(dst, posX, posY, *color);
}

void mImageDrawPixelV(Image * dst, Vector2 *position, Color *color)
{
	return ImageDrawPixelV(dst, *position, *color);
}

void mImageDrawLine(Image * dst, int startPosX, int startPosY, int endPosX, int endPosY, Color *color)
{
	return ImageDrawLine(dst, startPosX, startPosY, endPosX, endPosY, *color);
}

void mImageDrawLineV(Image * dst, Vector2 *start, Vector2 *end, Color *color)
{
	return ImageDrawLineV(dst, *start, *end, *color);
}

void mImageDrawCircle(Image * dst, int centerX, int centerY, int radius, Color *color)
{
	return ImageDrawCircle(dst, centerX, centerY, radius, *color);
}

void mImageDrawCircleV(Image * dst, Vector2 *center, int radius, Color *color)
{
	return ImageDrawCircleV(dst, *center, radius, *color);
}

void mImageDrawRectangle(Image * dst, int posX, int posY, int width, int height, Color *color)
{
	return ImageDrawRectangle(dst, posX, posY, width, height, *color);
}

void mImageDrawRectangleV(Image * dst, Vector2 *position, Vector2 *size, Color *color)
{
	return ImageDrawRectangleV(dst, *position, *size, *color);
}

void mImageDrawRectangleRec(Image * dst, Rectangle *rec, Color *color)
{
	return ImageDrawRectangleRec(dst, *rec, *color);
}

void mImageDrawRectangleLines(Image * dst, Rectangle *rec, int thick, Color *color)
{
	return ImageDrawRectangleLines(dst, *rec, thick, *color);
}

void mImageDraw(Image * dst, Image *src, Rectangle *srcRec, Rectangle *dstRec, Color *tint)
{
	return ImageDraw(dst, *src, *srcRec, *dstRec, *tint);
}

void mImageDrawText(Image * dst, const char * text, int posX, int posY, int fontSize, Color *color)
{
	return ImageDrawText(dst, text, posX, posY, fontSize, *color);
}

void mImageDrawTextEx(Image * dst, Font *font, const char * text, Vector2 *position, float fontSize, float spacing, Color *tint)
{
	return ImageDrawTextEx(dst, *font, text, *position, fontSize, spacing, *tint);
}

void mLoadTexture(Texture2D *out, const char * fileName)
{
	*out = LoadTexture(fileName);
}

void mLoadTextureFromImage(Texture2D *out, Image *image)
{
	*out = LoadTextureFromImage(*image);
}

void mLoadTextureCubemap(TextureCubemap *out, Image *image, int layout)
{
	*out = LoadTextureCubemap(*image, layout);
}

void mLoadRenderTexture(RenderTexture2D *out, int width, int height)
{
	*out = LoadRenderTexture(width, height);
}

void mUnloadTexture(Texture2D *texture)
{
	return UnloadTexture(*texture);
}

void mUnloadRenderTexture(RenderTexture2D *target)
{
	return UnloadRenderTexture(*target);
}

void mUpdateTexture(Texture2D *texture, const void * pixels)
{
	return UpdateTexture(*texture, pixels);
}

void mUpdateTextureRec(Texture2D *texture, Rectangle *rec, const void * pixels)
{
	return UpdateTextureRec(*texture, *rec, pixels);
}

void mGenTextureMipmaps(Texture2D * texture)
{
	return GenTextureMipmaps(texture);
}

void mSetTextureFilter(Texture2D *texture, int filter)
{
	return SetTextureFilter(*texture, filter);
}

void mSetTextureWrap(Texture2D *texture, int wrap)
{
	return SetTextureWrap(*texture, wrap);
}

void mDrawTexture(Texture2D *texture, int posX, int posY, Color *tint)
{
	return DrawTexture(*texture, posX, posY, *tint);
}

void mDrawTextureV(Texture2D *texture, Vector2 *position, Color *tint)
{
	return DrawTextureV(*texture, *position, *tint);
}

void mDrawTextureEx(Texture2D *texture, Vector2 *position, float rotation, float scale, Color *tint)
{
	return DrawTextureEx(*texture, *position, rotation, scale, *tint);
}

void mDrawTextureRec(Texture2D *texture, Rectangle *source, Vector2 *position, Color *tint)
{
	return DrawTextureRec(*texture, *source, *position, *tint);
}

void mDrawTextureQuad(Texture2D *texture, Vector2 *tiling, Vector2 *offset, Rectangle *quad, Color *tint)
{
	return DrawTextureQuad(*texture, *tiling, *offset, *quad, *tint);
}

void mDrawTextureTiled(Texture2D *texture, Rectangle *source, Rectangle *dest, Vector2 *origin, float rotation, float scale, Color *tint)
{
	return DrawTextureTiled(*texture, *source, *dest, *origin, rotation, scale, *tint);
}

void mDrawTexturePro(Texture2D *texture, Rectangle *source, Rectangle *dest, Vector2 *origin, float rotation, Color *tint)
{
	return DrawTexturePro(*texture, *source, *dest, *origin, rotation, *tint);
}

void mDrawTextureNPatch(Texture2D *texture, NPatchInfo *nPatchInfo, Rectangle *dest, Vector2 *origin, float rotation, Color *tint)
{
	return DrawTextureNPatch(*texture, *nPatchInfo, *dest, *origin, rotation, *tint);
}

void mDrawTexturePoly(Texture2D *texture, Vector2 *center, Vector2 * points, Vector2 * texcoords, int pointCount, Color *tint)
{
	return DrawTexturePoly(*texture, *center, points, texcoords, pointCount, *tint);
}

void mFade(Color *out, Color *color, float alpha)
{
	*out = Fade(*color, alpha);
}

int mColorToInt(Color *color)
{
	return ColorToInt(*color);
}

void mColorNormalize(Vector4 *out, Color *color)
{
	*out = ColorNormalize(*color);
}

void mColorFromNormalized(Color *out, Vector4 *normalized)
{
	*out = ColorFromNormalized(*normalized);
}

void mColorToHSV(Vector3 *out, Color *color)
{
	*out = ColorToHSV(*color);
}

void mColorFromHSV(Color *out, float hue, float saturation, float value)
{
	*out = ColorFromHSV(hue, saturation, value);
}

void mColorAlpha(Color *out, Color *color, float alpha)
{
	*out = ColorAlpha(*color, alpha);
}

void mColorAlphaBlend(Color *out, Color *dst, Color *src, Color *tint)
{
	*out = ColorAlphaBlend(*dst, *src, *tint);
}

void mGetColor(Color *out, unsigned int hexValue)
{
	*out = GetColor(hexValue);
}

void mGetPixelColor(Color *out, void * srcPtr, int format)
{
	*out = GetPixelColor(srcPtr, format);
}

void mSetPixelColor(void * dstPtr, Color *color, int format)
{
	return SetPixelColor(dstPtr, *color, format);
}

int mGetPixelDataSize(int width, int height, int format)
{
	return GetPixelDataSize(width, height, format);
}

void mGetFontDefault(Font *out)
{
	*out = GetFontDefault();
}

void mLoadFont(Font *out, const char * fileName)
{
	*out = LoadFont(fileName);
}

void mLoadFontEx(Font *out, const char * fileName, int fontSize, int * fontChars, int glyphCount)
{
	*out = LoadFontEx(fileName, fontSize, fontChars, glyphCount);
}

void mLoadFontFromImage(Font *out, Image *image, Color *key, int firstChar)
{
	*out = LoadFontFromImage(*image, *key, firstChar);
}

void mLoadFontFromMemory(Font *out, const char * fileType, const unsigned char * fileData, int dataSize, int fontSize, int * fontChars, int glyphCount)
{
	*out = LoadFontFromMemory(fileType, fileData, dataSize, fontSize, fontChars, glyphCount);
}

GlyphInfo * mLoadFontData(const unsigned char * fileData, int dataSize, int fontSize, int * fontChars, int glyphCount, int type)
{
	return LoadFontData(fileData, dataSize, fontSize, fontChars, glyphCount, type);
}

void mUnloadFontData(GlyphInfo * chars, int glyphCount)
{
	return UnloadFontData(chars, glyphCount);
}

void mUnloadFont(Font *font)
{
	return UnloadFont(*font);
}

bool mExportFontAsCode(Font *font, const char * fileName)
{
	return ExportFontAsCode(*font, fileName);
}

void mDrawFPS(int posX, int posY)
{
	return DrawFPS(posX, posY);
}

void mDrawText(const char * text, int posX, int posY, int fontSize, Color *color)
{
	return DrawText(text, posX, posY, fontSize, *color);
}

void mDrawTextEx(Font *font, const char * text, Vector2 *position, float fontSize, float spacing, Color *tint)
{
	return DrawTextEx(*font, text, *position, fontSize, spacing, *tint);
}

void mDrawTextPro(Font *font, const char * text, Vector2 *position, Vector2 *origin, float rotation, float fontSize, float spacing, Color *tint)
{
	return DrawTextPro(*font, text, *position, *origin, rotation, fontSize, spacing, *tint);
}

void mDrawTextCodepoint(Font *font, int codepoint, Vector2 *position, float fontSize, Color *tint)
{
	return DrawTextCodepoint(*font, codepoint, *position, fontSize, *tint);
}

void mDrawTextCodepoints(Font *font, const int * codepoints, int count, Vector2 *position, float fontSize, float spacing, Color *tint)
{
	return DrawTextCodepoints(*font, codepoints, count, *position, fontSize, spacing, *tint);
}

int mMeasureText(const char * text, int fontSize)
{
	return MeasureText(text, fontSize);
}

void mMeasureTextEx(Vector2 *out, Font *font, const char * text, float fontSize, float spacing)
{
	*out = MeasureTextEx(*font, text, fontSize, spacing);
}

int mGetGlyphIndex(Font *font, int codepoint)
{
	return GetGlyphIndex(*font, codepoint);
}

void mGetGlyphInfo(GlyphInfo *out, Font *font, int codepoint)
{
	*out = GetGlyphInfo(*font, codepoint);
}

void mGetGlyphAtlasRec(Rectangle *out, Font *font, int codepoint)
{
	*out = GetGlyphAtlasRec(*font, codepoint);
}

int * mLoadCodepoints(const char * text, int * count)
{
	return LoadCodepoints(text, count);
}

void mUnloadCodepoints(int * codepoints)
{
	return UnloadCodepoints(codepoints);
}

int mGetCodepointCount(const char * text)
{
	return GetCodepointCount(text);
}

int mGetCodepoint(const char * text, int * bytesProcessed)
{
	return GetCodepoint(text, bytesProcessed);
}

const char * mCodepointToUTF8(int codepoint, int * byteSize)
{
	return CodepointToUTF8(codepoint, byteSize);
}

char * mTextCodepointsToUTF8(const int * codepoints, int length)
{
	return TextCodepointsToUTF8(codepoints, length);
}

int mTextCopy(char * dst, const char * src)
{
	return TextCopy(dst, src);
}

bool mTextIsEqual(const char * text1, const char * text2)
{
	return TextIsEqual(text1, text2);
}

unsigned int mTextLength(const char * text)
{
	return TextLength(text);
}

const char * mTextSubtext(const char * text, int position, int length)
{
	return TextSubtext(text, position, length);
}

char * mTextReplace(char * text, const char * replace, const char * by)
{
	return TextReplace(text, replace, by);
}

char * mTextInsert(const char * text, const char * insert, int position)
{
	return TextInsert(text, insert, position);
}

int mTextFindIndex(const char * text, const char * find)
{
	return TextFindIndex(text, find);
}

const char * mTextToUpper(const char * text)
{
	return TextToUpper(text);
}

const char * mTextToLower(const char * text)
{
	return TextToLower(text);
}

const char * mTextToPascal(const char * text)
{
	return TextToPascal(text);
}

int mTextToInteger(const char * text)
{
	return TextToInteger(text);
}

void mDrawLine3D(Vector3 *startPos, Vector3 *endPos, Color *color)
{
	return DrawLine3D(*startPos, *endPos, *color);
}

void mDrawPoint3D(Vector3 *position, Color *color)
{
	return DrawPoint3D(*position, *color);
}

void mDrawCircle3D(Vector3 *center, float radius, Vector3 *rotationAxis, float rotationAngle, Color *color)
{
	return DrawCircle3D(*center, radius, *rotationAxis, rotationAngle, *color);
}

void mDrawTriangle3D(Vector3 *v1, Vector3 *v2, Vector3 *v3, Color *color)
{
	return DrawTriangle3D(*v1, *v2, *v3, *color);
}

void mDrawTriangleStrip3D(Vector3 * points, int pointCount, Color *color)
{
	return DrawTriangleStrip3D(points, pointCount, *color);
}

void mDrawCube(Vector3 *position, float width, float height, float length, Color *color)
{
	return DrawCube(*position, width, height, length, *color);
}

void mDrawCubeV(Vector3 *position, Vector3 *size, Color *color)
{
	return DrawCubeV(*position, *size, *color);
}

void mDrawCubeWires(Vector3 *position, float width, float height, float length, Color *color)
{
	return DrawCubeWires(*position, width, height, length, *color);
}

void mDrawCubeWiresV(Vector3 *position, Vector3 *size, Color *color)
{
	return DrawCubeWiresV(*position, *size, *color);
}

void mDrawCubeTexture(Texture2D *texture, Vector3 *position, float width, float height, float length, Color *color)
{
	return DrawCubeTexture(*texture, *position, width, height, length, *color);
}

void mDrawCubeTextureRec(Texture2D *texture, Rectangle *source, Vector3 *position, float width, float height, float length, Color *color)
{
	return DrawCubeTextureRec(*texture, *source, *position, width, height, length, *color);
}

void mDrawSphere(Vector3 *centerPos, float radius, Color *color)
{
	return DrawSphere(*centerPos, radius, *color);
}

void mDrawSphereEx(Vector3 *centerPos, float radius, int rings, int slices, Color *color)
{
	return DrawSphereEx(*centerPos, radius, rings, slices, *color);
}

void mDrawSphereWires(Vector3 *centerPos, float radius, int rings, int slices, Color *color)
{
	return DrawSphereWires(*centerPos, radius, rings, slices, *color);
}

void mDrawCylinder(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color)
{
	return DrawCylinder(*position, radiusTop, radiusBottom, height, slices, *color);
}

void mDrawCylinderEx(Vector3 *startPos, Vector3 *endPos, float startRadius, float endRadius, int sides, Color *color)
{
	return DrawCylinderEx(*startPos, *endPos, startRadius, endRadius, sides, *color);
}

void mDrawCylinderWires(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color)
{
	return DrawCylinderWires(*position, radiusTop, radiusBottom, height, slices, *color);
}

void mDrawCylinderWiresEx(Vector3 *startPos, Vector3 *endPos, float startRadius, float endRadius, int sides, Color *color)
{
	return DrawCylinderWiresEx(*startPos, *endPos, startRadius, endRadius, sides, *color);
}

void mDrawPlane(Vector3 *centerPos, Vector2 *size, Color *color)
{
	return DrawPlane(*centerPos, *size, *color);
}

void mDrawRay(Ray *ray, Color *color)
{
	return DrawRay(*ray, *color);
}

void mDrawGrid(int slices, float spacing)
{
	return DrawGrid(slices, spacing);
}

void mLoadModel(Model *out, const char * fileName)
{
	*out = LoadModel(fileName);
}

void mLoadModelFromMesh(Model *out, Mesh *mesh)
{
	*out = LoadModelFromMesh(*mesh);
}

void mUnloadModel(Model *model)
{
	return UnloadModel(*model);
}

void mUnloadModelKeepMeshes(Model *model)
{
	return UnloadModelKeepMeshes(*model);
}

void mGetModelBoundingBox(BoundingBox *out, Model *model)
{
	*out = GetModelBoundingBox(*model);
}

void mDrawModel(Model *model, Vector3 *position, float scale, Color *tint)
{
	return DrawModel(*model, *position, scale, *tint);
}

void mDrawModelEx(Model *model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint)
{
	return DrawModelEx(*model, *position, *rotationAxis, rotationAngle, *scale, *tint);
}

void mDrawModelWires(Model *model, Vector3 *position, float scale, Color *tint)
{
	return DrawModelWires(*model, *position, scale, *tint);
}

void mDrawModelWiresEx(Model *model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint)
{
	return DrawModelWiresEx(*model, *position, *rotationAxis, rotationAngle, *scale, *tint);
}

void mDrawBoundingBox(BoundingBox *box, Color *color)
{
	return DrawBoundingBox(*box, *color);
}

void mDrawBillboard(Camera *camera, Texture2D *texture, Vector3 *position, float size, Color *tint)
{
	return DrawBillboard(*camera, *texture, *position, size, *tint);
}

void mDrawBillboardRec(Camera *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector2 *size, Color *tint)
{
	return DrawBillboardRec(*camera, *texture, *source, *position, *size, *tint);
}

void mDrawBillboardPro(Camera *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector3 *up, Vector2 *size, Vector2 *origin, float rotation, Color *tint)
{
	return DrawBillboardPro(*camera, *texture, *source, *position, *up, *size, *origin, rotation, *tint);
}

void mUploadMesh(Mesh * mesh, bool dynamic)
{
	return UploadMesh(mesh, dynamic);
}

void mUpdateMeshBuffer(Mesh *mesh, int index, const void * data, int dataSize, int offset)
{
	return UpdateMeshBuffer(*mesh, index, data, dataSize, offset);
}

void mUnloadMesh(Mesh *mesh)
{
	return UnloadMesh(*mesh);
}

void mDrawMesh(Mesh *mesh, Material *material, Matrix *transform)
{
	return DrawMesh(*mesh, *material, *transform);
}

void mDrawMeshInstanced(Mesh *mesh, Material *material, const Matrix * transforms, int instances)
{
	return DrawMeshInstanced(*mesh, *material, transforms, instances);
}

bool mExportMesh(Mesh *mesh, const char * fileName)
{
	return ExportMesh(*mesh, fileName);
}

void mGetMeshBoundingBox(BoundingBox *out, Mesh *mesh)
{
	*out = GetMeshBoundingBox(*mesh);
}

void mGenMeshTangents(Mesh * mesh)
{
	return GenMeshTangents(mesh);
}

void mGenMeshBinormals(Mesh * mesh)
{
	return GenMeshBinormals(mesh);
}

void mGenMeshPoly(Mesh *out, int sides, float radius)
{
	*out = GenMeshPoly(sides, radius);
}

void mGenMeshPlane(Mesh *out, float width, float length, int resX, int resZ)
{
	*out = GenMeshPlane(width, length, resX, resZ);
}

void mGenMeshCube(Mesh *out, float width, float height, float length)
{
	*out = GenMeshCube(width, height, length);
}

void mGenMeshSphere(Mesh *out, float radius, int rings, int slices)
{
	*out = GenMeshSphere(radius, rings, slices);
}

void mGenMeshHemiSphere(Mesh *out, float radius, int rings, int slices)
{
	*out = GenMeshHemiSphere(radius, rings, slices);
}

void mGenMeshCylinder(Mesh *out, float radius, float height, int slices)
{
	*out = GenMeshCylinder(radius, height, slices);
}

void mGenMeshCone(Mesh *out, float radius, float height, int slices)
{
	*out = GenMeshCone(radius, height, slices);
}

void mGenMeshTorus(Mesh *out, float radius, float size, int radSeg, int sides)
{
	*out = GenMeshTorus(radius, size, radSeg, sides);
}

void mGenMeshKnot(Mesh *out, float radius, float size, int radSeg, int sides)
{
	*out = GenMeshKnot(radius, size, radSeg, sides);
}

void mGenMeshHeightmap(Mesh *out, Image *heightmap, Vector3 *size)
{
	*out = GenMeshHeightmap(*heightmap, *size);
}

void mGenMeshCubicmap(Mesh *out, Image *cubicmap, Vector3 *cubeSize)
{
	*out = GenMeshCubicmap(*cubicmap, *cubeSize);
}

Material * mLoadMaterials(const char * fileName, int * materialCount)
{
	return LoadMaterials(fileName, materialCount);
}

void mLoadMaterialDefault(Material *out)
{
	*out = LoadMaterialDefault();
}

void mUnloadMaterial(Material *material)
{
	return UnloadMaterial(*material);
}

void mSetMaterialTexture(Material * material, int mapType, Texture2D *texture)
{
	return SetMaterialTexture(material, mapType, *texture);
}

void mSetModelMeshMaterial(Model * model, int meshId, int materialId)
{
	return SetModelMeshMaterial(model, meshId, materialId);
}

ModelAnimation * mLoadModelAnimations(const char * fileName, unsigned int * animCount)
{
	return LoadModelAnimations(fileName, animCount);
}

void mUpdateModelAnimation(Model *model, ModelAnimation *anim, int frame)
{
	return UpdateModelAnimation(*model, *anim, frame);
}

void mUnloadModelAnimation(ModelAnimation *anim)
{
	return UnloadModelAnimation(*anim);
}

void mUnloadModelAnimations(ModelAnimation * animations, unsigned int count)
{
	return UnloadModelAnimations(animations, count);
}

bool mIsModelAnimationValid(Model *model, ModelAnimation *anim)
{
	return IsModelAnimationValid(*model, *anim);
}

bool mCheckCollisionSpheres(Vector3 *center1, float radius1, Vector3 *center2, float radius2)
{
	return CheckCollisionSpheres(*center1, radius1, *center2, radius2);
}

bool mCheckCollisionBoxes(BoundingBox *box1, BoundingBox *box2)
{
	return CheckCollisionBoxes(*box1, *box2);
}

bool mCheckCollisionBoxSphere(BoundingBox *box, Vector3 *center, float radius)
{
	return CheckCollisionBoxSphere(*box, *center, radius);
}

void mGetRayCollisionSphere(RayCollision *out, Ray *ray, Vector3 *center, float radius)
{
	*out = GetRayCollisionSphere(*ray, *center, radius);
}

void mGetRayCollisionBox(RayCollision *out, Ray *ray, BoundingBox *box)
{
	*out = GetRayCollisionBox(*ray, *box);
}

void mGetRayCollisionMesh(RayCollision *out, Ray *ray, Mesh *mesh, Matrix *transform)
{
	*out = GetRayCollisionMesh(*ray, *mesh, *transform);
}

void mGetRayCollisionTriangle(RayCollision *out, Ray *ray, Vector3 *p1, Vector3 *p2, Vector3 *p3)
{
	*out = GetRayCollisionTriangle(*ray, *p1, *p2, *p3);
}

void mGetRayCollisionQuad(RayCollision *out, Ray *ray, Vector3 *p1, Vector3 *p2, Vector3 *p3, Vector3 *p4)
{
	*out = GetRayCollisionQuad(*ray, *p1, *p2, *p3, *p4);
}

void mInitAudioDevice(void)
{
	return InitAudioDevice();
}

void mCloseAudioDevice(void)
{
	return CloseAudioDevice();
}

bool mIsAudioDeviceReady(void)
{
	return IsAudioDeviceReady();
}

void mSetMasterVolume(float volume)
{
	return SetMasterVolume(volume);
}

void mLoadWave(Wave *out, const char * fileName)
{
	*out = LoadWave(fileName);
}

void mLoadWaveFromMemory(Wave *out, const char * fileType, const unsigned char * fileData, int dataSize)
{
	*out = LoadWaveFromMemory(fileType, fileData, dataSize);
}

void mLoadSound(Sound *out, const char * fileName)
{
	*out = LoadSound(fileName);
}

void mLoadSoundFromWave(Sound *out, Wave *wave)
{
	*out = LoadSoundFromWave(*wave);
}

void mUpdateSound(Sound *sound, const void * data, int sampleCount)
{
	return UpdateSound(*sound, data, sampleCount);
}

void mUnloadWave(Wave *wave)
{
	return UnloadWave(*wave);
}

void mUnloadSound(Sound *sound)
{
	return UnloadSound(*sound);
}

bool mExportWave(Wave *wave, const char * fileName)
{
	return ExportWave(*wave, fileName);
}

bool mExportWaveAsCode(Wave *wave, const char * fileName)
{
	return ExportWaveAsCode(*wave, fileName);
}

void mPlaySound(Sound *sound)
{
	return PlaySound(*sound);
}

void mStopSound(Sound *sound)
{
	return StopSound(*sound);
}

void mPauseSound(Sound *sound)
{
	return PauseSound(*sound);
}

void mResumeSound(Sound *sound)
{
	return ResumeSound(*sound);
}

void mPlaySoundMulti(Sound *sound)
{
	return PlaySoundMulti(*sound);
}

void mStopSoundMulti(void)
{
	return StopSoundMulti();
}

int mGetSoundsPlaying(void)
{
	return GetSoundsPlaying();
}

bool mIsSoundPlaying(Sound *sound)
{
	return IsSoundPlaying(*sound);
}

void mSetSoundVolume(Sound *sound, float volume)
{
	return SetSoundVolume(*sound, volume);
}

void mSetSoundPitch(Sound *sound, float pitch)
{
	return SetSoundPitch(*sound, pitch);
}

void mSetSoundPan(Sound *sound, float pan)
{
	return SetSoundPan(*sound, pan);
}

void mWaveCopy(Wave *out, Wave *wave)
{
	*out = WaveCopy(*wave);
}

void mWaveCrop(Wave * wave, int initSample, int finalSample)
{
	return WaveCrop(wave, initSample, finalSample);
}

void mWaveFormat(Wave * wave, int sampleRate, int sampleSize, int channels)
{
	return WaveFormat(wave, sampleRate, sampleSize, channels);
}

float * mLoadWaveSamples(Wave *wave)
{
	return LoadWaveSamples(*wave);
}

void mUnloadWaveSamples(float * samples)
{
	return UnloadWaveSamples(samples);
}

void mLoadMusicStream(Music *out, const char * fileName)
{
	*out = LoadMusicStream(fileName);
}

void mLoadMusicStreamFromMemory(Music *out, const char * fileType, const unsigned char * data, int dataSize)
{
	*out = LoadMusicStreamFromMemory(fileType, data, dataSize);
}

void mUnloadMusicStream(Music *music)
{
	return UnloadMusicStream(*music);
}

void mPlayMusicStream(Music *music)
{
	return PlayMusicStream(*music);
}

bool mIsMusicStreamPlaying(Music *music)
{
	return IsMusicStreamPlaying(*music);
}

void mUpdateMusicStream(Music *music)
{
	return UpdateMusicStream(*music);
}

void mStopMusicStream(Music *music)
{
	return StopMusicStream(*music);
}

void mPauseMusicStream(Music *music)
{
	return PauseMusicStream(*music);
}

void mResumeMusicStream(Music *music)
{
	return ResumeMusicStream(*music);
}

void mSeekMusicStream(Music *music, float position)
{
	return SeekMusicStream(*music, position);
}

void mSetMusicVolume(Music *music, float volume)
{
	return SetMusicVolume(*music, volume);
}

void mSetMusicPitch(Music *music, float pitch)
{
	return SetMusicPitch(*music, pitch);
}

void mSetMusicPan(Music *music, float pan)
{
	return SetMusicPan(*music, pan);
}

float mGetMusicTimeLength(Music *music)
{
	return GetMusicTimeLength(*music);
}

float mGetMusicTimePlayed(Music *music)
{
	return GetMusicTimePlayed(*music);
}

void mLoadAudioStream(AudioStream *out, unsigned int sampleRate, unsigned int sampleSize, unsigned int channels)
{
	*out = LoadAudioStream(sampleRate, sampleSize, channels);
}

void mUnloadAudioStream(AudioStream *stream)
{
	return UnloadAudioStream(*stream);
}

void mUpdateAudioStream(AudioStream *stream, const void * data, int frameCount)
{
	return UpdateAudioStream(*stream, data, frameCount);
}

bool mIsAudioStreamProcessed(AudioStream *stream)
{
	return IsAudioStreamProcessed(*stream);
}

void mPlayAudioStream(AudioStream *stream)
{
	return PlayAudioStream(*stream);
}

void mPauseAudioStream(AudioStream *stream)
{
	return PauseAudioStream(*stream);
}

void mResumeAudioStream(AudioStream *stream)
{
	return ResumeAudioStream(*stream);
}

bool mIsAudioStreamPlaying(AudioStream *stream)
{
	return IsAudioStreamPlaying(*stream);
}

void mStopAudioStream(AudioStream *stream)
{
	return StopAudioStream(*stream);
}

void mSetAudioStreamVolume(AudioStream *stream, float volume)
{
	return SetAudioStreamVolume(*stream, volume);
}

void mSetAudioStreamPitch(AudioStream *stream, float pitch)
{
	return SetAudioStreamPitch(*stream, pitch);
}

void mSetAudioStreamPan(AudioStream *stream, float pan)
{
	return SetAudioStreamPan(*stream, pan);
}

void mSetAudioStreamBufferSizeDefault(int size)
{
	return SetAudioStreamBufferSizeDefault(size);
}

void mSetAudioStreamCallback(AudioStream *stream, AudioCallback *callback)
{
	return SetAudioStreamCallback(*stream, *callback);
}

void mAttachAudioStreamProcessor(AudioStream *stream, AudioCallback *processor)
{
	return AttachAudioStreamProcessor(*stream, *processor);
}

void mDetachAudioStreamProcessor(AudioStream *stream, AudioCallback *processor)
{
	return DetachAudioStreamProcessor(*stream, *processor);
}

float mClamp(float value, float min, float max)
{
	return Clamp(value, min, max);
}

float mLerp(float start, float end, float amount)
{
	return Lerp(start, end, amount);
}

float mNormalize(float value, float start, float end)
{
	return Normalize(value, start, end);
}

float mRemap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd)
{
	return Remap(value, inputStart, inputEnd, outputStart, outputEnd);
}

void mVector2Zero(Vector2 *out)
{
	*out = Vector2Zero();
}

void mVector2One(Vector2 *out)
{
	*out = Vector2One();
}

void mVector2Add(Vector2 *out, Vector2 *v1, Vector2 *v2)
{
	*out = Vector2Add(*v1, *v2);
}

void mVector2AddValue(Vector2 *out, Vector2 *v, float add)
{
	*out = Vector2AddValue(*v, add);
}

void mVector2Subtract(Vector2 *out, Vector2 *v1, Vector2 *v2)
{
	*out = Vector2Subtract(*v1, *v2);
}

void mVector2SubtractValue(Vector2 *out, Vector2 *v, float sub)
{
	*out = Vector2SubtractValue(*v, sub);
}

float mVector2Length(Vector2 *v)
{
	return Vector2Length(*v);
}

float mVector2LengthSqr(Vector2 *v)
{
	return Vector2LengthSqr(*v);
}

float mVector2DotProduct(Vector2 *v1, Vector2 *v2)
{
	return Vector2DotProduct(*v1, *v2);
}

float mVector2Distance(Vector2 *v1, Vector2 *v2)
{
	return Vector2Distance(*v1, *v2);
}

float mVector2DistanceSqr(Vector2 *v1, Vector2 *v2)
{
	return Vector2DistanceSqr(*v1, *v2);
}

float mVector2Angle(Vector2 *v1, Vector2 *v2)
{
	return Vector2Angle(*v1, *v2);
}

void mVector2Scale(Vector2 *out, Vector2 *v, float scale)
{
	*out = Vector2Scale(*v, scale);
}

void mVector2Multiply(Vector2 *out, Vector2 *v1, Vector2 *v2)
{
	*out = Vector2Multiply(*v1, *v2);
}

void mVector2Negate(Vector2 *out, Vector2 *v)
{
	*out = Vector2Negate(*v);
}

void mVector2Divide(Vector2 *out, Vector2 *v1, Vector2 *v2)
{
	*out = Vector2Divide(*v1, *v2);
}

void mVector2Normalize(Vector2 *out, Vector2 *v)
{
	*out = Vector2Normalize(*v);
}

void mVector2Transform(Vector2 *out, Vector2 *v, Matrix *mat)
{
	*out = Vector2Transform(*v, *mat);
}

void mVector2Lerp(Vector2 *out, Vector2 *v1, Vector2 *v2, float amount)
{
	*out = Vector2Lerp(*v1, *v2, amount);
}

void mVector2Reflect(Vector2 *out, Vector2 *v, Vector2 *normal)
{
	*out = Vector2Reflect(*v, *normal);
}

void mVector2Rotate(Vector2 *out, Vector2 *v, float angle)
{
	*out = Vector2Rotate(*v, angle);
}

void mVector2MoveTowards(Vector2 *out, Vector2 *v, Vector2 *target, float maxDistance)
{
	*out = Vector2MoveTowards(*v, *target, maxDistance);
}

void mVector3Zero(Vector3 *out)
{
	*out = Vector3Zero();
}

void mVector3One(Vector3 *out)
{
	*out = Vector3One();
}

void mVector3Add(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Add(*v1, *v2);
}

void mVector3AddValue(Vector3 *out, Vector3 *v, float add)
{
	*out = Vector3AddValue(*v, add);
}

void mVector3Subtract(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Subtract(*v1, *v2);
}

void mVector3SubtractValue(Vector3 *out, Vector3 *v, float sub)
{
	*out = Vector3SubtractValue(*v, sub);
}

void mVector3Scale(Vector3 *out, Vector3 *v, float scalar)
{
	*out = Vector3Scale(*v, scalar);
}

void mVector3Multiply(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Multiply(*v1, *v2);
}

void mVector3CrossProduct(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3CrossProduct(*v1, *v2);
}

void mVector3Perpendicular(Vector3 *out, Vector3 *v)
{
	*out = Vector3Perpendicular(*v);
}

float mVector3Length(const Vector3 *v)
{
	return Vector3Length(*v);
}

float mVector3LengthSqr(const Vector3 *v)
{
	return Vector3LengthSqr(*v);
}

float mVector3DotProduct(Vector3 *v1, Vector3 *v2)
{
	return Vector3DotProduct(*v1, *v2);
}

float mVector3Distance(Vector3 *v1, Vector3 *v2)
{
	return Vector3Distance(*v1, *v2);
}

float mVector3DistanceSqr(Vector3 *v1, Vector3 *v2)
{
	return Vector3DistanceSqr(*v1, *v2);
}

float mVector3Angle(Vector3 *v1, Vector3 *v2)
{
	return Vector3Angle(*v1, *v2);
}

void mVector3Negate(Vector3 *out, Vector3 *v)
{
	*out = Vector3Negate(*v);
}

void mVector3Divide(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Divide(*v1, *v2);
}

void mVector3Normalize(Vector3 *out, Vector3 *v)
{
	*out = Vector3Normalize(*v);
}

void mVector3OrthoNormalize(Vector3 * v1, Vector3 * v2)
{
	return Vector3OrthoNormalize(v1, v2);
}

void mVector3Transform(Vector3 *out, Vector3 *v, Matrix *mat)
{
	*out = Vector3Transform(*v, *mat);
}

void mVector3RotateByQuaternion(Vector3 *out, Vector3 *v, Quaternion *q)
{
	*out = Vector3RotateByQuaternion(*v, *q);
}

void mVector3Lerp(Vector3 *out, Vector3 *v1, Vector3 *v2, float amount)
{
	*out = Vector3Lerp(*v1, *v2, amount);
}

void mVector3Reflect(Vector3 *out, Vector3 *v, Vector3 *normal)
{
	*out = Vector3Reflect(*v, *normal);
}

void mVector3Min(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Min(*v1, *v2);
}

void mVector3Max(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Max(*v1, *v2);
}

void mVector3Barycenter(Vector3 *out, Vector3 *p, Vector3 *a, Vector3 *b, Vector3 *c)
{
	*out = Vector3Barycenter(*p, *a, *b, *c);
}

void mVector3Unproject(Vector3 *out, Vector3 *source, Matrix *projection, Matrix *view)
{
	*out = Vector3Unproject(*source, *projection, *view);
}

void mVector3ToFloatV(float3 *out, Vector3 *v)
{
	*out = Vector3ToFloatV(*v);
}

float mMatrixDeterminant(Matrix *mat)
{
	return MatrixDeterminant(*mat);
}

float mMatrixTrace(Matrix *mat)
{
	return MatrixTrace(*mat);
}

void mMatrixTranspose(Matrix *out, Matrix *mat)
{
	*out = MatrixTranspose(*mat);
}

void mMatrixInvert(Matrix *out, Matrix *mat)
{
	*out = MatrixInvert(*mat);
}

void mMatrixIdentity(Matrix *out)
{
	*out = MatrixIdentity();
}

void mMatrixAdd(Matrix *out, Matrix *left, Matrix *right)
{
	*out = MatrixAdd(*left, *right);
}

void mMatrixSubtract(Matrix *out, Matrix *left, Matrix *right)
{
	*out = MatrixSubtract(*left, *right);
}

void mMatrixMultiply(Matrix *out, Matrix *left, Matrix *right)
{
	*out = MatrixMultiply(*left, *right);
}

void mMatrixTranslate(Matrix *out, float x, float y, float z)
{
	*out = MatrixTranslate(x, y, z);
}

void mMatrixRotate(Matrix *out, Vector3 *axis, float angle)
{
	*out = MatrixRotate(*axis, angle);
}

void mMatrixRotateX(Matrix *out, float angle)
{
	*out = MatrixRotateX(angle);
}

void mMatrixRotateY(Matrix *out, float angle)
{
	*out = MatrixRotateY(angle);
}

void mMatrixRotateZ(Matrix *out, float angle)
{
	*out = MatrixRotateZ(angle);
}

void mMatrixRotateXYZ(Matrix *out, Vector3 *ang)
{
	*out = MatrixRotateXYZ(*ang);
}

void mMatrixRotateZYX(Matrix *out, Vector3 *ang)
{
	*out = MatrixRotateZYX(*ang);
}

void mMatrixScale(Matrix *out, float x, float y, float z)
{
	*out = MatrixScale(x, y, z);
}

void mMatrixFrustum(Matrix *out, double left, double right, double bottom, double top, double near, double far)
{
	*out = MatrixFrustum(left, right, bottom, top, near, far);
}

void mMatrixPerspective(Matrix *out, double fovy, double aspect, double near, double far)
{
	*out = MatrixPerspective(fovy, aspect, near, far);
}

void mMatrixOrtho(Matrix *out, double left, double right, double bottom, double top, double near, double far)
{
	*out = MatrixOrtho(left, right, bottom, top, near, far);
}

void mMatrixLookAt(Matrix *out, Vector3 *eye, Vector3 *target, Vector3 *up)
{
	*out = MatrixLookAt(*eye, *target, *up);
}

void mMatrixToFloatV(float16 *out, Matrix *mat)
{
	*out = MatrixToFloatV(*mat);
}

void mQuaternionAdd(Quaternion *out, Quaternion *q1, Quaternion *q2)
{
	*out = QuaternionAdd(*q1, *q2);
}

void mQuaternionAddValue(Quaternion *out, Quaternion *q, float add)
{
	*out = QuaternionAddValue(*q, add);
}

void mQuaternionSubtract(Quaternion *out, Quaternion *q1, Quaternion *q2)
{
	*out = QuaternionSubtract(*q1, *q2);
}

void mQuaternionSubtractValue(Quaternion *out, Quaternion *q, float sub)
{
	*out = QuaternionSubtractValue(*q, sub);
}

void mQuaternionIdentity(Quaternion *out)
{
	*out = QuaternionIdentity();
}

float mQuaternionLength(Quaternion *q)
{
	return QuaternionLength(*q);
}

void mQuaternionNormalize(Quaternion *out, Quaternion *q)
{
	*out = QuaternionNormalize(*q);
}

void mQuaternionInvert(Quaternion *out, Quaternion *q)
{
	*out = QuaternionInvert(*q);
}

void mQuaternionMultiply(Quaternion *out, Quaternion *q1, Quaternion *q2)
{
	*out = QuaternionMultiply(*q1, *q2);
}

void mQuaternionScale(Quaternion *out, Quaternion *q, float mul)
{
	*out = QuaternionScale(*q, mul);
}

void mQuaternionDivide(Quaternion *out, Quaternion *q1, Quaternion *q2)
{
	*out = QuaternionDivide(*q1, *q2);
}

void mQuaternionLerp(Quaternion *out, Quaternion *q1, Quaternion *q2, float amount)
{
	*out = QuaternionLerp(*q1, *q2, amount);
}

void mQuaternionNlerp(Quaternion *out, Quaternion *q1, Quaternion *q2, float amount)
{
	*out = QuaternionNlerp(*q1, *q2, amount);
}

void mQuaternionSlerp(Quaternion *out, Quaternion *q1, Quaternion *q2, float amount)
{
	*out = QuaternionSlerp(*q1, *q2, amount);
}

void mQuaternionFromVector3ToVector3(Quaternion *out, Vector3 *from, Vector3 *to)
{
	*out = QuaternionFromVector3ToVector3(*from, *to);
}

void mQuaternionFromMatrix(Quaternion *out, Matrix *mat)
{
	*out = QuaternionFromMatrix(*mat);
}

void mQuaternionToMatrix(Matrix *out, Quaternion *q)
{
	*out = QuaternionToMatrix(*q);
}

void mQuaternionFromAxisAngle(Quaternion *out, Vector3 *axis, float angle)
{
	*out = QuaternionFromAxisAngle(*axis, angle);
}

void mQuaternionToAxisAngle(Quaternion *q, Vector3 * outAxis, float * outAngle)
{
	return QuaternionToAxisAngle(*q, outAxis, outAngle);
}

void mQuaternionFromEuler(Quaternion *out, float pitch, float yaw, float roll)
{
	*out = QuaternionFromEuler(pitch, yaw, roll);
}

void mQuaternionToEuler(Vector3 *out, Quaternion *q)
{
	*out = QuaternionToEuler(*q);
}

void mQuaternionTransform(Quaternion *out, Quaternion *q, Matrix *mat)
{
	*out = QuaternionTransform(*q, *mat);
}

