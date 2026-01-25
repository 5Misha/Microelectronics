module counter_1bit #(parameter MAX_COUNT = 9)
(
	input logic clk, _rst,
	output logic [3:0] Q,
	output logic carry_out
);

always_ff @(posedge clk, negedge _rst) begin
	if (!_rst) 
		Q <= 0;
		
	else if (Q < MAX_COUNT)
		Q <= Q +1'b1;
		
	else
		Q <= 0;
end

assign carry_out = (Q == MAX_COUNT);

endmodule
