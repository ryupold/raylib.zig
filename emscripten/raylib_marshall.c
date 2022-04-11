#include "raylib.h"
#include "raymath.h"

//=== File System =================================================================================

unsigned char *mLoadFileData(const char *fileName, unsigned int *bytesRead)
{
    return LoadFileData(fileName, bytesRead);
}
void mUnloadFileData(unsigned char *data)
{
    UnloadFileData(data);
}
