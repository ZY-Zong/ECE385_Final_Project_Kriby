#ifndef STAR_H_
#define STAR_H_

#include "kirby.h"

//typedef struct star {
//    int x;
//    int y;
//    int idx;
//    int appear;
//    int is_left;
//} Star;

void initial_Star(Star * star);
void spit_Star(Kirby * kirby, Star * star);
void upload_Star_Info(Star * star);
void update_Star(Kirby * kirby, Star * star);


#endif /*STAR_H_*/
