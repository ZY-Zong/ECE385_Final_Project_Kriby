
module  Kirby (
              input         Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,          // The clock indicating a new frame (~60Hz)
					    input [7:0]   keycode,
              input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					    // input         initial_frame, final_frame, game_over,
              output logic  is_kirby,       // Whether current pixel belongs to Kirby
					    output logic  character_frame
              );


    parameter [9:0] Kirby_X_Min = 10'd203;     // Leftmost point on the X axis
    parameter [9:0] Kirby_X_Max = 10'd436;     // Rightmost point on the X axis
    parameter [9:0] Kirby_Y_Min = 10'd152;     // Topmost point on the Y axis
    parameter [9:0] Kirby_Y_Max = 10'd327;     // Bottommost point on the Y axis
    parameter [9:0] Kirby_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Kirby_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Kirby_X_Size = 10'd4;      // Kirby's size in X domain
    parameter [9:0] Kirby_Y_Size = 10'd4;      // Kirby's size in Y domain

    parameter [9:0] Kirby_Inhaled_X_Size = 10'd8;
    parameter [9:0] Kirby_Inhaled_X_Size = 10'd4;      // Inhaled Kirby's size in X domain
    parameter [9:0] Kirby_Inhaled_Y_Size = 10'd4;      // Inhaled Kirby's size in Y domain 
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    

  // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= Ball_Y_Step;
        end
        else
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
        end
    end

endmodule
