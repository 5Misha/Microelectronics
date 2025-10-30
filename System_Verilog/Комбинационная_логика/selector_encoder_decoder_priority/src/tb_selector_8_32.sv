`timescale 1ns / 1ps

module tb_selector_8_32;

logic [2:0] st;
logic [31:0] xt [7:0];
logic [31:0] yt_selector_8_32;

top_selector_8_32 DUT ( .s(st), .x(xt), .y_selector_8_32(yt_selector_8_32) );

initial begin 
	 // запишем данные
	 xt[0] = 32'h00000001;
    xt[1] = 32'h00000010;
    xt[2] = 32'h00000100;
    xt[3] = 32'h00001000;
    xt[4] = 32'h00010000;
    xt[5] = 32'h00100000;
    xt[6] = 32'h01000000;
    xt[7] = 32'h10000000;
	 
	     st = 3'b000;
	 #10 st = 3'b001;
	 #10 st = 3'b010;
	 #10 st = 3'b011;
	 #10 st = 3'b100;
	 #10 st = 3'b101;
	 #10 st = 3'b110;
	 #10 st = 3'b111;
end

initial 
	#100 $stop;

initial begin 

	$display("Start test");
	$monitor($time, " s = %b | y = %h", st, yt_selector_8_32);
	$display("x[0]=%h x[1]=%h x[2]=%h x[3]=%h x[4]=%h x[5]=%h x[6]=%h x[7]=%h", xt[0], xt[1], xt[2], xt[3], xt[4], xt[5], xt[6], xt[7]);	
end

endmodule
