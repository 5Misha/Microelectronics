module decoder_3to8_case(y, x);

input logic  [2:0] y;
output logic [7:0] x;

always_comb begin
    case (y)
        3'b000: x = 8'b00000001;
        3'b001: x = 8'b00000010;
        3'b010: x = 8'b00000100;
        3'b011: x = 8'b00001000;
        3'b100: x = 8'b00010000;
        3'b101: x = 8'b00100000;
        3'b110: x = 8'b01000000;
        3'b111: x = 8'b10000000;
        default: x = 8'b00000000;
    endcase
end

endmodule
