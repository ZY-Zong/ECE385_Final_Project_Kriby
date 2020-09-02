#include "kirby.h"
#include "parameter.h"

void initialKirby(Kirby kirby){
    kirby.x = KIRBY_START_X;
    kirby.y = KIRBY_START_Y;
    kirby.health = 8;
    kirby.action = 0;
    kirby.frame = 0;
    kirby.in_sky = 0;
    kirby.is_inhaled = 0;
}



void updateKirbyInfo(Kirby kirby) {
    int Kirby_Pos_X = kirby.x + SCREEN_START_X;
    int Kirby_Pos_Y = kirby.y + SCREEN_START_Y;
    int Kirby_Image_X = kirby.frame * KIRBY_WIDTH;
    int Kirby_Image_Y = kirby.action * KIRBY_HEIGHT;
    REG_1_KIRBY_INFO = encryption(Kirby_Pos_X, Kirby_Pos_Y, Kirby_Image_X, Kirby_Image_Y);
}


unsigned int encryption(int a, int b, int c, int d) {
    unsigned int packet_info = (a << 24) | (b << 16) | (c << 8) | d;
    return packet_info;
}