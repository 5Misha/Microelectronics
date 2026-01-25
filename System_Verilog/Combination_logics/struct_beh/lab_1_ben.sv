module lab1_ben(x, y);

input logic [2:0] x;
output logic [1:0] y;

assign y[0] = ~( (x[0]^x[1]) & (x[1]&x[2]) );
assign y[1] = ~(x[0] & x[2]);

endmodule 