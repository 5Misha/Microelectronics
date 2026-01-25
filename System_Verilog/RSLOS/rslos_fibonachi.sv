module rslos_fibonachi #(
	parameter WIDTH = 16,
	parameter START_BITS = 16'b1010_0010_1100_0001
)(
	input logic enable,
	input logic clk,
	input logic rst,
	output logic [WIDTH-1 : 0] random_out
);
	
logic [WIDTH-1 : 0] x;
logic bit_after_os;

assign bit_after_os = x[11] ^ x[10] ^ x[9] ^ x[3];

always_ff @(posedge clk, posedge rst) begin
	if (rst)
		x <= 16'hA2C1;
	else if (enable)
		x <= {bit_after_os, x[WIDTH-1 : 1]};
end

assign random_out = x;

endmodule
