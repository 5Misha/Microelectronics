module traffic_light_blink(
    input logic clk_1hz, rst_n,
    output logic red_light, yellow_light, green_light
);

enum logic [1:0] {
    RED_STATE = 2'b00,
    GREEN_STATE = 2'b01,
    YELLOW_STATE = 2'b10
} state, next_state;

localparam RED_CNT = 6;
localparam GREEN_CNT = 10;
localparam YELLOW_CNT = 2;

logic [$clog2(GREEN_CNT+1)-1 : 0] cnt;
logic green_blink; // сигнал для мигания зеленого

// регистр состояний
always_ff @(posedge clk_1hz, negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 0;
        state <= RED_STATE;
    end else begin
        state <= next_state;
        
        if (state != next_state)
            cnt <= 1;
        else
            cnt <= cnt + 1;
    end
end

// логика некст состояния
always_comb begin
    next_state = state;
    
    case (state)
        RED_STATE: begin
            if (cnt >= RED_CNT)
                next_state = GREEN_STATE;
            else
                next_state = RED_STATE;
        end
    
        GREEN_STATE: begin
            if (cnt >= GREEN_CNT)
                next_state = YELLOW_STATE;
            else
                next_state = GREEN_STATE;
        end
        
        YELLOW_STATE: begin
            if (cnt >= YELLOW_CNT)
                next_state = RED_STATE;
            else
                next_state = YELLOW_STATE;
        end
        
        default: next_state = RED_STATE;
    endcase
end

// мигание зеленого
always_ff @(posedge clk_1hz, negedge rst_n) begin
    if (!rst_n) begin
        green_blink <= 1'b0;
    end else begin
        if (state == GREEN_STATE && cnt >= (GREEN_CNT - 4)) begin
            // Последние секунды: мигаем с частотой 1 Гц
            green_blink <= ~green_blink;
        end else begin
            green_blink <= 1'b1;
        end
    end
end

always_comb begin
    red_light = 1'b0;
    yellow_light = 1'b0;
    green_light = 1'b0;
    
    case (state)
        RED_STATE : red_light = 1'b1;
        GREEN_STATE : green_light = green_blink; // Используем мигающий сигнал
        YELLOW_STATE : yellow_light = 1'b1;
        default: red_light = 1'b1;
    endcase
end

endmodule