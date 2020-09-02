#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <io.h>
#include <fcntl.h>

#include "test.h"
#include "usb_main.h"
#include "parameter.h"

int main(void) {

    int keycode = 0;

    usb_initialize();
    while (1)
    {
        keycode = get_keycode_value();
//        test_keyboard(keycode);
        switch (keycode){
                case 26:  // h1A, "w"
                    REG_0_MAP_INFO = (1 << 16);
                    break;
                case 22:  // h16, "s"
                    REG_0_MAP_INFO = (2 << 16);
                    break;
                case 4:   // h04, "a"
                    REG_0_MAP_INFO = 1 << 16;
                    break;
                case 7:   // h07, "d"
                    REG_0_MAP_INFO = 2 << 16;
                    break;
                default:
                    REG_0_MAP_INFO = 0 << 16;
                    break;
            }
    }

    return 0;
}
