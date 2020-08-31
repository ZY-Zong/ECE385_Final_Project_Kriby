
module  Kirby ( input         Clk,                // 50 MHz clock
                              Reset,              // Active-high reset signal
                              frame_clk,          // The clock indicating a new frame (~60Hz)
                input [9:0]   DrawX, DrawY,       // Current pixel coordinates
			    input [7:0]   keycode,        // Key pressed in the keyboard (8-bit)
                output logic  is_ball             // Whether current pixel belongs to ball or background
              );

    
endmodule
