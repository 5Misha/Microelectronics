transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+G:/Train_proj/laba_3_3_2_RSLOS {G:/Train_proj/laba_3_3_2_RSLOS/rslos_fibonachi.sv}
vlog -sv -work work +incdir+G:/Train_proj/laba_3_3_2_RSLOS {G:/Train_proj/laba_3_3_2_RSLOS/rslos_galya.sv}
vlog -sv -work work +incdir+G:/Train_proj/laba_3_3_2_RSLOS {G:/Train_proj/laba_3_3_2_RSLOS/top.sv}

vlog -sv -work work +incdir+G:/Train_proj/laba_3_3_2_RSLOS/src {G:/Train_proj/laba_3_3_2_RSLOS/src/tb_rslos.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_rslos

add wave *
view structure
view signals
run -all
