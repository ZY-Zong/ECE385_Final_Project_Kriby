#include "game_logic.h"
#include "parameter.h"
#include "kirby.h"
#include "test.h"
#include "star.h"
#include "enemy.h"
#include "usb_main.h"

#include <stdio.h>

void GameStart() {
    Kirby * kirby;
    Star * star;
    Enemy * lemon;
    Enemy * fire;
    Enemy * monkey;
    Enemy * lightning;

    int end = 0;
    int keycode = 0;
    int pre_keycode = 0;

    usb_initialize();

    // Start of the game loop
    START:
    end = 0;
    keycode = 0;
    pre_keycode = 0;

    initial_Registers();
    initial_Star(star);
    initial_Kirby(kirby);

    initial_enemy(lemon,3);
    initial_enemy(fire,1);
//    initial_enemy(monkey,2);
    initial_enemy(lightning,0);

    while (get_keycode_value() != 0x0028) {
        draw_Start_Image(kirby);
    }

    REG_15_GAME_CONTROL = 0x0000000e;

    while (!end)
    {
        pre_keycode = keycode;
        keycode = get_keycode_value();

        // Renew enemies
        if (kirby->x >= (150 + lemon->dist + SCREEN_WIDTH/2))
            initial_enemy(lemon, 3);
//        if ((kirby->x >= (320 + monkey->dist + SCREEN_WIDTH/2)) || (kirby->x <= (320 - SCREEN_WIDTH/2)))
//            initial_enemy(monkey, 2);
        if ((kirby->x >= (540 + fire->dist + SCREEN_WIDTH/2)) || (kirby->x <= (540 - SCREEN_WIDTH/2)))
            initial_enemy(fire, 1);
        if ((kirby->x >= (700 + lightning->dist + SCREEN_WIDTH/2)) || (kirby->x <= (700 - SCREEN_WIDTH/2)))
            initial_enemy(lightning,0);
        
        
        AI_enemy(lemon, kirby, 150, 30);
//        AI_enemy(monkey, kirby, 320, 95);
        AI_enemy(fire, kirby, 540, 64);
        AI_enemy(lightning, kirby, 700, 113);

        // Detect enemies in caching area
//        if ((sqr_Dis_Kirby_Enemy(kirby, monkey) <= ENEMY_DETECT_DIS_SQRT * ENEMY_DETECT_DIS_SQRT) && (monkey->health != 0)) {
//            updateKirby(kirby, star, monkey, keycode, pre_keycode);
//            upload_Kirby_Info(kirby);
//            if (star->appear == 1)
//        	    spit_Star(kirby, star, monkey);
//        } else
        if ((sqr_Dis_Kirby_Enemy(kirby, lemon) <= ENEMY_DETECT_DIS_SQRT * ENEMY_DETECT_DIS_SQRT) && (lemon->health != 0)) {
            updateKirby(kirby, star, lemon, keycode, pre_keycode);
            upload_Kirby_Info(kirby);
            if (star->appear == 1)
        	    spit_Star(kirby, star, lemon);
        } else if ((sqr_Dis_Kirby_Enemy(kirby, fire) <= ENEMY_DETECT_DIS_SQRT * ENEMY_DETECT_DIS_SQRT) && (fire->health != 0)) {
            updateKirby(kirby, star, fire, keycode, pre_keycode);
            upload_Kirby_Info(kirby);
            if (star->appear == 1)
        	    spit_Star(kirby, star, fire);
        } else {
            updateKirby(kirby, star, lightning, keycode, pre_keycode);
            upload_Kirby_Info(kirby);
            if (star->appear == 1)
        	    spit_Star(kirby, star, lightning);
        }

        if ((kirby->health == 0) || (kirby->entered_door == 1))
            end = 1;
    }

    goto START;
}


void initial_Game_State (Game * game_state) {
    game_state->start = 0;
    game_state->end = 0;
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
    REG_15_GAME_CONTROL = 0;
}


void draw_Start_Image(Kirby * kirby) {
    REG_15_GAME_CONTROL = 0x00000000;
    upload_Kirby_Info(kirby);
}
