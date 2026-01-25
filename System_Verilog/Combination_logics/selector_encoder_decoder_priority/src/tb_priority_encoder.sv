`timescale 1ns / 1ps

module tb_priority_encoder;

logic [7:0] xt;
logic [2:0] yt_ternar, yt_if_else, yt_case;
logic ft_ternar, ft_if_else, ft_case;

top DUT ( .x(xt), 
	 .y_ternar(yt_ternar), .y_if_else(yt_if_else), .y_case(yt_case),
	 .f_ternar(ft_ternar), .f_if_else(ft_if_else), .f_case(ft_case) );

initial begin

    // Тестирование приоритета (старшие биты имеют приоритет)
        xt = 8'b00000001; // Должен выдать 000
    #10 xt = 8'b00000011; // Должен выдать 001 (бит 1 имеет приоритет над битом 0)
    #10 xt = 8'b00000101; // Должен выдать 010 (бит 2 имеет приоритет)
    #10 xt = 8'b00001000; // Должен выдать 011
    #10 xt = 8'b00011000; // Должен выдать 100 (бит 4 имеет приоритет)
    #10 xt = 8'b00100000; // Должен выдать 101
    #10 xt = 8'b01100000; // Должен выдать 110 (бит 6 имеет приоритет)
    #10 xt = 8'b11000000; // Должен выдать 111 (бит 7 имеет приоритет)
    // Краевые случаи
    #10 xt = 8'b00000000; // Ни один активен
    #10 xt = 8'b11111111; // Все активны - приоритет у бита 7
end

initial 
    #110 $stop;

initial begin 
    $display("Start test");
    $monitor($time, " x = %b | y_ternar = %b, y_if_else = %b, y_case = %b | f_ternar = %b, f_if_else = %b, f_case = %b", xt, yt_ternar, yt_if_else, yt_case, ft_ternar, ft_if_else, ft_case);
end

endmodule