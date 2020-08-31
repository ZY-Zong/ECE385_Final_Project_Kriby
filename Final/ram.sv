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
		input [17:0] read_address,
		input Clk,
		output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:213839];

initial
begin
	 $readmemh("txt_files/Area1.txt", mem);
end


always_ff @ (posedge Clk) begin
		data_Out<= mem[read_address];
end

endmodule
