module top_selector_8_32(s, x, y_selector_8_32);

input logic [2:0] s;
input logic [31:0] x [7:0];
output logic [31:0] y_selector_8_32;

selector_8_32 U ( .s(s), .x(x), .y(y_selector_8_32) );

endmodule
