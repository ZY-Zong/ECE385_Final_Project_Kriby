module reg_32 ( input  logic Clk,
                             Reset,
							 Load,
			    input  logic [31:0] data_in,
			    output logic [31:0] data_out);

always_ff @ (posedge Clk)
begin
	if (Reset)
		data_out <= 32'h00000000;
   else if (Load)
		data_out <= data_in;
end

endmodule


module reg_16 ( input  logic Clk,
                             Reset,
							 Load,
			    input  logic [15:0] data_in,
			    output logic [15:0] data_out);

always_ff @ (posedge Clk)
begin
	if (Reset)
		data_out <= 16'h0000;
   else if (Load)
		data_out <= data_in;
end

endmodule


module reg_8 ( input  logic Clk,
                             Reset,
							 Load,
			    input  logic [7:0] data_in,
			    output logic [7:0] data_out);

always_ff @ (posedge Clk)
begin
	if (Reset)
		data_out <= 8'h00;
   else if (Load)
		data_out <= data_in;
end

endmodule