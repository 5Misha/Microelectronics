transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/Quartuz_2.0/Zadaniya/laba_2 {E:/Quartuz_2.0/Zadaniya/laba_2/selector_8_32.sv}
vlog -sv -work work +incdir+E:/Quartuz_2.0/Zadaniya/laba_2 {E:/Quartuz_2.0/Zadaniya/laba_2/top_selector_8_32.sv}

vlog -sv -work work +incdir+E:/Quartuz_2.0/Zadaniya/laba_2/src {E:/Quartuz_2.0/Zadaniya/laba_2/src/tb_selector_8_32.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_selector_8_32

add wave *
view structure
view signals
run -all
