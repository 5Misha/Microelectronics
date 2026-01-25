transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/zebra/OneDrive/Git_projects/Microelectronics/System_Verilog/Sequence_logic/div_50Mhz {C:/Users/zebra/OneDrive/Git_projects/Microelectronics/System_Verilog/Sequence_logic/div_50Mhz/div_50M_1.sv}
vlog -sv -work work +incdir+C:/Users/zebra/OneDrive/Git_projects/Microelectronics/System_Verilog/Sequence_logic/div_50Mhz {C:/Users/zebra/OneDrive/Git_projects/Microelectronics/System_Verilog/Sequence_logic/div_50Mhz/top.sv}

vlog -sv -work work +incdir+C:/Users/zebra/OneDrive/Git_projects/Microelectronics/System_Verilog/Sequence_logic/div_50Mhz/src {C:/Users/zebra/OneDrive/Git_projects/Microelectronics/System_Verilog/Sequence_logic/div_50Mhz/src/tb_freq_divider.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_freq_divider

add wave *
view structure
view signals
run -all
