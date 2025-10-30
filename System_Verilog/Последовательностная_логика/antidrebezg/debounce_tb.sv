module debounce_tb;

    logic clk;
    logic rst_n;
    logic button_in;
    logic button_out;
    
    // Создание экземпляра тестируемого модуля
    debounce_counter #(
        .COUNTER_WIDTH(4),
		  .COUNTER_MAX(15)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .button_in(button_in),
        .button_out(button_out)
    );
    
    // Генерация тактового сигнала
    always #10 clk = ~clk; // 50 МГц
    
    // Тестовые воздействия
    initial begin
        // Инициализация
        clk = 0;
        rst_n = 0;
        button_in = 0;
        
        // Сброс
        #20;
        rst_n = 1;
        
        // Тест: нажатие кнопки с дребезгом
        #20;
        button_in = 1;
        #10;
        button_in = 0;  // Имитация дребезга
        #50;
        button_in = 1;
        #30;
        button_in = 0;  // Еще дребезг
        #90;
        button_in = 1;  // Стабильное состояние
        
        // Ждем стабилизации
        #500;
        
        // Тест: отпускание кнопки
        button_in = 0;
        #100;
        button_in = 1;  // Дребезг
        #50;
        button_in = 0;  // Стабильное состояние
        
        #500;
        $finish;
    end
    
    // Мониторинг сигналов
    initial begin
        $monitor("Time: %t, button_in: %b, button_out: %b, counter: %d", 
                 $time, button_in, button_out, dut.counter);
    end

endmodule