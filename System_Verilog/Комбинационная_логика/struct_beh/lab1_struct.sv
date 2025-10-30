module lab1_struct(x, y);

input  logic [2:0] x;
output logic [1:0] y;

logic [1:0] w;

xor(w[0], x[0], x[1]);
and(w[1], x[1], x[2]);

nand(y[0], w[0], w[1]);
nand(y[1], x[0], x[2]);

endmodule 