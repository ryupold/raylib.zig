//--- CORE ----------------------------------------------------------------------------------------
#define GRAPHICS_API_OPENGL_11
// #define RLGL_IMPLEMENTATION
#include "raylib.h"
#include "rlgl.h"
#include "raymath.h"

// Enable vertex state pointer
void rlEnableStatePointer(int vertexAttribType, void *buffer);

// Disable vertex state pointer
void rlDisableStatePointer(int vertexAttribType);// Initialize window and OpenGL context
void mInitWindow(int width, int height, const char * title);

// Close window and unload OpenGL context
void mCloseWindow(void);

// Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
bool mWindowShouldClose(void);

// Check if window has been initialized successfully
bool mIsWindowReady(void);

// Check if window is currently fullscreen
bool mIsWindowFullscreen(void);

// Check if window is currently hidden (only PLATFORM_DESKTOP)
bool mIsWindowHidden(void);

// Check if window is currently minimized (only PLATFORM_DESKTOP)
bool mIsWindowMinimized(void);

// Check if window is currently maximized (only PLATFORM_DESKTOP)
bool mIsWindowMaximized(void);

// Check if window is currently focused (only PLATFORM_DESKTOP)
bool mIsWindowFocused(void);

// Check if window has been resized last frame
bool mIsWindowResized(void);

// Check if one specific window flag is enabled
bool mIsWindowState(unsigned int flag);

// Set window configuration state using flags (only PLATFORM_DESKTOP)
void mSetWindowState(unsigned int flags);

// Clear window configuration state flags
void mClearWindowState(unsigned int flags);

// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
void mToggleFullscreen(void);

// Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
void mToggleBorderlessWindowed(void);

// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
void mMaximizeWindow(void);

// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
void mMinimizeWindow(void);

// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
void mRestoreWindow(void);

// Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
void mSetWindowIcon(Image *image);

// Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
void mSetWindowIcons(Image * images, int count);

// Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
void mSetWindowTitle(const char * title);

// Set window position on screen (only PLATFORM_DESKTOP)
void mSetWindowPosition(int x, int y);

// Set monitor for the current window
void mSetWindowMonitor(int monitor);

// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
void mSetWindowMinSize(int width, int height);

// Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
void mSetWindowMaxSize(int width, int height);

// Set window dimensions
void mSetWindowSize(int width, int height);

// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
void mSetWindowOpacity(float opacity);

// Set window focused (only PLATFORM_DESKTOP)
void mSetWindowFocused(void);

// Get current screen width
int mGetScreenWidth(void);

// Get current screen height
int mGetScreenHeight(void);

// Get current render width (it considers HiDPI)
int mGetRenderWidth(void);

// Get current render height (it considers HiDPI)
int mGetRenderHeight(void);

// Get number of connected monitors
int mGetMonitorCount(void);

// Get current connected monitor
int mGetCurrentMonitor(void);

// Get specified monitor position
void mGetMonitorPosition(Vector2 *out, int monitor);

// Get specified monitor width (current video mode used by monitor)
int mGetMonitorWidth(int monitor);

// Get specified monitor height (current video mode used by monitor)
int mGetMonitorHeight(int monitor);

// Get specified monitor physical width in millimetres
int mGetMonitorPhysicalWidth(int monitor);

// Get specified monitor physical height in millimetres
int mGetMonitorPhysicalHeight(int monitor);

// Get specified monitor refresh rate
int mGetMonitorRefreshRate(int monitor);

// Get window position XY on monitor
void mGetWindowPosition(Vector2 *out);

// Get window scale DPI factor
void mGetWindowScaleDPI(Vector2 *out);

// Get the human-readable, UTF-8 encoded name of the specified monitor
const char * mGetMonitorName(int monitor);

// Set clipboard text content
void mSetClipboardText(const char * text);

// Get clipboard text content
const char * mGetClipboardText(void);

// Enable waiting for events on EndDrawing(), no automatic event polling
void mEnableEventWaiting(void);

// Disable waiting for events on EndDrawing(), automatic events polling
void mDisableEventWaiting(void);

// Shows cursor
void mShowCursor(void);

// Hides cursor
void mHideCursor(void);

// Check if cursor is not visible
bool mIsCursorHidden(void);

// Enables cursor (unlock cursor)
void mEnableCursor(void);

// Disables cursor (lock cursor)
void mDisableCursor(void);

// Check if cursor is on the screen
bool mIsCursorOnScreen(void);

// Set background color (framebuffer clear color)
void mClearBackground(Color *color);

// Setup canvas (framebuffer) to start drawing
void mBeginDrawing(void);

// End canvas drawing and swap buffers (double buffering)
void mEndDrawing(void);

// Begin 2D mode with custom camera (2D)
void mBeginMode2D(Camera2D *camera);

// Ends 2D mode with custom camera
void mEndMode2D(void);

// Begin 3D mode with custom camera (3D)
void mBeginMode3D(Camera3D *camera);

// Ends 3D mode and returns to default 2D orthographic mode
void mEndMode3D(void);

// Begin drawing to render texture
void mBeginTextureMode(RenderTexture2D *target);

// Ends drawing to render texture
void mEndTextureMode(void);

// Begin custom shader drawing
void mBeginShaderMode(Shader *shader);

// End custom shader drawing (use default shader)
void mEndShaderMode(void);

// Begin blending mode (alpha, additive, multiplied, subtract, custom)
void mBeginBlendMode(int mode);

// End blending mode (reset to default: alpha blending)
void mEndBlendMode(void);

// Begin scissor mode (define screen area for following drawing)
void mBeginScissorMode(int x, int y, int width, int height);

// End scissor mode
void mEndScissorMode(void);

// Begin stereo rendering (requires VR simulator)
void mBeginVrStereoMode(VrStereoConfig *config);

// End stereo rendering (requires VR simulator)
void mEndVrStereoMode(void);

// Load VR stereo config for VR simulator device parameters
void mLoadVrStereoConfig(VrStereoConfig *out, VrDeviceInfo *device);

// Unload VR stereo config
void mUnloadVrStereoConfig(VrStereoConfig *config);

// Load shader from files and bind default locations
void mLoadShader(Shader *out, const char * vsFileName, const char * fsFileName);

// Load shader from code strings and bind default locations
void mLoadShaderFromMemory(Shader *out, const char * vsCode, const char * fsCode);

// Check if a shader is ready
bool mIsShaderReady(Shader *shader);

// Get shader uniform location
int mGetShaderLocation(Shader *shader, const char * uniformName);

// Get shader attribute location
int mGetShaderLocationAttrib(Shader *shader, const char * attribName);

// Set shader uniform value
void mSetShaderValue(Shader *shader, int locIndex, const void * value, int uniformType);

// Set shader uniform value vector
void mSetShaderValueV(Shader *shader, int locIndex, const void * value, int uniformType, int count);

// Set shader uniform value (matrix 4x4)
void mSetShaderValueMatrix(Shader *shader, int locIndex, Matrix *mat);

// Set shader uniform value for texture (sampler2d)
void mSetShaderValueTexture(Shader *shader, int locIndex, Texture2D *texture);

// Unload shader from GPU memory (VRAM)
void mUnloadShader(Shader *shader);

// Get a ray trace from mouse position
void mGetMouseRay(Ray *out, Vector2 *mousePosition, Camera3D *camera);

// Get camera transform matrix (view matrix)
void mGetCameraMatrix(Matrix *out, Camera3D *camera);

// Get camera 2d transform matrix
void mGetCameraMatrix2D(Matrix *out, Camera2D *camera);

// Get the screen space position for a 3d world space position
void mGetWorldToScreen(Vector2 *out, Vector3 *position, Camera3D *camera);

// Get the world space position for a 2d camera screen space position
void mGetScreenToWorld2D(Vector2 *out, Vector2 *position, Camera2D *camera);

// Get size position for a 3d world space position
void mGetWorldToScreenEx(Vector2 *out, Vector3 *position, Camera3D *camera, int width, int height);

// Get the screen space position for a 2d camera world space position
void mGetWorldToScreen2D(Vector2 *out, Vector2 *position, Camera2D *camera);

// Set target FPS (maximum)
void mSetTargetFPS(int fps);

// Get time in seconds for last frame drawn (delta time)
float mGetFrameTime(void);

// Get elapsed time in seconds since InitWindow()
double mGetTime(void);

// Get current FPS
int mGetFPS(void);

// Swap back buffer with front buffer (screen drawing)
void mSwapScreenBuffer(void);

// Register all input events
void mPollInputEvents(void);

// Wait for some time (halt program execution)
void mWaitTime(double seconds);

// Set the seed for the random number generator
void mSetRandomSeed(unsigned int seed);

// Get a random value between min and max (both included)
int mGetRandomValue(int min, int max);

// Load random values sequence, no values repeated
int * mLoadRandomSequence(unsigned int count, int min, int max);

// Unload random values sequence
void mUnloadRandomSequence(int * sequence);

// Takes a screenshot of current screen (filename extension defines format)
void mTakeScreenshot(const char * fileName);

// Open URL with default system browser (if available)
void mOpenURL(const char * url);

// Set the current threshold (minimum) log level
void mSetTraceLogLevel(int logLevel);

// Set custom file binary data loader
void mSetLoadFileDataCallback(LoadFileDataCallback callback);

// Set custom file binary data saver
void mSetSaveFileDataCallback(SaveFileDataCallback callback);

// Set custom file text data loader
void mSetLoadFileTextCallback(LoadFileTextCallback callback);

// Set custom file text data saver
void mSetSaveFileTextCallback(SaveFileTextCallback callback);

// Save data to file from byte array (write), returns true on success
bool mSaveFileData(const char * fileName, void * data, int dataSize);

// Export data to code (.h), returns true on success
bool mExportDataAsCode(const unsigned char * data, int dataSize, const char * fileName);

// Load text data from file (read), returns a '\0' terminated string
char * mLoadFileText(const char * fileName);

// Unload file text data allocated by LoadFileText()
void mUnloadFileText(char * text);

// Save text data to file (write), string must be '\0' terminated, returns true on success
bool mSaveFileText(const char * fileName, char * text);

// Check if file exists
bool mFileExists(const char * fileName);

// Check if a directory path exists
bool mDirectoryExists(const char * dirPath);

// Check file extension (including point: .png, .wav)
bool mIsFileExtension(const char * fileName, const char * ext);

// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
int mGetFileLength(const char * fileName);

// Get pointer to extension for a filename string (includes dot: '.png')
const char * mGetFileExtension(const char * fileName);

// Get pointer to filename for a path string
const char * mGetFileName(const char * filePath);

// Get filename string without extension (uses static string)
const char * mGetFileNameWithoutExt(const char * filePath);

// Get full path for a given fileName with path (uses static string)
const char * mGetDirectoryPath(const char * filePath);

// Get previous directory path for a given path (uses static string)
const char * mGetPrevDirectoryPath(const char * dirPath);

// Get current working directory (uses static string)
const char * mGetWorkingDirectory(void);

// Get the directory of the running application (uses static string)
const char * mGetApplicationDirectory(void);

// Change working directory, return true on success
bool mChangeDirectory(const char * dir);

// Check if a given path is a file or a directory
bool mIsPathFile(const char * path);

// Load directory filepaths
void mLoadDirectoryFiles(FilePathList *out, const char * dirPath);

// Load directory filepaths with extension filtering and recursive directory scan
void mLoadDirectoryFilesEx(FilePathList *out, const char * basePath, const char * filter, bool scanSubdirs);

// Unload filepaths
void mUnloadDirectoryFiles(FilePathList *files);

// Check if a file has been dropped into window
bool mIsFileDropped(void);

// Load dropped filepaths
void mLoadDroppedFiles(FilePathList *out);

// Unload dropped filepaths
void mUnloadDroppedFiles(FilePathList *files);

// Get file modification time (last write time)
long mGetFileModTime(const char * fileName);

// Compress data (DEFLATE algorithm), memory must be MemFree()
unsigned char * mCompressData(const unsigned char * data, int dataSize, int * compDataSize);

// Decompress data (DEFLATE algorithm), memory must be MemFree()
unsigned char * mDecompressData(const unsigned char * compData, int compDataSize, int * dataSize);

// Encode data to Base64 string, memory must be MemFree()
char * mEncodeDataBase64(const unsigned char * data, int dataSize, int * outputSize);

// Decode Base64 string data, memory must be MemFree()
unsigned char * mDecodeDataBase64(const unsigned char * data, int * outputSize);

// Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
void mLoadAutomationEventList(AutomationEventList *out, const char * fileName);

// Unload automation events list from file
void mUnloadAutomationEventList(AutomationEventList *list);

// Export automation events list as text file
bool mExportAutomationEventList(AutomationEventList *list, const char * fileName);

// Set automation event list to record to
void mSetAutomationEventList(AutomationEventList * list);

// Set automation event internal base frame to start recording
void mSetAutomationEventBaseFrame(int frame);

// Start recording automation events (AutomationEventList must be set)
void mStartAutomationEventRecording(void);

// Stop recording automation events
void mStopAutomationEventRecording(void);

// Play a recorded automation event
void mPlayAutomationEvent(AutomationEvent *event);

// Check if a key has been pressed once
bool mIsKeyPressed(int key);

// Check if a key has been pressed again (Only PLATFORM_DESKTOP)
bool mIsKeyPressedRepeat(int key);

// Check if a key is being pressed
bool mIsKeyDown(int key);

// Check if a key has been released once
bool mIsKeyReleased(int key);

// Check if a key is NOT being pressed
bool mIsKeyUp(int key);

// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
int mGetKeyPressed(void);

// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
int mGetCharPressed(void);

// Set a custom key to exit program (default is ESC)
void mSetExitKey(int key);

// Check if a gamepad is available
bool mIsGamepadAvailable(int gamepad);

// Get gamepad internal name id
const char * mGetGamepadName(int gamepad);

// Check if a gamepad button has been pressed once
bool mIsGamepadButtonPressed(int gamepad, int button);

// Check if a gamepad button is being pressed
bool mIsGamepadButtonDown(int gamepad, int button);

// Check if a gamepad button has been released once
bool mIsGamepadButtonReleased(int gamepad, int button);

// Check if a gamepad button is NOT being pressed
bool mIsGamepadButtonUp(int gamepad, int button);

// Get gamepad axis count for a gamepad
int mGetGamepadAxisCount(int gamepad);

// Get axis movement value for a gamepad axis
float mGetGamepadAxisMovement(int gamepad, int axis);

// Set internal gamepad mappings (SDL_GameControllerDB)
int mSetGamepadMappings(const char * mappings);

// Check if a mouse button has been pressed once
bool mIsMouseButtonPressed(int button);

// Check if a mouse button is being pressed
bool mIsMouseButtonDown(int button);

// Check if a mouse button has been released once
bool mIsMouseButtonReleased(int button);

// Check if a mouse button is NOT being pressed
bool mIsMouseButtonUp(int button);

// Get mouse position X
int mGetMouseX(void);

// Get mouse position Y
int mGetMouseY(void);

// Get mouse position XY
void mGetMousePosition(Vector2 *out);

// Get mouse delta between frames
void mGetMouseDelta(Vector2 *out);

// Set mouse position XY
void mSetMousePosition(int x, int y);

// Set mouse offset
void mSetMouseOffset(int offsetX, int offsetY);

// Set mouse scaling
void mSetMouseScale(float scaleX, float scaleY);

// Get mouse wheel movement for X or Y, whichever is larger
float mGetMouseWheelMove(void);

// Get mouse wheel movement for both X and Y
void mGetMouseWheelMoveV(Vector2 *out);

// Set mouse cursor
void mSetMouseCursor(int cursor);

// Get touch position X for touch point 0 (relative to screen size)
int mGetTouchX(void);

// Get touch position Y for touch point 0 (relative to screen size)
int mGetTouchY(void);

// Get touch position XY for a touch point index (relative to screen size)
void mGetTouchPosition(Vector2 *out, int index);

// Get touch point identifier for given index
int mGetTouchPointId(int index);

// Get number of touch points
int mGetTouchPointCount(void);

// Enable a set of gestures using flags
void mSetGesturesEnabled(unsigned int flags);

// Check if a gesture have been detected
bool mIsGestureDetected(unsigned int gesture);

// Get latest detected gesture
int mGetGestureDetected(void);

// Get gesture hold time in milliseconds
float mGetGestureHoldDuration(void);

// Get gesture drag vector
void mGetGestureDragVector(Vector2 *out);

// Get gesture drag angle
float mGetGestureDragAngle(void);

// Get gesture pinch delta
void mGetGesturePinchVector(Vector2 *out);

// Get gesture pinch angle
float mGetGesturePinchAngle(void);

// Update camera position for selected mode
void mUpdateCamera(Camera * camera, int mode);

// Update camera movement/rotation
void mUpdateCameraPro(Camera * camera, Vector3 *movement, Vector3 *rotation, float zoom);

// Set texture and rectangle to be used on shapes drawing
void mSetShapesTexture(Texture2D *texture, Rectangle *source);

// Get texture that is used for shapes drawing
void mGetShapesTexture(Texture2D *out);

// Get texture source rectangle that is used for shapes drawing
void mGetShapesTextureRectangle(Rectangle *out);

// Draw a pixel
void mDrawPixel(int posX, int posY, Color *color);

// Draw a pixel (Vector version)
void mDrawPixelV(Vector2 *position, Color *color);

// Draw a line
void mDrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color *color);

// Draw a line (using gl lines)
void mDrawLineV(Vector2 *startPos, Vector2 *endPos, Color *color);

// Draw a line (using triangles/quads)
void mDrawLineEx(Vector2 *startPos, Vector2 *endPos, float thick, Color *color);

// Draw lines sequence (using gl lines)
void mDrawLineStrip(Vector2 * points, int pointCount, Color *color);

// Draw line segment cubic-bezier in-out interpolation
void mDrawLineBezier(Vector2 *startPos, Vector2 *endPos, float thick, Color *color);

// Draw a color-filled circle
void mDrawCircle(int centerX, int centerY, float radius, Color *color);

// Draw a piece of a circle
void mDrawCircleSector(Vector2 *center, float radius, float startAngle, float endAngle, int segments, Color *color);

// Draw circle sector outline
void mDrawCircleSectorLines(Vector2 *center, float radius, float startAngle, float endAngle, int segments, Color *color);

// Draw a gradient-filled circle
void mDrawCircleGradient(int centerX, int centerY, float radius, Color *color1, Color *color2);

// Draw a color-filled circle (Vector version)
void mDrawCircleV(Vector2 *center, float radius, Color *color);

// Draw circle outline
void mDrawCircleLines(int centerX, int centerY, float radius, Color *color);

// Draw circle outline (Vector version)
void mDrawCircleLinesV(Vector2 *center, float radius, Color *color);

// Draw ellipse
void mDrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color *color);

// Draw ellipse outline
void mDrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color *color);

// Draw ring
void mDrawRing(Vector2 *center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color *color);

// Draw ring outline
void mDrawRingLines(Vector2 *center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color *color);

// Draw a color-filled rectangle
void mDrawRectangle(int posX, int posY, int width, int height, Color *color);

// Draw a color-filled rectangle (Vector version)
void mDrawRectangleV(Vector2 *position, Vector2 *size, Color *color);

// Draw a color-filled rectangle
void mDrawRectangleRec(Rectangle *rec, Color *color);

// Draw a color-filled rectangle with pro parameters
void mDrawRectanglePro(Rectangle *rec, Vector2 *origin, float rotation, Color *color);

// Draw a vertical-gradient-filled rectangle
void mDrawRectangleGradientV(int posX, int posY, int width, int height, Color *color1, Color *color2);

// Draw a horizontal-gradient-filled rectangle
void mDrawRectangleGradientH(int posX, int posY, int width, int height, Color *color1, Color *color2);

// Draw a gradient-filled rectangle with custom vertex colors
void mDrawRectangleGradientEx(Rectangle *rec, Color *col1, Color *col2, Color *col3, Color *col4);

// Draw rectangle outline
void mDrawRectangleLines(int posX, int posY, int width, int height, Color *color);

// Draw rectangle outline with extended parameters
void mDrawRectangleLinesEx(Rectangle *rec, float lineThick, Color *color);

// Draw rectangle with rounded edges
void mDrawRectangleRounded(Rectangle *rec, float roundness, int segments, Color *color);

// Draw rectangle with rounded edges outline
void mDrawRectangleRoundedLines(Rectangle *rec, float roundness, int segments, float lineThick, Color *color);

// Draw a color-filled triangle (vertex in counter-clockwise order!)
void mDrawTriangle(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color);

// Draw triangle outline (vertex in counter-clockwise order!)
void mDrawTriangleLines(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color);

// Draw a triangle fan defined by points (first vertex is the center)
void mDrawTriangleFan(Vector2 * points, int pointCount, Color *color);

// Draw a triangle strip defined by points
void mDrawTriangleStrip(Vector2 * points, int pointCount, Color *color);

// Draw a regular polygon (Vector version)
void mDrawPoly(Vector2 *center, int sides, float radius, float rotation, Color *color);

// Draw a polygon outline of n sides
void mDrawPolyLines(Vector2 *center, int sides, float radius, float rotation, Color *color);

// Draw a polygon outline of n sides with extended parameters
void mDrawPolyLinesEx(Vector2 *center, int sides, float radius, float rotation, float lineThick, Color *color);

// Draw spline: Linear, minimum 2 points
void mDrawSplineLinear(Vector2 * points, int pointCount, float thick, Color *color);

// Draw spline: B-Spline, minimum 4 points
void mDrawSplineBasis(Vector2 * points, int pointCount, float thick, Color *color);

// Draw spline: Catmull-Rom, minimum 4 points
void mDrawSplineCatmullRom(Vector2 * points, int pointCount, float thick, Color *color);

// Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
void mDrawSplineBezierQuadratic(Vector2 * points, int pointCount, float thick, Color *color);

// Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
void mDrawSplineBezierCubic(Vector2 * points, int pointCount, float thick, Color *color);

// Draw spline segment: Linear, 2 points
void mDrawSplineSegmentLinear(Vector2 *p1, Vector2 *p2, float thick, Color *color);

// Draw spline segment: B-Spline, 4 points
void mDrawSplineSegmentBasis(Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float thick, Color *color);

// Draw spline segment: Catmull-Rom, 4 points
void mDrawSplineSegmentCatmullRom(Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float thick, Color *color);

// Draw spline segment: Quadratic Bezier, 2 points, 1 control point
void mDrawSplineSegmentBezierQuadratic(Vector2 *p1, Vector2 *c2, Vector2 *p3, float thick, Color *color);

// Draw spline segment: Cubic Bezier, 2 points, 2 control points
void mDrawSplineSegmentBezierCubic(Vector2 *p1, Vector2 *c2, Vector2 *c3, Vector2 *p4, float thick, Color *color);

// Get (evaluate) spline point: Linear
void mGetSplinePointLinear(Vector2 *out, Vector2 *startPos, Vector2 *endPos, float t);

// Get (evaluate) spline point: B-Spline
void mGetSplinePointBasis(Vector2 *out, Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float t);

// Get (evaluate) spline point: Catmull-Rom
void mGetSplinePointCatmullRom(Vector2 *out, Vector2 *p1, Vector2 *p2, Vector2 *p3, Vector2 *p4, float t);

// Get (evaluate) spline point: Quadratic Bezier
void mGetSplinePointBezierQuad(Vector2 *out, Vector2 *p1, Vector2 *c2, Vector2 *p3, float t);

// Get (evaluate) spline point: Cubic Bezier
void mGetSplinePointBezierCubic(Vector2 *out, Vector2 *p1, Vector2 *c2, Vector2 *c3, Vector2 *p4, float t);

// Check collision between two rectangles
bool mCheckCollisionRecs(Rectangle *rec1, Rectangle *rec2);

// Check collision between two circles
bool mCheckCollisionCircles(Vector2 *center1, float radius1, Vector2 *center2, float radius2);

// Check collision between circle and rectangle
bool mCheckCollisionCircleRec(Vector2 *center, float radius, Rectangle *rec);

// Check if point is inside rectangle
bool mCheckCollisionPointRec(Vector2 *point, Rectangle *rec);

// Check if point is inside circle
bool mCheckCollisionPointCircle(Vector2 *point, Vector2 *center, float radius);

// Check if point is inside a triangle
bool mCheckCollisionPointTriangle(Vector2 *point, Vector2 *p1, Vector2 *p2, Vector2 *p3);

// Check if point is within a polygon described by array of vertices
bool mCheckCollisionPointPoly(Vector2 *point, Vector2 * points, int pointCount);

// Check the collision between two lines defined by two points each, returns collision point by reference
bool mCheckCollisionLines(Vector2 *startPos1, Vector2 *endPos1, Vector2 *startPos2, Vector2 *endPos2, Vector2 * collisionPoint);

// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
bool mCheckCollisionPointLine(Vector2 *point, Vector2 *p1, Vector2 *p2, int threshold);

// Get collision rectangle for two rectangles collision
void mGetCollisionRec(Rectangle *out, Rectangle *rec1, Rectangle *rec2);

// Load image from file into CPU memory (RAM)
void mLoadImage(Image *out, const char * fileName);

// Load image from RAW file data
void mLoadImageRaw(Image *out, const char * fileName, int width, int height, int format, int headerSize);

// Load image from SVG file data or string with specified size
void mLoadImageSvg(Image *out, const char * fileNameOrString, int width, int height);

// Load image sequence from file (frames appended to image.data)
void mLoadImageAnim(Image *out, const char * fileName, int * frames);

// Load image sequence from memory buffer
void mLoadImageAnimFromMemory(Image *out, const char * fileType, const unsigned char * fileData, int dataSize, int * frames);

// Load image from memory buffer, fileType refers to extension: i.e. '.png'
void mLoadImageFromMemory(Image *out, const char * fileType, const unsigned char * fileData, int dataSize);

// Load image from GPU texture data
void mLoadImageFromTexture(Image *out, Texture2D *texture);

// Load image from screen buffer and (screenshot)
void mLoadImageFromScreen(Image *out);

// Check if an image is ready
bool mIsImageReady(Image *image);

// Unload image from CPU memory (RAM)
void mUnloadImage(Image *image);

// Export image data to file, returns true on success
bool mExportImage(Image *image, const char * fileName);

// Export image to memory buffer
unsigned char * mExportImageToMemory(Image *image, const char * fileType, int * fileSize);

// Export image as code file defining an array of bytes, returns true on success
bool mExportImageAsCode(Image *image, const char * fileName);

// Generate image: plain color
void mGenImageColor(Image *out, int width, int height, Color *color);

// Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
void mGenImageGradientLinear(Image *out, int width, int height, int direction, Color *start, Color *end);

// Generate image: radial gradient
void mGenImageGradientRadial(Image *out, int width, int height, float density, Color *inner, Color *outer);

// Generate image: square gradient
void mGenImageGradientSquare(Image *out, int width, int height, float density, Color *inner, Color *outer);

// Generate image: checked
void mGenImageChecked(Image *out, int width, int height, int checksX, int checksY, Color *col1, Color *col2);

// Generate image: white noise
void mGenImageWhiteNoise(Image *out, int width, int height, float factor);

// Generate image: perlin noise
void mGenImagePerlinNoise(Image *out, int width, int height, int offsetX, int offsetY, float scale);

// Generate image: cellular algorithm, bigger tileSize means bigger cells
void mGenImageCellular(Image *out, int width, int height, int tileSize);

// Generate image: grayscale image from text data
void mGenImageText(Image *out, int width, int height, const char * text);

// Create an image duplicate (useful for transformations)
void mImageCopy(Image *out, Image *image);

// Create an image from another image piece
void mImageFromImage(Image *out, Image *image, Rectangle *rec);

// Create an image from text (default font)
void mImageText(Image *out, const char * text, int fontSize, Color *color);

// Create an image from text (custom sprite font)
void mImageTextEx(Image *out, Font *font, const char * text, float fontSize, float spacing, Color *tint);

// Convert image data to desired format
void mImageFormat(Image * image, int newFormat);

// Convert image to POT (power-of-two)
void mImageToPOT(Image * image, Color *fill);

// Crop an image to a defined rectangle
void mImageCrop(Image * image, Rectangle *crop);

// Crop image depending on alpha value
void mImageAlphaCrop(Image * image, float threshold);

// Clear alpha channel to desired color
void mImageAlphaClear(Image * image, Color *color, float threshold);

// Apply alpha mask to image
void mImageAlphaMask(Image * image, Image *alphaMask);

// Premultiply alpha channel
void mImageAlphaPremultiply(Image * image);

// Apply Gaussian blur using a box blur approximation
void mImageBlurGaussian(Image * image, int blurSize);

// Apply Custom Square image convolution kernel
void mImageKernelConvolution(Image * image, float* kernel, int kernelSize);

// Resize image (Bicubic scaling algorithm)
void mImageResize(Image * image, int newWidth, int newHeight);

// Resize image (Nearest-Neighbor scaling algorithm)
void mImageResizeNN(Image * image, int newWidth, int newHeight);

// Resize canvas and fill with color
void mImageResizeCanvas(Image * image, int newWidth, int newHeight, int offsetX, int offsetY, Color *fill);

// Compute all mipmap levels for a provided image
void mImageMipmaps(Image * image);

// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
void mImageDither(Image * image, int rBpp, int gBpp, int bBpp, int aBpp);

// Flip image vertically
void mImageFlipVertical(Image * image);

// Flip image horizontally
void mImageFlipHorizontal(Image * image);

// Rotate image by input angle in degrees (-359 to 359)
void mImageRotate(Image * image, int degrees);

// Rotate image clockwise 90deg
void mImageRotateCW(Image * image);

// Rotate image counter-clockwise 90deg
void mImageRotateCCW(Image * image);

// Modify image color: tint
void mImageColorTint(Image * image, Color *color);

// Modify image color: invert
void mImageColorInvert(Image * image);

// Modify image color: grayscale
void mImageColorGrayscale(Image * image);

// Modify image color: contrast (-100 to 100)
void mImageColorContrast(Image * image, float contrast);

// Modify image color: brightness (-255 to 255)
void mImageColorBrightness(Image * image, int brightness);

// Modify image color: replace color
void mImageColorReplace(Image * image, Color *color, Color *replace);

// Load color data from image as a Color array (RGBA - 32bit)
Color * mLoadImageColors(Image *image);

// Load colors palette from image as a Color array (RGBA - 32bit)
Color * mLoadImagePalette(Image *image, int maxPaletteSize, int * colorCount);

// Unload color data loaded with LoadImageColors()
void mUnloadImageColors(Color * colors);

// Unload colors palette loaded with LoadImagePalette()
void mUnloadImagePalette(Color * colors);

// Get image alpha border rectangle
void mGetImageAlphaBorder(Rectangle *out, Image *image, float threshold);

// Get image pixel color at (x, y) position
void mGetImageColor(Color *out, Image *image, int x, int y);

// Clear image background with given color
void mImageClearBackground(Image * dst, Color *color);

// Draw pixel within an image
void mImageDrawPixel(Image * dst, int posX, int posY, Color *color);

// Draw pixel within an image (Vector version)
void mImageDrawPixelV(Image * dst, Vector2 *position, Color *color);

// Draw line within an image
void mImageDrawLine(Image * dst, int startPosX, int startPosY, int endPosX, int endPosY, Color *color);

// Draw line within an image (Vector version)
void mImageDrawLineV(Image * dst, Vector2 *start, Vector2 *end, Color *color);

// Draw a filled circle within an image
void mImageDrawCircle(Image * dst, int centerX, int centerY, int radius, Color *color);

// Draw a filled circle within an image (Vector version)
void mImageDrawCircleV(Image * dst, Vector2 *center, int radius, Color *color);

// Draw circle outline within an image
void mImageDrawCircleLines(Image * dst, int centerX, int centerY, int radius, Color *color);

// Draw circle outline within an image (Vector version)
void mImageDrawCircleLinesV(Image * dst, Vector2 *center, int radius, Color *color);

// Draw rectangle within an image
void mImageDrawRectangle(Image * dst, int posX, int posY, int width, int height, Color *color);

// Draw rectangle within an image (Vector version)
void mImageDrawRectangleV(Image * dst, Vector2 *position, Vector2 *size, Color *color);

// Draw rectangle within an image
void mImageDrawRectangleRec(Image * dst, Rectangle *rec, Color *color);

// Draw rectangle lines within an image
void mImageDrawRectangleLines(Image * dst, Rectangle *rec, int thick, Color *color);

// Draw a source image within a destination image (tint applied to source)
void mImageDraw(Image * dst, Image *src, Rectangle *srcRec, Rectangle *dstRec, Color *tint);

// Draw text (using default font) within an image (destination)
void mImageDrawText(Image * dst, const char * text, int posX, int posY, int fontSize, Color *color);

// Draw text (custom sprite font) within an image (destination)
void mImageDrawTextEx(Image * dst, Font *font, const char * text, Vector2 *position, float fontSize, float spacing, Color *tint);

// Load texture from file into GPU memory (VRAM)
void mLoadTexture(Texture2D *out, const char * fileName);

// Load texture from image data
void mLoadTextureFromImage(Texture2D *out, Image *image);

// Load cubemap from image, multiple image cubemap layouts supported
void mLoadTextureCubemap(Texture2D *out, Image *image, int layout);

// Load texture for rendering (framebuffer)
void mLoadRenderTexture(RenderTexture2D *out, int width, int height);

// Check if a texture is ready
bool mIsTextureReady(Texture2D *texture);

// Unload texture from GPU memory (VRAM)
void mUnloadTexture(Texture2D *texture);

// Check if a render texture is ready
bool mIsRenderTextureReady(RenderTexture2D *target);

// Unload render texture from GPU memory (VRAM)
void mUnloadRenderTexture(RenderTexture2D *target);

// Update GPU texture with new data
void mUpdateTexture(Texture2D *texture, const void * pixels);

// Update GPU texture rectangle with new data
void mUpdateTextureRec(Texture2D *texture, Rectangle *rec, const void * pixels);

// Generate GPU mipmaps for a texture
void mGenTextureMipmaps(Texture2D * texture);

// Set texture scaling filter mode
void mSetTextureFilter(Texture2D *texture, int filter);

// Set texture wrapping mode
void mSetTextureWrap(Texture2D *texture, int wrap);

// Draw a Texture2D
void mDrawTexture(Texture2D *texture, int posX, int posY, Color *tint);

// Draw a Texture2D with position defined as Vector2
void mDrawTextureV(Texture2D *texture, Vector2 *position, Color *tint);

// Draw a Texture2D with extended parameters
void mDrawTextureEx(Texture2D *texture, Vector2 *position, float rotation, float scale, Color *tint);

// Draw a part of a texture defined by a rectangle
void mDrawTextureRec(Texture2D *texture, Rectangle *source, Vector2 *position, Color *tint);

// Draw a part of a texture defined by a rectangle with 'pro' parameters
void mDrawTexturePro(Texture2D *texture, Rectangle *source, Rectangle *dest, Vector2 *origin, float rotation, Color *tint);

// Draws a texture (or part of it) that stretches or shrinks nicely
void mDrawTextureNPatch(Texture2D *texture, NPatchInfo *nPatchInfo, Rectangle *dest, Vector2 *origin, float rotation, Color *tint);

// Get color with alpha applied, alpha goes from 0.0f to 1.0f
void mFade(Color *out, Color *color, float alpha);

// Get hexadecimal value for a Color
int mColorToInt(Color *color);

// Get Color normalized as float [0..1]
void mColorNormalize(Vector4 *out, Color *color);

// Get Color from normalized values [0..1]
void mColorFromNormalized(Color *out, Vector4 *normalized);

// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
void mColorToHSV(Vector3 *out, Color *color);

// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
void mColorFromHSV(Color *out, float hue, float saturation, float value);

// Get color multiplied with another color
void mColorTint(Color *out, Color *color, Color *tint);

// Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
void mColorBrightness(Color *out, Color *color, float factor);

// Get color with contrast correction, contrast values between -1.0f and 1.0f
void mColorContrast(Color *out, Color *color, float contrast);

// Get color with alpha applied, alpha goes from 0.0f to 1.0f
void mColorAlpha(Color *out, Color *color, float alpha);

// Get src alpha-blended into dst color with tint
void mColorAlphaBlend(Color *out, Color *dst, Color *src, Color *tint);

// Get Color structure from hexadecimal value
void mGetColor(Color *out, unsigned int hexValue);

// Get Color from a source pixel pointer of certain format
void mGetPixelColor(Color *out, void * srcPtr, int format);

// Set color formatted into destination pixel pointer
void mSetPixelColor(void * dstPtr, Color *color, int format);

// Get pixel data size in bytes for certain format
int mGetPixelDataSize(int width, int height, int format);

// Get the default Font
void mGetFontDefault(Font *out);

// Load font from file into GPU memory (VRAM)
void mLoadFont(Font *out, const char * fileName);

// Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character setFont
void mLoadFontEx(Font *out, const char * fileName, int fontSize, int * codepoints, int codepointCount);

// Load font from Image (XNA style)
void mLoadFontFromImage(Font *out, Image *image, Color *key, int firstChar);

// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
void mLoadFontFromMemory(Font *out, const char * fileType, const unsigned char * fileData, int dataSize, int fontSize, int * codepoints, int codepointCount);

// Check if a font is ready
bool mIsFontReady(Font *font);

// Load font data for further use
GlyphInfo * mLoadFontData(const unsigned char * fileData, int dataSize, int fontSize, int * codepoints, int codepointCount, int type);

// Unload font chars info data (RAM)
void mUnloadFontData(GlyphInfo * glyphs, int glyphCount);

// Unload font from GPU memory (VRAM)
void mUnloadFont(Font *font);

// Export font as code file, returns true on success
bool mExportFontAsCode(Font *font, const char * fileName);

// Draw current FPS
void mDrawFPS(int posX, int posY);

// Draw text (using default font)
void mDrawText(const char * text, int posX, int posY, int fontSize, Color *color);

// Draw text using font and additional parameters
void mDrawTextEx(Font *font, const char * text, Vector2 *position, float fontSize, float spacing, Color *tint);

// Draw text using Font and pro parameters (rotation)
void mDrawTextPro(Font *font, const char * text, Vector2 *position, Vector2 *origin, float rotation, float fontSize, float spacing, Color *tint);

// Draw one character (codepoint)
void mDrawTextCodepoint(Font *font, int codepoint, Vector2 *position, float fontSize, Color *tint);

// Draw multiple character (codepoint)
void mDrawTextCodepoints(Font *font, const int * codepoints, int codepointCount, Vector2 *position, float fontSize, float spacing, Color *tint);

// Set vertical line spacing when drawing with line-breaks
void mSetTextLineSpacing(int spacing);

// Measure string width for default font
int mMeasureText(const char * text, int fontSize);

// Measure string size for Font
void mMeasureTextEx(Vector2 *out, Font *font, const char * text, float fontSize, float spacing);

// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
int mGetGlyphIndex(Font *font, int codepoint);

// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
void mGetGlyphInfo(GlyphInfo *out, Font *font, int codepoint);

// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
void mGetGlyphAtlasRec(Rectangle *out, Font *font, int codepoint);

// Load UTF-8 text encoded from codepoints array
char * mLoadUTF8(const int * codepoints, int length);

// Unload UTF-8 text encoded from codepoints array
void mUnloadUTF8(char * text);

// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
int * mLoadCodepoints(const char * text, int * count);

// Unload codepoints data from memory
void mUnloadCodepoints(int * codepoints);

// Get total number of codepoints in a UTF-8 encoded string
int mGetCodepointCount(const char * text);

// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
int mGetCodepoint(const char * text, int * codepointSize);

// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
int mGetCodepointNext(const char * text, int * codepointSize);

// Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
int mGetCodepointPrevious(const char * text, int * codepointSize);

// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
const char * mCodepointToUTF8(int codepoint, int * utf8Size);

// Copy one string to another, returns bytes copied
int mTextCopy(char * dst, const char * src);

// Check if two text string are equal
bool mTextIsEqual(const char * text1, const char * text2);

// Get text length, checks for '\0' ending
unsigned int mTextLength(const char * text);

// Get a piece of a text string
const char * mTextSubtext(const char * text, int position, int length);

// Replace text string (WARNING: memory must be freed!)
char * mTextReplace(const char * text, const char * replace, const char * by);

// Insert text in a position (WARNING: memory must be freed!)
char * mTextInsert(const char * text, const char * insert, int position);

// Find first text occurrence within a string
int mTextFindIndex(const char * text, const char * find);

// Get upper case version of provided string
const char * mTextToUpper(const char * text);

// Get lower case version of provided string
const char * mTextToLower(const char * text);

// Get Pascal case notation version of provided string
const char * mTextToPascal(const char * text);

// Get integer value from text (negative values not supported)
int mTextToInteger(const char * text);

// Get float value from text (negative values not supported)
float mTextToFloat(const char * text);

// Draw a line in 3D world space
void mDrawLine3D(Vector3 *startPos, Vector3 *endPos, Color *color);

// Draw a point in 3D space, actually a small line
void mDrawPoint3D(Vector3 *position, Color *color);

// Draw a circle in 3D world space
void mDrawCircle3D(Vector3 *center, float radius, Vector3 *rotationAxis, float rotationAngle, Color *color);

// Draw a color-filled triangle (vertex in counter-clockwise order!)
void mDrawTriangle3D(Vector3 *v1, Vector3 *v2, Vector3 *v3, Color *color);

// Draw a triangle strip defined by points
void mDrawTriangleStrip3D(Vector3 * points, int pointCount, Color *color);

// Draw cube
void mDrawCube(Vector3 *position, float width, float height, float length, Color *color);

// Draw cube (Vector version)
void mDrawCubeV(Vector3 *position, Vector3 *size, Color *color);

// Draw cube wires
void mDrawCubeWires(Vector3 *position, float width, float height, float length, Color *color);

// Draw cube wires (Vector version)
void mDrawCubeWiresV(Vector3 *position, Vector3 *size, Color *color);

// Draw sphere
void mDrawSphere(Vector3 *centerPos, float radius, Color *color);

// Draw sphere with extended parameters
void mDrawSphereEx(Vector3 *centerPos, float radius, int rings, int slices, Color *color);

// Draw sphere wires
void mDrawSphereWires(Vector3 *centerPos, float radius, int rings, int slices, Color *color);

// Draw a cylinder/cone
void mDrawCylinder(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color);

// Draw a cylinder with base at startPos and top at endPos
void mDrawCylinderEx(Vector3 *startPos, Vector3 *endPos, float startRadius, float endRadius, int sides, Color *color);

// Draw a cylinder/cone wires
void mDrawCylinderWires(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color);

// Draw a cylinder wires with base at startPos and top at endPos
void mDrawCylinderWiresEx(Vector3 *startPos, Vector3 *endPos, float startRadius, float endRadius, int sides, Color *color);

// Draw a capsule with the center of its sphere caps at startPos and endPos
void mDrawCapsule(Vector3 *startPos, Vector3 *endPos, float radius, int slices, int rings, Color *color);

// Draw capsule wireframe with the center of its sphere caps at startPos and endPos
void mDrawCapsuleWires(Vector3 *startPos, Vector3 *endPos, float radius, int slices, int rings, Color *color);

// Draw a plane XZ
void mDrawPlane(Vector3 *centerPos, Vector2 *size, Color *color);

// Draw a ray line
void mDrawRay(Ray *ray, Color *color);

// Draw a grid (centered at (0, 0, 0))
void mDrawGrid(int slices, float spacing);

// Load model from files (meshes and materials)
void mLoadModel(Model *out, const char * fileName);

// Load model from generated mesh (default material)
void mLoadModelFromMesh(Model *out, Mesh *mesh);

// Check if a model is ready
bool mIsModelReady(Model *model);

// Unload model (including meshes) from memory (RAM and/or VRAM)
void mUnloadModel(Model *model);

// Compute model bounding box limits (considers all meshes)
void mGetModelBoundingBox(BoundingBox *out, Model *model);

// Draw a model (with texture if set)
void mDrawModel(Model *model, Vector3 *position, float scale, Color *tint);

// Draw a model with extended parameters
void mDrawModelEx(Model *model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint);

// Draw a model wires (with texture if set)
void mDrawModelWires(Model *model, Vector3 *position, float scale, Color *tint);

// Draw a model wires (with texture if set) with extended parameters
void mDrawModelWiresEx(Model *model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint);

// Draw bounding box (wires)
void mDrawBoundingBox(BoundingBox *box, Color *color);

// Draw a billboard texture
void mDrawBillboard(Camera3D *camera, Texture2D *texture, Vector3 *position, float size, Color *tint);

// Draw a billboard texture defined by source
void mDrawBillboardRec(Camera3D *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector2 *size, Color *tint);

// Draw a billboard texture defined by source and rotation
void mDrawBillboardPro(Camera3D *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector3 *up, Vector2 *size, Vector2 *origin, float rotation, Color *tint);

// Upload mesh vertex data in GPU and provide VAO/VBO ids
void mUploadMesh(Mesh * mesh, bool dynamic);

// Update mesh vertex data in GPU for a specific buffer index
void mUpdateMeshBuffer(Mesh *mesh, int index, const void * data, int dataSize, int offset);

// Unload mesh data from CPU and GPU
void mUnloadMesh(Mesh *mesh);

// Draw a 3d mesh with material and transform
void mDrawMesh(Mesh *mesh, Material *material, Matrix *transform);

// Draw multiple mesh instances with material and different transforms
void mDrawMeshInstanced(Mesh *mesh, Material *material, const Matrix * transforms, int instances);

// Compute mesh bounding box limits
void mGetMeshBoundingBox(BoundingBox *out, Mesh *mesh);

// Compute mesh tangents
void mGenMeshTangents(Mesh * mesh);

// Export mesh data to file, returns true on success
bool mExportMesh(Mesh *mesh, const char * fileName);

// Export mesh as code file (.h) defining multiple arrays of vertex attributes
bool mExportMeshAsCode(Mesh *mesh, const char * fileName);

// Generate polygonal mesh
void mGenMeshPoly(Mesh *out, int sides, float radius);

// Generate plane mesh (with subdivisions)
void mGenMeshPlane(Mesh *out, float width, float length, int resX, int resZ);

// Generate cuboid mesh
void mGenMeshCube(Mesh *out, float width, float height, float length);

// Generate sphere mesh (standard sphere)
void mGenMeshSphere(Mesh *out, float radius, int rings, int slices);

// Generate half-sphere mesh (no bottom cap)
void mGenMeshHemiSphere(Mesh *out, float radius, int rings, int slices);

// Generate cylinder mesh
void mGenMeshCylinder(Mesh *out, float radius, float height, int slices);

// Generate cone/pyramid mesh
void mGenMeshCone(Mesh *out, float radius, float height, int slices);

// Generate torus mesh
void mGenMeshTorus(Mesh *out, float radius, float size, int radSeg, int sides);

// Generate trefoil knot mesh
void mGenMeshKnot(Mesh *out, float radius, float size, int radSeg, int sides);

// Generate heightmap mesh from image data
void mGenMeshHeightmap(Mesh *out, Image *heightmap, Vector3 *size);

// Generate cubes-based map mesh from image data
void mGenMeshCubicmap(Mesh *out, Image *cubicmap, Vector3 *cubeSize);

// Load materials from model file
Material * mLoadMaterials(const char * fileName, int * materialCount);

// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
void mLoadMaterialDefault(Material *out);

// Check if a material is ready
bool mIsMaterialReady(Material *material);

// Unload material from GPU memory (VRAM)
void mUnloadMaterial(Material *material);

// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
void mSetMaterialTexture(Material * material, int mapType, Texture2D *texture);

// Set material for a mesh
void mSetModelMeshMaterial(Model * model, int meshId, int materialId);

// Load model animations from file
ModelAnimation * mLoadModelAnimations(const char * fileName, int * animCount);

// Update model animation pose
void mUpdateModelAnimation(Model *model, ModelAnimation *anim, int frame);

// Unload animation data
void mUnloadModelAnimation(ModelAnimation *anim);

// Unload animation array data
void mUnloadModelAnimations(ModelAnimation * animations, int animCount);

// Check model animation skeleton match
bool mIsModelAnimationValid(Model *model, ModelAnimation *anim);

// Check collision between two spheres
bool mCheckCollisionSpheres(Vector3 *center1, float radius1, Vector3 *center2, float radius2);

// Check collision between two bounding boxes
bool mCheckCollisionBoxes(BoundingBox *box1, BoundingBox *box2);

// Check collision between box and sphere
bool mCheckCollisionBoxSphere(BoundingBox *box, Vector3 *center, float radius);

// Get collision info between ray and sphere
void mGetRayCollisionSphere(RayCollision *out, Ray *ray, Vector3 *center, float radius);

// Get collision info between ray and box
void mGetRayCollisionBox(RayCollision *out, Ray *ray, BoundingBox *box);

// Get collision info between ray and mesh
void mGetRayCollisionMesh(RayCollision *out, Ray *ray, Mesh *mesh, Matrix *transform);

// Get collision info between ray and triangle
void mGetRayCollisionTriangle(RayCollision *out, Ray *ray, Vector3 *p1, Vector3 *p2, Vector3 *p3);

// Get collision info between ray and quad
void mGetRayCollisionQuad(RayCollision *out, Ray *ray, Vector3 *p1, Vector3 *p2, Vector3 *p3, Vector3 *p4);

// Initialize audio device and context
void mInitAudioDevice(void);

// Close the audio device and context
void mCloseAudioDevice(void);

// Check if audio device has been initialized successfully
bool mIsAudioDeviceReady(void);

// Set master volume (listener)
void mSetMasterVolume(float volume);

// Get master volume (listener)
float mGetMasterVolume(void);

// Load wave data from file
void mLoadWave(Wave *out, const char * fileName);

// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
void mLoadWaveFromMemory(Wave *out, const char * fileType, const unsigned char * fileData, int dataSize);

// Checks if wave data is ready
bool mIsWaveReady(Wave *wave);

// Load sound from file
void mLoadSound(Sound *out, const char * fileName);

// Load sound from wave data
void mLoadSoundFromWave(Sound *out, Wave *wave);

// Create a new sound that shares the same sample data as the source sound, does not own the sound data
void mLoadSoundAlias(Sound *out, Sound *source);

// Checks if a sound is ready
bool mIsSoundReady(Sound *sound);

// Update sound buffer with new data
void mUpdateSound(Sound *sound, const void * data, int sampleCount);

// Unload wave data
void mUnloadWave(Wave *wave);

// Unload sound
void mUnloadSound(Sound *sound);

// Unload a sound alias (does not deallocate sample data)
void mUnloadSoundAlias(Sound *alias);

// Export wave data to file, returns true on success
bool mExportWave(Wave *wave, const char * fileName);

// Export wave sample data to code (.h), returns true on success
bool mExportWaveAsCode(Wave *wave, const char * fileName);

// Play a sound
void mPlaySound(Sound *sound);

// Stop playing a sound
void mStopSound(Sound *sound);

// Pause a sound
void mPauseSound(Sound *sound);

// Resume a paused sound
void mResumeSound(Sound *sound);

// Check if a sound is currently playing
bool mIsSoundPlaying(Sound *sound);

// Set volume for a sound (1.0 is max level)
void mSetSoundVolume(Sound *sound, float volume);

// Set pitch for a sound (1.0 is base level)
void mSetSoundPitch(Sound *sound, float pitch);

// Set pan for a sound (0.5 is center)
void mSetSoundPan(Sound *sound, float pan);

// Copy a wave to a new wave
void mWaveCopy(Wave *out, Wave *wave);

// Crop a wave to defined samples range
void mWaveCrop(Wave * wave, int initSample, int finalSample);

// Convert wave data to desired format
void mWaveFormat(Wave * wave, int sampleRate, int sampleSize, int channels);

// Load samples data from wave as a 32bit float data array
float * mLoadWaveSamples(Wave *wave);

// Unload samples data loaded with LoadWaveSamples()
void mUnloadWaveSamples(float * samples);

// Load music stream from file
void mLoadMusicStream(Music *out, const char * fileName);

// Load music stream from data
void mLoadMusicStreamFromMemory(Music *out, const char * fileType, const unsigned char * data, int dataSize);

// Checks if a music stream is ready
bool mIsMusicReady(Music *music);

// Unload music stream
void mUnloadMusicStream(Music *music);

// Start music playing
void mPlayMusicStream(Music *music);

// Check if music is playing
bool mIsMusicStreamPlaying(Music *music);

// Updates buffers for music streaming
void mUpdateMusicStream(Music *music);

// Stop music playing
void mStopMusicStream(Music *music);

// Pause music playing
void mPauseMusicStream(Music *music);

// Resume playing paused music
void mResumeMusicStream(Music *music);

// Seek music to a position (in seconds)
void mSeekMusicStream(Music *music, float position);

// Set volume for music (1.0 is max level)
void mSetMusicVolume(Music *music, float volume);

// Set pitch for a music (1.0 is base level)
void mSetMusicPitch(Music *music, float pitch);

// Set pan for a music (0.5 is center)
void mSetMusicPan(Music *music, float pan);

// Get music time length (in seconds)
float mGetMusicTimeLength(Music *music);

// Get current music time played (in seconds)
float mGetMusicTimePlayed(Music *music);

// Load audio stream (to stream raw audio pcm data)
void mLoadAudioStream(AudioStream *out, unsigned int sampleRate, unsigned int sampleSize, unsigned int channels);

// Checks if an audio stream is ready
bool mIsAudioStreamReady(AudioStream *stream);

// Unload audio stream and free memory
void mUnloadAudioStream(AudioStream *stream);

// Update audio stream buffers with data
void mUpdateAudioStream(AudioStream *stream, const void * data, int frameCount);

// Check if any audio stream buffers requires refill
bool mIsAudioStreamProcessed(AudioStream *stream);

// Play audio stream
void mPlayAudioStream(AudioStream *stream);

// Pause audio stream
void mPauseAudioStream(AudioStream *stream);

// Resume audio stream
void mResumeAudioStream(AudioStream *stream);

// Check if audio stream is playing
bool mIsAudioStreamPlaying(AudioStream *stream);

// Stop audio stream
void mStopAudioStream(AudioStream *stream);

// Set volume for audio stream (1.0 is max level)
void mSetAudioStreamVolume(AudioStream *stream, float volume);

// Set pitch for audio stream (1.0 is base level)
void mSetAudioStreamPitch(AudioStream *stream, float pitch);

// Set pan for audio stream (0.5 is centered)
void mSetAudioStreamPan(AudioStream *stream, float pan);

// Default size for new audio streams
void mSetAudioStreamBufferSizeDefault(int size);

// Audio thread callback to request new data
void mSetAudioStreamCallback(AudioStream *stream, AudioCallback callback);

// Attach audio stream processor to stream, receives the samples as <float>s
void mAttachAudioStreamProcessor(AudioStream *stream, AudioCallback processor);

// Detach audio stream processor from stream
void mDetachAudioStreamProcessor(AudioStream *stream, AudioCallback processor);

// Attach audio stream processor to the entire audio pipeline, receives the samples as <float>s
void mAttachAudioMixedProcessor(AudioCallback processor);

// Detach audio stream processor from the entire audio pipeline
void mDetachAudioMixedProcessor(AudioCallback processor);

// Choose the current matrix to be transformed
void mrlMatrixMode(int mode);

// Push the current matrix to stack
void mrlPushMatrix(void);

// Pop latest inserted matrix from stack
void mrlPopMatrix(void);

// Reset current matrix to identity matrix
void mrlLoadIdentity(void);

// Multiply the current matrix by a translation matrix
void mrlTranslatef(float x, float y, float z);

// Multiply the current matrix by a rotation matrix
void mrlRotatef(float angle, float x, float y, float z);

// Multiply the current matrix by a scaling matrix
void mrlScalef(float x, float y, float z);

// Multiply the current matrix by another matrix
void mrlMultMatrixf(const float * matf);

// 
void mrlFrustum(double left, double right, double bottom, double top, double znear, double zfar);

// 
void mrlOrtho(double left, double right, double bottom, double top, double znear, double zfar);

// Set the viewport area
void mrlViewport(int x, int y, int width, int height);

// Initialize drawing mode (how to organize vertex)
void mrlBegin(int mode);

// Finish vertex providing
void mrlEnd(void);

// Define one vertex (position) - 2 int
void mrlVertex2i(int x, int y);

// Define one vertex (position) - 2 float
void mrlVertex2f(float x, float y);

// Define one vertex (position) - 3 float
void mrlVertex3f(float x, float y, float z);

// Define one vertex (texture coordinate) - 2 float
void mrlTexCoord2f(float x, float y);

// Define one vertex (normal) - 3 float
void mrlNormal3f(float x, float y, float z);

// Define one vertex (color) - 4 byte
void mrlColor4ub(unsigned char r, unsigned char g, unsigned char b, unsigned char a);

// Define one vertex (color) - 3 float
void mrlColor3f(float x, float y, float z);

// Define one vertex (color) - 4 float
void mrlColor4f(float x, float y, float z, float w);

// Enable vertex array (VAO, if supported)
bool mrlEnableVertexArray(unsigned int vaoId);

// Disable vertex array (VAO, if supported)
void mrlDisableVertexArray(void);

// Enable vertex buffer (VBO)
void mrlEnableVertexBuffer(unsigned int id);

// Disable vertex buffer (VBO)
void mrlDisableVertexBuffer(void);

// Enable vertex buffer element (VBO element)
void mrlEnableVertexBufferElement(unsigned int id);

// Disable vertex buffer element (VBO element)
void mrlDisableVertexBufferElement(void);

// Enable vertex attribute index
void mrlEnableVertexAttribute(unsigned int index);

// Disable vertex attribute index
void mrlDisableVertexAttribute(unsigned int index);

// Select and active a texture slot
void mrlActiveTextureSlot(int slot);

// Enable texture
void mrlEnableTexture(unsigned int id);

// Disable texture
void mrlDisableTexture(void);

// Enable texture cubemap
void mrlEnableTextureCubemap(unsigned int id);

// Disable texture cubemap
void mrlDisableTextureCubemap(void);

// Set texture parameters (filter, wrap)
void mrlTextureParameters(unsigned int id, int param, int value);

// Set cubemap parameters (filter, wrap)
void mrlCubemapParameters(unsigned int id, int param, int value);

// Enable shader program
void mrlEnableShader(unsigned int id);

// Disable shader program
void mrlDisableShader(void);

// Enable render texture (fbo)
void mrlEnableFramebuffer(unsigned int id);

// Disable render texture (fbo), return to default framebuffer
void mrlDisableFramebuffer(void);

// Activate multiple draw color buffers
void mrlActiveDrawBuffers(int count);

// Blit active framebuffer to main framebuffer
void mrlBlitFramebuffer(int srcX, int srcY, int srcWidth, int srcHeight, int dstX, int dstY, int dstWidth, int dstHeight, int bufferMask);

// Bind framebuffer (FBO) 
void mrlBindFramebuffer(unsigned int target, unsigned int framebuffer);

// Enable color blending
void mrlEnableColorBlend(void);

// Disable color blending
void mrlDisableColorBlend(void);

// Enable depth test
void mrlEnableDepthTest(void);

// Disable depth test
void mrlDisableDepthTest(void);

// Enable depth write
void mrlEnableDepthMask(void);

// Disable depth write
void mrlDisableDepthMask(void);

// Enable backface culling
void mrlEnableBackfaceCulling(void);

// Disable backface culling
void mrlDisableBackfaceCulling(void);

// Color mask control
void mrlColorMask(bool r, bool g, bool b, bool a);

// Set face culling mode
void mrlSetCullFace(int mode);

// Enable scissor test
void mrlEnableScissorTest(void);

// Disable scissor test
void mrlDisableScissorTest(void);

// Scissor test
void mrlScissor(int x, int y, int width, int height);

// Enable wire mode
void mrlEnableWireMode(void);

// Enable point mode
void mrlEnablePointMode(void);

// Disable wire mode ( and point ) maybe rename
void mrlDisableWireMode(void);

// Set the line drawing width
void mrlSetLineWidth(float width);

// Get the line drawing width
float mrlGetLineWidth(void);

// Enable line aliasing
void mrlEnableSmoothLines(void);

// Disable line aliasing
void mrlDisableSmoothLines(void);

// Enable stereo rendering
void mrlEnableStereoRender(void);

// Disable stereo rendering
void mrlDisableStereoRender(void);

// Check if stereo render is enabled
bool mrlIsStereoRenderEnabled(void);

// Clear color buffer with color
void mrlClearColor(unsigned char r, unsigned char g, unsigned char b, unsigned char a);

// Clear used screen buffers (color and depth)
void mrlClearScreenBuffers(void);

// Check and log OpenGL error codes
void mrlCheckErrors(void);

// Set blending mode
void mrlSetBlendMode(int mode);

// Set blending mode factor and equation (using OpenGL factors)
void mrlSetBlendFactors(int glSrcFactor, int glDstFactor, int glEquation);

// Set blending mode factors and equations separately (using OpenGL factors)
void mrlSetBlendFactorsSeparate(int glSrcRGB, int glDstRGB, int glSrcAlpha, int glDstAlpha, int glEqRGB, int glEqAlpha);

// Initialize rlgl (buffers, shaders, textures, states)
void mrlglInit(int width, int height);

// De-initialize rlgl (buffers, shaders, textures)
void mrlglClose(void);

// Load OpenGL extensions (loader function required)
void mrlLoadExtensions(void * loader);

// Get current OpenGL version
int mrlGetVersion(void);

// Set current framebuffer width
void mrlSetFramebufferWidth(int width);

// Get default framebuffer width
int mrlGetFramebufferWidth(void);

// Set current framebuffer height
void mrlSetFramebufferHeight(int height);

// Get default framebuffer height
int mrlGetFramebufferHeight(void);

// Get default texture id
unsigned int mrlGetTextureIdDefault(void);

// Get default shader id
unsigned int mrlGetShaderIdDefault(void);

// Get default shader locations
int * mrlGetShaderLocsDefault(void);

// Load a render batch system
void mrlLoadRenderBatch(rlRenderBatch *out, int numBuffers, int bufferElements);

// Unload render batch system
void mrlUnloadRenderBatch(rlRenderBatch *batch);

// Draw render batch data (Update->Draw->Reset)
void mrlDrawRenderBatch(rlRenderBatch * batch);

// Set the active render batch for rlgl (NULL for default internal)
void mrlSetRenderBatchActive(rlRenderBatch * batch);

// Update and draw internal render batch
void mrlDrawRenderBatchActive(void);

// Check internal buffer overflow for a given number of vertex
bool mrlCheckRenderBatchLimit(int vCount);

// Set current texture for render batch and check buffers limits
void mrlSetTexture(unsigned int id);

// Load vertex array (vao) if supported
unsigned int mrlLoadVertexArray(void);

// Load a vertex buffer object
unsigned int mrlLoadVertexBuffer(const void * buffer, int size, bool dynamic);

// Load vertex buffer elements object
unsigned int mrlLoadVertexBufferElement(const void * buffer, int size, bool dynamic);

// Update vertex buffer object data on GPU buffer
void mrlUpdateVertexBuffer(unsigned int bufferId, const void * data, int dataSize, int offset);

// Update vertex buffer elements data on GPU buffer
void mrlUpdateVertexBufferElements(unsigned int id, const void * data, int dataSize, int offset);

// Unload vertex array (vao)
void mrlUnloadVertexArray(unsigned int vaoId);

// Unload vertex buffer object
void mrlUnloadVertexBuffer(unsigned int vboId);

// Set vertex attribute data configuration
void mrlSetVertexAttribute(unsigned int index, int compSize, int type, bool normalized, int stride, const void * pointer);

// Set vertex attribute data divisor
void mrlSetVertexAttributeDivisor(unsigned int index, int divisor);

// Set vertex attribute default value, when attribute to provided
void mrlSetVertexAttributeDefault(int locIndex, const void * value, int attribType, int count);

// Draw vertex array (currently active vao)
void mrlDrawVertexArray(int offset, int count);

// Draw vertex array elements
void mrlDrawVertexArrayElements(int offset, int count, const void * buffer);

// Draw vertex array (currently active vao) with instancing
void mrlDrawVertexArrayInstanced(int offset, int count, int instances);

// Draw vertex array elements with instancing
void mrlDrawVertexArrayElementsInstanced(int offset, int count, const void * buffer, int instances);

// Load texture data
unsigned int mrlLoadTexture(const void * data, int width, int height, int format, int mipmapCount);

// Load depth texture/renderbuffer (to be attached to fbo)
unsigned int mrlLoadTextureDepth(int width, int height, bool useRenderBuffer);

// Load texture cubemap data
unsigned int mrlLoadTextureCubemap(const void * data, int size, int format);

// Update texture with new data on GPU
void mrlUpdateTexture(unsigned int id, int offsetX, int offsetY, int width, int height, int format, const void * data);

// Get OpenGL internal formats
void mrlGetGlTextureFormats(int format, unsigned int * glInternalFormat, unsigned int * glFormat, unsigned int * glType);

// Get name string for pixel format
const char * mrlGetPixelFormatName(unsigned int format);

// Unload texture from GPU memory
void mrlUnloadTexture(unsigned int id);

// Generate mipmap data for selected texture
void mrlGenTextureMipmaps(unsigned int id, int width, int height, int format, int * mipmaps);

// Read texture pixel data
void * mrlReadTexturePixels(unsigned int id, int width, int height, int format);

// Read screen pixel data (color buffer)
unsigned char * mrlReadScreenPixels(int width, int height);

// Load an empty framebuffer
unsigned int mrlLoadFramebuffer(int width, int height);

// Attach texture/renderbuffer to a framebuffer
void mrlFramebufferAttach(unsigned int fboId, unsigned int texId, int attachType, int texType, int mipLevel);

// Verify framebuffer is complete
bool mrlFramebufferComplete(unsigned int id);

// Delete framebuffer from GPU
void mrlUnloadFramebuffer(unsigned int id);

// Load shader from code strings
unsigned int mrlLoadShaderCode(const char * vsCode, const char * fsCode);

// Compile custom shader and return shader id (type: RL_VERTEX_SHADER, RL_FRAGMENT_SHADER, RL_COMPUTE_SHADER)
unsigned int mrlCompileShader(const char * shaderCode, int type);

// Load custom shader program
unsigned int mrlLoadShaderProgram(unsigned int vShaderId, unsigned int fShaderId);

// Unload shader program
void mrlUnloadShaderProgram(unsigned int id);

// Get shader location uniform
int mrlGetLocationUniform(unsigned int shaderId, const char * uniformName);

// Get shader location attribute
int mrlGetLocationAttrib(unsigned int shaderId, const char * attribName);

// Set shader value uniform
void mrlSetUniform(int locIndex, const void * value, int uniformType, int count);

// Set shader value matrix
void mrlSetUniformMatrix(int locIndex, Matrix *mat);

// Set shader value sampler
void mrlSetUniformSampler(int locIndex, unsigned int textureId);

// Set shader currently active (id and locations)
void mrlSetShader(unsigned int id, int * locs);

// Load compute shader program
unsigned int mrlLoadComputeShaderProgram(unsigned int shaderId);

// Dispatch compute shader (equivalent to *draw* for graphics pipeline)
void mrlComputeShaderDispatch(unsigned int groupX, unsigned int groupY, unsigned int groupZ);

// Load shader storage buffer object (SSBO)
unsigned int mrlLoadShaderBuffer(unsigned int size, const void * data, int usageHint);

// Unload shader storage buffer object (SSBO)
void mrlUnloadShaderBuffer(unsigned int ssboId);

// Update SSBO buffer data
void mrlUpdateShaderBuffer(unsigned int id, const void * data, unsigned int dataSize, unsigned int offset);

// Bind SSBO buffer
void mrlBindShaderBuffer(unsigned int id, unsigned int index);

// Read SSBO buffer data (GPU->CPU)
void mrlReadShaderBuffer(unsigned int id, void * dest, unsigned int count, unsigned int offset);

// Copy SSBO data between buffers
void mrlCopyShaderBuffer(unsigned int destId, unsigned int srcId, unsigned int destOffset, unsigned int srcOffset, unsigned int count);

// Get SSBO buffer size
unsigned int mrlGetShaderBufferSize(unsigned int id);

// Bind image texture
void mrlBindImageTexture(unsigned int id, unsigned int index, int format, bool readonly);

// Get internal modelview matrix
void mrlGetMatrixModelview(Matrix *out);

// Get internal projection matrix
void mrlGetMatrixProjection(Matrix *out);

// Get internal accumulated transform matrix
void mrlGetMatrixTransform(Matrix *out);

// 
void mrlGetMatrixProjectionStereo(Matrix *out, int eye);

// 
void mrlGetMatrixViewOffsetStereo(Matrix *out, int eye);

// Set a custom projection matrix (replaces internal projection matrix)
void mrlSetMatrixProjection(Matrix *proj);

// Set a custom modelview matrix (replaces internal modelview matrix)
void mrlSetMatrixModelview(Matrix *view);

// Set eyes projection matrices for stereo rendering
void mrlSetMatrixProjectionStereo(Matrix *right, Matrix *left);

// Set eyes view offsets matrices for stereo rendering
void mrlSetMatrixViewOffsetStereo(Matrix *right, Matrix *left);

// Load and draw a cube
void mrlLoadDrawCube(void);

// Load and draw a quad
void mrlLoadDrawQuad(void);

// 
float mClamp(float value, float min, float max);

// 
float mLerp(float start, float end, float amount);

// 
float mNormalize(float value, float start, float end);

// 
float mRemap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd);

// 
float mWrap(float value, float min, float max);

// 
int mFloatEquals(float x, float y);

// 
void mVector2Zero(Vector2 *out);

// 
void mVector2One(Vector2 *out);

// 
void mVector2Add(Vector2 *out, Vector2 *v1, Vector2 *v2);

// 
void mVector2AddValue(Vector2 *out, Vector2 *v, float add);

// 
void mVector2Subtract(Vector2 *out, Vector2 *v1, Vector2 *v2);

// 
void mVector2SubtractValue(Vector2 *out, Vector2 *v, float sub);

// 
float mVector2Length(Vector2 *v);

// 
float mVector2LengthSqr(Vector2 *v);

// 
float mVector2DotProduct(Vector2 *v1, Vector2 *v2);

// 
float mVector2Distance(Vector2 *v1, Vector2 *v2);

// 
float mVector2DistanceSqr(Vector2 *v1, Vector2 *v2);

// 
float mVector2Angle(Vector2 *v1, Vector2 *v2);

// 
float mVector2LineAngle(Vector2 *start, Vector2 *end);

// 
void mVector2Scale(Vector2 *out, Vector2 *v, float scale);

// 
void mVector2Multiply(Vector2 *out, Vector2 *v1, Vector2 *v2);

// 
void mVector2Negate(Vector2 *out, Vector2 *v);

// 
void mVector2Divide(Vector2 *out, Vector2 *v1, Vector2 *v2);

// 
void mVector2Normalize(Vector2 *out, Vector2 *v);

// 
void mVector2Transform(Vector2 *out, Vector2 *v, Matrix *mat);

// 
void mVector2Lerp(Vector2 *out, Vector2 *v1, Vector2 *v2, float amount);

// 
void mVector2Reflect(Vector2 *out, Vector2 *v, Vector2 *normal);

// 
void mVector2Rotate(Vector2 *out, Vector2 *v, float angle);

// 
void mVector2MoveTowards(Vector2 *out, Vector2 *v, Vector2 *target, float maxDistance);

// 
void mVector2Invert(Vector2 *out, Vector2 *v);

// 
void mVector2Clamp(Vector2 *out, Vector2 *v, Vector2 *min, Vector2 *max);

// 
void mVector2ClampValue(Vector2 *out, Vector2 *v, float min, float max);

// 
int mVector2Equals(Vector2 *p, Vector2 *q);

// 
void mVector3Zero(Vector3 *out);

// 
void mVector3One(Vector3 *out);

// 
void mVector3Add(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3AddValue(Vector3 *out, Vector3 *v, float add);

// 
void mVector3Subtract(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3SubtractValue(Vector3 *out, Vector3 *v, float sub);

// 
void mVector3Scale(Vector3 *out, Vector3 *v, float scalar);

// 
void mVector3Multiply(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3CrossProduct(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3Perpendicular(Vector3 *out, Vector3 *v);

// 
float mVector3Length(const Vector3 *v);

// 
float mVector3LengthSqr(const Vector3 *v);

// 
float mVector3DotProduct(Vector3 *v1, Vector3 *v2);

// 
float mVector3Distance(Vector3 *v1, Vector3 *v2);

// 
float mVector3DistanceSqr(Vector3 *v1, Vector3 *v2);

// 
float mVector3Angle(Vector3 *v1, Vector3 *v2);

// 
void mVector3Negate(Vector3 *out, Vector3 *v);

// 
void mVector3Divide(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3Normalize(Vector3 *out, Vector3 *v);

// 
void mVector3Project(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3Reject(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3OrthoNormalize(Vector3 * v1, Vector3 * v2);

// 
void mVector3Transform(Vector3 *out, Vector3 *v, Matrix *mat);

// 
void mVector3RotateByQuaternion(Vector3 *out, Vector3 *v, Vector4 *q);

// 
void mVector3RotateByAxisAngle(Vector3 *out, Vector3 *v, Vector3 *axis, float angle);

// 
void mVector3Lerp(Vector3 *out, Vector3 *v1, Vector3 *v2, float amount);

// 
void mVector3Reflect(Vector3 *out, Vector3 *v, Vector3 *normal);

// 
void mVector3Min(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3Max(Vector3 *out, Vector3 *v1, Vector3 *v2);

// 
void mVector3Barycenter(Vector3 *out, Vector3 *p, Vector3 *a, Vector3 *b, Vector3 *c);

// 
void mVector3Unproject(Vector3 *out, Vector3 *source, Matrix *projection, Matrix *view);

// 
void mVector3ToFloatV(float3 *out, Vector3 *v);

// 
void mVector3Invert(Vector3 *out, Vector3 *v);

// 
void mVector3Clamp(Vector3 *out, Vector3 *v, Vector3 *min, Vector3 *max);

// 
void mVector3ClampValue(Vector3 *out, Vector3 *v, float min, float max);

// 
int mVector3Equals(Vector3 *p, Vector3 *q);

// 
void mVector3Refract(Vector3 *out, Vector3 *v, Vector3 *n, float r);

// 
float mMatrixDeterminant(Matrix *mat);

// 
float mMatrixTrace(Matrix *mat);

// 
void mMatrixTranspose(Matrix *out, Matrix *mat);

// 
void mMatrixInvert(Matrix *out, Matrix *mat);

// 
void mMatrixIdentity(Matrix *out);

// 
void mMatrixAdd(Matrix *out, Matrix *left, Matrix *right);

// 
void mMatrixSubtract(Matrix *out, Matrix *left, Matrix *right);

// 
void mMatrixMultiply(Matrix *out, Matrix *left, Matrix *right);

// 
void mMatrixTranslate(Matrix *out, float x, float y, float z);

// 
void mMatrixRotate(Matrix *out, Vector3 *axis, float angle);

// 
void mMatrixRotateX(Matrix *out, float angle);

// 
void mMatrixRotateY(Matrix *out, float angle);

// 
void mMatrixRotateZ(Matrix *out, float angle);

// 
void mMatrixRotateXYZ(Matrix *out, Vector3 *angle);

// 
void mMatrixRotateZYX(Matrix *out, Vector3 *angle);

// 
void mMatrixScale(Matrix *out, float x, float y, float z);

// 
void mMatrixFrustum(Matrix *out, double left, double right, double bottom, double top, double near, double far);

// 
void mMatrixPerspective(Matrix *out, double fovY, double aspect, double nearPlane, double farPlane);

// 
void mMatrixOrtho(Matrix *out, double left, double right, double bottom, double top, double nearPlane, double farPlane);

// 
void mMatrixLookAt(Matrix *out, Vector3 *eye, Vector3 *target, Vector3 *up);

// 
void mMatrixToFloatV(float16 *out, Matrix *mat);

// 
void mQuaternionAdd(Vector4 *out, Vector4 *q1, Vector4 *q2);

// 
void mQuaternionAddValue(Vector4 *out, Vector4 *q, float add);

// 
void mQuaternionSubtract(Vector4 *out, Vector4 *q1, Vector4 *q2);

// 
void mQuaternionSubtractValue(Vector4 *out, Vector4 *q, float sub);

// 
void mQuaternionIdentity(Vector4 *out);

// 
float mQuaternionLength(Vector4 *q);

// 
void mQuaternionNormalize(Vector4 *out, Vector4 *q);

// 
void mQuaternionInvert(Vector4 *out, Vector4 *q);

// 
void mQuaternionMultiply(Vector4 *out, Vector4 *q1, Vector4 *q2);

// 
void mQuaternionScale(Vector4 *out, Vector4 *q, float mul);

// 
void mQuaternionDivide(Vector4 *out, Vector4 *q1, Vector4 *q2);

// 
void mQuaternionLerp(Vector4 *out, Vector4 *q1, Vector4 *q2, float amount);

// 
void mQuaternionNlerp(Vector4 *out, Vector4 *q1, Vector4 *q2, float amount);

// 
void mQuaternionSlerp(Vector4 *out, Vector4 *q1, Vector4 *q2, float amount);

// 
void mQuaternionFromVector3ToVector3(Vector4 *out, Vector3 *from, Vector3 *to);

// 
void mQuaternionFromMatrix(Vector4 *out, Matrix *mat);

// 
void mQuaternionToMatrix(Matrix *out, Vector4 *q);

// 
void mQuaternionFromAxisAngle(Vector4 *out, Vector3 *axis, float angle);

// 
void mQuaternionToAxisAngle(Vector4 *q, Vector3 * outAxis, float * outAngle);

// 
void mQuaternionFromEuler(Vector4 *out, float pitch, float yaw, float roll);

// 
void mQuaternionToEuler(Vector3 *out, Vector4 *q);

// 
void mQuaternionTransform(Vector4 *out, Vector4 *q, Matrix *mat);

// 
int mQuaternionEquals(Vector4 *p, Vector4 *q);

