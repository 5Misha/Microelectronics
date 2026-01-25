module counter_2bit_60 (
	input logic clk, _rst,
	output logic [7:0] Q
	);

logic [3:0] units, tens;
logic carry_units;
logic carry_delayed;  // Задержанный сигнал переноса

counter_1bit #(.MAX_COUNT(9)) units_counter(
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

counter_1bit #(.MAX_COUNT(5)) tens_counter(
	.clk(carry_delayed),
	._rst(_rst),
	.Q(tens),
	.carry_out()
	);

assign Q = {tens, units};

endmodule