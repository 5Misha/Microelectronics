module demux_if(x, s, y1, y2, y3);

input  logic [15:0] x;
input  logic [1:0] s;
output logic [15:0] y1;
output logic [15:0] y2;
output logic [15:0] y3;

always_comb begin
	// длеаем все выходы пока 0, чтобы
	// обработать случай при s=11
	y1 = 16'h0000;
	y2 = 16'h0000;
	y3 = 16'h0000;
	
	if (s == 2'b00)
		y1 = x;
	else if (s == 2'b01)
		y2 = x;
	else if (s == 2'b10)
		y3 = x;
	// мы не обрабатываем ситуацию с s=11, чтобы на выходах были везде 0
end

endmodule
	