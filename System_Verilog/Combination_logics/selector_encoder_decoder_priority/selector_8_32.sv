module selector_8_32(s, x, y);

input logic [2:0] s;
input logic [31:0] x [7:0]; // 8 входов по 32 бита
output logic [31:0] y;

always_comb begin
	case (s)
		3'b000 : y = x[0];
		3'b001 : y = x[1];
		3'b010 : y = x[2];
		3'b011 : y = x[3];
		3'b100 : y = x[4];
		3'b101 : y = x[5];
		3'b110 : y = x[6];
		3'b111 : y = x[7];
		default : y = 32'b0;
	endcase
end

endmodule
