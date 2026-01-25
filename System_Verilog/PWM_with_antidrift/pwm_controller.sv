`include "G:\\Train_proj\\labyba_3_5_antidrebezg\\debounce_counter.sv"

module pwm_controller (
	input logic clk, 
	input logic rst, 
	input logic btn_up, // Кнопка увеличения яркости
	input logic btn_down, // Кнопка уменьшения яркости
	output logic pwm_out // сигнал для светодиода
);

parameter CLK_FREQ = 50_000_000; // Частота тактового сигнала в Гц
parameter PWM_FREQ = 1_000; // Частота ШИМ (1 кГц)
parameter COUNTER_MAX = CLK_FREQ / PWM_FREQ;

logic [15:0] counter;            // Счетчик для генерации периода ШИМ
logic [3:0]  duty_cycle_index;   // Индекс текущей яркости (0-8)
logic [15:0] duty_cycle_value;   // Текущее значение яркости
logic        btn_up_debounced;   // Кнопка вверх после антидребезга
logic        btn_down_debounced; // Кнопка вниз после антидребезга
logic        btn_up_prev;        // Предыдущее состояние кнопки вверх
logic        btn_down_prev;      // Предыдущее состояние кнопки вниз
logic [15:0] duty_cycles [0:8];  // Массив значений яркости для 10%-90% с шагом 10%

// Инициализация массива значений яркости
initial begin
  duty_cycles[0] = (COUNTER_MAX * 10) / 100;  // 10%
  duty_cycles[1] = (COUNTER_MAX * 20) / 100;
  duty_cycles[2] = (COUNTER_MAX * 30) / 100;
  duty_cycles[3] = (COUNTER_MAX * 40) / 100;
  duty_cycles[4] = (COUNTER_MAX * 50) / 100;  // 50%
  duty_cycles[5] = (COUNTER_MAX * 60) / 100;
  duty_cycles[6] = (COUNTER_MAX * 70) / 100; 
  duty_cycles[7] = (COUNTER_MAX * 80) / 100;
  duty_cycles[8] = (COUNTER_MAX * 90) / 100;  // 90%
end

// Модули антидребезга для кнопок
 debounce_counter #(
	  .COUNTER_WIDTH(14),
	  .COUNTER_MAX(10_000) // 1 ms при 50 MHz
 ) debounce_up (
	  .clk(clk),
	  .rst_n(~rst), // Инвертируем для активного высокого сброса
	  .button_in(btn_up),
	  .button_out(btn_up_debounced)
 );
 
 debounce_counter #(
	  .COUNTER_WIDTH(14),
	  .COUNTER_MAX(10_000)
 ) debounce_down (
	  .clk(clk),
	  .rst_n(~rst),                
	  .button_in(btn_down),
	  .button_out(btn_down_debounced)
 );
 
 // Зпись предыдущих состояний для обнаружения фронтов
 always_ff @(posedge clk or posedge rst) begin
	  if (rst) begin
			btn_up_prev <= 1'b0;
			btn_down_prev <= 1'b0;
	  end else begin
			btn_up_prev <= btn_up_debounced;
			btn_down_prev <= btn_down_debounced;
	  end
 end
 
 // Обработка нажатий кнопок и изменение яркости
 always_ff @(posedge clk or posedge rst) begin
	  if (rst) begin
			duty_cycle_index <= 4'd4;  // Начальное значение 50%
			duty_cycle_value <= duty_cycles[4];
	  end else begin
			// Обновляем текущее значение яркости из массива
			duty_cycle_value <= duty_cycles[duty_cycle_index];
			
			// Обработка кнопки увеличения яркости (обнаружение фронта)
			if (btn_up_debounced && !btn_up_prev) begin
				 if (duty_cycle_index < 4'd8)
					  duty_cycle_index <= duty_cycle_index + 4'd1;
			end
			
			// Обработка кнопки уменьшения яркости (обнаружение фронта)
			if (btn_down_debounced && !btn_down_prev) begin
				 if (duty_cycle_index > 4'd0)
					  duty_cycle_index <= duty_cycle_index - 4'd1;
			end
	  end
 end
 
 // Счетчик для генерации периода ШИМ
 always_ff @(posedge clk or posedge rst) begin
	  if (rst)
			counter <= 16'b0;
	  else begin
			if (counter >= COUNTER_MAX - 1)
				 counter <= 16'b0;
			else
				 counter <= counter + 16'b1;
	  end
 end
 
 // Генерация ШИМ сигнала
 always_ff @(posedge clk or posedge rst) begin
	  if (rst)
			pwm_out <= 1'b0;
	  else begin
			// Сигнал HIGH когда счетчик меньше значения яркости
			if (counter < duty_cycle_value)
				 pwm_out <= 1'b1;
			else
				 pwm_out <= 1'b0;
	  end
 end

endmodule
