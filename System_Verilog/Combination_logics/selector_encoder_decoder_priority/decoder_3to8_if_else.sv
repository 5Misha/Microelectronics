module decoder_3to8_if_else(y, x);

input logic [2:0] y;
output [7:0] x;

always_comb begin
    if (y == 3'b000)      x = 8'b00000001;
    else if (y == 3'b001) x = 8'b00000010;
    else if (y == 3'b010) x = 8'b00000100;
    else if (y == 3'b011) x = 8'b00001000;
    else if (y == 3'b100) x = 8'b00010000;
    else if (y == 3'b101) x = 8'b00100000;
    else if (y == 3'b110) x = 8'b01000000;
    else                        x = 8'b10000000;
end

endmodule
