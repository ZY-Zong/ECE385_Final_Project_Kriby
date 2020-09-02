#ifndef PARAMETER_H_
#define PARAMETER_H_


/* Avalon_Kirby_Interface Parameters */
static volatile unsigned int * ADDRESS_PTR = (unsigned int *) 0x00000000;
#define REG_0_              ADDRESS_PTR[0]
#define REG_1_ADDR_X        ADDRESS_PTR[1]
#define REG_2_ADDR_Y        ADDRESS_PTR[2]
#define REG_3_PALETTE_IDX   ADDRESS_PTR[3]
#define REG_4_COLOR_IDX     ADDRESS_PTR[4]
#define REG_5_MAP_IDX       ADDRESS_PTR[5]
#define REG_6_              ADDRESS_PTR[6]
#define REG_7_              ADDRESS_PTR[7]
#define REG_8_              ADDRESS_PTR[8]
#define REG_9_              ADDRESS_PTR[9]
#define REG_10_             ADDRESS_PTR[10]
#define REG_11_             ADDRESS_PTR[11]
#define REG_12_             ADDRESS_PTR[12]
#define REG_13_             ADDRESS_PTR[13]
#define REG_14_             ADDRESS_PTR[14]
#define REG_15_             ADDRESS_PTR[15]

/* Other Parameters */


#endif /*PARAMETER_H_*/
