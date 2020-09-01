#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <io.h>
#include <fcntl.h>

#include "usb_main.h"

int main(void) {

    printf("########Test KeyBoard########");

    int keycode = 0;

    usb_initialize();
    while (1)
    {
        keycode = get_keycode_value();
    }
    
    printf("######### End Test ##########");


    return 0;
}