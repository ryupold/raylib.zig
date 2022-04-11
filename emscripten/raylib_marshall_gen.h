#include "raylib.h"
#include "raymath.h"
#include "extras/raygui.h"
    
void mInitWindow(int width, int height, const char *title);

bool mWindowShouldClose(void);

void mCloseWindow(void);

void mSetWindowPosition(int x, int y);

void mSetWindowMonitor(int monitor);

void mSetWindowMinSize(int width, int height);

void mSetWindowSize(int width, int height);

int mGetScreenWidth(void);

int mGetScreenHeight(void);

bool mIsCursorOnScreen(void);

void mClearBackground(Color *color);

void mBeginDrawing(void);

void mEndDrawing(void);

void mBeginMode2D(Camera2D *camera);

void mEndMode2D(void);

void mGetCameraMatrix2D(Matrix *out, Camera2D *camera);

void mGetWorldToScreen2D(Vector2 *out, Vector2 *position, Camera2D *camera);

void mGetScreenToWorld2D(Vector2 *out, Vector2 *position, Camera2D *camera);

void mSetTargetFPS(int fps);

int mGetFPS(void);

float mGetFrameTime(void);

double mGetTime(void);

void mOpenURL(const char *url);

bool mIsKeyPressed(int key);

bool mIsKeyDown(int key);

bool mIsKeyReleased(int key);

bool mIsKeyUp(int key);

void mSetExitKey(int key);

int mGetKeyPressed(void);

int mGetCharPressed(void);

bool mIsMouseButtonPressed(int button);

bool mIsMouseButtonDown(int button);

bool mIsMouseButtonReleased(int button);

bool mIsMouseButtonUp(int button);

void mGetMousePosition(Vector2 *out);

void mGetMouseDelta(Vector2 *out);

void mSetMouseOffset(int offsetX, int offsetY);

void mSetMouseScale(float scaleX, float scaleY);

float mGetMouseWheelMove(void);

void mSetMouseCursor(int cursor);

void mGetTouchPosition(Vector2 *out, int index);

int mGetTouchPointCount(void);

void mDrawLineEx(Vector2 *startPos, Vector2 *endPos, float thick, Color *color);

void mDrawRectanglePro(Rectangle *rec, Vector2 *origin, float rotation, Color *color);

void mDrawTriangle(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color);

void mLoadTexture(Texture2D *out, const char *fileName);

void mUnloadTexture(Texture2D *texture);

void mDrawTextureEx(Texture2D *texture, Vector2 *position, float rotation, float scale, Color *tint);

void mDrawTextureRec(Texture2D *texture, Rectangle *source, Vector2 *position, Color *tint);

void mDrawTexturePro(Texture2D *texture, Rectangle *source, Rectangle *dest, Vector2 *origin, float rotation, Color *tint);

void mDrawFPS(int posX, int posY);

void mDrawText(const char *text, int posX, int posY, int fontSize, Color *color);

void mMatrixIdentity(Matrix *out);

void mMatrixMultiply(Matrix *out, Matrix *left, Matrix *right);

void mQuaternionFromMatrix(Quaternion *out, Matrix *mat);

void mQuaternionFromAxisAngle(Quaternion *out, Vector3 *axis, float angle);

void mQuaternionToAxisAngle(Quaternion *q, Vector3 *outAxis, float *outAngle);
