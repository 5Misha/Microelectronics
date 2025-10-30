transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+G:/Train_proj/labyba_3_4 {G:/Train_proj/labyba_3_4/param_ring_register.sv}
vlog -sv -work work +incdir+G:/Train_proj/labyba_3_4 {G:/Train_proj/labyba_3_4/top.sv}

vlog -sv -work work +incdir+G:/Train_proj/labyba_3_4/src {G:/Train_proj/labyba_3_4/src/tb_param_ring_register.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_param_ring_register

add wave *
view structure
view signals
run -all
