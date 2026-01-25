module param_ring_register #(parameter N = 69)(
		 input logic clk, rst,
		 input logic [1:0] mode, // 00-хранение, 01-влево, 10-вправо, 11-загрузка
		 input logic [N-1:0] data_in,
		 output logic [N-1:0] data_out);

logic [N-1:0] shift_reg;

always_ff @(posedge clk) begin
	if (rst) 
		shift_reg <= '0;
	else begin
		case (mode) 
			2'b00: shift_reg <= shift_reg;
			2'b01: shift_reg <= {shift_reg[N-2:0], shift_reg[N-1]};
			2'b10: shift_reg <= {shift_reg[0], shift_reg[N-1:1]};
			2'b11: shift_reg <= data_in;
			default: shift_reg <= shift_reg;
		endcase
	end
end

assign data_out = shift_reg;

endmodule
