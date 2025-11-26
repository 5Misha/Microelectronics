transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+G:/Train_proj/Laba_3_on_3_buzzer {G:/Train_proj/Laba_3_on_3_buzzer/antidrebezg.sv}
vlog -sv -work work +incdir+G:/Train_proj/Laba_3_on_3_buzzer {G:/Train_proj/Laba_3_on_3_buzzer/buzzer.sv}
vlog -sv -work work +incdir+G:/Train_proj/Laba_3_on_3_buzzer {G:/Train_proj/Laba_3_on_3_buzzer/top.sv}

vlog -sv -work work +incdir+G:/Train_proj/Laba_3_on_3_buzzer/src {G:/Train_proj/Laba_3_on_3_buzzer/src/tb_buzzer.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_buzzer

add wave *
view structure
view signals
run -all
