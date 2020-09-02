#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <io.h>
#include <fcntl.h>

#include "usb_main.h"
#include "parameter.h"

int main(void) {

    printf("########Test KeyBoard########");

    int keycode = 0;

    usb_initialize();
    while (1)
    {
        keycode = get_keycode_value();

        switch (keycode)
        {
        case 26:  // h1A, "w"
            REG_4_COLOR_IDX = 0;
            break;
        case 22:  // h16, "s"
            REG_4_COLOR_IDX = 1;
            break;
        case 4:   // h04, "a"
            REG_4_COLOR_IDX = 2;
            break;
        case 7:   // h07, "d"
            REG_4_COLOR_IDX = 3;
            break;
        default:
            REG_4_COLOR_IDX = 4;
            break;
        }
    }
    
    printf("######### End Test ##########");


    return 0;
}