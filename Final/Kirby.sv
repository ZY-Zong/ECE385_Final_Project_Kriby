module Kirby (
    input         Clk,                // 50 MHz clock
                  Reset,              // Active-high reset signal
                  frame_clk,          // The clock indicating a new frame (~60Hz)
    input  [9:0]  DrawX, DrawY,       // Current pixel coordinates
    input  [7:0]  keycode,            // Key pressed in the keyboard (8-bit)
    input  [9:0]  Left_Dis, Right_Dis, Up_Dis, Bottom_Dis,
    output logic [9:0]  KirbyX, KirbyY,
    output logic        draw_Kirby
);
    parameter [9:0] Screen_X_Center = 10'd320; // Center position on the X axis
    parameter [9:0] Screen_Y_Center = 10'd240; // Center position on the Y axis
    parameter [9:0] Kirby_X_Min = 10'd203;     // Leftmost point on the X axis
    parameter [9:0] Kirby_X_Max = 10'd436;     // Rightmost point on the X axis
    parameter [9:0] Kirby_Y_Min = 10'd152;     // Topmost point on the Y axis
    parameter [9:0] Kirby_Y_Max = 10'd327;     // Bottommost point on the Y axis
    parameter [9:0] Kirby_X_Move_Step = 10'd2;   // Move step size on the X axis
    parameter [9:0] Kirby_Y_Jump_Step = 10'd8; // Step size on the Y axis -- jump
    parameter [9:0] Kirby_X_Size = 10'd28;     // Kirby's size in X domain
    parameter [9:0] Kirby_Y_Size = 10'd28;     // Kirby's size in Y domain

    parameter [9:0] Kirby_X_Start = 10'd230;
    parameter [9:0] Kirby_Y_Start = 10'd240;

    // parameter [9:0] Kirby_Inhaled_Y_Step = 10'd2;

    logic [9:0] Kirby_X_Pos, Kirby_Y_Pos; // Position in the map
    logic [9:0] Kirby_X_Pos_in, Kirby_Y_Pos_in;
    logic [9:0] Kirby_X_Pixel, Kirby_Y_Pixel; // Index of pixel on the VGA screen
    logic [9:0] Kirby_X_Pixel_in, Kirby_Y_Pixel_in;

    logic frame_clk_delayed, frame_clk_rising_edge;

    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

    // Update registers
    always_ff @ (posedge Clk) begin
        if (Reset)
        begin
            Kirby_X_Pixel <= Kirby_X_Start;
            Kirby_Y_Pixel <= Kirby_Y_Start;
            Kirby_X_Pos <= Kirby_X_Start - Kirby_X_Min;
            Kirby_Y_Pos <= Kirby_Y_Start - Kirby_Y_Min;
        end
        else
        begin
            Kirby_X_Pixel <= Kirby_X_Pixel_in;
            Kirby_Y_Pixel <= Kirby_Y_Pixel_in;
            Kirby_X_Pos <= Kirby_X_Pos_in;
            Kirby_Y_Pos <= Kirby_Y_Pos_in;
        end
    end
    

    always_comb begin
        // By default, keep motion and position unchanged
        Kirby_X_Pixel_in = Kirby_X_Pixel;
        Kirby_Y_Pixel_in = Kirby_Y_Pixel;
        Kirby_X_Pos_in <= Kirby_X_Pos;
        Kirby_Y_Pos_in <= Kirby_Y_Pos;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		      case(keycode)
				
					8'h1A: begin		//w
                        if (Kirby_Y_Pixel_in <= Kirby_Y_Min + Kirby_Y_Jump_Step) begin
                            Kirby_Y_Pixel_in = Kirby_Y_Min;
                        end
                        else begin
                            Kirby_Y_Pixel_in = Kirby_Y_Pixel + (~(Kirby_Y_Jump_Step) + 1'b1);
                            Kirby_Y_Pos_in = Kirby_Y_Pos + (~(Kirby_Y_Jump_Step) + 1'b1);
                        end
					end
							  
					8'h16: begin		//s
						if (Kirby_Y_Pixel_in + Kirby_Y_Jump_Step >= Kirby_Y_Max) begin
                            Kirby_Y_Pixel_in = Kirby_Y_Max;
                        end
                        else begin
                            Kirby_Y_Pixel_in = Kirby_Y_Pixel + Kirby_Y_Jump_Step;
                            Kirby_Y_Pos_in = Kirby_Y_Pos + Kirby_Y_Jump_Step;
                        end
					end
					
					8'h04: begin		//a
						if (Kirby_X_Pixel_in <= Kirby_X_Min + Kirby_X_Move_Step) begin
                            Kirby_X_Pixel_in = Kirby_X_Min;
                        end
                        else begin
                            Kirby_X_Pixel_in = Kirby_X_Pixel + (~(Kirby_X_Move_Step) + 1'b1);
                            Kirby_X_Pos_in = Kirby_X_Pos + (~(Kirby_X_Move_Step) + 1'b1);
                        end
					end
							  
					8'h07: begin		//d
						if (Kirby_X_Pixel_in + Kirby_X_Move_Step >= Kirby_X_Max) begin
                            Kirby_X_Pixel_in = Kirby_X_Max;
                        end
                        else begin
                            Kirby_X_Pixel_in = Kirby_X_Pixel + Kirby_X_Move_Step;
                            Kirby_X_Pos_in = Kirby_X_Pos + Kirby_X_Move_Step;
                        end
					end

					default: ;
				
				endcase
        end
    end
    // Assign to Kirby center pixel position in VGA screen
    // Also decide whether this pixel should draw Kirby or not
    assign KirbyX = Kirby_X_Pixel;
    assign KirbyY = Kirby_Y_Pixel;
    always_comb begin
        if ((DrawX + Left_Dis >= Kirby_X_Pixel) && (DrawX <= Kirby_X_Pixel + Right_Dis) && (DrawY + Up_Dis >= Kirby_Y_Pixel) && (DrawY <= Kirby_Y_Pixel + Bottom_Dis) )
            draw_Kirby = 1'b1;
        else
            draw_Kirby = 1'b0;
    end


endmodule