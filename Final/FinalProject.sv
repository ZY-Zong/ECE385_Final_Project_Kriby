//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module FinalProject(
             input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
                    );
    
    logic Reset_h, Clk;
    logic [7:0] keycode;
	logic [511:0] Register_Files;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    logic [1:0] hpi_addr, dirc;
    logic [15:0] hpi_data_in, hpi_data_out,count;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     final_nios_system nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset),
							 .kirby_export_export_data(Register_Files)
    );
    
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    // TODO: Fill in the connections for the rest of the modules 
	 
	 logic [9:0] DrawX,DrawY; // for ball
	 logic is_ball;
    VGA_controller vga_controller_instance(.Clk(Clk),.Reset(Reset_h),.*);
    
    // Which signal should be frame_clk?
    ball ball_instance(.Clk(Clk),.Reset(Reset_h),.frame_clk(VGA_VS),.*);
    
    color_mapper color_instance(.*);
	 
	 
	 
	 logic        Direction;
	 logic [1 :0] Map_idx;
	 logic [3 :0] idx_forest;
	 logic [3 :0] idx_area1,idx_area2,idx_area3;
	 logic [3 :0] idx_kirby;
	 logic [15:0] Map_pos_X,Map_pos_Y;
	 logic [16:0] backindex;
	 logic [17:0] areaindex1,areaindex2,areaindex3,kirbyindex;
	 logic [6 :0] Image_height;                     // 28 for 28x28, 30 for 30x30, 60 for 60x30
	 logic [7 :0] Kirby_Image_X, Kirby_Image_Y;
	 logic [7 :0] Kirby_Pos_X, Kirby_Pos_Y,Image_width;
	 
	 
	 
	// kirbyindex kirby_index(.DrawX(DrawX),.DrawY(DrawY),.Clk(Clk),.kirbyindex(kirbyindex));

	 
//	 assign Kirby_Pos_X   = 0;
//  assign Kirby_Pos_Y   = 0;
//	 assign Kirby_Image_X = 1;
//  assign Kirby_Image_Y = 1;
//	 assign Image_height  = 28;
//	 assign Image_width   = 28;
	 
	 //always_comb
//	

	 logic [10:0] Map_Width[2:0];
//	 logic [3:0] idx_area[2:0];
	 //logic [17:0] areaindex[2:0];
	 assign Map_Width[0]  = 11'd1215; //4'd2;
	 assign Map_Width[1]  = 11'd976;
	 assign Map_Width[2]  = 11'd1217;
	 

//	 assign areaindex[0]  = 17'd0; //4'd2;
//	 assign areaindex[1]  = 17'd0;
//	 assign areaindex[2]  = 17'd0;
	 
	 getbackindex  background_index(.*);
	 getkirbyindex kirby_index(.*);
	 getareaindex  the_area_index1(.DrawX(DrawX),.DrawY(DrawY),.Map_pos_X(Map_pos_X),.Map_Wid(Map_Width[0]),.areaindex(areaindex1));
	 getareaindex  the_area_index2(.DrawX(DrawX),.DrawY(DrawY),.Map_pos_X(Map_pos_X),.Map_Wid(Map_Width[1]),.areaindex(areaindex2));
	 getareaindex  the_area_index3(.DrawX(DrawX),.DrawY(DrawY),.Map_pos_X(Map_pos_X),.Map_Wid(Map_Width[2]),.areaindex(areaindex3));
/*
	 always_comb 
	 begin

        	 if (DrawY < 10'd328 && DrawY >= 10'd152 && DrawX < 10'd436 && DrawX >= 10'd202)
				 begin
				    if(Map_pos_X > 16'd117 && ) // TO DO: Add another edge detection
					 begin
						 backindex = (DrawY-152) * 395  + (DrawX-202)+(Map_pos_X-117)/6;// Expand to 4 times
						 areaindex1= (DrawY-152) * 1215 + (DrawX-202)+(Map_pos_X-117);
						 areaindex2= (DrawY-152) * 976  + (DrawX-202)+(Map_pos_X-117);
						 areaindex3= (DrawY-152) * 1217 + (DrawX-202)+(Map_pos_X-117);
					 end
					 else
					 begin
					 
						 backindex = (DrawY-152) * 395  + (DrawX-202);// Expand to 4 times
						 areaindex1= (DrawY-152) * 1215 + (DrawX-202);
						 areaindex2= (DrawY-152) * 976  + (DrawX-202);
						 areaindex3= (DrawY-152) * 1217 + (DrawX-202);
					 end

				 end
			  else 
				 begin
					 backindex = 0;
					 areaindex1= 0;
					 areaindex2= 0;
					 areaindex3= 0;
				 end
				 
			 
    end
*/
    logic [31:0] Register [15:0];
//    logic [7:0] Addr_X, Addr_Y;
//    logic [2:0] Palette_idx;
//    logic [3:0] Color_idx;
//    logic [1:0] Map_idx;

    assign Register[0 ] = Register_Files[31 :0  ];
    assign Register[1 ] = Register_Files[63 :32 ];
    assign Register[2 ] = Register_Files[95 :64 ];
    assign Register[3 ] = Register_Files[127:96 ];
    assign Register[4 ] = Register_Files[159:128];
    assign Register[5 ] = Register_Files[191:160];
    assign Register[6 ] = Register_Files[223:192];
    assign Register[7 ] = Register_Files[255:224];
    assign Register[8 ] = Register_Files[287:256];
    assign Register[9 ] = Register_Files[319:288];
    assign Register[10] = Register_Files[351:320];
    assign Register[11] = Register_Files[383:352];
    assign Register[12] = Register_Files[415:384];
    assign Register[13] = Register_Files[447:416];
    assign Register[14] = Register_Files[479:448];
    assign Register[15] = Register_Files[511:480];


    always_comb 
	 begin
		  Kirby_Pos_X   =  Register[0][31:24];
        Kirby_Pos_Y   =  Register[0][23:16];
		  Map_idx       =  Register[0][ 1: 0];
		  
        Kirby_Image_X =  Register[1][31:24];
        Kirby_Image_Y =  Register[1][23:16];
		  Image_width   =  Register[1][15: 8];
		  Image_height  =  Register[1][ 7: 1];
		  Direction     =  Register[1][0];
		  
		  Map_pos_X     =  Register[2][31:16];
		  Map_pos_Y     =  Register[2][15: 0];
    end

	 Kirby kirby(.data_In(4'b0), 
												  .write_address(17'b0), 
												  .read_address(kirbyindex), 
												  .we(1'b0),.Clk(Clk), .data_Out(idx_kirby));

	 areaRAM area1(.data_In(4'b0), 
												  .write_address(17'b0), 
												  .read_address(areaindex1), 
												  .we(1'b0),.Clk(Clk), .data_Out(idx_area1));
 /*
	 areaRAM2 area2(.data_In(4'b0), 
												  .write_address(17'b0), 
												  .read_address(areaindex2), 
												  .we(1'b0),.Clk(Clk), .data_Out(idx_area2));
												  
												  
	 areaRAM3 area3(.data_In(4'b0), 
												  .write_address(17'b0), 
												  .read_address(areaindex3), 
												  .we(1'b0),.Clk(Clk), .data_Out(idx_area3));		
	 */

	//// Read into ram
	 background1RAM background1_ram(.data_In(4'b0), 
	 								.write_address(17'b0), 
	 								.read_address(backindex), 
	 								.we(1'b0), .Clk(Clk), .data_Out(idx_forest));
    
    // Display keycode on hex display
    HexDriver hex_inst_0 (keycode[3:0], HEX0);
    HexDriver hex_inst_1 (keycode[7:4], HEX1);
	 

endmodule
