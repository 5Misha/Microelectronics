module top_demux(
	input logic [1:0] s,
	input logic [15:0] x,
	
	output logic [15:0] y1_if,
	output logic [15:0] y2_if,
	output logic [15:0] y3_if,
	
	output logic [15:0] y1_case,
	output logic [15:0] y2_case,
	output logic [15:0] y3_case
);

demux_if U1 ( .s(s), .x(x), .y1(y1_if), .y2(y2_if), .y3(y3_if) );
demux_case U2 ( .s(s), .x(x), .y1(y1_case), .y2(y2_case), .y3(y3_case) );

endmodule
