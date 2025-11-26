module frequency_divider(
	input logic clk_50Mhz, rst_n,
	output logic clk_1hz
);

localparam DIV = 50;
logic [$clog2(DIV+1) - 1 : 0] cnt;

always_ff @(posedge clk_50Mhz, negedge rst_n) begin
	if (!rst_n) begin
		cnt <= 0;
		clk_1hz <= 0;
	end else begin
		if (cnt >= DIV - 1) begin
			clk_1hz <= ~clk_1hz;
			cnt <= 0;
		end else
			cnt <= cnt + 1;
	end
end

endmodule
