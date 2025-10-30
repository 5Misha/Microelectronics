module top #(parameter N = 69)(
	 input logic clk, rst,
	 input logic [1:0] mode, // 00-хранение, 01-влево, 10-вправо, 11-загрузка
	 input logic [N-1:0] data_in,
	 output logic [N-1:0] data_out);

param_ring_register #(.N(N)) DUT(
	.clk(clk),
	.rst(rst),
	.mode(mode),
	.data_in(data_in),
	.data_out(data_out)
);

endmodule
