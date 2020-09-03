#ifndef GAME_LOGIC_H_
#define GAME_LOGIC_H_

typedef struct game_logic
{
    int map;
    int interrupt;
} Game;

Game GameStart();
void initial_Game_State (Game game_state);




#endif /*GAME_LOGIC_H_*/