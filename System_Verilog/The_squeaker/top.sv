module top (
    input logic clk,
    input logic rst_n, 
    input logic btn_up,
    input logic btn_down,
    output logic pwm_out
);

buzzer #(
    .CLK_FREQ(50_000_000),
    .MIN_FREQ(1_000),
    .MAX_FREQ(20_000),
    .DEFAULT_FREQ(20_000)
) buzzer_inst (
    .clk(clk),
    .rst_n(rst_n),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .pwm_out(pwm_out)
);

endmodule