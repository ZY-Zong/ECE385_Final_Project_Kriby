#ifndef GAME_LOGIC_H_
#define GAME_LOGIC_H_

typedef struct kirbyStruct
{
    int x;
    int y;
    int in_sky;
    int health;
    int frame;
    int is_inhaled;
} kirby;

void updateKirby();





#endif /*GAME_LOGIC_H_*/