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
					   input        [3:0] idx_star, 
						input logic        Star_appear,
					   input        [3:0] idx_kirby,idx_inholekirby,idx_damagekirby,idx_monkey,idx_fire,idx_lemon,idx_lightning, 
					   input logic  [1:0] Map_idx,Kirby_state,            // which map to be printed
                  input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                  output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
	 
	 logic [7:0] R_forest, G_forest, B_forest;
	 logic [7:0] R_area, G_area, B_area;
	 logic [7:0] R_kirby,G_kirby,B_kirby;
	 logic [7:0] R_star,G_star,B_star;
	 
	 logic [7:0] R_monkey,G_monkey,B_monkey;
	 logic [7:0] R_lemon,G_lemon,B_lemon;
	 logic [7:0] R_fire,G_fire,B_fire;
	 logic [7:0] R_lightning,G_lightning,B_lightning;

	 logic [3:0] idx_area[2:0];
	 logic [3:0] index_kirby[2:0];
	 
	 assign idx_area[0]  = idx_area1; //4'd2;//
	 assign idx_area[1]  = idx_area2;
	 assign idx_area[2]  = idx_area3;

	 assign index_kirby[0]  = idx_kirby;
	 assign index_kirby[1]  = idx_inholekirby;
	 assign index_kirby[2]  = idx_damagekirby;
	 
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
    begin
		  if(idx_star== 4'd0 || Star_appear==0)
			  begin
				  if ((index_kirby[Kirby_state] == 4'd0)&&(idx_monkey==4'd0)&&(idx_fire==4'd0)&&(idx_lemon==4'd0)&& (idx_lightning==4'd0))
				  //if (index_kirby[2] == 4'd0)
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
						if	(index_kirby[Kirby_state] != 4'd0)
						  begin
										Red = R_kirby;
										Green = G_kirby;
										Blue = B_kirby;			  
						  end 
						else
							begin
								if(idx_lemon!=4'd0)
									begin
										Red = R_lemon;
										Green = G_lemon;
										Blue = B_lemon;		

									end
								else
									begin
										if (idx_monkey!=4'd0)
											begin
												Red = R_monkey;
									         Green = G_monkey;
										      Blue = B_monkey;	
											end
										else
											begin
												if (idx_fire!=4'd0)
													begin
														Red = R_fire;
														Green = G_fire;
														Blue = B_fire;
													
													end
												else
													begin
														if (idx_lightning!=4'd0)
															begin 
																Red = R_lightning;
																Green = G_lightning;
																Blue = B_lightning;
															end
														else
															begin
															   //  impossible situation
																Red = 8'h00;;
																Green = 8'h00;;
																Blue = 8'h00;;												
															end
													end
											end
									end
								
							
							end
						  
				  end
			  end
		  else
			  begin
					Red = R_star;
					Green = G_star;
					Blue = B_star;
			  end
		  
    end
	 palette_kirby kirby(.data_In(index_kirby[Kirby_state]), .Red(R_kirby), .Green(G_kirby), .Blue(B_kirby));
	 palette_kirby star(.data_In(idx_star), .Red(R_star), .Green(G_star), .Blue(B_star));
	 palette_forest forest(.data_In(idx_forest), .Red(R_forest), .Green(G_forest), .Blue(B_forest));
    palette_area area1(.data_In(idx_area[Map_idx]), .Red(R_area), .Green(G_area), .Blue(B_area));
	 
	 palette_enemy lemon(.data_In(idx_lemon), .Red(R_lemon), .Green(G_lemon), .Blue(B_lemon));
	 palette_enemy monkey(.data_In(idx_monkey), .Red(R_monkey), .Green(G_monkey), .Blue(B_monkey));
	 palette_enemy fire(.data_In(idx_fire), .Red(R_fire), .Green(G_fire), .Blue(B_fire));
	 palette_enemy lightning(.data_In(idx_lightning), .Red(R_lightning), .Green(G_lightning), .Blue(B_lightning));
endmodule
