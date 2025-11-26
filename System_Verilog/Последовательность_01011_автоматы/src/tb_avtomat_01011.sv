`timescale 1ns/1ps;

module tb_avtomat_01011;

logic enable_t;
logic clk_t;
logic rst_n_t;
logic y_moore_t;
logic random_out_t;

// Счетчик обнаруженных последовательностей
int sequence_count = 0;

top_avtomat_01011 DUT(
	.enable(enable_t),
	.clk(clk_t),
	.rst_n(rst_n_t),
	.y_moore(y_moore_t),
	.random_out(random_out_t)
);

initial begin
	clk_t = 0;
	forever #5 clk_t = ~clk_t;
end

initial begin
    	enable_t = 0;
    	rst_n_t = 0;
    	sequence_count = 0;

	#20;
	rst_n_t = 1;
	enable_t = 1;
	
	#10000;

	$display("Discovered %0d subsequences'01011'", sequence_count);
	$finish;
end

// Подсчет обнаруженных последовательностей
always @(posedge clk_t) begin
    if (rst_n_t && y_moore_t) begin
        sequence_count <= sequence_count + 1;
        $display("%0t | %b | %b | %0d", 
                 $time, random_out_t, y_moore_t, sequence_count + 1);
    end
end

initial begin
	$monitor("Time: %0t ns | y_moore: %b | random_out: %b",
				$time, y_moore_t, random_out_t);
end

endmodule
