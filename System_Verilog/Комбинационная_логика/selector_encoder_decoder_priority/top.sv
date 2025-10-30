module top(x, y_ternar, y_if_else, y_case, f_ternar, f_if_else, f_case);

input  logic [7:0] x;
output logic [0:2] y_ternar, y_if_else, y_case;
output logic f_ternar, f_if_else, f_case;

priority_encoder_ternar  U1 ( .x(x), .y(y_ternar), .f(f_ternar) );
priority_encoder_if_else U2 ( .x(x), .y(y_if_else), .f(f_if_else) );
priority_encoder_case    U3 ( .x(x), .y(y_case), .f(f_case) );

endmodule
