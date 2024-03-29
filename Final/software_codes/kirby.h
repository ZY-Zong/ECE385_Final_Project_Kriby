#ifndef KIRBY_H_
#define KIRBY_H_

#include "game_logic.h"

typedef struct kirby {
    int x;
    int y;
    int image;
    int is_left;
    int health;
    int action;
    int frame;
    int in_slope;
    int in_air;
    int is_inhaled;
    int damaging;
    int inhaling;
    int spitting;
} Kirby;

void initial_Kirby(Kirby * kirby);
void upload_Kirby_Info(Kirby * kirby, Game * game_state);
unsigned int encryption(int a, int b, int c, int d);
void updateKirby(Kirby * kirby, Game * game_state, int keycode, int pre_keycode);
void force_It_On_Ground(Kirby * kirby, int map_idx);
void force_It_Inside_Map(Kirby * kirby, int map_idx);

// helper functions
void frame_Time(int t);
int map_Width(int i);
int will_Touch_Ground(Kirby * kirby, int map_idx);
int get_Kirby_Botton_Pos(Kirby * kirby);
int get_Kirby_Ceil_Pos(Kirby * kirby);
int get_Kirby_Left_Pos(Kirby * kirby);
int get_Kirby_Right_Pos(Kirby * kirby);


#endif /*KIRBY_H_*/
