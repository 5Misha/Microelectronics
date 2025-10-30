module tb_freq_divider;

    logic clk_in;
    logic nrst;
    logic clk_out;
    logic flag_out;
    
    localparam CLK_PERIOD = 10;
    
    div_50M_1 #(.FREG_INPUT(8), .FREG_OUTPUT(1)) dut (.*);
    
    // Clock
    initial begin
        clk_in = 0;
        forever #(CLK_PERIOD/2) clk_in = ~clk_in;
    end
    
    // Test
    initial begin
        // Initialize and reset
        nrst = 0;
        #100;
        nrst = 1;
        
        // Run for enough time to see multiple output periods
        #1000;
        $finish;
    end
    
    // Display results
    initial begin
        $monitor("Time: %4t ns | clk_in: %b | nrst: %b | clk_out: %b | flag_out: %b | cnt: %2d",
                 $time, clk_in, nrst, clk_out, flag_out, dut.cnt);
    end

endmodule