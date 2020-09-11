#include <stdio.h>

#include "star.h"
#include "parameter.h"
#include "enemy.h"


void initial_Star(Star * star) {
    star->x = 0;
    star->y = 0;
    star->map_x = 0;
    star->idx = 0;
    star->appear = 0;
    star->is_left = 0;
}

void spit_Star(Kirby * kirby, Star * star, Enemy * enemy) {
    update_Star(kirby, star, enemy);
    upload_Star_Info(star);
    frame_Time(STAR_FRAME_TIME);
}

void upload_Star_Info(Star * star) {
//    printf("\n**************** Spit Star - Load Registers ****************\n");
    REG_3_STAR = (star->x << 24) | (star->y << 16) | (star->idx << 14) | (star->is_left << 13) | (star->appear << 12);
}

void update_Star(Kirby * kirby, Star * star, Enemy * enemy) {
    if ((kirby->image == 1) && (kirby->action == 4) && (kirby->frame == 2)) {
        // spit star
        star->appear = 1;
        star->idx = 0;
        star->is_left = kirby->is_left;
        if (star->is_left == 0) { // Right
            star->x = kirby_Screen_Center_X(kirby->x) + 31;
            star->map_x = kirby->x + 31;
        } else { // Left
            star->x = kirby_Screen_Center_X(kirby->x) - 31;
            star->map_x = kirby->x - 31;
        }
        star->y = kirby->y + 3;
        return;
    }

    if (star->appear == 1) {
        star->idx = (star->idx + 1) % 4; // 4 frames for 1 star-cycle

        // 1 - Edge detection: L/R
        if (star->is_left == 0) {
            star->x += STAR_STEP_X;
            star->map_x += STAR_STEP_X;

            // If meet edges of map or screen
            if ((get_Wall_Info(star->map_x + 22, star->y + 7, 0) == 1) || ((star->x + 22) > 260)) {
                star->appear = 0;
                return;
            }
        }
        else {
            star->x -= STAR_STEP_X;
            star->map_x -= STAR_STEP_X;

            // If meet edges of map or screen
            if ((get_Wall_Info(star->map_x + 1, star->y + 7, 0) == 1) || ((star->x + 1) <= 0)) {
                star->appear = 0;
                return;
            }
        }
        
        // 2 - Enemy detection
        if (star_Meet_Enemy(star, enemy)) {  // TO DO: Need a signal here
            // TO DO: Enemy get a signal - Damaged
            star->appear = 0;
            enemy->health = 0;
            return;
        }
        return;
    }
}

int star_Meet_Enemy(Star * star, Enemy * enemy) {
    int star_Center_X = star->map_x + 12;
    int star_Center_Y = star->y + 12;
    int enemy_Center_X = (get_Enemy_Botton_Pos(enemy) >> 16) & 0x0000ffff;
    int enemy_Center_Y = (get_Enemy_Left_Pos(enemy) & 0x0000ffff);

    if (((star_Center_X - enemy_Center_X) * (star_Center_X - enemy_Center_X)) + ((star_Center_Y - enemy_Center_Y) * (star_Center_Y - enemy_Center_Y)) <= (STAR_DAMAGE_DIS_SQRT * STAR_DAMAGE_DIS_SQRT))
        return 1;
    return 0;
}
