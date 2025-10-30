module tb_param_ring_register;

parameter N = 69;

logic clk_t, rst_t;
logic [1:0] mode_t;
logic [N-1:0] data_in_t;
logic [N-1:0] data_out_t;

 param_ring_register #(.N(69)) DUT(
	  .clk(clk_t),
	  .rst(rst_t),
	  .mode(mode_t),
	  .data_in(data_in_t),
	  .data_out(data_out_t)
 );

 // Генератор тактового сигнала
 initial begin
	  clk_t = 0;
	  forever #10 clk_t = ~clk_t;  // Период 20 единиц времени
 end
 
 // Основной тестовый процесс
 initial begin
	  // Инициализация
	  rst_t = 1;
	  mode_t = 2'b00;
	  data_in_t = 0;
	  
	  #20;
	  rst_t = 0;
	  #20;
	  
	  $display("Time | mode | input data | output data");
	  
	  // Тест 1: Загрузка начального значения
	  $display("\nTest 1:");
	  data_in_t = 69'h1A5A5A5A5A5A5A5A5A5;  // Произвольное значение
	  mode_t = 2'b11;  // Режим загрузки
	  #40;
	  $display("%0t | LOAD  | %h | %h", $time, data_in_t, data_out_t);
	  
	  // Тест 2: Хранение данных
	  $display("\nTest 2: save mode");
	  mode_t = 2'b00;  // Режим хранения
	  #40;
	  $display("%0t | HOLD  | %h | %h", $time, data_in_t, data_out_t);
	  
	  // Тест 3: Кольцевой сдвиг влево на 3 позиции
	  $display("\nTest 3: ring shift left on 3 position");
	  mode_t = 2'b01;  // Сдвиг влево
	  #60;
	  $display("%0t | LEFT  | %h | %h", $time, data_in_t, data_out_t);
	  
	  // Тест 4: Кольцевой сдвиг вправо на 5 позиций
	  $display("\nTest 4: ring shift right on 5 position");
	  mode_t = 2'b10;
	  #100;
	  $display("%0t | RIGHT  | %h | %h", $time, data_in_t, data_out_t);
	  

	  $finish;
 end
    
    // Мониторинг изменений в реальном времени
    always @(posedge clk_t) begin
        if (!rst_t) begin  // Только когда нет сброса
            case (mode_t)
                2'b00: $display("%0t | HOLD  | %h | %h", $time, data_in_t, data_out_t);
                2'b01: $display("%0t | LEFT  | %h | %h", $time, data_in_t, data_out_t);
                2'b10: $display("%0t | RIGHT | %h | %h", $time, data_in_t, data_out_t);
                2'b11: $display("%0t | LOAD  | %h | %h", $time, data_in_t, data_out_t);
            endcase
        end
    end

endmodule