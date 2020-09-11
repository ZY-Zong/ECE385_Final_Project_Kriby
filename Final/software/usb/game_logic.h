#ifndef GAME_LOGIC_H_
#define GAME_LOGIC_H_

#include "structure.h"

// #define TEST1;

typedef struct game_logic
{
    int start;
    int end;
} Game;

void GameStart();
void initial_Game_State(Game * game_state);
void initial_Registers();
void draw_Start_Image(Kirby * kirby);



#endif /*GAME_LOGIC_H_*/
