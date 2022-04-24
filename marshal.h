#include "raylib.h"
#include "raymath.h"
#include "extras/raygui.h"

// Initialize window and OpenGL context
void mInitWindow(int width, int height, const char * title);

// Check if KEY_ESCAPE pressed or Close icon pressed
bool mWindowShouldClose(void);

// Close window and unload OpenGL context
void mCloseWindow(void);

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

// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
void mMaximizeWindow(void);

// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
void mMinimizeWindow(void);

// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
void mRestoreWindow(void);

// Set icon for window (only PLATFORM_DESKTOP)
void mSetWindowIcon(Image *image);

// Set title for window (only PLATFORM_DESKTOP)
void mSetWindowTitle(const char * title);

// Set window position on screen (only PLATFORM_DESKTOP)
void mSetWindowPosition(int x, int y);

// Set monitor for the current window (fullscreen mode)
void mSetWindowMonitor(int monitor);

// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
void mSetWindowMinSize(int width, int height);

// Set window dimensions
void mSetWindowSize(int width, int height);

// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
void mSetWindowOpacity(float opacity);

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

// Get specified monitor width (max available by monitor)
int mGetMonitorWidth(int monitor);

// Get specified monitor height (max available by monitor)
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

// Get the human-readable, UTF-8 encoded name of the primary monitor
const char * mGetMonitorName(int monitor);

// Set clipboard text content
void mSetClipboardText(const char * text);

// Get clipboard text content
const char * mGetClipboardText(void);

// Swap back buffer with front buffer (screen drawing)
void mSwapScreenBuffer(void);

// Register all input events
void mPollInputEvents(void);

// Wait for some milliseconds (halt program execution)
void mWaitTime(float ms);

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
void mGetMouseRay(Ray *out, Vector2 *mousePosition, Camera *camera);

// Get camera transform matrix (view matrix)
void mGetCameraMatrix(Matrix *out, Camera *camera);

// Get camera 2d transform matrix
void mGetCameraMatrix2D(Matrix *out, Camera2D *camera);

// Get the screen space position for a 3d world space position
void mGetWorldToScreen(Vector2 *out, Vector3 *position, Camera *camera);

// Get size position for a 3d world space position
void mGetWorldToScreenEx(Vector2 *out, Vector3 *position, Camera *camera, int width, int height);

// Get the screen space position for a 2d camera world space position
void mGetWorldToScreen2D(Vector2 *out, Vector2 *position, Camera2D *camera);

// Get the world space position for a 2d camera screen space position
void mGetScreenToWorld2D(Vector2 *out, Vector2 *position, Camera2D *camera);

// Set target FPS (maximum)
void mSetTargetFPS(int fps);

// Get current FPS
int mGetFPS(void);

// Get time in seconds for last frame drawn (delta time)
float mGetFrameTime(void);

// Get elapsed time in seconds since InitWindow()
double mGetTime(void);

// Get a random value between min and max (both included)
int mGetRandomValue(int min, int max);

// Set the seed for the random number generator
void mSetRandomSeed(unsigned int seed);

// Takes a screenshot of current screen (filename extension defines format)
void mTakeScreenshot(const char * fileName);

// Setup init configuration flags (view FLAGS)
void mSetConfigFlags(unsigned int flags);

// Set the current threshold (minimum) log level
void mSetTraceLogLevel(int logLevel);

// Set custom file binary data loader
void mSetLoadFileDataCallback(LoadFileDataCallback *callback);

// Set custom file binary data saver
void mSetSaveFileDataCallback(SaveFileDataCallback *callback);

// Set custom file text data loader
void mSetLoadFileTextCallback(LoadFileTextCallback *callback);

// Set custom file text data saver
void mSetSaveFileTextCallback(SaveFileTextCallback *callback);

// Load file data as byte array (read)
unsigned char * mLoadFileData(const char * fileName, unsigned int * bytesRead);

// Unload file data allocated by LoadFileData()
void mUnloadFileData(unsigned char * data);

// Save data to file from byte array (write), returns true on success
bool mSaveFileData(const char * fileName, void * data, unsigned int bytesToWrite);

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

// Get the directory if the running application (uses static string)
const char * mGetApplicationDirectory(void);

// Clear directory files paths buffers (free memory)
void mClearDirectoryFiles(void);

// Change working directory, return true on success
bool mChangeDirectory(const char * dir);

// Check if a file has been dropped into window
bool mIsFileDropped(void);

// Clear dropped files paths buffer (free memory)
void mClearDroppedFiles(void);

// Get file modification time (last write time)
long mGetFileModTime(const char * fileName);

// Compress data (DEFLATE algorithm)
unsigned char * mCompressData(const unsigned char * data, int dataSize, int * compDataSize);

// Decompress data (DEFLATE algorithm)
unsigned char * mDecompressData(const unsigned char * compData, int compDataSize, int * dataSize);

// Encode data to Base64 string
char * mEncodeDataBase64(const unsigned char * data, int dataSize, int * outputSize);

// Decode Base64 string data
unsigned char * mDecodeDataBase64(const unsigned char * data, int * outputSize);

// Save integer value to storage file (to defined position), returns true on success
bool mSaveStorageValue(unsigned int position, int value);

// Load integer value from storage file (from defined position)
int mLoadStorageValue(unsigned int position);

// Open URL with default system browser (if available)
void mOpenURL(const char * url);

// Check if a key has been pressed once
bool mIsKeyPressed(int key);

// Check if a key is being pressed
bool mIsKeyDown(int key);

// Check if a key has been released once
bool mIsKeyReleased(int key);

// Check if a key is NOT being pressed
bool mIsKeyUp(int key);

// Set a custom key to exit program (default is ESC)
void mSetExitKey(int key);

// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
int mGetKeyPressed(void);

// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
int mGetCharPressed(void);

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

// Get the last gamepad button pressed
int mGetGamepadButtonPressed(void);

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

// Get mouse wheel movement Y
float mGetMouseWheelMove(void);

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
bool mIsGestureDetected(int gesture);

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

// Set camera mode (multiple camera modes available)
void mSetCameraMode(Camera *camera, int mode);

// Update camera position for selected mode
void mUpdateCamera(Camera * camera);

// Set camera pan key to combine with mouse movement (free camera)
void mSetCameraPanControl(int keyPan);

// Set camera alt key to combine with mouse movement (free camera)
void mSetCameraAltControl(int keyAlt);

// Set camera smooth zoom key to combine with mouse (free camera)
void mSetCameraSmoothZoomControl(int keySmoothZoom);

// Set camera move controls (1st person and 3rd person cameras)
void mSetCameraMoveControls(int keyFront, int keyBack, int keyRight, int keyLeft, int keyUp, int keyDown);

// Set texture and rectangle to be used on shapes drawing
void mSetShapesTexture(Texture2D *texture, Rectangle *source);

// Draw a pixel
void mDrawPixel(int posX, int posY, Color *color);

// Draw a pixel (Vector version)
void mDrawPixelV(Vector2 *position, Color *color);

// Draw a line
void mDrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color *color);

// Draw a line (Vector version)
void mDrawLineV(Vector2 *startPos, Vector2 *endPos, Color *color);

// Draw a line defining thickness
void mDrawLineEx(Vector2 *startPos, Vector2 *endPos, float thick, Color *color);

// Draw a line using cubic-bezier curves in-out
void mDrawLineBezier(Vector2 *startPos, Vector2 *endPos, float thick, Color *color);

// Draw line using quadratic bezier curves with a control point
void mDrawLineBezierQuad(Vector2 *startPos, Vector2 *endPos, Vector2 *controlPos, float thick, Color *color);

// Draw line using cubic bezier curves with 2 control points
void mDrawLineBezierCubic(Vector2 *startPos, Vector2 *endPos, Vector2 *startControlPos, Vector2 *endControlPos, float thick, Color *color);

// Draw lines sequence
void mDrawLineStrip(Vector2 * points, int pointCount, Color *color);

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

// Load image sequence from file (frames appended to image.data)
void mLoadImageAnim(Image *out, const char * fileName, int * frames);

// Load image from memory buffer, fileType refers to extension: i.e. '.png'
void mLoadImageFromMemory(Image *out, const char * fileType, const unsigned char * fileData, int dataSize);

// Load image from GPU texture data
void mLoadImageFromTexture(Image *out, Texture2D *texture);

// Load image from screen buffer and (screenshot)
void mLoadImageFromScreen(Image *out);

// Unload image from CPU memory (RAM)
void mUnloadImage(Image *image);

// Export image data to file, returns true on success
bool mExportImage(Image *image, const char * fileName);

// Export image as code file defining an array of bytes, returns true on success
bool mExportImageAsCode(Image *image, const char * fileName);

// Generate image: plain color
void mGenImageColor(Image *out, int width, int height, Color *color);

// Generate image: vertical gradient
void mGenImageGradientV(Image *out, int width, int height, Color *top, Color *bottom);

// Generate image: horizontal gradient
void mGenImageGradientH(Image *out, int width, int height, Color *left, Color *right);

// Generate image: radial gradient
void mGenImageGradientRadial(Image *out, int width, int height, float density, Color *inner, Color *outer);

// Generate image: checked
void mGenImageChecked(Image *out, int width, int height, int checksX, int checksY, Color *col1, Color *col2);

// Generate image: white noise
void mGenImageWhiteNoise(Image *out, int width, int height, float factor);

// Generate image: cellular algorithm, bigger tileSize means bigger cells
void mGenImageCellular(Image *out, int width, int height, int tileSize);

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

// Draw circle within an image
void mImageDrawCircle(Image * dst, int centerX, int centerY, int radius, Color *color);

// Draw circle within an image (Vector version)
void mImageDrawCircleV(Image * dst, Vector2 *center, int radius, Color *color);

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
void mLoadTextureCubemap(TextureCubemap *out, Image *image, int layout);

// Load texture for rendering (framebuffer)
void mLoadRenderTexture(RenderTexture2D *out, int width, int height);

// Unload texture from GPU memory (VRAM)
void mUnloadTexture(Texture2D *texture);

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

// Draw texture quad with tiling and offset parameters
void mDrawTextureQuad(Texture2D *texture, Vector2 *tiling, Vector2 *offset, Rectangle *quad, Color *tint);

// Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
void mDrawTextureTiled(Texture2D *texture, Rectangle *source, Rectangle *dest, Vector2 *origin, float rotation, float scale, Color *tint);

// Draw a part of a texture defined by a rectangle with 'pro' parameters
void mDrawTexturePro(Texture2D *texture, Rectangle *source, Rectangle *dest, Vector2 *origin, float rotation, Color *tint);

// Draws a texture (or part of it) that stretches or shrinks nicely
void mDrawTextureNPatch(Texture2D *texture, NPatchInfo *nPatchInfo, Rectangle *dest, Vector2 *origin, float rotation, Color *tint);

// Draw a textured polygon
void mDrawTexturePoly(Texture2D *texture, Vector2 *center, Vector2 * points, Vector2 * texcoords, int pointCount, Color *tint);

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

// Load font from file with extended parameters, use NULL for fontChars and 0 for glyphCount to load the default character set
void mLoadFontEx(Font *out, const char * fileName, int fontSize, int * fontChars, int glyphCount);

// Load font from Image (XNA style)
void mLoadFontFromImage(Font *out, Image *image, Color *key, int firstChar);

// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
void mLoadFontFromMemory(Font *out, const char * fileType, const unsigned char * fileData, int dataSize, int fontSize, int * fontChars, int glyphCount);

// Load font data for further use
GlyphInfo * mLoadFontData(const unsigned char * fileData, int dataSize, int fontSize, int * fontChars, int glyphCount, int type);

// Unload font chars info data (RAM)
void mUnloadFontData(GlyphInfo * chars, int glyphCount);

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
void mDrawTextCodepoints(Font *font, const int * codepoints, int count, Vector2 *position, float fontSize, float spacing, Color *tint);

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

// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
int * mLoadCodepoints(const char * text, int * count);

// Unload codepoints data from memory
void mUnloadCodepoints(int * codepoints);

// Get total number of codepoints in a UTF-8 encoded string
int mGetCodepointCount(const char * text);

// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
int mGetCodepoint(const char * text, int * bytesProcessed);

// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
const char * mCodepointToUTF8(int codepoint, int * byteSize);

// Encode text as codepoints array into UTF-8 text string (WARNING: memory must be freed!)
char * mTextCodepointsToUTF8(const int * codepoints, int length);

// Copy one string to another, returns bytes copied
int mTextCopy(char * dst, const char * src);

// Check if two text string are equal
bool mTextIsEqual(const char * text1, const char * text2);

// Get text length, checks for '\0' ending
unsigned int mTextLength(const char * text);

// Get a piece of a text string
const char * mTextSubtext(const char * text, int position, int length);

// Replace text string (WARNING: memory must be freed!)
char * mTextReplace(char * text, const char * replace, const char * by);

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

// Draw cube textured
void mDrawCubeTexture(Texture2D *texture, Vector3 *position, float width, float height, float length, Color *color);

// Draw cube with a region of a texture
void mDrawCubeTextureRec(Texture2D *texture, Rectangle *source, Vector3 *position, float width, float height, float length, Color *color);

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

// Unload model (including meshes) from memory (RAM and/or VRAM)
void mUnloadModel(Model *model);

// Unload model (but not meshes) from memory (RAM and/or VRAM)
void mUnloadModelKeepMeshes(Model *model);

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
void mDrawBillboard(Camera *camera, Texture2D *texture, Vector3 *position, float size, Color *tint);

// Draw a billboard texture defined by source
void mDrawBillboardRec(Camera *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector2 *size, Color *tint);

// Draw a billboard texture defined by source and rotation
void mDrawBillboardPro(Camera *camera, Texture2D *texture, Rectangle *source, Vector3 *position, Vector3 *up, Vector2 *size, Vector2 *origin, float rotation, Color *tint);

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

// Export mesh data to file, returns true on success
bool mExportMesh(Mesh *mesh, const char * fileName);

// Compute mesh bounding box limits
void mGetMeshBoundingBox(BoundingBox *out, Mesh *mesh);

// Compute mesh tangents
void mGenMeshTangents(Mesh * mesh);

// Compute mesh binormals
void mGenMeshBinormals(Mesh * mesh);

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

// Unload material from GPU memory (VRAM)
void mUnloadMaterial(Material *material);

// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
void mSetMaterialTexture(Material * material, int mapType, Texture2D *texture);

// Set material for a mesh
void mSetModelMeshMaterial(Model * model, int meshId, int materialId);

// Load model animations from file
ModelAnimation * mLoadModelAnimations(const char * fileName, unsigned int * animCount);

// Update model animation pose
void mUpdateModelAnimation(Model *model, ModelAnimation *anim, int frame);

// Unload animation data
void mUnloadModelAnimation(ModelAnimation *anim);

// Unload animation array data
void mUnloadModelAnimations(ModelAnimation * animations, unsigned int count);

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

// Load wave data from file
void mLoadWave(Wave *out, const char * fileName);

// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
void mLoadWaveFromMemory(Wave *out, const char * fileType, const unsigned char * fileData, int dataSize);

// Load sound from file
void mLoadSound(Sound *out, const char * fileName);

// Load sound from wave data
void mLoadSoundFromWave(Sound *out, Wave *wave);

// Update sound buffer with new data
void mUpdateSound(Sound *sound, const void * data, int sampleCount);

// Unload wave data
void mUnloadWave(Wave *wave);

// Unload sound
void mUnloadSound(Sound *sound);

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

// Play a sound (using multichannel buffer pool)
void mPlaySoundMulti(Sound *sound);

// Stop any sound playing (using multichannel buffer pool)
void mStopSoundMulti(void);

// Get number of sounds playing in the multichannel
int mGetSoundsPlaying(void);

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
void mSetAudioStreamCallback(AudioStream *stream, AudioCallback *callback);

// 
void mAttachAudioStreamProcessor(AudioStream *stream, AudioCallback *processor);

// 
void mDetachAudioStreamProcessor(AudioStream *stream, AudioCallback *processor);

// 
float mClamp(float value, float min, float max);

// 
float mLerp(float start, float end, float amount);

// 
float mNormalize(float value, float start, float end);

// 
float mRemap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd);

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
void mVector3OrthoNormalize(Vector3 * v1, Vector3 * v2);

// 
void mVector3Transform(Vector3 *out, Vector3 *v, Matrix *mat);

// 
void mVector3RotateByQuaternion(Vector3 *out, Vector3 *v, Quaternion *q);

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
void mMatrixRotateXYZ(Matrix *out, Vector3 *ang);

// 
void mMatrixRotateZYX(Matrix *out, Vector3 *ang);

// 
void mMatrixScale(Matrix *out, float x, float y, float z);

// 
void mMatrixFrustum(Matrix *out, double left, double right, double bottom, double top, double near, double far);

// 
void mMatrixPerspective(Matrix *out, double fovy, double aspect, double near, double far);

// 
void mMatrixOrtho(Matrix *out, double left, double right, double bottom, double top, double near, double far);

// 
void mMatrixLookAt(Matrix *out, Vector3 *eye, Vector3 *target, Vector3 *up);

// 
void mMatrixToFloatV(float16 *out, Matrix *mat);

// 
void mQuaternionAdd(Quaternion *out, Quaternion *q1, Quaternion *q2);

// 
void mQuaternionAddValue(Quaternion *out, Quaternion *q, float add);

// 
void mQuaternionSubtract(Quaternion *out, Quaternion *q1, Quaternion *q2);

// 
void mQuaternionSubtractValue(Quaternion *out, Quaternion *q, float sub);

// 
void mQuaternionIdentity(Quaternion *out);

// 
float mQuaternionLength(Quaternion *q);

// 
void mQuaternionNormalize(Quaternion *out, Quaternion *q);

// 
void mQuaternionInvert(Quaternion *out, Quaternion *q);

// 
void mQuaternionMultiply(Quaternion *out, Quaternion *q1, Quaternion *q2);

// 
void mQuaternionScale(Quaternion *out, Quaternion *q, float mul);

// 
void mQuaternionDivide(Quaternion *out, Quaternion *q1, Quaternion *q2);

// 
void mQuaternionLerp(Quaternion *out, Quaternion *q1, Quaternion *q2, float amount);

// 
void mQuaternionNlerp(Quaternion *out, Quaternion *q1, Quaternion *q2, float amount);

// 
void mQuaternionSlerp(Quaternion *out, Quaternion *q1, Quaternion *q2, float amount);

// 
void mQuaternionFromVector3ToVector3(Quaternion *out, Vector3 *from, Vector3 *to);

// 
void mQuaternionFromMatrix(Quaternion *out, Matrix *mat);

// 
void mQuaternionToMatrix(Matrix *out, Quaternion *q);

// 
void mQuaternionFromAxisAngle(Quaternion *out, Vector3 *axis, float angle);

// 
void mQuaternionToAxisAngle(Quaternion *q, Vector3 * outAxis, float * outAngle);

// 
void mQuaternionFromEuler(Quaternion *out, float pitch, float yaw, float roll);

// 
void mQuaternionToEuler(Vector3 *out, Quaternion *q);

// 
void mQuaternionTransform(Quaternion *out, Quaternion *q, Matrix *mat);

