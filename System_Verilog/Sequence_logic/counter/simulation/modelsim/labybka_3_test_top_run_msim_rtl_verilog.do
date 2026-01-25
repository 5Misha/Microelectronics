transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+G:/Train_proj/labyba_3_1_counter {G:/Train_proj/labyba_3_1_counter/counter_1bit.sv}
vlog -sv -work work +incdir+G:/Train_proj/labyba_3_1_counter {G:/Train_proj/labyba_3_1_counter/counter_2bit.sv}
vlog -sv -work work +incdir+G:/Train_proj/labyba_3_1_counter {G:/Train_proj/labyba_3_1_counter/top.sv}

vlog -sv -work work +incdir+G:/Train_proj/labyba_3_1_counter/src {G:/Train_proj/labyba_3_1_counter/src/tb_counter_2bit.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_counter_2bit

add wave *
view structure
view signals
run -all
