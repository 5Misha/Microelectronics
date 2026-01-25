`timescale 1ns/1ps

module tb_generation;

parameter WIDTH = 16;

logic clk_t, rst_t, enable_t;
logic [WIDTH-1 : 0] random_out_f_t, random_out_g_t;

top DUT (.clk(clk_t), .rst(rst_t), .enable(enable_t), .random_out_f(random_out_f_t), .random_out_g(random_out_g_t));

int file_g; 
int file_f;

// Генерация тактового сигнала
initial begin
    clk_t = 0;
    forever #5 clk_t = ~clk_t;
end

// Инициализация и управление
initial begin
    // Открытие файлов
    file_g = $fopen("Sequence_g.txt", "w");
    file_f = $fopen("Sequence_f.txt", "w");
    
    if (file_g == 0 || file_f == 0) begin
        $display("Ошибка открытия файла!");
        $finish;
    end
    
    // Сброс
    rst_t = 1;
    enable_t = 0;
    #20;
    
    // Запуск генерации
    rst_t = 0;
    enable_t = 1;
    
    // Завершение через 10000 тактов
    repeat(10000) @(posedge clk_t);
    
    // Закрытие файлов
    $fclose(file_g);
    $fclose(file_f);
    $display("Запись завершена!");
    $finish;
end

// Запись в файл на каждом положительном фронте такта
always @(posedge clk_t) begin
    if (enable_t && !rst_t) begin
        $fwrite(file_g, "%b", random_out_g_t[0]);
        $fwrite(file_f, "%b", random_out_f_t[0]);
    end
end

endmodule