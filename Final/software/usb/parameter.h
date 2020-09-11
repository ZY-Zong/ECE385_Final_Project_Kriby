#ifndef PARAMETER_H_
#define PARAMETER_H_


/* Avalon_Kirby_Interface Parameters */
static volatile unsigned int * ADDRESS_PTR = (unsigned int *) 0x00000000;

#define REG_0_MAP_INFO          ADDRESS_PTR[0 ]
#define REG_1_KIRBY_IMAGE       ADDRESS_PTR[1 ]
#define REG_2_KIRBY_MAP_POS     ADDRESS_PTR[2 ]
#define REG_3_STAR              ADDRESS_PTR[3 ]
#define REG_4_                  ADDRESS_PTR[4 ]
#define REG_5_                  ADDRESS_PTR[5 ]
#define REG_6_                  ADDRESS_PTR[6 ]
#define REG_7_                  ADDRESS_PTR[7 ]
#define REG_8_                  ADDRESS_PTR[8 ]
#define REG_9_                  ADDRESS_PTR[9 ]
#define REG_10_                 ADDRESS_PTR[10]
#define REG_11_                 ADDRESS_PTR[11]
#define REG_12_                 ADDRESS_PTR[12]
#define REG_13_                 ADDRESS_PTR[13]
#define REG_14_                 ADDRESS_PTR[14]
#define REG_15_GAME_CONTROL     ADDRESS_PTR[15]

/* KIRBY's Parameters */
#define KIRBY_WIDTH             28
#define KIRBY_HEIGHT            28
#define KIRBY_START_X           5
#define KIRBY_START_Y           99
#define KIRBY_STEP_X            3
#define KIRBY_STEP_Y            3
#define KIRBY_KICK_X            3
#define KIRBY_DROP_Y            4
#define KIRBY_INHALED_WIDTH     30
#define KIRBY_INHALED_HEIGHT    30
#define KIRBY_INHALE_DIS_SQRT   36
#define KIRBY_DAMAGE_DIS_SQRT   20
#define KIRBY_DAMEGE_DIS_SQRTL  32

#define KIRBY_FRAME_TIME_WALK   1500//1600
#define KIRBY_FRAME_TIME_BLINK  3000//15000
#define KIRBY_FRAME_TIME_GULP   4000//20000
#define KIRBY_FRAME_TIME_INHALE 5000//8000
#define KIRBY_FRAME_TIME_KICK   900//4000
#define KIRBY_FRAME_TIME_DROP   3000//3000
#define KIRBY_FRAME_TIME_DAMAGE 2500
#define KIRBY_FRAME_STEP        500//200000

#define KIRBY_INHALED_WALK_FN   13
#define KIRBY_INHALED_FLY_FN    6
#define KIRBY_STAND_FN          2
#define KIRBY_NORMAL_WALK_FN    10
#define KIRBY_GULP_FN           6
#define KIRBY_INHALING_FN       8

/* VGA & Screen Related Parameters */
#define SCREEN_WIDTH            234
#define SCREEN_HEIGHT           176
#define SCREEN_START_X          203
#define SCREEN_START_Y          152

#define VGA_WIDTH               640
#define VGA_HEIGHT              480
#define VGA_CENTER_X            320
#define VGA_CENTER_Y            240


/* Map Parameters */
#define MAP_0_WIDTH             1215
#define MAP_1_WIDTH             976
#define MAP_2_WIDTH             1217
#define MAP_HEIGHT              176

#define AREA_CAN_GO             0
#define AREA_CANNOT_GO          1

/* Star Parameters */
#define STAR_STEP_X             4
#define STAR_FRAME_TIME         3500
#define STAR_DAMAGE_DIS_SQRT    21

/* Enemy Parameters */
#define LEFT_FRAME_NUM          8
#define LEFT_FRAME_DEMAGE_NUM   4
#define ENEMY_DETECT_DIS_SQRT   150

/* Game About Parameters */
#define GAME_OVER_FRAME_TIME    45000
#define DOOR_TOLERANCE          6
#define DOOR_CENTER_X           1094
#define DOOR_CENTER_Y           85
#define DIE_INCREASE_TIME_BASE  10000

#endif /*PARAMETER_H_*/
