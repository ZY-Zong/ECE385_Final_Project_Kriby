#include "test.h"
#include "parameter.h"




void test_keyboard(int keycode) {

    printf("########Test KeyBoard########");
    switch (keycode){
        case 0x001a:  // h1A, "w"
            REG_0_MAP_INFO = 1 << 16;
            break;
        case 0x0016:  // h16, "s"
            REG_0_MAP_INFO = 2 << 16;
            break;
        case 0x0004:   // h04, "a"
            REG_0_MAP_INFO = 1 << 16;
            break;
        case 0x0007:   // h07, "d"
            REG_0_MAP_INFO = 2 << 16;
            break;
        default:
            REG_0_MAP_INFO = 0 << 16;
            break;
    }
    printf("######### End Test ##########");
}
