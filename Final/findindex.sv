

module  getkirbyindex
(
		input  [9 :0] DrawX,DrawY,
		input  logic  Direction,
		input  [7 :0] Kirby_Image_X, Kirby_Image_Y,
		input  [7 :0] Kirby_Pos_X, Kirby_Pos_Y,Image_width,
		input  [6 :0] Image_height,
		input  [8 :0] kirby_Width,
		output [17:0] kirbyindex
);
	//always_ff @ (posedge Clk) 
	logic [15 :0] Kirby_Image_Xsize, Kirby_Image_Ysize;
	assign Kirby_Image_Xsize=Kirby_Image_X*Image_width;
	assign Kirby_Image_Ysize=Kirby_Image_Y*Image_height;
	always_comb
		begin
			if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				begin
					if (Direction)
						begin 
							if (DrawY < (152+Kirby_Pos_Y+Image_height) && DrawY >= (152+Kirby_Pos_Y) && DrawX < (203+Kirby_Pos_X+Image_width/2) && DrawX >= (203+Kirby_Pos_X-Image_width/2))
								begin
									kirbyindex= (Kirby_Image_Ysize+DrawY-Kirby_Pos_Y-152)*kirby_Width +Kirby_Image_Xsize+Image_width/2-DrawX+Kirby_Pos_X+202;//-1 for edge {width-1    0-27)
								end 
							else
								begin
									kirbyindex= 0;
								end
						end 
					else
						begin
							if (DrawY < (152+Kirby_Pos_Y+Image_height) && DrawY >= (152+Kirby_Pos_Y) && DrawX < (203+Kirby_Pos_X+Image_width/2) && DrawX >= (203+Kirby_Pos_X-Image_width/2  ))
								begin
									kirbyindex= (Kirby_Image_Ysize+DrawY-Kirby_Pos_Y-152)*kirby_Width + Kirby_Image_Xsize+DrawX-Kirby_Pos_X-203+Image_width/2 ;
								end
							else
								begin
									kirbyindex= 0;
								end
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






module  getstarindex
(	
		input  [9 :0] DrawX,DrawY,
		input  [7 :0] Star_X,Star_Y,
		input  [1 :0] Star_image_X,
		input  logic  Star_Direction,
		output [16:0] starindex
);
 
	logic [15 :0] Image_X, Image_width;
	assign Image_X=24*Star_image_X;
	assign Image_width=24;
	always_comb
		begin
			if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				begin
					if (Star_Direction)
						begin 
							if (DrawY < (152+Star_Y+Image_width) && DrawY >= (152+Star_Y) && DrawX < (203+Star_X+Image_width/2) && DrawX >= (203+Star_X-Image_width/2))
								begin
									starindex= (DrawY-Star_Y-152)*96 +Image_X+Image_width/2-DrawX+Star_X+202;//-1 for edge {width-1    0-27)
								end 
							else
								begin
									starindex= 0;
								end
						end 
					else
						begin
							if (DrawY < (152+Star_Y+Image_width) && DrawY >= (152+Star_Y) && DrawX < (203+Star_X+Image_width/2) && DrawX >= (203+Star_X-Image_width/2  ))
								begin
									starindex= (DrawY-Star_Y-152)*96 + Image_X+DrawX-Star_X-203+Image_width/2 ;
								end
							else
								begin
									starindex= 0;
								end
						end	
				end
			else
				begin
					starindex= 0;
				end
		end
					
	
endmodule



module  getenemyindex
(
		input  [9 :0] DrawX,DrawY,
		input  logic  Enemy_Direction,
		input  [3 :0] Enemy_Image_X, Enemy_Image_Y,
		input  [15 :0] Enemy_Pos_X, Enemy_Pos_Y,
		input  [8 :0] Enemy_Image_width,Enemy_Image_height,
		input  [8 :0] Enemy_Width,
		output [17:0] enemyindex
);
	//always_ff @ (posedge Clk) 
	logic [15 :0] Enemy_Image_Xsize, Enemy_Image_Ysize;
	assign Enemy_Image_Xsize=Enemy_Image_X*Enemy_Image_width;
	assign Enemy_Image_Ysize=Enemy_Image_Y*25;
	always_comb
		begin
			if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				begin
					if (Enemy_Direction)
						begin 
							if (DrawY < (Enemy_Pos_Y+Enemy_Image_height) && DrawY >= Enemy_Pos_Y && DrawX < (Enemy_Pos_X+Enemy_Image_width/2) && DrawX >= (Enemy_Pos_X-Enemy_Image_width/2))
								begin
									enemyindex= (Enemy_Image_Ysize+DrawY-Enemy_Pos_Y)*Enemy_Width +Enemy_Image_Xsize+Enemy_Image_width/2-DrawX+Enemy_Pos_X-1;//-1 for edge {width-1    0-27)
								end 
							else
								begin
									enemyindex= 0;
								end
						end 
					else
						begin
							if (DrawY < (Enemy_Pos_Y+Enemy_Image_height) && DrawY >= (Enemy_Pos_Y) && DrawX < (Enemy_Pos_X+Enemy_Image_width/2) && DrawX >= (Enemy_Pos_X-Enemy_Image_width/2  ))
								begin
									enemyindex= (Enemy_Image_Ysize+DrawY-Enemy_Pos_Y)*Enemy_Width + Enemy_Image_Xsize+DrawX-Enemy_Pos_X+Enemy_Image_width/2;
								end
							else
								begin
									enemyindex= 0;
								end
						end	
				end
			else
				begin
					enemyindex= 0;
				end
		end
	
endmodule




module  getbarindex
(		
		input  [9 :0] DrawX,DrawY,
		input  [2:0]  Health,
		output [16:0] barindex
);
	 logic [15 :0] bar_X, bar_Y,Image_height,Image_width,Enemy_Pos_Y,Enemy_Pos_X;
	 assign bar_X=(6-Health)*25;
	 assign bar_Y=0;
	 assign Image_height = 14;
	 assign Image_width =25;
	 assign Enemy_Pos_Y=300;
	 assign Enemy_Pos_X=220;
	 always_comb 
	 begin
		

        	 if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				 begin
				    if (DrawY < (Enemy_Pos_Y+Image_height) && DrawY >= Enemy_Pos_Y && DrawX < (Enemy_Pos_X+Image_width) && DrawX >= (Enemy_Pos_X))
						 begin
							 barindex = (DrawY-Enemy_Pos_Y) * 175  + (DrawX-Enemy_Pos_X+bar_X);
						 end
					 else
						 begin
							 barindex = 0;
						 end
					
				 end
			  else 
				 begin
					   barindex = 0;
				 end
				 
			 
    end
endmodule




module  startscreen
(		
		input  [9 :0] DrawX,DrawY,
		output [16:0] gamestartindex
);
	 logic [15 :0] Image_height,Image_width,Enemy_Pos_Y,Enemy_Pos_X;

	 assign Image_height = 176;
	 assign Image_width =234;
	 assign Enemy_Pos_Y=152;
	 assign Enemy_Pos_X=203;
	 always_comb 
	 begin
		

        	 if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd203)
				 begin
				    if (DrawY < (Enemy_Pos_Y+Image_height) && DrawY >= Enemy_Pos_Y && DrawX < (Enemy_Pos_X+Image_width) && DrawX >= (Enemy_Pos_X))
						 begin
							 gamestartindex = (DrawY-Enemy_Pos_Y) * 234  + (DrawX-Enemy_Pos_X);
						 end
					 else
						 begin
							 gamestartindex = 0;
						 end
					
				 end
			  else 
				 begin
					   gamestartindex = 0;
				 end
				 
			 
    end
endmodule