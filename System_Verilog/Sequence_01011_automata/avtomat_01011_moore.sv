module avtomat_01011_moore(
	input logic x, clk, rst_n,
	output logic y
);

enum logic [2:0] {
	S0 = 3'b000,
	S1 = 3'b001,
	S2 = 3'b010,
	S3 = 3'b011,
	S4 = 3'b100,
	S5 = 3'b101
} state, next_state;

// регистр состояния 
always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		state <= S0;
	else
		state <= next_state;
end

// логика некст сост
always_comb begin
	next_state = state;
	
	case (state)
		S0 : next_state = (x == 1'b1) ? S0 : S1;
		S1 : next_state = (x == 1'b1) ? S2 : S1;
		S2 : next_state = (x == 1'b1) ? S0 : S3;
		S3 : next_state = (x == 1'b1) ? S4 : S1;
		S4 : next_state = (x == 1'b1) ? S5 : S3;
		S5 : next_state = (x == 1'b1) ? S0 : S1;
		default : next_state = S0;
	endcase
end

// логика выходов
always_comb begin
	y = (state == S5) ? 1'b1 : 1'b0;
end

endmodule
