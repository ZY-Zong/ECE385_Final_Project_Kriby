module palette_area (
	input  logic [3:0] data_In,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red   = R;
	assign Green = G;
	assign Blue  = B;

	always_comb
	begin
		case(data_In)
		4'b0000:
		begin
			R = 8'hff;
			G = 8'hff;
			B = 8'hff;
		end
		4'b0001:
		begin
			R = 8'hf0;
			G = 8'ha0;
			B = 8'h10;
		end
		4'b0010:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0011:
		begin
			R = 8'h40;
			G = 8'h98;
			B = 8'h58;
		end
		4'b0100:
		begin
			R = 8'h08;
			G = 8'h09;
			B = 8'h90;
		end
		4'b0101:
		begin
			R = 8'hf8;
			G = 8'ha0;
			B = 8'he0;
		end
		4'b0110:
		begin
			R = 8'ha0;
			G = 8'h50;
			B = 8'hd8;
		end
		4'b0111:
		begin
			R = 8'h88;
			G = 8'he0;
			B = 8'hf8;
		end
		4'b1000:
		begin
			R = 8'h68;
			G = 8'hf8;
			B = 8'h00;
		end
		4'b1001:
		begin
			R = 8'ha5;
			G = 8'h7d;
			B = 8'hc6;
		end
		4'b1010:
		begin
			R = 8'hcb;
			G = 8'hc6;
			B = 8'he4;
		end
		4'b1011:
		begin
			R = 8'he0;
			G = 8'he0;
			B = 8'hf0;
		end
		4'b1100:
		begin
			R = 8'h90;
			G = 8'he0;
			B = 8'hf3;
		end
		4'b1101:
		begin
			R = 8'h99;
			G = 8'he5;
			B = 8'hf4;
		end
		4'b1110:
		begin
			R = 8'h3a;
			G = 8'h84;
			B = 8'hb7;
		end
		4'b1111:
		begin
			R = 8'h0c;
			G = 8'h3e;
			B = 8'hbd;
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



module palette_forest (
	input  logic [3:0] data_In,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red   = R;
	assign Green = G;
	assign Blue  = B;

	always_comb
	begin
		case(data_In)
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


module palette_kirby (
	input  logic [3:0] data_In,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red   = R;
	assign Green = G;
	assign Blue  = B;

	always_comb
	begin
		case(data_In)
		4'b0000:
		begin
			R = 8'hcf;
			G = 8'hb0;
			B = 8'hff;
		end
		4'b0001:
		begin
			R = 8'h0f;
			G = 8'h08;
			B = 8'h0f;
		end
		4'b0010:
		begin
			R = 8'hd0;
			G = 8'h00;
			B = 8'h50;
		end
		4'b0011:
		begin
			R = 8'hff;
			G = 8'ha0;
			B = 8'hdf;
		end
		4'b0100:
		begin
			R = 8'hf0;
			G = 8'h70;
			B = 8'ha0;
		end
		4'b0101:
		begin
			R = 8'h60;
			G = 8'h10;
			B = 8'h10;
		end
		4'b0110:
		begin
			R = 8'hff;
			G = 8'hf8;
			B = 8'hff;
		end
		4'b0111:
		begin
			R = 8'hef;
			G = 8'he8;
			B = 8'hd0;
		end
		4'b1000:
		begin
			R = 8'hbf;
			G = 8'hb8;
			B = 8'h9f;
		end
		4'b1001:
		begin
			R = 8'h0f;
			G = 8'hf0;
			B = 8'hff;
		end
		4'b1010:
		begin
			R = 8'hff;
			G = 8'hf8;
			B = 8'h00;
		end
		4'b1011:
		begin
			R = 8'hff;
			G = 8'h68;
			B = 8'h2f;
		end
		4'b1100:
		begin
			R = 8'h00;
			G = 8'ha0;
			B = 8'h90;
		end
		4'b1101:
		begin
			R = 8'hff;
			G = 8'h90;
			B = 8'hc0;
		end
		4'b1110:
		begin
			R = 8'hff;
			G = 8'h20;
			B = 8'h00;
		end
		4'b1111:
		begin
			R = 8'h60;
			G = 8'h10;
			B = 8'h10;
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


module palette_enemy (
	input  logic [3:0] data_In,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red   = R;
	assign Green = G;
	assign Blue  = B;

	always_comb
	begin
		case(data_In)
		4'b0000:
		begin
			R = 8'h00;
			G = 8'hdb;
			B = 8'hff;
		end
		4'b0001:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0010:
		begin
			R = 8'hde;
			G = 8'hfb;
			B = 8'hff;
		end
		4'b0011:
		begin
			R = 8'h52;
			G = 8'he3;
			B = 8'hb5;
		end
		4'b0100:
		begin
			R = 8'h00;
			G = 8'h71;
			B = 8'h4a;
		end
		4'b0101:
		begin
			R = 8'hff;
			G = 8'h92;
			B = 8'h42;
		end
		4'b0110:
		begin
			R = 8'hff;
			G = 8'hdb;
			B = 8'h8c;
		end
		4'b0111:
		begin
			R = 8'hc6;
			G = 8'h00;
			B = 8'h00;
		end
		4'b1000:
		begin
			R = 8'hff;
			G = 8'h49;
			B = 8'h08;
		end
		4'b1001:
		begin
			R = 8'hff;
			G = 8'heb;
			B = 8'h8c;
		end
		4'b1010:
		begin
			R = 8'hff;
			G = 8'hc3;
			B = 8'h08;
		end
		4'b1011:
		begin
			R = 8'hb5;
			G = 8'h8a;
			B = 8'h08;
		end
		4'b1100:
		begin
			R = 8'hbd;
			G = 8'hba;
			B = 8'hbd;
		end
		4'b1101:
		begin
			R = 8'h00;
			G = 8'h92;
			B = 8'h63;
		end
		4'b1110:
		begin
			R = 8'hb5;
			G = 8'hfb;
			B = 8'hff;
		end
		4'b1111:
		begin
			R = 8'h42;
			G = 8'h10;
			B = 8'h21;
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





module palette_start (
	input  logic [3:0] data_In,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red   = R;
	assign Green = G;
	assign Blue  = B;

	always_comb
	begin
		case(data_In)
		4'b0000:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0001:
		begin
			R = 8'h0f;
			G = 8'h31;
			B = 8'h9d;
		end
		4'b0010:
		begin
			R = 8'h70;
			G = 8'haa;
			B = 8'hff;
		end
		4'b0011:
		begin
			R = 8'h86;
			G = 8'hb8;
			B = 8'hff;
		end
		4'b0100:
		begin
			R = 8'h96;
			G = 8'hc9;
			B = 8'hff;
		end
		4'b0101:
		begin
			R = 8'h4a;
			G = 8'h42;
			B = 8'haf;
		end
		4'b0110:
		begin
			R = 8'hf8;
			G = 8'h91;
			B = 8'h35;
		end
		4'b0111:
		begin
			R = 8'hf8;
			G = 8'hf8;
			B = 8'hf8;
		end
		4'b1000:
		begin
			R = 8'hb0;
			G = 8'hf0;
			B = 8'hf8;
		end
		4'b1001:
		begin
			R = 8'h97;
			G = 8'h1f;
			B = 8'h29;
		end
		4'b1010:
		begin
			R = 8'hde;
			G = 8'hd2;
			B = 8'he6;
		end
		4'b1011:
		begin
			R = 8'he5;
			G = 8'hc7;
			B = 8'h43;
		end
		4'b1100:
		begin
			R = 8'hf4;
			G = 8'hd8;
			B = 8'h77;
		end
		4'b1101:
		begin
			R = 8'h6d;
			G = 8'hc4;
			B = 8'h80;
		end
		4'b1110:
		begin
			R = 8'ha4;
			G = 8'h9e;
			B = 8'ha0;
		end
		4'b1111:
		begin
			R = 8'h86;
			G = 8'hf9;
			B = 8'hc2;
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

