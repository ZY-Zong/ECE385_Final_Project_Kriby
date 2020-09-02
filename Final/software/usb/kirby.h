#ifndef KIRBY_H_
#define KIRBY_H_

typedef struct kirby
{
    int x;
    int y;
    int health;
    int action;
    int frame;
    int in_sky;
    int is_inhaled;
} Kirby;

void initialKirby(Kirby kirby);
void updateKirbyInfo(Kirby kirby);
unsigned int encryption(int a, int b, int c, int d);




#endif /*KIRBY_H_*/
