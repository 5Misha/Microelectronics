`timescale 1ns/1ps;

module tb_traffic_light;

logic clk_50Mhz_t;
logic rst_n_t;
logic red_light_t;
logic yellow_light_t;
logic green_light_t;

traffic_light_top DUT(
	.clk_50Mhz(clk_50Mhz_t),
	.rst_n(rst_n_t),
	.red_light(red_light_t),
	.yellow_light(yellow_light_t),
	.green_light(green_light_t)
);

initial begin
	clk_50Mhz_t = 0;
	forever #5 clk_50Mhz_t = ~clk_50Mhz_t;
end

initial begin
	rst_n_t = 0;
	#40; 
	rst_n_t = 1;
	
	#50000;
	
	$finish;
end

initial begin
	$monitor("Time: %0t ns | Red: %d | Yellow: %b | Green: %b",
				$time, red_light_t, yellow_light_t, green_light_t);
end

endmodule
