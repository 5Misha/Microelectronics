module rslos_galya #(
	parameter WIDTH = 16,
	parameter START_BITS = 16'b1010_0010_1100_0001
)(
	input logic clk,
	input logic rst,
	input logic enable,
	output logic [WIDTH-1 : 0] random_out
);

logic [WIDTH-1 : 0] x;
logic bit_after_os;

assign bit_after_os = x[0];

always_ff @(posedge clk, posedge rst) begin
	if (rst)
		x <= 16'hA2C1;
	else if (enable) begin
			// Реализация РСЛОС Галуа
			x[0]  <= x[15];
			x[1]  <= x[0];
			x[2]  <= x[1];
			x[3]  <= x[2];
			x[4]  <= x[3] ^ x[15];
			x[5]  <= x[4];
			x[6]  <= x[5];
			x[7]  <= x[6];
			x[8]  <= x[7];
			x[9]  <= x[8];
			x[10] <= x[9] ^ x[15];
			x[11] <= x[10] ^ x[15];
			x[12] <= x[11] ^ x[15];
			x[13] <= x[12];
			x[14] <= x[13];
			x[15] <= x[14];
	end
end

assign random_out = x;

endmodule
