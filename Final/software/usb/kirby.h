#ifndef KIRBY_H_
#define KIRBY_H_

#include "game_logic.h"



typedef struct kirby {
    int x;
    int y;
    int map;
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

typedef struct star {
    int x;
    int y;
    int map_x;
    int idx;
    int appear;
    int is_left;
} Star;


void initial_Kirby(Kirby * kirby);
void upload_Kirby_Info(Kirby * kirby);
unsigned int encryption(int a, int b, int c, int d);
void updateKirby(Kirby * kirby, Star * star, int keycode, int pre_keycode);
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

int get_Wall_Info(int x, int y, int map_idx);
void kirby_Return_Normal(Kirby * kirby);
void kirby_Inhaling(Kirby * kirby);
// void kirby_Spitting(Kirby * kirby, Star * star);
void kirby_Kick_Ass(Kirby * kirby);
int kirby_Screen_Center_X(int x);


#endif /*KIRBY_H_*/
