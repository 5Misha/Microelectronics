module priority_encoder_case(x, y, f);

input logic [7:0] x;
output logic [2:0] y;
output logic f;

always_comb begin
    casez (x)  // casex создает регулярное выражение
        8'b1???????: begin y = 3'b111; f = 1'b1; end
        8'b01??????: begin y = 3'b110; f = 1'b1; end
        8'b001?????: begin y = 3'b101; f = 1'b1; end
        8'b0001????: begin y = 3'b100; f = 1'b1; end
        8'b00001???: begin y = 3'b011; f = 1'b1; end
        8'b000001??: begin y = 3'b010; f = 1'b1; end
        8'b0000001?: begin y = 3'b001; f = 1'b1; end
        8'b00000001: begin y = 3'b000; f = 1'b1; end
        default:     begin y = 3'b000; f = 1'b0; end
    endcase
end

endmodule
