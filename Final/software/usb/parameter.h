#ifndef PARAMETER_H_
#define PARAMETER_H_


/* Avalon_Kirby_Interface Parameters */
static volatile unsigned int * ADDRESS_PTR = (unsigned int *) 0x00000000;

#define REG_0_MAP_INFO          ADDRESS_PTR[0]
#define REG_1_KIRBY_IMAGE       ADDRESS_PTR[1]
#define REG_2_KIRBY_MAP_POS     ADDRESS_PTR[2]
#define REG_3_                  ADDRESS_PTR[3]
#define REG_4_                  ADDRESS_PTR[4]
#define REG_5_                  ADDRESS_PTR[5]
#define REG_6_                  ADDRESS_PTR[6]
#define REG_7_                  ADDRESS_PTR[7]
#define REG_8_                  ADDRESS_PTR[8]
#define REG_9_                  ADDRESS_PTR[9]
#define REG_10_                 ADDRESS_PTR[10]
#define REG_11_                 ADDRESS_PTR[11]
#define REG_12_                 ADDRESS_PTR[12]
#define REG_13_                 ADDRESS_PTR[13]
#define REG_14_                 ADDRESS_PTR[14]
#define REG_15_                 ADDRESS_PTR[15]

/* KIRBY's Parameters */
#define KIRBY_WIDTH             28
#define KIRBY_HEIGHT            28
#define KIRBY_START_X           5
#define KIRBY_START_Y           99
#define KIRBY_STEP_X            3
#define KIRBY_STEP_Y            3
#define KIRBY_INHALED_WIDTH     30
#define KIRBY_INHALED_HEIGHT    30
#define KIRBY_FRAME_TIME_WALK   1600
#define KIRBY_FRAME_TIME_BLINK  15000
#define KIRBY_FRAME_TIME_GULP   1700

#define KIRBY_INHALED_WALK_FN   13
#define KIRBY_INHALED_FLY_FN    6
#define KIRBY_STAND_FN          2
#define KIRBY_NORMAL_WALK_FN    10
#define KIRBY_GULP_FN           6

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

#endif /*PARAMETER_H_*/
