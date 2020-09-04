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
module  color_mapper ( //input              is_ball,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
					   input        [3:0] idx_area1,idx_area2,idx_area3,
					   input        [3:0] idx_forest,         // idx of color in the palette - forest background
						input        [3:0] idx_kirby, 
					   input logic  [1:0] Map_idx,            // which map to be printed
                  input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                  output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
	 
	 logic [7:0] R_forest, G_forest, B_forest;
	 logic [7:0] R_area, G_area, B_area;
	 logic [7:0] R_kirby,G_kirby,B_kirby;
	 logic [3:0] idx_area[2:0];
	 
	 assign idx_area[0]  = idx_area1; //
	 assign idx_area[1]  = idx_area2;
	 assign idx_area[2]  = idx_area3;
	 
   
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
    begin
		  if (idx_kirby == 4'd0)
			  begin
				  if (idx_area[Map_idx] == 4'd2)
						  begin
								// Background forest with nice color gradient
								Red = R_forest;
								Green = G_forest;
								Blue = B_forest;
					
						  end
				  else
					  begin
							// Background forest with nice color gradient
							Red = R_area;
							Green = G_area;
							Blue = B_area;
					  end

			  end
		  else
			  begin
							Red = R_kirby;
							Green = G_kirby;
							Blue = B_kirby;			  
			  end 
		  
		  
    end
	 palette_kirby kirby(.data_In(idx_kirby), .Red(R_kirby), .Green(G_kirby), .Blue(B_kirby));
	 palette_forest forest(.data_In(idx_forest), .Red(R_forest), .Green(G_forest), .Blue(B_forest));
    palette_area area1(.data_In(idx_area[Map_idx]), .Red(R_area), .Green(G_area), .Blue(B_area));
endmodule
