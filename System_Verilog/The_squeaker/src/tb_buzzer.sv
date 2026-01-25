
`timescale 1ns / 1ps // 1ns - единица измерения времени. 1ps - точность шага симуляции
// означает, что #1 это 1ns
module tb_buzzer;

logic clk_t;
logic rst_n_t;
logic btn_up_t;
logic btn_down_t;
logic pwm_out_t;


top DUT (
	.clk(clk_t), 
	.rst_n(rst_n_t), 
	.btn_up(btn_up_t),
	.btn_down(btn_down_t), 
	.pwm_out(pwm_out_t)
);


initial begin 
	clk_t = 0;
	forever #10 clk_t = ~clk_t;
end

initial begin 
	$display("START TEST!");

	$display("reset system");
	rst_n_t = 0;
	btn_up_t = 0;
	btn_down_t = 0;
	#1000;
	
	rst_n_t = 1;
	#1000;
	
	// Проверяем работу на 20 khz
	$display("2. PWM should work at 20 kHz");
	#105000;
	
	// теперь чекнем вычет 1khz при помощи кнопки
	$display("3. testing operation at - 1khz ");
	btn_down_t = 1;
	#1000;
	btn_down_t = 0;
	#2000;

	btn_down_t = 1;
	#1000;
	btn_down_t = 0;
	#2000;

	btn_down_t = 1;
	#1000;
	btn_down_t = 0;
	#2000;

	btn_down_t = 1;
	#1000;
	btn_down_t = 0;
	#2000;

	btn_down_t = 1;
	#1000;
	btn_down_t = 0;
	#2000;

	btn_down_t = 1;
	#1000;
	btn_down_t = 0;
	#100000;
	
	// теперь чекнем прибавку 1khz при помощи кнопки
	$display("3. testing operation at + 1khz ");
	btn_up_t = 1;
	#1000;
	btn_up_t = 0;
	#2000;

	btn_up_t = 1;
	#1000;
	btn_up_t = 0;
	#2000;

	btn_up_t = 1;
	#1000;
	btn_up_t = 0;
	#2000;

	btn_up_t = 1;
	#1000;
	btn_up_t = 0;

	#150000;

	$stop;
end

initial begin
	$display("                  Time | RST | UP | DOWN | PWM ");
	$monitor($time, "   |  %b  | %b  |  %b   |  %b  ", rst_n_t, btn_up_t, btn_down_t, pwm_out_t);
end
endmodule