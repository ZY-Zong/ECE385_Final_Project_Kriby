#include "test.h"
#include "parameter.h"




void test_keyboard(int keycode) {

    printf("########Test KeyBoard########");
    switch (keycode){
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
    printf("######### End Test ##########");
}