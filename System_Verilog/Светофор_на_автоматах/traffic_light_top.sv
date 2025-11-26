module traffic_light_top (
	input logic clk_50Mhz, rst_n,
	output logic red_light, yellow_light, green_light
);

logic clk_1hz;

frequency_divider U1(
	.clk_50Mhz(clk_50Mhz),
	.rst_n(rst_n),
	.clk_1hz(clk_1hz)
);

traffic_light_blink U2(
	.clk_1hz(clk_1hz),
	.rst_n(rst_n),
	.red_light(red_light),
	.yellow_light(yellow_light),
	.green_light(green_light)
);

endmodule
