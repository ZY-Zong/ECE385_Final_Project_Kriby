#ifndef KIRBY_H_
#define KIRBY_H_

#include "game_logic.h"
#include "enemy.h"
#include "structure.h"

void initial_Kirby(Kirby * kirby);
void upload_Kirby_Info(Kirby * kirby);
unsigned int encryption(int a, int b, int c, int d);
void updateKirby(Kirby * kirby, Star * star, Enemy * enemy, int keycode, int pre_keycode);
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
void kirby_Kick_Ass(Kirby * kirby);
int kirby_Screen_Center_X(int x);
int kirby_Is_Damaged(Kirby * kirby, Enemy * enemy);
int kirby_Damage_Action(Enemy * enemy);
int damage_Frame_Number(Enemy * enemy);
int enemy_Should_Be_Inhaled(Kirby * kirby, Enemy * enemy);
int sqr_Dis_Kirby_Enemy(Kirby * kirby, Enemy * enemy);
int sqr_Dis_Kirby_Door(Kirby * kirby);

void game_Over_Anime(Kirby * kirby);
void win_Anime(Kirby * kirby);

#endif /*KIRBY_H_*/
