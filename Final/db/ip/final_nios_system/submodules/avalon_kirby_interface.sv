/**
 *	Avalon-MM Interface for Drawing
 *
 *
 *	Assignment of 0-15 registers, SOME MAY NOT BE USED:
 *  0: 
 *  1: Addr_X
 *  2: Addr_Y
 *  3: Palette_idx
 *  4: Color_idx
 *  5: Map_idx
 *  6:
 *  7:
 *  etc...
 */

module avalon_kirby_interface (
    // Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,				// Avalon-MM Read
	input  logic AVL_WRITE,				// Avalon-MM Write
	input  logic AVL_CS,				// Avalon-MM Chip Select
	input  logic [3:0] AVL_ADDR,		// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data

    // Defined for game logic
    // output logic [7:0] Addr_X, Addr_Y,  // pixel location on true screen
    // output logic [2:0] Palette_idx,     // index of palette
    // output logic [3:0] Color_idx,       // index of color in palette
	// output logic [1:0] Map_idx          // which map to be printed
    // output logic w_enable, Frame_Done   // Used for double frame buffer
	output logic [511:0] Register_Files
);

logic [31:0] Reg [15:0];
// logic Frame_Done_in;

always_ff @(posedge CLK) begin
	if(RESET) begin
		Reg[0 ] <= 32'h0;
			Reg[1 ] <= 32'h0;
			Reg[2 ] <= 32'h0;
			Reg[3 ] <= 32'h0;
			Reg[4 ] <= 32'h0;
			Reg[5 ] <= 32'h0;
			Reg[6 ] <= 32'h0;
			Reg[7 ] <= 32'h0;
			Reg[8 ] <= 32'h0;
			Reg[9 ] <= 32'h0;
			Reg[10] <= 32'h0;
			Reg[11] <= 32'h0;
			Reg[12] <= 32'h0;
			Reg[13] <= 32'h0;
			Reg[14] <= 32'h0;
			Reg[15] <= 32'h0;
	end
	
	else if(AVL_WRITE && AVL_CS) begin
		Reg[AVL_ADDR] <= AVL_WRITEDATA;
	end
end


always_comb begin
	// Addr_X = Reg[1][7:0];
	// Addr_Y = Reg[2][7:0];
	// Palette_idx = Reg[3][2:0];
	// Color_idx = Reg[4][3:0];
	// Map_idx = Reg[5][1:0];
	Register_Files = {Reg[15], Reg[14], Reg[13], Reg[12], Reg[11], Reg[10], Reg[9], Reg[8], Reg[7], Reg[6], Reg[5], Reg[4],, Reg[3],, Reg[2],, Reg[1], , Reg[0]};
	AVL_READDATA = (AVL_CS && AVL_READ) ? Reg[AVL_ADDR] : 32'b0;
end

endmodule