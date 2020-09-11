#include "game_logic.h"
#include "parameter.h"
#include "kirby.h"
#include "test.h"

#include <stdio.h>

void GameStart(Game * game_state) {
    Kirby * kirby;

    #ifdef TEST2
        printf("\n/************* check 0 *************/\n");
        printf("\nkirby->x = %d; kirby->y = %d; kirby->frame = %d; kirby->action = %d\n", kirby->x, kirby->y, kirby->frame, kirby->action);
        printf("\nkirby->health = %d; kirby->is_inhaled = %d; kirby->inhaling = %d; kirby->in_slope = %d; kirby->spitting = %d\n", kirby->health, kirby->is_inhaled, kirby->inhaling, kirby->in_slope, kirby->spitting);
        printf("\n/************* end check 0 *************/\n");
    #endif


    usb_initialize();
    #ifdef TEST2
        printf("\n/************* check 1 *************/\n");
        printf("\nkirby->x = %d; kirby->y = %d; kirby->frame = %d; kirby->action = %d\n", kirby->x, kirby->y, kirby->frame, kirby->action);
        printf("\nkirby->health = %d; kirby->is_inhaled = %d; kirby->inhaling = %d; kirby->in_slope = %d; kirby->spitting = %d\n", kirby->health, kirby->is_inhaled, kirby->inhaling, kirby->in_slope, kirby->spitting);
        printf("\n/************* end check 1 *************/\n");
    #endif

    initial_Game_State(game_state);

    #ifdef TEST1
        printf("\n/************* check initial game state *************/\n");
        printf("\nkirby->x = %d; kirby->y = %d; kirby->frame = %d; kirby->action = %d\n", kirby->x, kirby->y, kirby->frame, kirby->action);
        printf("\nkirby->health = %d; kirby->is_inhaled = %d; kirby->inhaling = %d; kirby->in_slope = %d; kirby->spitting = %d\n", kirby->health, kirby->is_inhaled, kirby->inhaling, kirby->in_slope, kirby->spitting);
        printf("\n/************* end check initial game state *************/\n");
    #endif

    initial_Registers();
    #ifdef TEST2
        printf("\n/************* check 2 *************/\n");
        printf("\nkirby->x = %d; kirby->y = %d; kirby->frame = %d; kirby->action = %d\n", kirby->x, kirby->y, kirby->frame, kirby->action);
        printf("\nkirby->health = %d; kirby->is_inhaled = %d; kirby->inhaling = %d; kirby->in_slope = %d; kirby->spitting = %d\n", kirby->health, kirby->is_inhaled, kirby->inhaling, kirby->in_slope, kirby->spitting);
        printf("\n/************* end check 2 *************/\n");
    #endif

    initial_Kirby(kirby);

    #ifdef TEST1
        printf("\n/************* check initial kirby *************/\n");
        printf("\nkirby->x = %d; kirby->y = %d; kirby->frame = %d; kirby->action = %d\n", kirby->x, kirby->y, kirby->frame, kirby->action);
        printf("\nkirby->health = %d; kirby->is_inhaled = %d; kirby->inhaling = %d; kirby->in_slope = %d; kirby->spitting = %d\n", kirby->health, kirby->is_inhaled, kirby->inhaling, kirby->in_slope, kirby->spitting);
        printf("\n/************* end check initial kirby *************/\n");
    #endif

    
    int keycode = 0;
    int pre_keycode = 0;

    while (1)
    {
        pre_keycode = keycode;
        keycode = get_keycode_value();

        #ifdef TEST1
            printf("\n/************* check get keycode *************/\n");
            printf("\nkirby->x = %d; kirby->y = %d; kirby->frame = %d; kirby->action = %d\n", kirby->x, kirby->y, kirby->frame, kirby->action);
            printf("\nkirby->health = %d; kirby->is_inhaled = %d; kirby->inhaling = %d; kirby->in_slope = %d; kirby->spitting = %d\n", kirby->health, kirby->is_inhaled, kirby->inhaling, kirby->in_slope, kirby->spitting);
            printf("\n/************* end check get keycode *************/\n");
        #endif

        // test_keyboard(keycode);
        updateKirby(kirby, game_state, keycode, pre_keycode);
        upload_Kirby_Info(kirby, game_state);

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
    REG_3_              = 0;
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
