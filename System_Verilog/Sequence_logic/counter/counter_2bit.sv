module counter_2bit (
	input logic clk, _rst,
	output logic [7:0] Q
);

logic [3:0] units, tens;
logic carry_units; // перенос единиц
logic carry_delayed; // задержка для десятков

// подключаем одноразрядный счетчик для единиц
counter_1bit units_counter(
	.clk(clk),
	._rst(_rst),
	.Q(units),
	.carry_out(carry_units)
);

// Регистр для задержки сигнала переноса на один такт
always_ff @(posedge clk, negedge _rst) begin
	if (!_rst)
		carry_delayed <= 0;
	else
		carry_delayed <= carry_units;
end


// и второй одноразр счетчик будет для десятков
counter_1bit tens_counter(
	.clk(carry_delayed), // клок работает по единицам
	._rst(_rst),
	.Q(tens), // каждый перенос в десяток считывается
	.carry_out()
);

assign Q = {tens, units}; // обединяем выходы в одну шину

endmodule
