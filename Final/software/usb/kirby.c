#include <stdio.h>

#include "kirby.h"
#include "parameter.h"
#include "image.h"
#include "wall.h"
#include "usb_main.h"
#include "star.h"

#define TEST_EDGE

void initial_Kirby(Kirby * kirby){
    kirby->x = KIRBY_START_X;
    kirby->y = KIRBY_START_Y;
    kirby->map = 0;
    kirby->image = 0;
    kirby->is_left = 0;
    kirby->health = 8;
    kirby->action = 0;
    kirby->frame = 0;
    kirby->in_slope = 0;
    kirby->in_air = 0;
    kirby->is_inhaled = 0;
    kirby->damaging = 0;
    kirby->inhaling = 0;
    kirby->spitting = 0;
}

void upload_Kirby_Info(Kirby * kirby) {
//    int Kirby_Pos_X = kirby->x;
//    int Kirby_Pos_Y = kirby->y;
    int Kirby_Image_X = kirby->frame;
    int Kirby_Image_Y = kirby->action;
    int Kirby_Image_Width = 0;
    int Kirby_Image_Height = 0;
    int Kirby_Screen_X = 0;
    int Kirby_Screen_Y = kirby->y;
//    int Map_Width = map_Width(kirby->map);
    int kirby_Botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff; // Center botton
    int kirby_Botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff; // Center botton

    // Decide kirby's image width and height
    if (kirby->is_inhaled == 1) {
        Kirby_Image_Width = 30;
        Kirby_Image_Height = 30;
    } else {
        Kirby_Image_Width = 28;
        Kirby_Image_Height = 28;
    }
    if ((kirby->is_inhaled == 1) && (kirby->spitting != 0)) {
        Kirby_Image_Width = 60;
        Kirby_Image_Height = 30;
    }
    if (kirby->inhaling != 0) {
        Kirby_Image_Width = 60;
        Kirby_Image_Height = 30;
    }

    // Decide the position X of kirby in screen
    Kirby_Screen_X = kirby_Screen_Center_X(kirby_Botton_X);


    // Upload to kirby's registers
    REG_0_MAP_INFO = (REG_0_MAP_INFO & 0x0000fff0) | (Kirby_Screen_X << 24) | (Kirby_Screen_Y << 16) | (kirby->image << 2) | kirby->map;
    REG_1_KIRBY_IMAGE = (Kirby_Image_X << 24) | (Kirby_Image_Y << 16) | (Kirby_Image_Width << 8) | (Kirby_Image_Height << 1) | (kirby->is_left & 0x00000001);
    REG_2_KIRBY_MAP_POS = (kirby_Botton_X << 16) | (kirby_Botton_Y);

    #ifdef TEST1
    printf("\n/******************* check upload ****************/\n");
    printf("\nkirby->x = %d; kirby->y = %d; kirby->frame = %d; kirby->action = %d\n", kirby->x, kirby->y, kirby->frame, kirby->action);
    printf("\nkirby->health = %d; kirby->is_inhaled = %d; kirby->inhaling = %d; kirby->in_slope = %d; kirby->spitting = %d\n", kirby->health, kirby->is_inhaled, kirby->inhaling, kirby->in_slope, kirby->spitting);
    printf("\nKirby_Image_X = %d; Kirby_Image_Y = %d; Kirby_Image_Width = %d; Kirby_Image_Height = %d\n", Kirby_Pos_X, Kirby_Pos_Y, Kirby_Image_Width, Kirby_Image_Height);
    printf("\nKirby_Pos_X = %d; Kirby_Pos_Y = %d\n", Kirby_Pos_X, Kirby_Pos_Y);
    printf("REG_0_MAP_INFO: %08x\n", REG_0_MAP_INFO);
    printf("REG_1_KIRBY_IMAGE: %08x\n", REG_1_KIRBY_IMAGE);
    printf("REG_2_KIRBY_MAP_POS: %08x\n", REG_2_KIRBY_MAP_POS);
    printf("\n/******************* end ****************/\n");
    #endif
}

void updateKirby(Kirby * kirby, Star * star, int keycode, int pre_keycode){
    int map_width = map_Width(kirby->map);
    int i = 0;

    // Enforce spitting
    if (kirby->spitting > 0) {
        kirby->spitting += 1;
        kirby->image = 1;
        kirby->action = 4;
        kirby->frame += 1;
        // printf("\n Spitting, ignore keyboard control \n");
        spit_Star(kirby, star); // spit star in specific frame
        if (kirby->spitting == 8) {
            kirby->spitting = 0;
            kirby->is_inhaled = 0;
            kirby->image = 0;
            kirby->action = 0;
            if (kirby->in_air == 1)
                kirby->frame = 10;
            else
                kirby->frame = 0;
        }
        frame_Time(KIRBY_FRAME_TIME_INHALE);
    }
    
    // Enforce inhaling
    else if (kirby->inhaling >= 2) {
        kirby->inhaling += 1;
        kirby->image = 1;
        kirby->action = 3;
        kirby->frame += 1;
        if (kirby->inhaling == 7) {
            kirby->inhaling = 0;
            kirby->is_inhaled = 0;
            if (kirby->in_air == 1) {
                kirby->action = 2;
                kirby->frame = 13;
            } else {
                kirby->action = 0;
                kirby->frame = 0;
            }
        }
    }
    
    // Key detection
    else {
        kirby->inhaling = 0;
        switch ((keycode & 0x0000ffff)) {
        case 0x0000: { // "" Stand
            if ((kirby->in_air == 0) && (kirby->is_inhaled == 0)) {
                kirby->image = 0;
                kirby->action = 0;
                if (pre_keycode == keycode) {
                    kirby->frame = (kirby->frame + 1) % KIRBY_STAND_FN + 2 * kirby->in_slope;
                } else {
                    kirby->frame = 0 + 2 * kirby->in_slope;
                }
                frame_Time(KIRBY_FRAME_TIME_BLINK);
            } else if ((kirby->in_air == 0) && (kirby->is_inhaled == 1)) {
                kirby->image = 1;
                kirby->action = 0;
                if (pre_keycode == keycode) {
                    kirby->frame = (kirby->frame + 1) % KIRBY_STAND_FN + 2 * kirby->in_slope;
                } else {
                    kirby->frame = 0 + 2 * kirby->in_slope;
                }
                frame_Time(KIRBY_FRAME_TIME_BLINK);
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 0)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->in_air = 0;
                } else {
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->frame = 10;
                    kirby->y += KIRBY_STEP_Y;
                    frame_Time(KIRBY_FRAME_TIME_WALK);
                }
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 1)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 1;
                    kirby->action = 0;
                    kirby->in_air = 0;
                    kirby->frame = 0;
                } else {
                    kirby->image = 1;
                    kirby->action = 2;
                    kirby->frame = 13;
                    kirby->y += KIRBY_STEP_Y;
                    frame_Time(KIRBY_FRAME_TIME_WALK);
                }
            }
            break;
        }

        case 0x0416:   //"a" & "s"
        case 0x1604:
        case 0x0400:
        case 0x0004: { //"a" left move
            kirby->x -= KIRBY_STEP_X;
            kirby->is_left = 1;

            // Kirby may walk to air
            if (will_Touch_Ground(kirby, kirby->map) == 0)
                kirby->in_air = 1;

            // state update
            if ((kirby->in_air == 0) && (kirby->is_inhaled == 0)) {
                kirby->image = 0;
                kirby->action = 1;
                if (pre_keycode == keycode)
                    kirby->frame = (kirby->frame + 1) % KIRBY_NORMAL_WALK_FN;
                else
                    kirby->frame = 0;
            } else if ((kirby->in_air == 0) && (kirby->is_inhaled == 1)) {
                kirby->image = 1;
                kirby->action = 1;
                if (pre_keycode == keycode)
                    kirby->frame = (kirby->frame + 1) % KIRBY_INHALED_WALK_FN;
                else
                    kirby->frame = 0 + 2 * kirby->in_slope; 
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 0)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 0;
                    kirby->action = 1;
                    kirby->in_air = 0;
                    kirby->frame = 0;
                    if (pre_keycode == keycode)
                        kirby->frame = (kirby->frame + 1) % KIRBY_NORMAL_WALK_FN;
                } else {
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->frame = 10;
                    kirby->y += KIRBY_STEP_Y;
                }
            } else if  ((kirby->in_air == 1) && (kirby->is_inhaled == 1)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 1;
                    kirby->action = 0;
                    kirby->in_air = 0;
                    kirby->frame = 0;
                    if (pre_keycode == keycode)
                        kirby->frame = (kirby->frame + 1) % KIRBY_INHALED_WALK_FN;
                } else {
                    kirby->image = 1;
                    kirby->action = 2;
                    kirby->frame = 13;
                    kirby->y += KIRBY_STEP_Y;
                }
            }
            frame_Time(KIRBY_FRAME_TIME_WALK);
            break;
        }

        case 0x0716:   //"d" & "s"
        case 0x1607:
        case 0x0700:
        case 0x0007: { //"d" right move
            kirby->x += KIRBY_STEP_X;
            kirby->is_left = 0;

            // Kirby may walk to air
            if (will_Touch_Ground(kirby, kirby->map) == 0)
                kirby->in_air = 1;

            // state update
            if ((kirby->in_air == 0) && (kirby->is_inhaled == 0)) {
                kirby->image = 0;
                kirby->action = 1;
                if (pre_keycode == keycode)
                    kirby->frame = (kirby->frame + 1) % KIRBY_NORMAL_WALK_FN;
                else
                    kirby->frame = 0;
            } else if ((kirby->in_air == 0) && (kirby->is_inhaled == 1)) {
                kirby->image = 1;
                kirby->action = 1;
                if (pre_keycode == keycode)
                    kirby->frame = (kirby->frame + 1) % KIRBY_INHALED_WALK_FN;
                else
                    kirby->frame = 0 + 2 * kirby->in_slope;
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 0)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 0;
                    kirby->action = 1;
                    kirby->in_air = 0;
                    kirby->frame = 0;
                    if (pre_keycode == keycode)
                        kirby->frame = (kirby->frame + 1) % KIRBY_NORMAL_WALK_FN;
                } else {
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->frame = 10;
                    kirby->y += KIRBY_STEP_Y;
                }
            } else if  ((kirby->in_air == 1) && (kirby->is_inhaled == 1)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 1;
                    kirby->action = 0;
                    kirby->in_air = 0;
                    kirby->frame = 0;
                    if (pre_keycode == keycode)
                        kirby->frame = (kirby->frame + 1) % KIRBY_INHALED_WALK_FN;
                } else {
                    kirby->image = 1;
                    kirby->action = 2;
                    kirby->frame = 13;
                    kirby->y += KIRBY_STEP_Y;
                }
            }
            frame_Time(KIRBY_FRAME_TIME_WALK);
            break;
        }

        case 0x041a:   // "a" & "w"
        case 0x1a04: { // "w" & "a"
            kirby->is_left = 1;
            kirby->in_air = 1;
            kirby->is_inhaled = 1;
            kirby->image = 1;
            kirby->action = 2;
            if (pre_keycode == keycode)
                kirby->frame = 7 + ((kirby->frame - 7) + 1) % KIRBY_INHALED_FLY_FN;
            else
                kirby->frame = 7;
            // TO DO: Maybe need to check whether tough the up walls
            kirby->y -= KIRBY_STEP_Y;
            kirby->x -= KIRBY_STEP_X;
            frame_Time(KIRBY_FRAME_TIME_WALK);
            break;
        }

        case 0x071a:   // "d" & "w"
        case 0x1a07:{  // "w" & "d"
            kirby->is_left = 0;
            kirby->in_air = 1;
            kirby->is_inhaled = 1;
            kirby->image = 1;
            kirby->action = 2;
            if (pre_keycode == keycode)
                kirby->frame = 7 + ((kirby->frame - 7) + 1) % KIRBY_INHALED_FLY_FN;
            else
                kirby->frame = 7;
            // TO DO: Maybe need to check whether tough the up walls
            kirby->y -= KIRBY_STEP_Y;
            kirby->x += KIRBY_STEP_X;
            frame_Time(KIRBY_FRAME_TIME_WALK);
            break;
        }
        
        case 0x0016: { //"s" squat
            if ((kirby->in_air == 0) && (kirby->is_inhaled == 0)) {
                kirby->image = 0;
                kirby->action = 2;
                if (pre_keycode == keycode)
                    kirby->frame = (kirby->frame + 1) % KIRBY_STAND_FN + 2 * kirby->in_slope;
                else
                    kirby->frame = 0;
                frame_Time(KIRBY_FRAME_TIME_BLINK);
            } else if ((kirby->in_air == 0) && (kirby->is_inhaled == 1)) { // Gulp
                kirby->image = 1;
                kirby->action = 2;
                kirby->frame = 0;
                for (i = 0; i < KIRBY_GULP_FN; i++) {
                    upload_Kirby_Info(kirby);
                    kirby->frame += 1;
                    frame_Time(KIRBY_FRAME_TIME_GULP);
                }
                kirby->is_inhaled = 0;
                kirby_Return_Normal(kirby);
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 0)) {
                if (will_Touch_Ground(kirby, kirby->map) == 1) {
                    kirby->in_air = 0;
                    force_It_On_Ground(kirby, kirby->map); // It will go to the ground
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->frame = 0 + 2 * kirby->in_slope;
                    frame_Time(KIRBY_FRAME_TIME_BLINK);
                } else {  // Slowly Drop downwards
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->frame = 10;
                    kirby->y += KIRBY_STEP_Y;
                    frame_Time(KIRBY_FRAME_TIME_WALK);
                }
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 1)) {
                if (will_Touch_Ground(kirby, kirby->map) == 1) {
                    kirby->in_air = 0;
                    force_It_On_Ground(kirby, kirby->map); // It will go to the ground
                    kirby->image = 1;
                    kirby->action = 0;
                    kirby->frame = 0;
                    frame_Time(KIRBY_FRAME_TIME_BLINK);
                } else {  // Slowly Drop downwards
                    kirby->image = 1;
                    kirby->action = 2;
                    kirby->frame = 13;
                    kirby->y += KIRBY_STEP_Y;
                    frame_Time(KIRBY_FRAME_TIME_WALK);
                }
            }
            break;
        }

        case 0x001a: { //"w" jump
            kirby->in_air = 1;
            kirby->is_inhaled = 1;
            kirby->image = 1;
            kirby->action = 2;
            if (pre_keycode == keycode) {
                kirby->frame = 7 + ((kirby->frame - 7) + 1) % KIRBY_INHALED_FLY_FN;
            } else {
                kirby->frame = 7;
            }
            // TO DO: Maybe need to check whether tough the up walls
            kirby->y -= KIRBY_STEP_Y; // fly upwards
            frame_Time(KIRBY_FRAME_TIME_WALK);
            break;
        }

        case 0x000e: { //"k" Fake B button
            if (kirby->is_inhaled == 0) { // Inhale
                kirby->inhaling = 1;
                kirby->image = 1;
                kirby->action = 3;
                if (1) {// Not get enemy signal
                    if (keycode == pre_keycode)
                        kirby->frame = (kirby->frame + 1) % 2;
                    else
                        kirby->frame = 0;
                    frame_Time(KIRBY_FRAME_TIME_INHALE * 3);
                } else { // TO DO: Get enemy signal, need test and add signal
                    print("\n################## Inhale Enemies ################\n");
                    kirby->inhaling = 2;
                    kirby->image = 1;
                    kirby->action = 3;
                    kirby->frame = 2;
                }
            } else { // Spitting
                kirby->spitting = 1;
                kirby->image = 1;
                kirby->action = 4;
                kirby->frame = 0;
            }
            frame_Time(KIRBY_FRAME_TIME_GULP);
            break;
        }

        case 0x000f: { //"l" Fake A button
                // Jump
            break;
        }

        case 0x160f:
        case 0x0f16: { //"l" & "s"
            if (kirby->is_inhaled == 0) {
                kirby_Kick_Ass(kirby);
            }
            while ((get_keycode_value() == 0x160f) || (get_keycode_value() == 0x0f16)) {
                kirby->image = 0;
                kirby->action = 2;
                kirby->frame = (kirby->frame + 1) % KIRBY_STAND_FN + 2 * kirby->in_slope;
                upload_Kirby_Info(kirby);
                force_It_On_Ground(kirby, kirby->map);
            }
            break;
        }

        #ifdef TEST_EDGE
        case 0x0017: // "t" test
            kirby->frame += 1;
            frame_Time(KIRBY_FRAME_STOP);
            break;
        #endif

        default: { // "" Stand
            if ((kirby->in_air == 0) && (kirby->is_inhaled == 0)) {
                kirby->image = 0;
                kirby->action = 0;
                if (pre_keycode == keycode) {
                    kirby->frame = (kirby->frame + 1) % KIRBY_STAND_FN + 2 * kirby->in_slope;
                } else {
                    kirby->frame = 0 + 2 * kirby->in_slope;
                }
                frame_Time(KIRBY_FRAME_TIME_BLINK);
            } else if ((kirby->in_air == 0) && (kirby->is_inhaled == 1)) {
                kirby->image = 1;
                kirby->action = 0;
                if (pre_keycode == keycode) {
                    kirby->frame = (kirby->frame + 1) % KIRBY_STAND_FN + 2 * kirby->in_slope;
                } else {
                    kirby->frame = 0 + 2 * kirby->in_slope;
                }
                frame_Time(KIRBY_FRAME_TIME_BLINK);
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 0)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->in_air = 0;
                } else {
                    kirby->image = 0;
                    kirby->action = 0;
                    kirby->frame = 10;
                    kirby->y += KIRBY_STEP_Y;
                    frame_Time(KIRBY_FRAME_TIME_WALK);
                }
            } else if ((kirby->in_air == 1) && (kirby->is_inhaled == 1)) {
                if (will_Touch_Ground(kirby, kirby->map)) {
                    kirby->image = 1;
                    kirby->action = 0;
                    kirby->in_air = 0;
                    kirby->frame = 0;
                } else {
                    kirby->image = 1;
                    kirby->action = 2;
                    kirby->frame = 13;
                    kirby->y += KIRBY_STEP_Y;
                    frame_Time(KIRBY_FRAME_TIME_WALK);
                }
            }
            break;
        }
        }
    }
    
    /* Position adjustment */
    // 1-Make sure Kirby not extending the map edges
    if (kirby->x <= 0) {
        kirby->x = 0;
    } else if (kirby->x >= map_width) {
        kirby->x = map_width;
    }
    if (kirby->y <= 0) {
        kirby->y = 0;
    } else if (kirby->y >= MAP_HEIGHT) {
        kirby->y = MAP_HEIGHT;
    }
    
    // 2-Floor detection for kirby on the ground
    if (kirby->in_air == 0) {
        force_It_On_Ground(kirby, kirby->map);
    }
    // 3-Make sure Kirby do not go inside white area
    force_It_Inside_Map(kirby, kirby->map);
}


void force_It_On_Ground(Kirby * kirby, int map_idx) {
    int kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
    int kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;
    // int kirby_ceil_X = (get_Kirby_Ceil_Pos(kirby) >> 16) & 0x0000ffff;
    // int kirby_ceil_Y = get_Kirby_Ceil_Pos(kirby) & 0x0000ffff;

    // Cling to the ground
    while (get_Wall_Info(kirby_botton_X, kirby_botton_Y + 1, map_idx) == AREA_CAN_GO) {
        int dropping_keycode = 0;
        kirby->y += 1;
        
        // Make kirby able to move in the air
        // dropping_keycode = get_keycode_value();
        // switch (dropping_keycode)
        // {
        // case 0x0004:
        // case 0x0400:
        // case 0x0416:
        // case 0x1604:
        // case 0x1a04:
        // case 0x041a: 
        //     kirby->is_left = 1;
        //     kirby->x -= KIRBY_STEP_X;
        //     break;
        //
        // case 0x0007:
        // case 0x0700:
        // case 0x0716:
        // case 0x1607:
        // case 0x1a07:
        // case 0x071a: 
        //     kirby->is_left = 0;
        //     kirby->x += KIRBY_STEP_X;
        //     break;
        //
        // default:
        //     break;
        // }
        // upload_Kirby_Info(kirby);
        // frame_Time(KIRBY_FRAME_TIME_DROP);

        // Update values
        kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;
    }
}

void force_It_Inside_Map(Kirby * kirby, int map_idx) {
    int kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
    int kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;
    int kirby_ceil_X = (get_Kirby_Ceil_Pos(kirby) >> 16) & 0x0000ffff;
    int kirby_ceil_Y = get_Kirby_Ceil_Pos(kirby) & 0x0000ffff;
    int kirby_left_X = (get_Kirby_Left_Pos(kirby) >> 16) & 0x0000ffff;
    int kirby_left_Y = get_Kirby_Left_Pos(kirby) & 0x0000ffff;
    int kirby_right_X = (get_Kirby_Right_Pos(kirby) >> 16) & 0x0000ffff;
    int kirby_right_Y = get_Kirby_Right_Pos(kirby) & 0x0000ffff;

    while (get_Wall_Info(kirby_botton_X, kirby_botton_Y, map_idx) == AREA_CANNOT_GO)
    {
        kirby->y -= 1;
        kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;
        kirby_ceil_X = (get_Kirby_Ceil_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_ceil_Y = get_Kirby_Ceil_Pos(kirby) & 0x0000ffff;
        kirby_left_X = (get_Kirby_Left_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_left_Y = get_Kirby_Left_Pos(kirby) & 0x0000ffff;
        kirby_right_X = (get_Kirby_Right_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_right_Y = get_Kirby_Right_Pos(kirby) & 0x0000ffff;
    }
    while (get_Wall_Info(kirby_left_X, kirby_left_Y, map_idx) == AREA_CANNOT_GO)
    {
        kirby->x += 1;
        kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;
        kirby_ceil_X = (get_Kirby_Ceil_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_ceil_Y = get_Kirby_Ceil_Pos(kirby) & 0x0000ffff;
        kirby_left_X = (get_Kirby_Left_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_left_Y = get_Kirby_Left_Pos(kirby) & 0x0000ffff;
        kirby_right_X = (get_Kirby_Right_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_right_Y = get_Kirby_Right_Pos(kirby) & 0x0000ffff;
    }
    while (get_Wall_Info(kirby_ceil_X, kirby_ceil_Y, map_idx) == AREA_CANNOT_GO)
    {
        kirby->y += 1;
        kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;
        kirby_ceil_X = (get_Kirby_Ceil_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_ceil_Y = get_Kirby_Ceil_Pos(kirby) & 0x0000ffff;
        kirby_left_X = (get_Kirby_Left_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_left_Y = get_Kirby_Left_Pos(kirby) & 0x0000ffff;
        kirby_right_X = (get_Kirby_Right_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_right_Y = get_Kirby_Right_Pos(kirby) & 0x0000ffff;
    }
    while (get_Wall_Info(kirby_right_X, kirby_right_Y, map_idx) == AREA_CANNOT_GO)
    {
        kirby->x -= 1;
        kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;
        kirby_ceil_X = (get_Kirby_Ceil_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_ceil_Y = get_Kirby_Ceil_Pos(kirby) & 0x0000ffff;
        kirby_left_X = (get_Kirby_Left_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_left_Y = get_Kirby_Left_Pos(kirby) & 0x0000ffff;
        kirby_right_X = (get_Kirby_Right_Pos(kirby) >> 16) & 0x0000ffff;
        kirby_right_Y = get_Kirby_Right_Pos(kirby) & 0x0000ffff;
    }
}

void frame_Time(int t) {
    int i;
    for (i = 0; i < t; i++) {
        /* wait unitl the frame is over */
    }
}

int map_Width(int i) {
    switch (i) {
    case 0:
        return MAP_0_WIDTH;
        break;
    case 1:
        return MAP_1_WIDTH;
        break;
     case 2:
         return MAP_2_WIDTH;
         break;
    default:
        return MAP_0_WIDTH;
        break;
    }
}

int will_Touch_Ground(Kirby * kirby, int map_idx) {
    int kirby_botton_X = (get_Kirby_Botton_Pos(kirby) >> 16) & 0x0000ffff;
    int kirby_botton_Y = get_Kirby_Botton_Pos(kirby) & 0x0000ffff;

    if (get_Wall_Info(kirby_botton_X, kirby_botton_Y + 1, map_idx) == AREA_CANNOT_GO) {
        return 1;
    } else {
        return 0;
    }
}

int get_Kirby_Botton_Pos(Kirby * kirby) {
    int kirby_botton_X = 0;
    int kirby_botton_Y = 0;

    if (kirby->is_inhaled == 1) {
        kirby_botton_X = kirby->x + 16;
        kirby_botton_Y = kirby->y + 25;
    } else if ((kirby->inhaling == 1) || (kirby->spitting == 1)) {
        kirby_botton_X = kirby->x + 30;
        kirby_botton_Y = kirby->y + 25;
    } else if (kirby->damaging == 1) {
        kirby_botton_X = kirby->x + 17;
        kirby_botton_Y = kirby->y + 33;
    } else {
        kirby_botton_X = kirby->x + 14;
        kirby_botton_Y = kirby->y + 20;
    }
    return ((kirby_botton_X << 16) | kirby_botton_Y);
}

int get_Kirby_Ceil_Pos(Kirby * kirby) {
    int kirby_ceil_X = 0;
    int kirby_ceil_Y = 0;

    if (kirby->is_inhaled == 1) {
        kirby_ceil_X = kirby->x + 16;
        kirby_ceil_Y = kirby->y + 5;
    } else if ((kirby->inhaling == 1) || (kirby->spitting == 1)) {
        kirby_ceil_X = kirby->x + 30;
        kirby_ceil_Y = kirby->y + 5;
    } else if (kirby->damaging == 1) {
        kirby_ceil_X = kirby->x + 17;
        kirby_ceil_Y = kirby->y + 7;   //// Not an accurate value!!! ////
    } else {
        kirby_ceil_X = kirby->x + 14;
        kirby_ceil_Y = kirby->y + 4;
    }
    return ((kirby_ceil_X << 16) | kirby_ceil_Y);
}

int get_Kirby_Left_Pos(Kirby * kirby) {
    int kirby_left_X = 0;
    int kirby_left_Y = 0;

    if (kirby->is_inhaled == 1) {
        kirby_left_X = kirby->x + 5;
        kirby_left_Y = kirby->y + 15;
    } else if ((kirby->inhaling == 1) || (kirby->spitting == 1)) {
        kirby_left_X = kirby->x + 21;
        kirby_left_Y = kirby->y + 15;
    } else if (kirby->damaging == 1) {
        kirby_left_X = kirby->x + 6;
        kirby_left_Y = kirby->y + 18;   //// Not an accurate value!!! ////
    } else {
        kirby_left_X = kirby->x + 8;    //// Not an accurate value!!! //// 8
        kirby_left_Y = kirby->y + 14;   //// Not an accurate value!!! ////
    }
    return ((kirby_left_X << 16) | kirby_left_Y);
}

int get_Kirby_Right_Pos(Kirby * kirby) {
    int kirby_right_X = 0;
    int kirby_right_Y = 0;

    if (kirby->is_inhaled == 1) {
        kirby_right_X = kirby->x + 26;
        kirby_right_Y = kirby->y + 15;
    } else if ((kirby->inhaling == 1) || (kirby->spitting == 1)) {
        kirby_right_X = kirby->x + 41;
        kirby_right_Y = kirby->y + 15;
    } else if (kirby->damaging == 1) {
        kirby_right_X = kirby->x + 29;   //// Not an accurate value!!! ////
        kirby_right_Y = kirby->y + 18;   //// Not an accurate value!!! ////
    } else {
        kirby_right_X = kirby->x + 24;    //// Not an accurate value!!! ////
        kirby_right_Y = kirby->y + 14;   //// Not an accurate value!!! ////
    }
    return ((kirby_right_X << 16) | kirby_right_Y);
}

int get_Wall_Info(int x, int y, int map_idx) {
    int idx, res = 0;
    idx = (map_Width(map_idx) * y + x) / 32;
    res = (map_Width(map_idx) * y + x) % 32;
    if (map_idx == 0) {
        return ((Wall1[idx] >> (31 - res)) & 0x00000001);
    } else if (map_idx == 1) {
        return ((Wall2[idx] >> (31 - res)) & 0x00000001);
    } else {
        printf("Error: Map index out of tolerrance!");
    }
    return 1;
}

void kirby_Inhaling(Kirby * kirby) {
    kirby->frame = 0;
    upload_Kirby_Info(kirby);
    frame_Time(KIRBY_FRAME_TIME_INHALE);
    while (get_keycode_value() == 0x000e) {
        kirby->frame = (kirby->frame + 1) % 2;
        upload_Kirby_Info(kirby);
        frame_Time(KIRBY_FRAME_TIME_INHALE);
    }
    kirby->inhaling = 0;
    kirby->is_inhaled = 1;
    kirby->action = 0;
    // kirby->frame = 11;
    // upload_Kirby_Info(kirby);
    kirby->frame = 12;
    upload_Kirby_Info(kirby);
    kirby->frame = 13;
    upload_Kirby_Info(kirby);
    kirby->is_inhaled = 0;
}

void kirby_Return_Normal(Kirby * kirby) {
    kirby->is_inhaled = 0;
    kirby->in_air = 0;
    kirby->image = 0;
    kirby->action = 0;
    kirby->frame = 0;
    upload_Kirby_Info(kirby);
}

void kirby_Kick_Ass(Kirby * kirby) {
    int i = 0;
    kirby->image = 0;
    kirby->action = 2;
    kirby->frame = 6;
    if (kirby->is_left == 0) {
        for (i = 0; i < 8; i++){
            kirby->x += KIRBY_KICK_X;
            force_It_Inside_Map(kirby, kirby->map);
            force_It_On_Ground(kirby, kirby->map);
            upload_Kirby_Info(kirby);
            frame_Time(KIRBY_FRAME_TIME_KICK);
        }
        for (i = 0; i < 6; i++)
        {
            kirby->x += (KIRBY_KICK_X - 1);
            force_It_Inside_Map(kirby, kirby->map);
            force_It_On_Ground(kirby, kirby->map);
            upload_Kirby_Info(kirby);
            frame_Time(KIRBY_FRAME_TIME_KICK);
        }
        kirby->x += (KIRBY_KICK_X - 2);
        force_It_Inside_Map(kirby, kirby->map);
        force_It_On_Ground(kirby, kirby->map);
        upload_Kirby_Info(kirby);
        frame_Time(KIRBY_FRAME_TIME_KICK);
    } else {
        for (i = 0; i < 8; i++){
            kirby->x -= KIRBY_KICK_X;
            force_It_Inside_Map(kirby, kirby->map);
            force_It_On_Ground(kirby, kirby->map);
            upload_Kirby_Info(kirby);
            frame_Time(KIRBY_FRAME_TIME_KICK);
        }
        for (i = 0; i < 6; i++)
        {
            kirby->x -= (KIRBY_KICK_X - 1);
            force_It_Inside_Map(kirby, kirby->map);
            force_It_On_Ground(kirby, kirby->map);
            upload_Kirby_Info(kirby);
            frame_Time(KIRBY_FRAME_TIME_KICK);
        }
        kirby->x -= (KIRBY_KICK_X - 2);
        force_It_Inside_Map(kirby, kirby->map);
        force_It_On_Ground(kirby, kirby->map);
        upload_Kirby_Info(kirby);
        frame_Time(KIRBY_FRAME_TIME_KICK);
    }
    

}

int kirby_Screen_Center_X(int x) {
    if (x <= (SCREEN_WIDTH/2)) {
        return x;
    } else if ((x > (SCREEN_WIDTH/2)) && (x < (MAP_0_WIDTH - SCREEN_WIDTH/2))) {
        return (SCREEN_WIDTH/2);
    } else {
        return (x - MAP_0_WIDTH + SCREEN_WIDTH);
    }
}

