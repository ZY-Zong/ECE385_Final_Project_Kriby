
#ifndef ENEMY_H_
#define ENEMY_H_

#include "kirby.h"
#include "structure.h"

void AI_enemy(Enemy * enemy, Kirby *  kirby, int startx, int starty);
void initial_enemy(Enemy * enemy, int which);
void set_the_enemy_easy(Enemy * enemy,int x,int y,Kirby * kirby);
void set_the_enemy_lightning(Enemy * enemy,int x,int y,Kirby * kirby);
void upload_enemy_Info(Enemy * enemy,Kirby * kirby);
void upload_enemy_Info_notshow(Enemy * enemy);

/* helper functions */
int get_Enemy_Botton_Pos (Enemy * enemy);
int get_Enemy_Ceil_Pos (Enemy * enemy);
int get_Enemy_Left_Pos (Enemy * enemy);
int get_Enemy_Right_Pos (Enemy * enemy);

#endif /*ENEMY_H_*/
