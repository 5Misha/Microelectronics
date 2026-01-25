module top(
	input logic clk, _rst,
	output logic [7:0] Q
);

// Создаем экземпляр тестируемого модуля
counter_2bit dut(
    .clk(clk),
    ._rst(_rst),
    .Q(Q)
);

endmodule
