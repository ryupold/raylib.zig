#include <stdint.h>
#include <stdlib.h>

#include "emscripten/emscripten.h"
#include "raylib.h"

// Zig compiles C code with -fstack-protector-strong which requires the following two symbols
// which don't seem to be provided by the emscripten toolchain(?)
void *__stack_chk_guard = (void *)0xdeadbeef;
void __stack_chk_fail(void)
{
    exit(1);
}


// emsc_main() is the Zig entry function in main.zig
extern int emsc_main(void);

extern void emsc_set_window_size(int width, int height);

int main()
{
    return emsc_main();
}
