module palatte_area (
	input  logic [2:0] DATA_IN,
	output logic [7:0] RED, GREEN, BLUE
);

	logic [7:0] R, G, B;

	assign RED = R;
	assign GREEN = G;
	assign BLUE = B;

	always_comb
	begin
		case(DATA_IN)
		3'b000:
		begin
			R = 8'hff;
			G = 8'hff;
			B = 8'hff;
		end
		3'b001:
		begin
			R = 8'hf0;
			G = 8'ha0;
			B = 8'h10;
		end
		3'b010:
		begin
			R = 8'h70;
			G = 8'hf8;
			B = 8'h08;
		end
		3'b011:
		begin
			R = 8'h40;
			G = 8'h98;
			B = 8'h58;
		end
		3'b100:
		begin
			R = 8'h08;
			G = 8'h09;
			B = 8'h90;
		end
		3'b101:
		begin
			R = 8'hf8;
			G = 8'ha0;
			B = 8'he0;
		end
		3'b110:
		begin
			R = 8'ha0;
			G = 8'h50;
			B = 8'hd8;
		end
		3'b111:
		begin
			R = 8'h88;
			G = 8'he0;
			B = 8'hf8;
		end
		default:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		endcase
	end
endmodule



module palatte_forest (
	input  logic [3:0] DATA_IN,
	output logic [7:0] RED, GREEN, BLUE
);

	logic [7:0] R, G, B;

	assign RED = R;
	assign GREEN = G;
	assign BLUE = B;

	always_comb
	begin
		case(DATA_IN)
		4'b0000:
		begin
			R = 8'hf8;
			G = 8'hf8;
			B = 8'hd8;
		end
		4'b0001:
		begin
			R = 8'ha8;
			G = 8'he8;
			B = 8'hf8;
		end
		4'b0010:
		begin
			R = 8'h68;
			G = 8'hb0;
			B = 8'h78;
		end
		4'b0011:
		begin
			R = 8'h68;
			G = 8'ha0;
			B = 8'h70;
		end
		4'b0100:
		begin
			R = 8'h78;
			G = 8'hf8;
			B = 8'ha8;
		end
		4'b0101:
		begin
			R = 8'ha8;
			G = 8'hc8;
			B = 8'he0;
		end
		4'b0110:
		begin
			R = 8'hf8;
			G = 8'hf8;
			B = 8'hf8;
		end
		4'b0111:
		begin
			R = 8'h98;
			G = 8'hc8;
			B = 8'hf8;
		end
		4'b1000:
		begin
			R = 8'he0;
			G = 8'hf8;
			B = 8'hf8;
		end
		4'b1001:
		begin
			R = 8'hd8;
			G = 8'he8;
			B = 8'hf8;
		end
		4'b1010:
		begin
			R = 8'hc8;
			G = 8'hd8;
			B = 8'he0;
		end
		4'b1011:
		begin
			R = 8'hd8;
			G = 8'hf8;
			B = 8'hf8;
		end
		4'b1100:
		begin
			R = 8'ha0;
			G = 8'hd8;
			B = 8'hf8;
		end
		4'b1101:
		begin
			R = 8'h90;
			G = 8'hb8;
			B = 8'hf8;
		end
		4'b1110:
		begin
			R = 8'ha0;
			G = 8'hd0;
			B = 8'hf8;
		end
		4'b1111:
		begin
			R = 8'hc8;
			G = 8'hf0;
			B = 8'hf8;
		end
		default:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		endcase
	end
endmodule