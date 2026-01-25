module buzzer (
		input logic clk, rst_n, btn_up, btn_down,
		output logic pwm_out
);

parameter CLK_FREQ = 50_000_000;
parameter MIN_FREQ = 1_000;
parameter MAX_FREQ = 20_000;
parameter DEFAULT_FREQ = 1_000;

localparam COUNTER_WIDTH = $clog2(CLK_FREQ / MIN_FREQ / 2) + 1;

logic [COUNTER_WIDTH - 1 : 0] counter;
logic [15:0] target_freq; // текущая частота
logic [COUNTER_WIDTH - 1 : 0] half_period; // тк коэффициент заполнения 50 % то ШИМ будет работать на половину
logic btn_up_clean, btn_down_clean;
logic btn_up_pulse, btn_down_pulse;
logic btn_up_delayed, btn_down_delayed;

// антидребезги
// up
antidrebezg #(
		.COUNTER_WIDTH(),
		.COUNTER_MAX()
) debounce_up (
	.clk(clk),
	.rst_n(rst_n),
	.button_in(btn_up),
	.button_out(btn_up_clean)
);
// down
antidrebezg #(
		.COUNTER_WIDTH(),
		.COUNTER_MAX()
) debounce_down (
	.clk(clk),
	.rst_n(rst_n),
	.button_in(btn_down),
	.button_out(btn_down_clean)
);

// детектор фронтов
always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n) begin
		btn_up_pulse <= 1'b0;
		btn_down_pulse <= 1'b0;
		
	end else begin
		btn_up_delayed <= btn_up_clean;
		btn_down_delayed <= btn_down_clean;
		
		btn_up_pulse <= btn_up_clean && !btn_up_delayed;
		btn_down_pulse <= btn_down_clean && !btn_down_delayed;
	end
end


// изменение частот кнопками
always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n) 
		target_freq <= DEFAULT_FREQ;
	else begin
		if (btn_up_pulse && (target_freq < MAX_FREQ))
			target_freq <= target_freq + 1000;
		else if (btn_down_pulse && (target_freq > MIN_FREQ))
			target_freq <= target_freq - 1000;
	end
end

// половинка периода по текущей частоте
always_comb
	half_period = (CLK_FREQ / target_freq) / 2;

// счетчик для ШИМ
always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n) begin
		counter <= '0;
		pwm_out <= 1'b0;
	end else begin
		if (counter >= half_period) begin
			counter <= '0;
			pwm_out <= ~pwm_out;
		end else
			counter <= counter + 1;
	end
end

endmodule
