
module debounce_counter
#(
    parameter COUNTER_WIDTH = 6,
    parameter COUNTER_MAX   = 32
)(
    input  logic clk,
    input  logic rst_n,
    input  logic button_in,
    output logic button_out
);

    logic [COUNTER_WIDTH-1:0] counter;
    logic button_sync;
    logic button_sync_delayed;
    
    // Двухстадийная синхронизация и задержка
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            button_sync <= 1'b0;
            button_sync_delayed <= 1'b0;
        end else begin
            button_sync <= button_in;
            button_sync_delayed <= button_sync;  // Задержанная версия
        end
    end
    
    // Логика антидребезга
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= '0;
            button_out <= 1'b0;
        end else begin
            // Сравниваем текущее и задержанное значение
            if (button_sync != button_sync_delayed) begin
                counter <= '0;  // Сброс при изменении
            end else if (counter >= COUNTER_MAX) begin
                button_out <= button_sync;  // Фиксация стабильного состояния
            end else begin
                counter <= counter + 1;  // Инкремент счетчика
            end
        end
    end

endmodule
