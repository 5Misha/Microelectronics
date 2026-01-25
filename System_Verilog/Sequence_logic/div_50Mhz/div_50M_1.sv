module div_50M_1 #(parameter FREG_INPUT = 50_000_000,
									  FREG_OUTPUT = 1)
						(input logic clk_in, nrst,
						 output logic clk_out, flag_out);

localparam COUNT_MAX = FREG_INPUT / FREG_OUTPUT - 1;

logic [$clog2(COUNT_MAX + 1) : 0] cnt;
logic clk_out_penultimate; // задержка выходного сигнала

always_ff @(posedge clk_in, negedge nrst)

	if (!nrst) begin
		cnt <= '0;
		clk_out <= 1'b0;
		
	end else begin
		clk_out_penultimate <= clk_out;
		
		if (cnt >= COUNT_MAX) begin
			cnt <= '0;
			clk_out <= ~clk_out;
			
		end else
			cnt <= cnt + 1'b1;
			
	end

assign flag_out = !clk_out_penultimate && clk_out;
	
endmodule
