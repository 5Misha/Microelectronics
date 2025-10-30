module priority_encoder_ternar(x, y, f);

input  logic [7:0] x;
output logic [2:0] y;
output logic		 f;

assign y = x[7] ? 3'b111 :
			  x[6] ? 3'b110 :
			  x[5] ? 3'b101 :
			  x[4] ? 3'b100 :
			  x[3] ? 3'b011 :
			  x[2] ? 3'b010 :
			  x[1] ? 3'b001 :
			  x[0] ? 3'b000 : 3'b000;
assign f = |x; // устанавливаем флаг в 0 если на всех входах 0

endmodule
