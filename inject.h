//--- CORE ----------------------------------------------------------------------------------------
#define GRAPHICS_API_OPENGL_11
// #define RLGL_IMPLEMENTATION
#include "raylib.h"
#include "rlgl.h"
#include "raymath.h"

//--- RAYGUI --------------------------------------------------------------------------------------
#define RAYGUI_CUSTOM_ICONS    // Custom icons set required
#include "gui_icons.h"         // Custom icons set provided, generated with rGuiIcons tool
#include "extras/raygui.h"

//--- PHYSACDEF -----------------------------------------------------------------------------------
#include "extras/physac.h"


// Enable vertex state pointer
void rlEnableStatePointer(int vertexAttribType, void *buffer);

// Disable vertex state pointer
void rlDisableStatePointer(int vertexAttribType);