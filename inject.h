//--- CORE ----------------------------------------------------------------------------------------
#include "raylib.h"
#include "raymath.h"

//--- RAYGUI --------------------------------------------------------------------------------------
#define RAYGUI_CUSTOM_ICONS    // Custom icons set required
#include "gui_icons.h"         // Custom icons set provided, generated with rGuiIcons tool
#include "extras/raygui.h"

const int TEXT_SIZE                = 16;       // Default text size for controls
const int RICON_SIZE               = 16;       // Size of icons (squared)
const int RICON_MAX_ICONS         = 256;       // Maximum number of icons
const int RICON_MAX_NAME_LENGTH    = 32;       // Maximum length of icon name id

// Icons data is defined by bit array (every bit represents one pixel)
// Those arrays are stored as unsigned int data arrays, so every array
// element defines 32 pixels (bits) of information
// Number of elemens depend on RICON_SIZE (by default 16x16 pixels)
const int RICON_DATA_ELEMENTS = (RICON_SIZE*RICON_SIZE/32);