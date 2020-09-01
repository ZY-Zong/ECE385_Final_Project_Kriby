//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input              is_ball,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
							  input        [3:0] idx_area1,
							  input        [3:0] idx_forest,         // idx of color in the palette - forest background
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
	 
	 logic [7:0] R_forest, G_forest, B_forest;
	 logic [7:0] R_area1, G_area1, B_area1;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
    begin
		  if (idx_area1 == 10'd2)
				  begin
						// Background forest with nice color gradient
						Red = R_forest;
						Green = G_forest;
						Blue = B_forest;
//						       if (is_ball == 1'b1) 
//        begin
//            // White ball
//            Red = 8'hff;
//            Green = 8'hff;
//            Blue = 8'hff;
//        end
//		  else 
				  end
		  else
			  begin
					// Background forest with nice color gradient
					Red = R_area1;
					Green = G_area1;
					Blue = B_area1;
			  end
		  
    end
	 
	 palette_forest forest(.data_In(idx_forest), .Red(R_forest), .Green(G_forest), .Blue(B_forest));
    palette_area area1(.data_In(idx_area1), .Red(R_area1), .Green(G_area1), .Blue(B_area1));
endmodule
