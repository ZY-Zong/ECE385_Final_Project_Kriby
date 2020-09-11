#ifndef STRUCTURE_H_
#define STRUCTURE_H_


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
    int kicking;
    int gulping;
    int entered_door;
} Kirby;

typedef struct star {
    int x;
    int y;
    int map_x;
    int idx;
    int appear;
    int is_left;
} Star;

typedef struct enemy {
    int realx;
    int realy;
    int is_right;
    int health;
    int action;
    int frame;
    int tpe;
    int enemyrightcount;
    int enemyleftcount;
    int dist;
    int framecount;
    int framechange;
} Enemy;


#endif /* STRUCTURE_H_ */
