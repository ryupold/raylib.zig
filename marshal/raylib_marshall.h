#include "raylib.h"
#include "raymath.h"
#include "extras/raygui.h"
#include "raylib_marshall_gen.h"

// File System
unsigned char *mLoadFileData(const char *fileName, unsigned int *bytesRead);
void mUnloadFileData(unsigned char *data);