#include "kirby.h"
#include "parameter.h"

void initial_Kirby(Kirby kirby){
    kirby.x = KIRBY_START_X;
    kirby.y = KIRBY_START_Y;
    kirby.is_left = 0;
    kirby.health = 8;
    kirby.action = 0;
    kirby.frame = 0;
    kirby.in_slope = 0;
    kirby.is_inhaled = 0;
}


void upload_Kirby_Info(Kirby kirby) {
    int Kirby_Pos_X = kirby.x + SCREEN_START_X;
    int Kirby_Pos_Y = kirby.y + SCREEN_START_Y;
    int Kirby_Image_X = kirby.frame * KIRBY_WIDTH;
    int Kirby_Image_Y = kirby.action * KIRBY_HEIGHT;
    REG_1_KIRBY_INFO = encryption(Kirby_Pos_X, Kirby_Pos_Y, Kirby_Image_X, Kirby_Image_Y);
    REG_2_DIRECTION = (REG_2_DIRECTION & 0xfffffff0) + (kirby.is_left & 0x0000000f);
}


unsigned int encryption(int a, int b, int c, int d) {
    unsigned int packet_info = (a << 24) | (b << 16) | (c << 8) | d;
    return packet_info;
}

void updateKirby(Kirby kirby, int keycode, int pre_keycode){
    int key0 = keycode & 0xff;
    int key1 = (keycode >> 8) & 0xff;
    int prekey0 = pre_keycode & 0xff;
    int prekey1 = (pre_keycode >> 8) & 0xff;

    switch (keycode) {
    case 0x0000: // "" Stand
        kirby.action = 0;
        if (pre_keycode == keycode) {
            kirby.frame = (kirby.frame + 1) % 2 + 2 * kirby.in_slope;
        } else {
            kirby.frame = 0 + 2 * kirby.in_slope;
        }
        frame_Time(1000);
        break;

    case 0x0004: //"a" left move
        kirby.action = 1;
        if (pre_keycode == keycode) {
            kirby.frame = (kirby.frame + 1) % 10;
        } else {
            kirby.frame = 0;
        }
        frame_Time(1000);
        kirby.x -= KIRBY_STEP_X;
        break;

    case 0x0007: //"d" right move
        kirby.action = 1;
        if (pre_keycode == keycode) {
            kirby.frame = (kirby.frame + 1) % 10;
        } else {
            kirby.frame = 0;
        }
        frame_Time(1000);
        kirby.x += KIRBY_STEP_X;
        break;
    
    case 0x0016: //"s" squat
        kirby.action = 2;
        if (pre_keycode == keycode) {
            kirby.frame = (kirby.frame + 1) % 2 + 2 * kirby.in_slope;
        } else {
            kirby.frame = 0 + 2 * kirby.in_slope;
        }
         frame_Time(1000);
        break;
    case 0x0026: //"w" fly
        if (kirby.is_inhaled == 1) {
            kirby.action = 3;
        }
        //TO DO: Continue
        break;
    default:
        break;
    }
    
    
}


void frame_Time(int t) {
    int i;
    for (i = 0; i < t; i++) {
        /* wait unitl the frame is over */
    }
}