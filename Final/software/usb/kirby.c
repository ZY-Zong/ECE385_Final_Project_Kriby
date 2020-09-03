#include "kirby.h"
#include "parameter.h"
#include "image.h"
#include "game_logic.h"

void initial_Kirby(Kirby kirby){
    kirby.x = KIRBY_START_X;
    kirby.y = KIRBY_START_Y;
    kirby.is_left = 0;
    kirby.health = 8;
    kirby.action = 0;
    kirby.frame = 0;
    kirby.in_slope = 0;
    kirby.is_inhaled = 0;
    kirby.inhaling = 0;
    kirby.spitting = 0;
}


void upload_Kirby_Info(Kirby kirby, Game game_state) {
    // int Kirby_Pos_X = kirby.x + SCREEN_START_X;
    // int Kirby_Pos_Y = kirby.y + SCREEN_START_Y;
    // int Kirby_Image_X = kirby.frame * KIRBY_WIDTH;
    // int Kirby_Image_Y = kirby.action * KIRBY_HEIGHT;
    int Kirby_Pos_X = kirby.x;
    int Kirby_Pos_Y = kirby.y;
    int Kirby_Image_X = kirby.frame;
    int Kirby_Image_Y = kirby.action;
    int Kirby_Image_Width = 0;
    int Kirby_Image_Height = 0;
    int Kirby_Screen_X = 0;
    int Kirby_Screen_Y = kirby.y;
    int Map_Width = map_Width(game_state.map);

    // Decide kirby's image width and height
    if (kirby.is_inhaled == 1) {
        Kirby_Image_Width = 30;
        Kirby_Image_Height = 30;
    } else if ((kirby.inhaling == 1) || (kirby.spitting == 1)) {
        Kirby_Image_Width = 60;
        Kirby_Image_Height = 30;
    } else {
        Kirby_Image_Width = 28;
        Kirby_Image_Height = 28;
    }

    // Decide the position X of kirby in screen
    if (kirby.x <= (SCREEN_WIDTH/2)) {
        Kirby_Screen_X = kirby.x;
    } else if ((kirby.x > (SCREEN_WIDTH/2)) && (kirby.x < (Map_Width - SCREEN_WIDTH/2))) {
        Kirby_Screen_X = (SCREEN_WIDTH/2);
    } else {
        Kirby_Screen_X = kirby.x - Map_Width + SCREEN_WIDTH;
    }

    // Upload to kirby's registers
    REG_0_MAP_INFO = (REG_0_MAP_INFO & 0x0000ffff) | (Kirby_Screen_X << 24) | (Kirby_Screen_Y << 16);
    REG_1_KIRBY_IMAGE = (Kirby_Image_X << 24) | (Kirby_Image_Y << 16) | (Kirby_Image_Width << 8) | (Kirby_Image_Height << 7) | (kirby.is_left & 0x00000001);
    REG_2_KIRBY_MAP_POS = (Kirby_Pos_X << 16) | (Kirby_Pos_Y);
    
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
    case 0x000e: //"k" Fake B button
        if (kirby.is_inhaled == 0) {
            // Inhale
        }
        
        break;
    case 0x000f: //"l" Fake A button
            // Jump
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