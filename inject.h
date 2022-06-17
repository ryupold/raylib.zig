//--- CORE ----------------------------------------------------------------------------------------
#define GRAPHICS_API_OPENGL_11
// #define RLGL_IMPLEMENTATION
#include "raylib.h"
#include "rlgl.h"
#include "raymath.h"

// Enable vertex state pointer
void rlEnableStatePointer(int vertexAttribType, void *buffer);

// Disable vertex state pointer
void rlDisableStatePointer(int vertexAttribType);