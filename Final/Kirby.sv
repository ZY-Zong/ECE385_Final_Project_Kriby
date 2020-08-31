module Kirby (
    input         Clk,                // 50 MHz clock
                  Reset,              // Active-high reset signal
                  frame_clk,          // The clock indicating a new frame (~60Hz)
    input  [9:0]  DrawX, DrawY,       // Current pixel coordinates
    // input [7:0]   keycode,            // Key pressed in the keyboard (8-bit)
    input  [2:0]  character_action_idx,       // which action
	input  [3:0]  character_action_frame_idx, // which frame of this action
    output logic [9:0]  KirbyX, KirbyY
);
    parameter [9:0] Kirby_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Kirby_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Kirby_X_Min = 10'd203;     // Leftmost point on the X axis
    parameter [9:0] Kirby_X_Max = 10'd436;     // Rightmost point on the X axis
    parameter [9:0] Kirby_Y_Min = 10'd152;     // Topmost point on the Y axis
    parameter [9:0] Kirby_Y_Max = 10'd327;     // Bottommost point on the Y axis
    parameter [9:0] Kirby_Move_Step = 10'd2;   // Move step size on the X axis
    parameter [9:0] Kirby_Y_Jump_Step = 10'd8; // Step size on the Y axis -- jump
    parameter [9:0] Kirby_X_Size = 10'd28;     // Kirby's size in X domain
    parameter [9:0] Kirby_Y_Size = 10'd28;     // Kirby's size in Y domain

    parameter [9:0] Kirby_X_Start = 10'd210;
    parameter [9:0] Kirby_Y_Start = 10'd240;

    // parameter [9:0] Kirby_Inhaled_Y_Step = 10'd2;

    logic [9:0] KirbyX_In, KirbyY_In;


endmodule