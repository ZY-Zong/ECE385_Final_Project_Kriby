/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  getkirbyindex
(
		input  [9 :0] DrawX,DrawY,
		input  [7 :0] Kirby_Image_X, Kirby_Image_Y,
		input  [7 :0] Kirby_Pos_X, Kirby_Pos_Y,Image_width,
		input  [6 :0] Image_height,
		output [17:0] kirbyindex
);
	//always_ff @ (posedge Clk) 
	logic [7 :0] Kirby_Image_Xsize, Kirby_Image_Ysize;
	assign Kirby_Image_Xsize=Kirby_Image_X*Image_width;
	assign Kirby_Image_Ysize=Kirby_Image_Y*Image_height;
	always_comb
		begin
			if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				begin
					if (DrawY < (152+Kirby_Pos_Y+Image_height) && DrawY >= (152+Kirby_Pos_Y) && DrawX < (203+Kirby_Pos_X+Image_width) && DrawX >= (203+Kirby_Pos_X))
						begin
							kirbyindex= (Kirby_Image_Ysize+DrawY-Kirby_Pos_Y-152)*308 + Kirby_Image_Xsize+DrawX-Kirby_Pos_X-203;
						end
					else
						begin
							kirbyindex= 0;
						end	
				end
			else
				begin
					kirbyindex= 0;
				end
		end
	
endmodule

module  getareaindex
(		
		input  [9 :0] DrawX,DrawY,
		input  [15:0] Map_pos_X,
		input  [10:0] Map_Wid,
		output [17:0] areaindex
);
	 always_comb 
	 begin

        	 if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				 begin
				    if(Map_pos_X < 16'd117) // TO DO: Add another edge detection
					 begin
						 areaindex = (DrawY-152) * Map_Wid + (DrawX-203);
						 
					 end
					 else
					 begin
					    if(Map_pos_X <= (Map_Wid-117))
						    begin
								areaindex = (DrawY-152) * Map_Wid + (DrawX-203)+(Map_pos_X-117);
							 end
						 else
							 begin
								areaindex = (DrawY-152) * Map_Wid + (DrawX-437+Map_Wid);
							 end
						 
					 end

				 end
			  else 
				 begin
					   areaindex = 0;
				 end
				 
			 
    end
endmodule


module  getbackindex
(		
		input  [9 :0] DrawX,DrawY,
		input  [15:0] Map_pos_X,
		output [16:0] backindex
);
	 always_comb 
	 begin

        	 if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				 begin
				    if(Map_pos_X < 16'd117) // TO DO: Add another edge detection
					 begin
						 backindex = (DrawY-152) * 395  + (DrawX-203);
						 
					 end
					 else
					 begin
					    if((Map_pos_X-117) <= 16'd966)
						    begin
								backindex = (DrawY-152) * 395  + (DrawX-203)+(Map_pos_X-117)/6;
							 end
						 else
							 begin
								backindex = (DrawY-152) * 395  + (DrawX-203)+161;
							 end
						 
					 end

				 end
			  else 
				 begin
					   backindex = 0;
				 end
				 
			 
    end
endmodule

