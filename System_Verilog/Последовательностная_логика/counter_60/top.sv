module top(
	input logic clk, _rst,
	output logic [7:0] Q
);

counter_2bit_60 DUT(
	.clk(clk),
	._rst(_rst),
	.Q(Q)
);

endmodule
