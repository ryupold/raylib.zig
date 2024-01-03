#define GRAPHICS_API_OPENGL_11
// #define RLGL_IMPLEMENTATION
#include "raylib.h"
#include "rlgl.h"
#include "raymath.h"
void mInitWindow(int width, int height, const char * title)
{
	InitWindow(width, height, title);
}

void mCloseWindow(void)
{
	CloseWindow();
}

bool mWindowShouldClose(void)
{
	return WindowShouldClose();
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
	SetWindowState(flags);
}

void mClearWindowState(unsigned int flags)
{
	ClearWindowState(flags);
}

void mToggleFullscreen(void)
{
	ToggleFullscreen();
}

void mToggleBorderlessWindowed(void)
{
	ToggleBorderlessWindowed();
}

void mMaximizeWindow(void)
{
	MaximizeWindow();
}

void mMinimizeWindow(void)
{
	MinimizeWindow();
}

void mRestoreWindow(void)
{
	RestoreWindow();
}

void mSetWindowIcon(Image *image)
{
	SetWindowIcon(*image);
}

void mSetWindowIcons(Image * images, int count)
{
	SetWindowIcons(images, count);
}

void mSetWindowTitle(const char * title)
{
	SetWindowTitle(title);
}

void mSetWindowPosition(int x, int y)
{
	SetWindowPosition(x, y);
}

void mSetWindowMonitor(int monitor)
{
	SetWindowMonitor(monitor);
}

void mSetWindowMinSize(int width, int height)
{
	SetWindowMinSize(width, height);
}

void mSetWindowMaxSize(int width, int height)
{
	SetWindowMaxSize(width, height);
}

void mSetWindowSize(int width, int height)
{
	SetWindowSize(width, height);
}

void mSetWindowOpacity(float opacity)
{
	SetWindowOpacity(opacity);
}

void mSetWindowFocused(void)
{
	SetWindowFocused();
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
	SetClipboardText(text);
}

const char * mGetClipboardText(void)
{
	return GetClipboardText();
}

void mEnableEventWaiting(void)
{
	EnableEventWaiting();
}

void mDisableEventWaiting(void)
{
	DisableEventWaiting();
}

void mShowCursor(void)
{
	ShowCursor();
}

void mHideCursor(void)
{
	HideCursor();
}

bool mIsCursorHidden(void)
{
	return IsCursorHidden();
}

void mEnableCursor(void)
{
	EnableCursor();
}

void mDisableCursor(void)
{
	DisableCursor();
}

bool mIsCursorOnScreen(void)
{
	return IsCursorOnScreen();
}

void mClearBackground(Color *color)
{
	ClearBackground(*color);
}

void mBeginDrawing(void)
{
	BeginDrawing();
}

void mEndDrawing(void)
{
	EndDrawing();
}

void mBeginMode2D(Camera2D *camera)
{
	BeginMode2D(*camera);
}

void mEndMode2D(void)
{
	EndMode2D();
}

void mBeginMode3D(Camera3D *camera)
{
	BeginMode3D(*camera);
}

void mEndMode3D(void)
{
	EndMode3D();
}

void mBeginTextureMode(RenderTexture2D *target)
{
	BeginTextureMode(*target);
}

void mEndTextureMode(void)
{
	EndTextureMode();
}

void mBeginShaderMode(Shader *shader)
{
	BeginShaderMode(*shader);
}

void mEndShaderMode(void)
{
	EndShaderMode();
}

void mBeginBlendMode(int mode)
{
	BeginBlendMode(mode);
}

void mEndBlendMode(void)
{
	EndBlendMode();
}

void mBeginScissorMode(int x, int y, int width, int height)
{
	BeginScissorMode(x, y, width, height);
}

void mEndScissorMode(void)
{
	EndScissorMode();
}

void mBeginVrStereoMode(VrStereoConfig *config)
{
	BeginVrStereoMode(*config);
}

void mEndVrStereoMode(void)
{
	EndVrStereoMode();
}

void mLoadVrStereoConfig(VrStereoConfig *out, VrDeviceInfo *device)
{
	*out = LoadVrStereoConfig(*device);
}

void mUnloadVrStereoConfig(VrStereoConfig *config)
{
	UnloadVrStereoConfig(*config);
}

void mLoadShader(Shader *out, const char * vsFileName, const char * fsFileName)
{
	*out = LoadShader(vsFileName, fsFileName);
}

void mLoadShaderFromMemory(Shader *out, const char * vsCode, const char * fsCode)
{
	*out = LoadShaderFromMemory(vsCode, fsCode);
}

bool mIsShaderReady(Shader *shader)
{
	return IsShaderReady(*shader);
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
	SetShaderValue(*shader, locIndex, value, uniformType);
}

void mSetShaderValueV(Shader *shader, int locIndex, const void * value, int uniformType, int count)
{
	SetShaderValueV(*shader, locIndex, value, uniformType, count);
}

void mSetShaderValueMatrix(Shader *shader, int locIndex, Matrix *mat)
{
	SetShaderValueMatrix(*shader, locIndex, *mat);
}

void mSetShaderValueTexture(Shader *shader, int locIndex, Texture2D *texture)
{
	SetShaderValueTexture(*shader, locIndex, *texture);
}

void mUnloadShader(Shader *shader)
{
	UnloadShader(*shader);
}

void mGetMouseRay(Ray *out, Vector2 *mousePosition, Camera3D *camera)
{
	*out = GetMouseRay(*mousePosition, *camera);
}

void mGetCameraMatrix(Matrix *out, Camera3D *camera)
{
	*out = GetCameraMatrix(*camera);
}

void mGetCameraMatrix2D(Matrix *out, Camera2D *camera)
{
	*out = GetCameraMatrix2D(*camera);
}

void mGetWorldToScreen(Vector2 *out, Vector3 *position, Camera3D *camera)
{
	*out = GetWorldToScreen(*position, *camera);
}

void mGetScreenToWorld2D(Vector2 *out, Vector2 *position, Camera2D *camera)
{
	*out = GetScreenToWorld2D(*position, *camera);
}

void mGetWorldToScreenEx(Vector2 *out, Vector3 *position, Camera3D *camera, int width, int height)
{
	*out = GetWorldToScreenEx(*position, *camera, width, height);
}

void mGetWorldToScreen2D(Vector2 *out, Vector2 *position, Camera2D *camera)
{
	*out = GetWorldToScreen2D(*position, *camera);
}

void mSetTargetFPS(int fps)
{
	SetTargetFPS(fps);
}

float mGetFrameTime(void)
{
	return GetFrameTime();
}

double mGetTime(void)
{
	return GetTime();
}

int mGetFPS(void)
{
	return GetFPS();
}

void mSwapScreenBuffer(void)
{
	SwapScreenBuffer();
}

void mPollInputEvents(void)
{
	PollInputEvents();
}

void mWaitTime(double seconds)
{
	WaitTime(seconds);
}

void mSetRandomSeed(unsigned int seed)
{
	SetRandomSeed(seed);
}

int mGetRandomValue(int min, int max)
{
	return GetRandomValue(min, max);
}

int * mLoadRandomSequence(unsigned int count, int min, int max)
{
	return LoadRandomSequence(count, min, max);
}

void mUnloadRandomSequence(int * sequence)
{
	UnloadRandomSequence(sequence);
}

void mTakeScreenshot(const char * fileName)
{
	TakeScreenshot(fileName);
}

void mOpenURL(const char * url)
{
	OpenURL(url);
}

void mSetTraceLogLevel(int logLevel)
{
	SetTraceLogLevel(logLevel);
}

void mSetLoadFileDataCallback(LoadFileDataCallback callback)
{
	SetLoadFileDataCallback(callback);
}

void mSetSaveFileDataCallback(SaveFileDataCallback callback)
{
	SetSaveFileDataCallback(callback);
}

void mSetLoadFileTextCallback(LoadFileTextCallback callback)
{
	SetLoadFileTextCallback(callback);
}

void mSetSaveFileTextCallback(SaveFileTextCallback callback)
{
	SetSaveFileTextCallback(callback);
}

bool mSaveFileData(const char * fileName, void * data, int dataSize)
{
	return SaveFileData(fileName, data, dataSize);
}

bool mExportDataAsCode(const unsigned char * data, int dataSize, const char * fileName)
{
	return ExportDataAsCode(data, dataSize, fileName);
}

char * mLoadFileText(const char * fileName)
{
	return LoadFileText(fileName);
}

void mUnloadFileText(char * text)
{
	UnloadFileText(text);
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

bool mChangeDirectory(const char * dir)
{
	return ChangeDirectory(dir);
}

bool mIsPathFile(const char * path)
{
	return IsPathFile(path);
}

void mLoadDirectoryFiles(FilePathList *out, const char * dirPath)
{
	*out = LoadDirectoryFiles(dirPath);
}

void mLoadDirectoryFilesEx(FilePathList *out, const char * basePath, const char * filter, bool scanSubdirs)
{
	*out = LoadDirectoryFilesEx(basePath, filter, scanSubdirs);
}

void mUnloadDirectoryFiles(FilePathList *files)
{
	UnloadDirectoryFiles(*files);
}

bool mIsFileDropped(void)
{
	return IsFileDropped();
}

void mLoadDroppedFiles(FilePathList *out)
{
	*out = LoadDroppedFiles();
}

void mUnloadDroppedFiles(FilePathList *files)
{
	UnloadDroppedFiles(*files);
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

void mLoadAutomationEventList(AutomationEventList *out, const char * fileName)
{
	*out = LoadAutomationEventList(fileName);
}

void mUnloadAutomationEventList(AutomationEventList *list)
{
	UnloadAutomationEventList(*list);
}

bool mExportAutomationEventList(AutomationEventList *list, const char * fileName)
{
	return ExportAutomationEventList(*list, fileName);
}

void mSetAutomationEventList(AutomationEventList * list)
{
	SetAutomationEventList(list);
}

void mSetAutomationEventBaseFrame(int frame)
{
	SetAutomationEventBaseFrame(frame);
}

void mStartAutomationEventRecording(void)
{
	StartAutomationEventRecording();
}

void mStopAutomationEventRecording(void)
{
	StopAutomationEventRecording();
}

void mPlayAutomationEvent(AutomationEvent *event)
{
	PlayAutomationEvent(*event);
}

bool mIsKeyPressed(int key)
{
	return IsKeyPressed(key);
}

bool mIsKeyPressedRepeat(int key)
{
	return IsKeyPressedRepeat(key);
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

int mGetKeyPressed(void)
{
	return GetKeyPressed();
}

int mGetCharPressed(void)
{
	return GetCharPressed();
}

void mSetExitKey(int key)
{
	SetExitKey(key);
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
	SetMousePosition(x, y);
}

void mSetMouseOffset(int offsetX, int offsetY)
{
	SetMouseOffset(offsetX, offsetY);
}

void mSetMouseScale(float scaleX, float scaleY)
{
	SetMouseScale(scaleX, scaleY);
}

float mGetMouseWheelMove(void)
{
	return GetMouseWheelMove();
}

void mGetMouseWheelMoveV(Vector2 *out)
{
	*out = GetMouseWheelMoveV();
}

void mSetMouseCursor(int cursor)
{
	SetMouseCursor(cursor);
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
	SetGesturesEnabled(flags);
}

bool mIsGestureDetected(unsigned int gesture)
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

void mUpdateCamera(Camera * camera, int mode)
{
	UpdateCamera(camera, mode);
}

void mUpdateCameraPro(Camera * camera, Vector3 *movement, Vector3 *rotation, float zoom)
{
	UpdateCameraPro(camera, *movement, *rotation, zoom);
}

void mSetShapesTexture(Texture2D *texture, Rectangle *source)
{
	SetShapesTexture(*texture, *source);
}

void mGetShapesTexture(Texture2D *out)
{
	*out = GetShapesTexture();
}

void mGetShapesTextureRectangle(Rectangle *out)
{
	*out = GetShapesTextureRectangle();
}

void mDrawPixel(int posX, int posY, Color *color)
{
	DrawPixel(posX, posY, *color);
}

void mDrawPixelV(Vector2 *position, Color *color)
{
	DrawPixelV(*position, *color);
}

void mDrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color *color)
{
	DrawLine(startPosX, startPosY, endPosX, endPosY, *color);
}

void mDrawLineV(Vector2 *startPos, Vector2 *endPos, Color *color)
{
	DrawLineV(*startPos, *endPos, *color);
}

void mDrawLineEx(Vector2 *startPos, Vector2 *endPos, float thick, Color *color)
{
	DrawLineEx(*startPos, *endPos, thick, *color);
}

void mDrawLineStrip(Vector2 * points, int pointCount, Color *color)
{
	DrawLineStrip(points, pointCount, *color);
}

void mDrawLineBezier(Vector2 *startPos, Vector2 *endPos, float thick, Color *color)
{
	DrawLineBezier(*startPos, *endPos, thick, *color);
}

void mDrawCircle(int centerX, int centerY, float radius, Color *color)
{
	DrawCircle(centerX, centerY, radius, *color);
}

void mDrawCircleSector(Vector2 *center, float radius, float startAngle, float endAngle, int segments, Color *color)
{
	DrawCircleSector(*center, radius, startAngle, endAngle, segments, *color);
}

void mDrawCircleSectorLines(Vector2 *center, float radius, float startAngle, float endAngle, int segments, Color *color)
{
	DrawCircleSectorLines(*center, radius, startAngle, endAngle, segments, *color);
}

void mDrawCircleGradient(int centerX, int centerY, float radius, Color *color1, Color *color2)
{
	DrawCircleGradient(centerX, centerY, radius, *color1, *color2);
}

void mDrawCircleV(Vector2 *center, float radius, Color *color)
{
	DrawCircleV(*center, radius, *color);
}

void mDrawCircleLines(int centerX, int centerY, float radius, Color *color)
{
	DrawCircleLines(centerX, centerY, radius, *color);
}

void mDrawCircleLinesV(Vector2 *center, float radius, Color *color)
{
	DrawCircleLinesV(*center, radius, *color);
}

void mDrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color *color)
{
	DrawEllipse(centerX, centerY, radiusH, radiusV, *color);
}

void mDrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color *color)
{
	DrawEllipseLines(centerX, centerY, radiusH, radiusV, *color);
}

void mDrawRing(Vector2 *center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color *color)
{
	DrawRing(*center, innerRadius, outerRadius, startAngle, endAngle, segments, *color);
}

void mDrawRingLines(Vector2 *center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color *color)
{
	DrawRingLines(*center, innerRadius, outerRadius, startAngle, endAngle, segments, *color);
}

void mDrawRectangle(int posX, int posY, int width, int height, Color *color)
{
	DrawRectangle(posX, posY, width, height, *color);
}

void mDrawRectangleV(Vector2 *position, Vector2 *size, Color *color)
{
	DrawRectangleV(*position, *size, *color);
}

void mDrawRectangleRec(Rectangle *rec, Color *color)
{
	DrawRectangleRec(*rec, *color);
}

void mDrawRectanglePro(Rectangle *rec, Vector2 *origin, float rotation, Color *color)
{
	DrawRectanglePro(*rec, *origin, rotation, *color);
}

void mDrawRectangleGradientV(int posX, int posY, int width, int height, Color *color1, Color *color2)
{
	DrawRectangleGradientV(posX, posY, width, height, *color1, *color2);
}

void mDrawRectangleGradientH(int posX, int posY, int width, int height, Color *color1, Color *color2)
{
	DrawRectangleGradientH(posX, posY, width, height, *color1, *color2);
}

void mDrawRectangleGradientEx(Rectangle *rec, Color *col1, Color *col2, Color *col3, Color *col4)
{
	DrawRectangleGradientEx(*rec, *col1, *col2, *col3, *col4);
}

void mDrawRectangleLines(int posX, int posY, int width, int height, Color *color)
{
	DrawRectangleLines(posX, posY, width, height, *color);
}

void mDrawRectangleLinesEx(Rectangle *rec, float lineThick, Color *color)
{
	DrawRectangleLinesEx(*rec, lineThick, *color);
}

void mDrawRectangleRounded(Rectangle *rec, float roundness, int segments, Color *color)
{
	DrawRectangleRounded(*rec, roundness, segments, *color);
}

void mDrawRectangleRoundedLines(Rectangle *rec, float roundness, int segments, float lineThick, Color *color)
{
	DrawRectangleRoundedLines(*rec, roundness, segments, lineThick, *color);
}

void mDrawTriangle(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color)
{
	DrawTriangle(*v1, *v2, *v3, *color);
}

void mDrawTriangleLines(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color)
{
	DrawTriangleLines(*v1, *v2, *v3, *color);
}

void mDrawTriangleFan(Vector2 * points, int pointCount, Color *color)
{
	DrawTriangleFan(points, pointCount, *color);
}

void mDrawTriangleStrip(Vector2 * points, int pointCount, Color *color)
{
	DrawTriangleStrip(points, pointCount, *color);
}

void mDrawPoly(Vector2 *center, int sides, float radius, float rotation, Color *color)
{
	DrawPoly(*center, sides, radius, rotation, *color);
}

void mDrawPolyLines(Vector2 *center, int sides, float radius, float rotation, Color *color)
{
	DrawPolyLines(*center, sides, radius, rotation, *color);
}

void mDrawPolyLinesEx(Vector2 *center, int sides, float radius, float rotation, float lineThick, Color *color)
{
	DrawPolyLinesEx(*center, sides, radius, rotation, lineThick, *color);
}

void mDrawSplineLinear(Vector2 * points, int pointCount, float thick, Color *color)
{
	DrawSplineLinear(points, pointCount, thick, *color);
}

void mDrawSplineBasis(Vector2 * points, int pointCount, float thick, Color *color)
{
	DrawSplineBasis(points, pointCount, thick, *color);
}

void mDrawSplineCatmullRom(Vector2 * points, int pointCount, float thick, Color *color)
{
	DrawSplineCatmullRom(points, pointCount, thick, *color);
}

void mDrawSplineBezierQuadratic(Vector2 * points, int pointCount, float thick, Color *color)
{
	DrawSplineBezierQuadratic(points, pointCount, thick, *color);
}

void mDrawSplineBezierCubic(Vector2 * points, int pointCount, float thick, Color *color)
{
	DrawSplineBezierCubic(points, pointCount, thick, *color);
}

void mDrawSplineSegmentLinear(Vector2 *p1, Vector2 *p2, float thick, Color *color)
{
	DrawSplineSegmentLinear(*p1, *p2, thick, *color);
}

void mDrawSplineSegmentBasis(Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float thick, Color *color)
{
	DrawSplineSegmentBasis(*p1, *p2, *p3, *p4, thick, *color);
}

void mDrawSplineSegmentCatmullRom(Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float thick, Color *color)
{
	DrawSplineSegmentCatmullRom(*p1, *p2, *p3, *p4, thick, *color);
}

void mDrawSplineSegmentBezierQuadratic(Vector2 *p1, Vector2 *c2, Vector2 *p3, float thick, Color *color)
{
	DrawSplineSegmentBezierQuadratic(*p1, *c2, *p3, thick, *color);
}

void mDrawSplineSegmentBezierCubic(Vector2 *p1, Vector2 *c2, Vector2 *c3, Vector2 *p4, float thick, Color *color)
{
	DrawSplineSegmentBezierCubic(*p1, *c2, *c3, *p4, thick, *color);
}

void mGetSplinePointLinear(Vector2 *out, Vector2 *startPos, Vector2 *endPos, float t)
{
	*out = GetSplinePointLinear(*startPos, *endPos, t);
}

void mGetSplinePointBasis(Vector2 *out, Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float t)
{
	*out = GetSplinePointBasis(*p1, *p2, *p3, *p4, t);
}

void mGetSplinePointCatmullRom(Vector2 *out, Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float t)
{
	*out = GetSplinePointCatmullRom(*p1, *p2, *p3, *p4, t);
}

void mGetSplinePointBezierQuad(Vector2 *out, Vector2 *p1, Vector2 *c2, Vector2 *p3, float t)
{
	*out = GetSplinePointBezierQuad(*p1, *c2, *p3, t);
}

void mGetSplinePointBezierCubic(Vector2 *out, Vector2 *p1, Vector2 *c2, Vector2 *c3, Vector2 *p4, float t)
{
	*out = GetSplinePointBezierCubic(*p1, *c2, *c3, *p4, t);
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

bool mCheckCollisionPointPoly(Vector2 *point, Vector2 * points, int pointCount)
{
	return CheckCollisionPointPoly(*point, points, pointCount);
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

void mLoadImageSvg(Image *out, const char * fileNameOrString, int width, int height)
{
	*out = LoadImageSvg(fileNameOrString, width, height);
}

void mLoadImageAnim(Image *out, const char * fileName, int * frames)
{
	*out = LoadImageAnim(fileName, frames);
}

void mLoadImageAnimFromMemory(Image *out, const char * fileType, const unsigned char * fileData, int dataSize, int * frames)
{
	*out = LoadImageAnimFromMemory(fileType, fileData, dataSize, frames);
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

bool mIsImageReady(Image *image)
{
	return IsImageReady(*image);
}

void mUnloadImage(Image *image)
{
	UnloadImage(*image);
}

bool mExportImage(Image *image, const char * fileName)
{
	return ExportImage(*image, fileName);
}

unsigned char * mExportImageToMemory(Image *image, const char * fileType, int * fileSize)
{
	return ExportImageToMemory(*image, fileType, fileSize);
}

bool mExportImageAsCode(Image *image, const char * fileName)
{
	return ExportImageAsCode(*image, fileName);
}

void mGenImageColor(Image *out, int width, int height, Color *color)
{
	*out = GenImageColor(width, height, *color);
}

void mGenImageGradientLinear(Image *out, int width, int height, int direction, Color *start, Color *end)
{
	*out = GenImageGradientLinear(width, height, direction, *start, *end);
}

void mGenImageGradientRadial(Image *out, int width, int height, float density, Color *inner, Color *outer)
{
	*out = GenImageGradientRadial(width, height, density, *inner, *outer);
}

void mGenImageGradientSquare(Image *out, int width, int height, float density, Color *inner, Color *outer)
{
	*out = GenImageGradientSquare(width, height, density, *inner, *outer);
}

void mGenImageChecked(Image *out, int width, int height, int checksX, int checksY, Color *col1, Color *col2)
{
	*out = GenImageChecked(width, height, checksX, checksY, *col1, *col2);
}

void mGenImageWhiteNoise(Image *out, int width, int height, float factor)
{
	*out = GenImageWhiteNoise(width, height, factor);
}

void mGenImagePerlinNoise(Image *out, int width, int height, int offsetX, int offsetY, float scale)
{
	*out = GenImagePerlinNoise(width, height, offsetX, offsetY, scale);
}

void mGenImageCellular(Image *out, int width, int height, int tileSize)
{
	*out = GenImageCellular(width, height, tileSize);
}

void mGenImageText(Image *out, int width, int height, const char * text)
{
	*out = GenImageText(width, height, text);
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
	ImageFormat(image, newFormat);
}

void mImageToPOT(Image * image, Color *fill)
{
	ImageToPOT(image, *fill);
}

void mImageCrop(Image * image, Rectangle *crop)
{
	ImageCrop(image, *crop);
}

void mImageAlphaCrop(Image * image, float threshold)
{
	ImageAlphaCrop(image, threshold);
}

void mImageAlphaClear(Image * image, Color *color, float threshold)
{
	ImageAlphaClear(image, *color, threshold);
}

void mImageAlphaMask(Image * image, Image *alphaMask)
{
	ImageAlphaMask(image, *alphaMask);
}

void mImageAlphaPremultiply(Image * image)
{
	ImageAlphaPremultiply(image);
}

void mImageBlurGaussian(Image * image, int blurSize)
{
	ImageBlurGaussian(image, blurSize);
}

void mImageKernelConvolution(Image * image, float* kernel, int kernelSize)
{
	ImageKernelConvolution(image, kernel, kernelSize);
}

void mImageResize(Image * image, int newWidth, int newHeight)
{
	ImageResize(image, newWidth, newHeight);
}

void mImageResizeNN(Image * image, int newWidth, int newHeight)
{
	ImageResizeNN(image, newWidth, newHeight);
}

void mImageResizeCanvas(Image * image, int newWidth, int newHeight, int offsetX, int offsetY, Color *fill)
{
	ImageResizeCanvas(image, newWidth, newHeight, offsetX, offsetY, *fill);
}

void mImageMipmaps(Image * image)
{
	ImageMipmaps(image);
}

void mImageDither(Image * image, int rBpp, int gBpp, int bBpp, int aBpp)
{
	ImageDither(image, rBpp, gBpp, bBpp, aBpp);
}

void mImageFlipVertical(Image * image)
{
	ImageFlipVertical(image);
}

void mImageFlipHorizontal(Image * image)
{
	ImageFlipHorizontal(image);
}

void mImageRotate(Image * image, int degrees)
{
	ImageRotate(image, degrees);
}

void mImageRotateCW(Image * image)
{
	ImageRotateCW(image);
}

void mImageRotateCCW(Image * image)
{
	ImageRotateCCW(image);
}

void mImageColorTint(Image * image, Color *color)
{
	ImageColorTint(image, *color);
}

void mImageColorInvert(Image * image)
{
	ImageColorInvert(image);
}

void mImageColorGrayscale(Image * image)
{
	ImageColorGrayscale(image);
}

void mImageColorContrast(Image * image, float contrast)
{
	ImageColorContrast(image, contrast);
}

void mImageColorBrightness(Image * image, int brightness)
{
	ImageColorBrightness(image, brightness);
}

void mImageColorReplace(Image * image, Color *color, Color *replace)
{
	ImageColorReplace(image, *color, *replace);
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
	UnloadImageColors(colors);
}

void mUnloadImagePalette(Color * colors)
{
	UnloadImagePalette(colors);
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
	ImageClearBackground(dst, *color);
}

void mImageDrawPixel(Image * dst, int posX, int posY, Color *color)
{
	ImageDrawPixel(dst, posX, posY, *color);
}

void mImageDrawPixelV(Image * dst, Vector2 *position, Color *color)
{
	ImageDrawPixelV(dst, *position, *color);
}

void mImageDrawLine(Image * dst, int startPosX, int startPosY, int endPosX, int endPosY, Color *color)
{
	ImageDrawLine(dst, startPosX, startPosY, endPosX, endPosY, *color);
}

void mImageDrawLineV(Image * dst, Vector2 *start, Vector2 *end, Color *color)
{
	ImageDrawLineV(dst, *start, *end, *color);
}

void mImageDrawCircle(Image * dst, int centerX, int centerY, int radius, Color *color)
{
	ImageDrawCircle(dst, centerX, centerY, radius, *color);
}

void mImageDrawCircleV(Image * dst, Vector2 *center, int radius, Color *color)
{
	ImageDrawCircleV(dst, *center, radius, *color);
}

void mImageDrawCircleLines(Image * dst, int centerX, int centerY, int radius, Color *color)
{
	ImageDrawCircleLines(dst, centerX, centerY, radius, *color);
}

void mImageDrawCircleLinesV(Image * dst, Vector2 *center, int radius, Color *color)
{
	ImageDrawCircleLinesV(dst, *center, radius, *color);
}

void mImageDrawRectangle(Image * dst, int posX, int posY, int width, int height, Color *color)
{
	ImageDrawRectangle(dst, posX, posY, width, height, *color);
}

void mImageDrawRectangleV(Image * dst, Vector2 *position, Vector2 *size, Color *color)
{
	ImageDrawRectangleV(dst, *position, *size, *color);
}

void mImageDrawRectangleRec(Image * dst, Rectangle *rec, Color *color)
{
	ImageDrawRectangleRec(dst, *rec, *color);
}

void mImageDrawRectangleLines(Image * dst, Rectangle *rec, int thick, Color *color)
{
	ImageDrawRectangleLines(dst, *rec, thick, *color);
}

void mImageDraw(Image * dst, Image *src, Rectangle *srcRec, Rectangle *dstRec, Color *tint)
{
	ImageDraw(dst, *src, *srcRec, *dstRec, *tint);
}

void mImageDrawText(Image * dst, const char * text, int posX, int posY, int fontSize, Color *color)
{
	ImageDrawText(dst, text, posX, posY, fontSize, *color);
}

void mImageDrawTextEx(Image * dst, Font *font, const char * text, Vector2 *position, float fontSize, float spacing, Color *tint)
{
	ImageDrawTextEx(dst, *font, text, *position, fontSize, spacing, *tint);
}

void mLoadTexture(Texture2D *out, const char * fileName)
{
	*out = LoadTexture(fileName);
}

void mLoadTextureFromImage(Texture2D *out, Image *image)
{
	*out = LoadTextureFromImage(*image);
}

void mLoadTextureCubemap(Texture2D *out, Image *image, int layout)
{
	*out = LoadTextureCubemap(*image, layout);
}

void mLoadRenderTexture(RenderTexture2D *out, int width, int height)
{
	*out = LoadRenderTexture(width, height);
}

bool mIsTextureReady(Texture2D *texture)
{
	return IsTextureReady(*texture);
}

void mUnloadTexture(Texture2D *texture)
{
	UnloadTexture(*texture);
}

bool mIsRenderTextureReady(RenderTexture2D *target)
{
	return IsRenderTextureReady(*target);
}

void mUnloadRenderTexture(RenderTexture2D *target)
{
	UnloadRenderTexture(*target);
}

void mUpdateTexture(Texture2D *texture, const void * pixels)
{
	UpdateTexture(*texture, pixels);
}

void mUpdateTextureRec(Texture2D *texture, Rectangle *rec, const void * pixels)
{
	UpdateTextureRec(*texture, *rec, pixels);
}

void mGenTextureMipmaps(Texture2D * texture)
{
	GenTextureMipmaps(texture);
}

void mSetTextureFilter(Texture2D *texture, int filter)
{
	SetTextureFilter(*texture, filter);
}

void mSetTextureWrap(Texture2D *texture, int wrap)
{
	SetTextureWrap(*texture, wrap);
}

void mDrawTexture(Texture2D *texture, int posX, int posY, Color *tint)
{
	DrawTexture(*texture, posX, posY, *tint);
}

void mDrawTextureV(Texture2D *texture, Vector2 *position, Color *tint)
{
	DrawTextureV(*texture, *position, *tint);
}

void mDrawTextureEx(Texture2D *texture, Vector2 *position, float rotation, float scale, Color *tint)
{
	DrawTextureEx(*texture, *position, rotation, scale, *tint);
}

void mDrawTextureRec(Texture2D *texture, Rectangle *source, Vector2 *position, Color *tint)
{
	DrawTextureRec(*texture, *source, *position, *tint);
}

void mDrawTexturePro(Texture2D *texture, Rectangle *source, Rectangle *dest, Vector2 *origin, float rotation, Color *tint)
{
	DrawTexturePro(*texture, *source, *dest, *origin, rotation, *tint);
}

void mDrawTextureNPatch(Texture2D *texture, NPatchInfo *nPatchInfo, Rectangle *dest, Vector2 *origin, float rotation, Color *tint)
{
	DrawTextureNPatch(*texture, *nPatchInfo, *dest, *origin, rotation, *tint);
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

void mColorTint(Color *out, Color *color, Color *tint)
{
	*out = ColorTint(*color, *tint);
}

void mColorBrightness(Color *out, Color *color, float factor)
{
	*out = ColorBrightness(*color, factor);
}

void mColorContrast(Color *out, Color *color, float contrast)
{
	*out = ColorContrast(*color, contrast);
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
	SetPixelColor(dstPtr, *color, format);
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

void mLoadFontEx(Font *out, const char * fileName, int fontSize, int * codepoints, int codepointCount)
{
	*out = LoadFontEx(fileName, fontSize, codepoints, codepointCount);
}

void mLoadFontFromImage(Font *out, Image *image, Color *key, int firstChar)
{
	*out = LoadFontFromImage(*image, *key, firstChar);
}

void mLoadFontFromMemory(Font *out, const char * fileType, const unsigned char * fileData, int dataSize, int fontSize, int * codepoints, int codepointCount)
{
	*out = LoadFontFromMemory(fileType, fileData, dataSize, fontSize, codepoints, codepointCount);
}

bool mIsFontReady(Font *font)
{
	return IsFontReady(*font);
}

GlyphInfo * mLoadFontData(const unsigned char * fileData, int dataSize, int fontSize, int * codepoints, int codepointCount, int type)
{
	return LoadFontData(fileData, dataSize, fontSize, codepoints, codepointCount, type);
}

void mUnloadFontData(GlyphInfo * glyphs, int glyphCount)
{
	UnloadFontData(glyphs, glyphCount);
}

void mUnloadFont(Font *font)
{
	UnloadFont(*font);
}

bool mExportFontAsCode(Font *font, const char * fileName)
{
	return ExportFontAsCode(*font, fileName);
}

void mDrawFPS(int posX, int posY)
{
	DrawFPS(posX, posY);
}

void mDrawText(const char * text, int posX, int posY, int fontSize, Color *color)
{
	DrawText(text, posX, posY, fontSize, *color);
}

void mDrawTextEx(Font *font, const char * text, Vector2 *position, float fontSize, float spacing, Color *tint)
{
	DrawTextEx(*font, text, *position, fontSize, spacing, *tint);
}

void mDrawTextPro(Font *font, const char * text, Vector2 *position, Vector2 *origin, float rotation, float fontSize, float spacing, Color *tint)
{
	DrawTextPro(*font, text, *position, *origin, rotation, fontSize, spacing, *tint);
}

void mDrawTextCodepoint(Font *font, int codepoint, Vector2 *position, float fontSize, Color *tint)
{
	DrawTextCodepoint(*font, codepoint, *position, fontSize, *tint);
}

void mDrawTextCodepoints(Font *font, const int * codepoints, int codepointCount, Vector2 *position, float fontSize, float spacing, Color *tint)
{
	DrawTextCodepoints(*font, codepoints, codepointCount, *position, fontSize, spacing, *tint);
}

void mSetTextLineSpacing(int spacing)
{
	SetTextLineSpacing(spacing);
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

char * mLoadUTF8(const int * codepoints, int length)
{
	return LoadUTF8(codepoints, length);
}

void mUnloadUTF8(char * text)
{
	UnloadUTF8(text);
}

int * mLoadCodepoints(const char * text, int * count)
{
	return LoadCodepoints(text, count);
}

void mUnloadCodepoints(int * codepoints)
{
	UnloadCodepoints(codepoints);
}

int mGetCodepointCount(const char * text)
{
	return GetCodepointCount(text);
}

int mGetCodepoint(const char * text, int * codepointSize)
{
	return GetCodepoint(text, codepointSize);
}

int mGetCodepointNext(const char * text, int * codepointSize)
{
	return GetCodepointNext(text, codepointSize);
}

int mGetCodepointPrevious(const char * text, int * codepointSize)
{
	return GetCodepointPrevious(text, codepointSize);
}

const char * mCodepointToUTF8(int codepoint, int * utf8Size)
{
	return CodepointToUTF8(codepoint, utf8Size);
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

char * mTextReplace(const char * text, const char * replace, const char * by)
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

float mTextToFloat(const char * text)
{
	return TextToFloat(text);
}

void mDrawLine3D(Vector3 *startPos, Vector3 *endPos, Color *color)
{
	DrawLine3D(*startPos, *endPos, *color);
}

void mDrawPoint3D(Vector3 *position, Color *color)
{
	DrawPoint3D(*position, *color);
}

void mDrawCircle3D(Vector3 *center, float radius, Vector3 *rotationAxis, float rotationAngle, Color *color)
{
	DrawCircle3D(*center, radius, *rotationAxis, rotationAngle, *color);
}

void mDrawTriangle3D(Vector3 *v1, Vector3 *v2, Vector3 *v3, Color *color)
{
	DrawTriangle3D(*v1, *v2, *v3, *color);
}

void mDrawTriangleStrip3D(Vector3 * points, int pointCount, Color *color)
{
	DrawTriangleStrip3D(points, pointCount, *color);
}

void mDrawCube(Vector3 *position, float width, float height, float length, Color *color)
{
	DrawCube(*position, width, height, length, *color);
}

void mDrawCubeV(Vector3 *position, Vector3 *size, Color *color)
{
	DrawCubeV(*position, *size, *color);
}

void mDrawCubeWires(Vector3 *position, float width, float height, float length, Color *color)
{
	DrawCubeWires(*position, width, height, length, *color);
}

void mDrawCubeWiresV(Vector3 *position, Vector3 *size, Color *color)
{
	DrawCubeWiresV(*position, *size, *color);
}

void mDrawSphere(Vector3 *centerPos, float radius, Color *color)
{
	DrawSphere(*centerPos, radius, *color);
}

void mDrawSphereEx(Vector3 *centerPos, float radius, int rings, int slices, Color *color)
{
	DrawSphereEx(*centerPos, radius, rings, slices, *color);
}

void mDrawSphereWires(Vector3 *centerPos, float radius, int rings, int slices, Color *color)
{
	DrawSphereWires(*centerPos, radius, rings, slices, *color);
}

void mDrawCylinder(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color)
{
	DrawCylinder(*position, radiusTop, radiusBottom, height, slices, *color);
}

void mDrawCylinderEx(Vector3 *startPos, Vector3 *endPos, float startRadius, float endRadius, int sides, Color *color)
{
	DrawCylinderEx(*startPos, *endPos, startRadius, endRadius, sides, *color);
}

void mDrawCylinderWires(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color)
{
	DrawCylinderWires(*position, radiusTop, radiusBottom, height, slices, *color);
}

void mDrawCylinderWiresEx(Vector3 *startPos, Vector3 *endPos, float startRadius, float endRadius, int sides, Color *color)
{
	DrawCylinderWiresEx(*startPos, *endPos, startRadius, endRadius, sides, *color);
}

void mDrawCapsule(Vector3 *startPos, Vector3 *endPos, float radius, int slices, int rings, Color *color)
{
	DrawCapsule(*startPos, *endPos, radius, slices, rings, *color);
}

void mDrawCapsuleWires(Vector3 *startPos, Vector3 *endPos, float radius, int slices, int rings, Color *color)
{
	DrawCapsuleWires(*startPos, *endPos, radius, slices, rings, *color);
}

void mDrawPlane(Vector3 *centerPos, Vector2 *size, Color *color)
{
	DrawPlane(*centerPos, *size, *color);
}

void mDrawRay(Ray *ray, Color *color)
{
	DrawRay(*ray, *color);
}

void mDrawGrid(int slices, float spacing)
{
	DrawGrid(slices, spacing);
}

void mLoadModel(Model *out, const char * fileName)
{
	*out = LoadModel(fileName);
}

void mLoadModelFromMesh(Model *out, Mesh *mesh)
{
	*out = LoadModelFromMesh(*mesh);
}

bool mIsModelReady(Model *model)
{
	return IsModelReady(*model);
}

void mUnloadModel(Model *model)
{
	UnloadModel(*model);
}

void mGetModelBoundingBox(BoundingBox *out, Model *model)
{
	*out = GetModelBoundingBox(*model);
}

void mDrawModel(Model *model, Vector3 *position, float scale, Color *tint)
{
	DrawModel(*model, *position, scale, *tint);
}

void mDrawModelEx(Model *model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint)
{
	DrawModelEx(*model, *position, *rotationAxis, rotationAngle, *scale, *tint);
}

void mDrawModelWires(Model *model, Vector3 *position, float scale, Color *tint)
{
	DrawModelWires(*model, *position, scale, *tint);
}

void mDrawModelWiresEx(Model *model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint)
{
	DrawModelWiresEx(*model, *position, *rotationAxis, rotationAngle, *scale, *tint);
}

void mDrawBoundingBox(BoundingBox *box, Color *color)
{
	DrawBoundingBox(*box, *color);
}

void mDrawBillboard(Camera3D *camera, Texture2D *texture, Vector3 *position, float size, Color *tint)
{
	DrawBillboard(*camera, *texture, *position, size, *tint);
}

void mDrawBillboardRec(Camera3D *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector2 *size, Color *tint)
{
	DrawBillboardRec(*camera, *texture, *source, *position, *size, *tint);
}

void mDrawBillboardPro(Camera3D *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector3 *up, Vector2 *size, Vector2 *origin, float rotation, Color *tint)
{
	DrawBillboardPro(*camera, *texture, *source, *position, *up, *size, *origin, rotation, *tint);
}

void mUploadMesh(Mesh * mesh, bool dynamic)
{
	UploadMesh(mesh, dynamic);
}

void mUpdateMeshBuffer(Mesh *mesh, int index, const void * data, int dataSize, int offset)
{
	UpdateMeshBuffer(*mesh, index, data, dataSize, offset);
}

void mUnloadMesh(Mesh *mesh)
{
	UnloadMesh(*mesh);
}

void mDrawMesh(Mesh *mesh, Material *material, Matrix *transform)
{
	DrawMesh(*mesh, *material, *transform);
}

void mDrawMeshInstanced(Mesh *mesh, Material *material, const Matrix * transforms, int instances)
{
	DrawMeshInstanced(*mesh, *material, transforms, instances);
}

void mGetMeshBoundingBox(BoundingBox *out, Mesh *mesh)
{
	*out = GetMeshBoundingBox(*mesh);
}

void mGenMeshTangents(Mesh * mesh)
{
	GenMeshTangents(mesh);
}

bool mExportMesh(Mesh *mesh, const char * fileName)
{
	return ExportMesh(*mesh, fileName);
}

bool mExportMeshAsCode(Mesh *mesh, const char * fileName)
{
	return ExportMeshAsCode(*mesh, fileName);
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

bool mIsMaterialReady(Material *material)
{
	return IsMaterialReady(*material);
}

void mUnloadMaterial(Material *material)
{
	UnloadMaterial(*material);
}

void mSetMaterialTexture(Material * material, int mapType, Texture2D *texture)
{
	SetMaterialTexture(material, mapType, *texture);
}

void mSetModelMeshMaterial(Model * model, int meshId, int materialId)
{
	SetModelMeshMaterial(model, meshId, materialId);
}

ModelAnimation * mLoadModelAnimations(const char * fileName, int * animCount)
{
	return LoadModelAnimations(fileName, animCount);
}

void mUpdateModelAnimation(Model *model, ModelAnimation *anim, int frame)
{
	UpdateModelAnimation(*model, *anim, frame);
}

void mUnloadModelAnimation(ModelAnimation *anim)
{
	UnloadModelAnimation(*anim);
}

void mUnloadModelAnimations(ModelAnimation * animations, int animCount)
{
	UnloadModelAnimations(animations, animCount);
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
	InitAudioDevice();
}

void mCloseAudioDevice(void)
{
	CloseAudioDevice();
}

bool mIsAudioDeviceReady(void)
{
	return IsAudioDeviceReady();
}

void mSetMasterVolume(float volume)
{
	SetMasterVolume(volume);
}

float mGetMasterVolume(void)
{
	return GetMasterVolume();
}

void mLoadWave(Wave *out, const char * fileName)
{
	*out = LoadWave(fileName);
}

void mLoadWaveFromMemory(Wave *out, const char * fileType, const unsigned char * fileData, int dataSize)
{
	*out = LoadWaveFromMemory(fileType, fileData, dataSize);
}

bool mIsWaveReady(Wave *wave)
{
	return IsWaveReady(*wave);
}

void mLoadSound(Sound *out, const char * fileName)
{
	*out = LoadSound(fileName);
}

void mLoadSoundFromWave(Sound *out, Wave *wave)
{
	*out = LoadSoundFromWave(*wave);
}

void mLoadSoundAlias(Sound *out, Sound *source)
{
	*out = LoadSoundAlias(*source);
}

bool mIsSoundReady(Sound *sound)
{
	return IsSoundReady(*sound);
}

void mUpdateSound(Sound *sound, const void * data, int sampleCount)
{
	UpdateSound(*sound, data, sampleCount);
}

void mUnloadWave(Wave *wave)
{
	UnloadWave(*wave);
}

void mUnloadSound(Sound *sound)
{
	UnloadSound(*sound);
}

void mUnloadSoundAlias(Sound *alias)
{
	UnloadSoundAlias(*alias);
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
	PlaySound(*sound);
}

void mStopSound(Sound *sound)
{
	StopSound(*sound);
}

void mPauseSound(Sound *sound)
{
	PauseSound(*sound);
}

void mResumeSound(Sound *sound)
{
	ResumeSound(*sound);
}

bool mIsSoundPlaying(Sound *sound)
{
	return IsSoundPlaying(*sound);
}

void mSetSoundVolume(Sound *sound, float volume)
{
	SetSoundVolume(*sound, volume);
}

void mSetSoundPitch(Sound *sound, float pitch)
{
	SetSoundPitch(*sound, pitch);
}

void mSetSoundPan(Sound *sound, float pan)
{
	SetSoundPan(*sound, pan);
}

void mWaveCopy(Wave *out, Wave *wave)
{
	*out = WaveCopy(*wave);
}

void mWaveCrop(Wave * wave, int initSample, int finalSample)
{
	WaveCrop(wave, initSample, finalSample);
}

void mWaveFormat(Wave * wave, int sampleRate, int sampleSize, int channels)
{
	WaveFormat(wave, sampleRate, sampleSize, channels);
}

float * mLoadWaveSamples(Wave *wave)
{
	return LoadWaveSamples(*wave);
}

void mUnloadWaveSamples(float * samples)
{
	UnloadWaveSamples(samples);
}

void mLoadMusicStream(Music *out, const char * fileName)
{
	*out = LoadMusicStream(fileName);
}

void mLoadMusicStreamFromMemory(Music *out, const char * fileType, const unsigned char * data, int dataSize)
{
	*out = LoadMusicStreamFromMemory(fileType, data, dataSize);
}

bool mIsMusicReady(Music *music)
{
	return IsMusicReady(*music);
}

void mUnloadMusicStream(Music *music)
{
	UnloadMusicStream(*music);
}

void mPlayMusicStream(Music *music)
{
	PlayMusicStream(*music);
}

bool mIsMusicStreamPlaying(Music *music)
{
	return IsMusicStreamPlaying(*music);
}

void mUpdateMusicStream(Music *music)
{
	UpdateMusicStream(*music);
}

void mStopMusicStream(Music *music)
{
	StopMusicStream(*music);
}

void mPauseMusicStream(Music *music)
{
	PauseMusicStream(*music);
}

void mResumeMusicStream(Music *music)
{
	ResumeMusicStream(*music);
}

void mSeekMusicStream(Music *music, float position)
{
	SeekMusicStream(*music, position);
}

void mSetMusicVolume(Music *music, float volume)
{
	SetMusicVolume(*music, volume);
}

void mSetMusicPitch(Music *music, float pitch)
{
	SetMusicPitch(*music, pitch);
}

void mSetMusicPan(Music *music, float pan)
{
	SetMusicPan(*music, pan);
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

bool mIsAudioStreamReady(AudioStream *stream)
{
	return IsAudioStreamReady(*stream);
}

void mUnloadAudioStream(AudioStream *stream)
{
	UnloadAudioStream(*stream);
}

void mUpdateAudioStream(AudioStream *stream, const void * data, int frameCount)
{
	UpdateAudioStream(*stream, data, frameCount);
}

bool mIsAudioStreamProcessed(AudioStream *stream)
{
	return IsAudioStreamProcessed(*stream);
}

void mPlayAudioStream(AudioStream *stream)
{
	PlayAudioStream(*stream);
}

void mPauseAudioStream(AudioStream *stream)
{
	PauseAudioStream(*stream);
}

void mResumeAudioStream(AudioStream *stream)
{
	ResumeAudioStream(*stream);
}

bool mIsAudioStreamPlaying(AudioStream *stream)
{
	return IsAudioStreamPlaying(*stream);
}

void mStopAudioStream(AudioStream *stream)
{
	StopAudioStream(*stream);
}

void mSetAudioStreamVolume(AudioStream *stream, float volume)
{
	SetAudioStreamVolume(*stream, volume);
}

void mSetAudioStreamPitch(AudioStream *stream, float pitch)
{
	SetAudioStreamPitch(*stream, pitch);
}

void mSetAudioStreamPan(AudioStream *stream, float pan)
{
	SetAudioStreamPan(*stream, pan);
}

void mSetAudioStreamBufferSizeDefault(int size)
{
	SetAudioStreamBufferSizeDefault(size);
}

void mSetAudioStreamCallback(AudioStream *stream, AudioCallback callback)
{
	SetAudioStreamCallback(*stream, callback);
}

void mAttachAudioStreamProcessor(AudioStream *stream, AudioCallback processor)
{
	AttachAudioStreamProcessor(*stream, processor);
}

void mDetachAudioStreamProcessor(AudioStream *stream, AudioCallback processor)
{
	DetachAudioStreamProcessor(*stream, processor);
}

void mAttachAudioMixedProcessor(AudioCallback processor)
{
	AttachAudioMixedProcessor(processor);
}

void mDetachAudioMixedProcessor(AudioCallback processor)
{
	DetachAudioMixedProcessor(processor);
}

void mrlMatrixMode(int mode)
{
	rlMatrixMode(mode);
}

void mrlPushMatrix(void)
{
	rlPushMatrix();
}

void mrlPopMatrix(void)
{
	rlPopMatrix();
}

void mrlLoadIdentity(void)
{
	rlLoadIdentity();
}

void mrlTranslatef(float x, float y, float z)
{
	rlTranslatef(x, y, z);
}

void mrlRotatef(float angle, float x, float y, float z)
{
	rlRotatef(angle, x, y, z);
}

void mrlScalef(float x, float y, float z)
{
	rlScalef(x, y, z);
}

void mrlMultMatrixf(const float * matf)
{
	rlMultMatrixf(matf);
}

void mrlFrustum(double left, double right, double bottom, double top, double znear, double zfar)
{
	rlFrustum(left, right, bottom, top, znear, zfar);
}

void mrlOrtho(double left, double right, double bottom, double top, double znear, double zfar)
{
	rlOrtho(left, right, bottom, top, znear, zfar);
}

void mrlViewport(int x, int y, int width, int height)
{
	rlViewport(x, y, width, height);
}

void mrlBegin(int mode)
{
	rlBegin(mode);
}

void mrlEnd(void)
{
	rlEnd();
}

void mrlVertex2i(int x, int y)
{
	rlVertex2i(x, y);
}

void mrlVertex2f(float x, float y)
{
	rlVertex2f(x, y);
}

void mrlVertex3f(float x, float y, float z)
{
	rlVertex3f(x, y, z);
}

void mrlTexCoord2f(float x, float y)
{
	rlTexCoord2f(x, y);
}

void mrlNormal3f(float x, float y, float z)
{
	rlNormal3f(x, y, z);
}

void mrlColor4ub(unsigned char r, unsigned char g, unsigned char b, unsigned char a)
{
	rlColor4ub(r, g, b, a);
}

void mrlColor3f(float x, float y, float z)
{
	rlColor3f(x, y, z);
}

void mrlColor4f(float x, float y, float z, float w)
{
	rlColor4f(x, y, z, w);
}

bool mrlEnableVertexArray(unsigned int vaoId)
{
	return rlEnableVertexArray(vaoId);
}

void mrlDisableVertexArray(void)
{
	rlDisableVertexArray();
}

void mrlEnableVertexBuffer(unsigned int id)
{
	rlEnableVertexBuffer(id);
}

void mrlDisableVertexBuffer(void)
{
	rlDisableVertexBuffer();
}

void mrlEnableVertexBufferElement(unsigned int id)
{
	rlEnableVertexBufferElement(id);
}

void mrlDisableVertexBufferElement(void)
{
	rlDisableVertexBufferElement();
}

void mrlEnableVertexAttribute(unsigned int index)
{
	rlEnableVertexAttribute(index);
}

void mrlDisableVertexAttribute(unsigned int index)
{
	rlDisableVertexAttribute(index);
}

void mrlActiveTextureSlot(int slot)
{
	rlActiveTextureSlot(slot);
}

void mrlEnableTexture(unsigned int id)
{
	rlEnableTexture(id);
}

void mrlDisableTexture(void)
{
	rlDisableTexture();
}

void mrlEnableTextureCubemap(unsigned int id)
{
	rlEnableTextureCubemap(id);
}

void mrlDisableTextureCubemap(void)
{
	rlDisableTextureCubemap();
}

void mrlTextureParameters(unsigned int id, int param, int value)
{
	rlTextureParameters(id, param, value);
}

void mrlCubemapParameters(unsigned int id, int param, int value)
{
	rlCubemapParameters(id, param, value);
}

void mrlEnableShader(unsigned int id)
{
	rlEnableShader(id);
}

void mrlDisableShader(void)
{
	rlDisableShader();
}

void mrlEnableFramebuffer(unsigned int id)
{
	rlEnableFramebuffer(id);
}

void mrlDisableFramebuffer(void)
{
	rlDisableFramebuffer();
}

void mrlActiveDrawBuffers(int count)
{
	rlActiveDrawBuffers(count);
}

void mrlBlitFramebuffer(int srcX, int srcY, int srcWidth, int srcHeight, int dstX, int dstY, int dstWidth, int dstHeight, int bufferMask)
{
	rlBlitFramebuffer(srcX, srcY, srcWidth, srcHeight, dstX, dstY, dstWidth, dstHeight, bufferMask);
}

void mrlBindFramebuffer(unsigned int target, unsigned int framebuffer)
{
	rlBindFramebuffer(target, framebuffer);
}

void mrlEnableColorBlend(void)
{
	rlEnableColorBlend();
}

void mrlDisableColorBlend(void)
{
	rlDisableColorBlend();
}

void mrlEnableDepthTest(void)
{
	rlEnableDepthTest();
}

void mrlDisableDepthTest(void)
{
	rlDisableDepthTest();
}

void mrlEnableDepthMask(void)
{
	rlEnableDepthMask();
}

void mrlDisableDepthMask(void)
{
	rlDisableDepthMask();
}

void mrlEnableBackfaceCulling(void)
{
	rlEnableBackfaceCulling();
}

void mrlDisableBackfaceCulling(void)
{
	rlDisableBackfaceCulling();
}

void mrlColorMask(bool r, bool g, bool b, bool a)
{
	rlColorMask(r, g, b, a);
}

void mrlSetCullFace(int mode)
{
	rlSetCullFace(mode);
}

void mrlEnableScissorTest(void)
{
	rlEnableScissorTest();
}

void mrlDisableScissorTest(void)
{
	rlDisableScissorTest();
}

void mrlScissor(int x, int y, int width, int height)
{
	rlScissor(x, y, width, height);
}

void mrlEnableWireMode(void)
{
	rlEnableWireMode();
}

void mrlEnablePointMode(void)
{
	rlEnablePointMode();
}

void mrlDisableWireMode(void)
{
	rlDisableWireMode();
}

void mrlSetLineWidth(float width)
{
	rlSetLineWidth(width);
}

float mrlGetLineWidth(void)
{
	return rlGetLineWidth();
}

void mrlEnableSmoothLines(void)
{
	rlEnableSmoothLines();
}

void mrlDisableSmoothLines(void)
{
	rlDisableSmoothLines();
}

void mrlEnableStereoRender(void)
{
	rlEnableStereoRender();
}

void mrlDisableStereoRender(void)
{
	rlDisableStereoRender();
}

bool mrlIsStereoRenderEnabled(void)
{
	return rlIsStereoRenderEnabled();
}

void mrlClearColor(unsigned char r, unsigned char g, unsigned char b, unsigned char a)
{
	rlClearColor(r, g, b, a);
}

void mrlClearScreenBuffers(void)
{
	rlClearScreenBuffers();
}

void mrlCheckErrors(void)
{
	rlCheckErrors();
}

void mrlSetBlendMode(int mode)
{
	rlSetBlendMode(mode);
}

void mrlSetBlendFactors(int glSrcFactor, int glDstFactor, int glEquation)
{
	rlSetBlendFactors(glSrcFactor, glDstFactor, glEquation);
}

void mrlSetBlendFactorsSeparate(int glSrcRGB, int glDstRGB, int glSrcAlpha, int glDstAlpha, int glEqRGB, int glEqAlpha)
{
	rlSetBlendFactorsSeparate(glSrcRGB, glDstRGB, glSrcAlpha, glDstAlpha, glEqRGB, glEqAlpha);
}

void mrlglInit(int width, int height)
{
	rlglInit(width, height);
}

void mrlglClose(void)
{
	rlglClose();
}

void mrlLoadExtensions(void * loader)
{
	rlLoadExtensions(loader);
}

int mrlGetVersion(void)
{
	return rlGetVersion();
}

void mrlSetFramebufferWidth(int width)
{
	rlSetFramebufferWidth(width);
}

int mrlGetFramebufferWidth(void)
{
	return rlGetFramebufferWidth();
}

void mrlSetFramebufferHeight(int height)
{
	rlSetFramebufferHeight(height);
}

int mrlGetFramebufferHeight(void)
{
	return rlGetFramebufferHeight();
}

unsigned int mrlGetTextureIdDefault(void)
{
	return rlGetTextureIdDefault();
}

unsigned int mrlGetShaderIdDefault(void)
{
	return rlGetShaderIdDefault();
}

int * mrlGetShaderLocsDefault(void)
{
	return rlGetShaderLocsDefault();
}

void mrlLoadRenderBatch(rlRenderBatch *out, int numBuffers, int bufferElements)
{
	*out = rlLoadRenderBatch(numBuffers, bufferElements);
}

void mrlUnloadRenderBatch(rlRenderBatch *batch)
{
	rlUnloadRenderBatch(*batch);
}

void mrlDrawRenderBatch(rlRenderBatch * batch)
{
	rlDrawRenderBatch(batch);
}

void mrlSetRenderBatchActive(rlRenderBatch * batch)
{
	rlSetRenderBatchActive(batch);
}

void mrlDrawRenderBatchActive(void)
{
	rlDrawRenderBatchActive();
}

bool mrlCheckRenderBatchLimit(int vCount)
{
	return rlCheckRenderBatchLimit(vCount);
}

void mrlSetTexture(unsigned int id)
{
	rlSetTexture(id);
}

unsigned int mrlLoadVertexArray(void)
{
	return rlLoadVertexArray();
}

unsigned int mrlLoadVertexBuffer(const void * buffer, int size, bool dynamic)
{
	return rlLoadVertexBuffer(buffer, size, dynamic);
}

unsigned int mrlLoadVertexBufferElement(const void * buffer, int size, bool dynamic)
{
	return rlLoadVertexBufferElement(buffer, size, dynamic);
}

void mrlUpdateVertexBuffer(unsigned int bufferId, const void * data, int dataSize, int offset)
{
	rlUpdateVertexBuffer(bufferId, data, dataSize, offset);
}

void mrlUpdateVertexBufferElements(unsigned int id, const void * data, int dataSize, int offset)
{
	rlUpdateVertexBufferElements(id, data, dataSize, offset);
}

void mrlUnloadVertexArray(unsigned int vaoId)
{
	rlUnloadVertexArray(vaoId);
}

void mrlUnloadVertexBuffer(unsigned int vboId)
{
	rlUnloadVertexBuffer(vboId);
}

void mrlSetVertexAttribute(unsigned int index, int compSize, int type, bool normalized, int stride, const void * pointer)
{
	rlSetVertexAttribute(index, compSize, type, normalized, stride, pointer);
}

void mrlSetVertexAttributeDivisor(unsigned int index, int divisor)
{
	rlSetVertexAttributeDivisor(index, divisor);
}

void mrlSetVertexAttributeDefault(int locIndex, const void * value, int attribType, int count)
{
	rlSetVertexAttributeDefault(locIndex, value, attribType, count);
}

void mrlDrawVertexArray(int offset, int count)
{
	rlDrawVertexArray(offset, count);
}

void mrlDrawVertexArrayElements(int offset, int count, const void * buffer)
{
	rlDrawVertexArrayElements(offset, count, buffer);
}

void mrlDrawVertexArrayInstanced(int offset, int count, int instances)
{
	rlDrawVertexArrayInstanced(offset, count, instances);
}

void mrlDrawVertexArrayElementsInstanced(int offset, int count, const void * buffer, int instances)
{
	rlDrawVertexArrayElementsInstanced(offset, count, buffer, instances);
}

unsigned int mrlLoadTexture(const void * data, int width, int height, int format, int mipmapCount)
{
	return rlLoadTexture(data, width, height, format, mipmapCount);
}

unsigned int mrlLoadTextureDepth(int width, int height, bool useRenderBuffer)
{
	return rlLoadTextureDepth(width, height, useRenderBuffer);
}

unsigned int mrlLoadTextureCubemap(const void * data, int size, int format)
{
	return rlLoadTextureCubemap(data, size, format);
}

void mrlUpdateTexture(unsigned int id, int offsetX, int offsetY, int width, int height, int format, const void * data)
{
	rlUpdateTexture(id, offsetX, offsetY, width, height, format, data);
}

void mrlGetGlTextureFormats(int format, unsigned int * glInternalFormat, unsigned int * glFormat, unsigned int * glType)
{
	rlGetGlTextureFormats(format, glInternalFormat, glFormat, glType);
}

const char * mrlGetPixelFormatName(unsigned int format)
{
	return rlGetPixelFormatName(format);
}

void mrlUnloadTexture(unsigned int id)
{
	rlUnloadTexture(id);
}

void mrlGenTextureMipmaps(unsigned int id, int width, int height, int format, int * mipmaps)
{
	rlGenTextureMipmaps(id, width, height, format, mipmaps);
}

void * mrlReadTexturePixels(unsigned int id, int width, int height, int format)
{
	return rlReadTexturePixels(id, width, height, format);
}

unsigned char * mrlReadScreenPixels(int width, int height)
{
	return rlReadScreenPixels(width, height);
}

unsigned int mrlLoadFramebuffer(int width, int height)
{
	return rlLoadFramebuffer(width, height);
}

void mrlFramebufferAttach(unsigned int fboId, unsigned int texId, int attachType, int texType, int mipLevel)
{
	rlFramebufferAttach(fboId, texId, attachType, texType, mipLevel);
}

bool mrlFramebufferComplete(unsigned int id)
{
	return rlFramebufferComplete(id);
}

void mrlUnloadFramebuffer(unsigned int id)
{
	rlUnloadFramebuffer(id);
}

unsigned int mrlLoadShaderCode(const char * vsCode, const char * fsCode)
{
	return rlLoadShaderCode(vsCode, fsCode);
}

unsigned int mrlCompileShader(const char * shaderCode, int type)
{
	return rlCompileShader(shaderCode, type);
}

unsigned int mrlLoadShaderProgram(unsigned int vShaderId, unsigned int fShaderId)
{
	return rlLoadShaderProgram(vShaderId, fShaderId);
}

void mrlUnloadShaderProgram(unsigned int id)
{
	rlUnloadShaderProgram(id);
}

int mrlGetLocationUniform(unsigned int shaderId, const char * uniformName)
{
	return rlGetLocationUniform(shaderId, uniformName);
}

int mrlGetLocationAttrib(unsigned int shaderId, const char * attribName)
{
	return rlGetLocationAttrib(shaderId, attribName);
}

void mrlSetUniform(int locIndex, const void * value, int uniformType, int count)
{
	rlSetUniform(locIndex, value, uniformType, count);
}

void mrlSetUniformMatrix(int locIndex, Matrix *mat)
{
	rlSetUniformMatrix(locIndex, *mat);
}

void mrlSetUniformSampler(int locIndex, unsigned int textureId)
{
	rlSetUniformSampler(locIndex, textureId);
}

void mrlSetShader(unsigned int id, int * locs)
{
	rlSetShader(id, locs);
}

unsigned int mrlLoadComputeShaderProgram(unsigned int shaderId)
{
	return rlLoadComputeShaderProgram(shaderId);
}

void mrlComputeShaderDispatch(unsigned int groupX, unsigned int groupY, unsigned int groupZ)
{
	rlComputeShaderDispatch(groupX, groupY, groupZ);
}

unsigned int mrlLoadShaderBuffer(unsigned int size, const void * data, int usageHint)
{
	return rlLoadShaderBuffer(size, data, usageHint);
}

void mrlUnloadShaderBuffer(unsigned int ssboId)
{
	rlUnloadShaderBuffer(ssboId);
}

void mrlUpdateShaderBuffer(unsigned int id, const void * data, unsigned int dataSize, unsigned int offset)
{
	rlUpdateShaderBuffer(id, data, dataSize, offset);
}

void mrlBindShaderBuffer(unsigned int id, unsigned int index)
{
	rlBindShaderBuffer(id, index);
}

void mrlReadShaderBuffer(unsigned int id, void * dest, unsigned int count, unsigned int offset)
{
	rlReadShaderBuffer(id, dest, count, offset);
}

void mrlCopyShaderBuffer(unsigned int destId, unsigned int srcId, unsigned int destOffset, unsigned int srcOffset, unsigned int count)
{
	rlCopyShaderBuffer(destId, srcId, destOffset, srcOffset, count);
}

unsigned int mrlGetShaderBufferSize(unsigned int id)
{
	return rlGetShaderBufferSize(id);
}

void mrlBindImageTexture(unsigned int id, unsigned int index, int format, bool readonly)
{
	rlBindImageTexture(id, index, format, readonly);
}

void mrlGetMatrixModelview(Matrix *out)
{
	*out = rlGetMatrixModelview();
}

void mrlGetMatrixProjection(Matrix *out)
{
	*out = rlGetMatrixProjection();
}

void mrlGetMatrixTransform(Matrix *out)
{
	*out = rlGetMatrixTransform();
}

void mrlGetMatrixProjectionStereo(Matrix *out, int eye)
{
	*out = rlGetMatrixProjectionStereo(eye);
}

void mrlGetMatrixViewOffsetStereo(Matrix *out, int eye)
{
	*out = rlGetMatrixViewOffsetStereo(eye);
}

void mrlSetMatrixProjection(Matrix *proj)
{
	rlSetMatrixProjection(*proj);
}

void mrlSetMatrixModelview(Matrix *view)
{
	rlSetMatrixModelview(*view);
}

void mrlSetMatrixProjectionStereo(Matrix *right, Matrix *left)
{
	rlSetMatrixProjectionStereo(*right, *left);
}

void mrlSetMatrixViewOffsetStereo(Matrix *right, Matrix *left)
{
	rlSetMatrixViewOffsetStereo(*right, *left);
}

void mrlLoadDrawCube(void)
{
	rlLoadDrawCube();
}

void mrlLoadDrawQuad(void)
{
	rlLoadDrawQuad();
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

float mWrap(float value, float min, float max)
{
	return Wrap(value, min, max);
}

int mFloatEquals(float x, float y)
{
	return FloatEquals(x, y);
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

float mVector2LineAngle(Vector2 *start, Vector2 *end)
{
	return Vector2LineAngle(*start, *end);
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

void mVector2Invert(Vector2 *out, Vector2 *v)
{
	*out = Vector2Invert(*v);
}

void mVector2Clamp(Vector2 *out, Vector2 *v, Vector2 *min, Vector2 *max)
{
	*out = Vector2Clamp(*v, *min, *max);
}

void mVector2ClampValue(Vector2 *out, Vector2 *v, float min, float max)
{
	*out = Vector2ClampValue(*v, min, max);
}

int mVector2Equals(Vector2 *p, Vector2 *q)
{
	return Vector2Equals(*p, *q);
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

void mVector3Project(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Project(*v1, *v2);
}

void mVector3Reject(Vector3 *out, Vector3 *v1, Vector3 *v2)
{
	*out = Vector3Reject(*v1, *v2);
}

void mVector3OrthoNormalize(Vector3 * v1, Vector3 * v2)
{
	Vector3OrthoNormalize(v1, v2);
}

void mVector3Transform(Vector3 *out, Vector3 *v, Matrix *mat)
{
	*out = Vector3Transform(*v, *mat);
}

void mVector3RotateByQuaternion(Vector3 *out, Vector3 *v, Vector4 *q)
{
	*out = Vector3RotateByQuaternion(*v, *q);
}

void mVector3RotateByAxisAngle(Vector3 *out, Vector3 *v, Vector3 *axis, float angle)
{
	*out = Vector3RotateByAxisAngle(*v, *axis, angle);
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

void mVector3Invert(Vector3 *out, Vector3 *v)
{
	*out = Vector3Invert(*v);
}

void mVector3Clamp(Vector3 *out, Vector3 *v, Vector3 *min, Vector3 *max)
{
	*out = Vector3Clamp(*v, *min, *max);
}

void mVector3ClampValue(Vector3 *out, Vector3 *v, float min, float max)
{
	*out = Vector3ClampValue(*v, min, max);
}

int mVector3Equals(Vector3 *p, Vector3 *q)
{
	return Vector3Equals(*p, *q);
}

void mVector3Refract(Vector3 *out, Vector3 *v, Vector3 *n, float r)
{
	*out = Vector3Refract(*v, *n, r);
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

void mMatrixRotateXYZ(Matrix *out, Vector3 *angle)
{
	*out = MatrixRotateXYZ(*angle);
}

void mMatrixRotateZYX(Matrix *out, Vector3 *angle)
{
	*out = MatrixRotateZYX(*angle);
}

void mMatrixScale(Matrix *out, float x, float y, float z)
{
	*out = MatrixScale(x, y, z);
}

void mMatrixFrustum(Matrix *out, double left, double right, double bottom, double top, double near, double far)
{
	*out = MatrixFrustum(left, right, bottom, top, near, far);
}

void mMatrixPerspective(Matrix *out, double fovY, double aspect, double nearPlane, double farPlane)
{
	*out = MatrixPerspective(fovY, aspect, nearPlane, farPlane);
}

void mMatrixOrtho(Matrix *out, double left, double right, double bottom, double top, double nearPlane, double farPlane)
{
	*out = MatrixOrtho(left, right, bottom, top, nearPlane, farPlane);
}

void mMatrixLookAt(Matrix *out, Vector3 *eye, Vector3 *target, Vector3 *up)
{
	*out = MatrixLookAt(*eye, *target, *up);
}

void mMatrixToFloatV(float16 *out, Matrix *mat)
{
	*out = MatrixToFloatV(*mat);
}

void mQuaternionAdd(Vector4 *out, Vector4 *q1, Vector4 *q2)
{
	*out = QuaternionAdd(*q1, *q2);
}

void mQuaternionAddValue(Vector4 *out, Vector4 *q, float add)
{
	*out = QuaternionAddValue(*q, add);
}

void mQuaternionSubtract(Vector4 *out, Vector4 *q1, Vector4 *q2)
{
	*out = QuaternionSubtract(*q1, *q2);
}

void mQuaternionSubtractValue(Vector4 *out, Vector4 *q, float sub)
{
	*out = QuaternionSubtractValue(*q, sub);
}

void mQuaternionIdentity(Vector4 *out)
{
	*out = QuaternionIdentity();
}

float mQuaternionLength(Vector4 *q)
{
	return QuaternionLength(*q);
}

void mQuaternionNormalize(Vector4 *out, Vector4 *q)
{
	*out = QuaternionNormalize(*q);
}

void mQuaternionInvert(Vector4 *out, Vector4 *q)
{
	*out = QuaternionInvert(*q);
}

void mQuaternionMultiply(Vector4 *out, Vector4 *q1, Vector4 *q2)
{
	*out = QuaternionMultiply(*q1, *q2);
}

void mQuaternionScale(Vector4 *out, Vector4 *q, float mul)
{
	*out = QuaternionScale(*q, mul);
}

void mQuaternionDivide(Vector4 *out, Vector4 *q1, Vector4 *q2)
{
	*out = QuaternionDivide(*q1, *q2);
}

void mQuaternionLerp(Vector4 *out, Vector4 *q1, Vector4 *q2, float amount)
{
	*out = QuaternionLerp(*q1, *q2, amount);
}

void mQuaternionNlerp(Vector4 *out, Vector4 *q1, Vector4 *q2, float amount)
{
	*out = QuaternionNlerp(*q1, *q2, amount);
}

void mQuaternionSlerp(Vector4 *out, Vector4 *q1, Vector4 *q2, float amount)
{
	*out = QuaternionSlerp(*q1, *q2, amount);
}

void mQuaternionFromVector3ToVector3(Vector4 *out, Vector3 *from, Vector3 *to)
{
	*out = QuaternionFromVector3ToVector3(*from, *to);
}

void mQuaternionFromMatrix(Vector4 *out, Matrix *mat)
{
	*out = QuaternionFromMatrix(*mat);
}

void mQuaternionToMatrix(Matrix *out, Vector4 *q)
{
	*out = QuaternionToMatrix(*q);
}

void mQuaternionFromAxisAngle(Vector4 *out, Vector3 *axis, float angle)
{
	*out = QuaternionFromAxisAngle(*axis, angle);
}

void mQuaternionToAxisAngle(Vector4 *q, Vector3 * outAxis, float * outAngle)
{
	QuaternionToAxisAngle(*q, outAxis, outAngle);
}

void mQuaternionFromEuler(Vector4 *out, float pitch, float yaw, float roll)
{
	*out = QuaternionFromEuler(pitch, yaw, roll);
}

void mQuaternionToEuler(Vector3 *out, Vector4 *q)
{
	*out = QuaternionToEuler(*q);
}

void mQuaternionTransform(Vector4 *out, Vector4 *q, Matrix *mat)
{
	*out = QuaternionTransform(*q, *mat);
}

int mQuaternionEquals(Vector4 *p, Vector4 *q)
{
	return QuaternionEquals(*p, *q);
}

