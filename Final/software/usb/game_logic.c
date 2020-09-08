#include "game_logic.h"
#include "parameter.h"
#include "kirby.h"
#include "test.h"
#include "star.h"
#include "usb_main.h"

#include <stdio.h>

void GameStart() {
    Kirby * kirby;
    Star * star;

    int keycode = 0;
    int pre_keycode = 0;
    int spitting_flag = 0;
    int kicking_flag = 0;

    initial_Registers();
    initial_Star(star);
    initial_Kirby(kirby);
    kirby->is_inhaled = 1;

//    printf("** USB initial begin?? **\n");

    usb_initialize();
    printf("What's wrong with USB?");

    while (1)
    {
        pre_keycode = keycode;
        keycode = get_keycode_value();

        // test_keyboard(keycode);
        updateKirby(kirby, star, keycode, pre_keycode);
        upload_Kirby_Info(kirby);

        if (star->appear == 1)
        	spit_Star(kirby, star);

        // TO DO: Check game_state.interrupt why changed
        // if (game_state->interrupt != 0) {
        //     break;
        // }
    }
    
}

void initial_Game_State (Game * game_state) {
    game_state->interrupt = 0;
    game_state->map = 0;
}


void initial_Registers() {
    REG_0_MAP_INFO      = 0;
    REG_1_KIRBY_IMAGE   = 0;
    REG_2_KIRBY_MAP_POS = 0;
    REG_3_STAR          = 0;
    REG_4_              = 0;
    REG_5_              = 0;
    REG_6_              = 0;
    REG_7_              = 0;
    REG_8_              = 0;
    REG_9_              = 0;
    REG_10_             = 0;
    REG_11_             = 0;
    REG_12_             = 0;
    REG_13_             = 0;
    REG_14_             = 0;
    REG_15_             = 0;
}
