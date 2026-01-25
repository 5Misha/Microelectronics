`timescale 1ns / 1ps

module tb_demux;

logic [1:0] st;
logic [15:0] xt;

logic [15:0] yt1_if;
logic [15:0] yt2_if;
logic [15:0] yt3_if;

logic [15:0] yt1_case;
logic [15:0] yt2_case;
logic [15:0] yt3_case;

top_demux DUT ( .s(st), .x(xt), 
					.y1_if(yt1_if), .y2_if(yt2_if), .y3_if(yt3_if), 
					.y1_case(yt1_case), .y2_case(yt2_case), .y3_case(yt3_case) 
);

initial begin 
		 xt = 16'h432f; st = 2'b10;
	#10 xt = 16'h322A; st = 2'b01;
	#10 xt = 16'h1011; st = 2'b10;
	#10 xt = 16'hABCD; st = 2'b11;
	#10 xt = 16'h010C; st = 2'b00;
end

initial 
	#60 $stop;

initial begin
	$display("Start test");
    $monitor($time, " s = %b and x = %h and y1_if = %h, y2_if = %h, y3_if = %h, y1_case = %h, y2_case = %h, y3_case = %h", st, xt, yt1_if, yt2_if, yt3_if, yt1_case, yt2_case, yt3_case);
end

endmodule
