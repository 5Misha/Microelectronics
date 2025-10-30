module top (
	input logic clk_in, nrst,
	output logic clk_out, flag_out
);

div_50M_1 #(.FREG_INPUT(8), 
				.FREG_OUTPUT(1)) 
		  DUT(.clk_in(clk_in),
				.nrst(nrst),
				.clk_out(clk_out),
				.flag_out(flag_out));
endmodule
