module top #(
	parameter WIDTH = 16,
	parameter START_BITS = 16'b1010_0010_1100_0001
)(
	input logic clk,
	input logic rst,
	input logic enable,
	output logic [WIDTH-1 : 0] random_out_f, 
	output logic [WIDTH-1 : 0] random_out_g
);

rslos_fibonachi U1 ( .clk(clk), .rst(rst), .enable(enable), .random_out(random_out_f) );

rslos_galya U2 ( .clk(clk), .rst(rst), .enable(enable), .random_out(random_out_g) );

endmodule
