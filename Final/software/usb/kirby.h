#ifndef KIRBY_H_
#define KIRBY_H_

typedef struct kirby {
    int x;
    int y;
    int is_left;
    int health;
    int action;
    int frame;
    int in_slope;
    int is_inhaled;
} Kirby;

void initial_Kirby(Kirby kirby);
void upload_Kirby_Info(Kirby kirby);
unsigned int encryption(int a, int b, int c, int d);
void updateKirby(Kirby kirby, int keycode, int pre_keycode);



#endif /*KIRBY_H_*/
