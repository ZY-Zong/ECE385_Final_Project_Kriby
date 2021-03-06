/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  background1RAM
(
		input [3:0] data_In,
		input [16:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:69519];

initial
begin
	 $readmemh("txt_files/Background1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module  areaRAM
(		
		input [3:0] data_In,
		input [16:0] write_address,input [17:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:213839];

initial
begin
	 $readmemh("txt_files/Area1v3.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  areaRAM2
(
		input [3:0] data_In,
		input [16:0] write_address,input [17:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:171775];

initial
begin
	 $readmemh("txt_files/Area2.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  areaRAM3
(
		input [3:0] data_In,
		input [16:0] write_address,input [17:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:214191];

initial
begin
	 $readmemh("txt_files/Area3.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  Kirby
(
		input [3:0] data_In,
		input [16:0] write_address,input [17:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:25871];

initial
begin
	 $readmemh("txt_files/MoKirby.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module  InholeKirby
(
		input [3:0] data_In,
		input [16:0] write_address,input [17:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:71999];

initial
begin
	 $readmemh("txt_files/InholeKirby.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module  DamageKirby
(
		input [3:0] data_In,
		input [16:0] write_address,input [17:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:95549];

initial
begin
	 $readmemh("txt_files/DamageKirby.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  Stars
(
		input [3:0] data_In,
		input [16:0] write_address,input [16:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:2303];

initial
begin
	 $readmemh("txt_files/Stars.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  Enemy
(
		input [3:0] data_In,
		input [16:0] write_address,input [17:0] read_address,
		input we,Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:71199];

initial
begin
	 $readmemh("txt_files/Enemy.txt", mem);
end


always_ff @ (posedge Clk) begin
   if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule




module  BARRAM
(
		input [3:0] data_In,
		input [16:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:2449];

initial
begin
	 $readmemh("txt_files/Bar.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule




module  GAMESTARTRAM
(
		input [3:0] data_In,
		input [16:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:41183];

initial
begin
	 $readmemh("txt_files/Gamestart.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


//
//module  GAMEENDRAM
//(
//		input [3:0] data_In,
//		input [16:0] write_address, read_address,
//		input we, Clk,
//
//		output logic [3:0] data_Out
//);
//
//// mem has width of 3 bits and a total of 400 addresses
//logic [3:0] mem [0:41183];
//
//initial
//begin
//	 $readmemh("txt_files/Gamestart.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
//	if (we)
//		mem[write_address] <= data_In;
//	data_Out<= mem[read_address];
//end
//
//endmodule