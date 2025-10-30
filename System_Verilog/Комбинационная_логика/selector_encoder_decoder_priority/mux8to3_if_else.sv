module mux8to3_if_else(D, S, F);

input  logic [7:0] D;
input  logic [2:0] S;
output logic 		 F;

always_comb begin
	if (S == 3'b000)
		F = D[0];
	else if (S == 2'b001)
		F = D[1];
	else if (S == 2'b010)
		F = D[2];
	else if (S == 2'b011)
		F = D[3];
	else if (S == 2'b100)
		F = D[4];
	else if (S == 2'b101)
		F = D[5];
	else if (S == 2'b110)
		F = D[6];
	else if (S == 2'b111)
		F = D[7];
	else
		F = D[0];
end

endmodule
		