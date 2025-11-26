transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+G:/Train_proj/laba_4_4a {G:/Train_proj/laba_4_4a/traffic_light_blink.sv}
vlog -sv -work work +incdir+G:/Train_proj/laba_4_4a {G:/Train_proj/laba_4_4a/frequency_divider.sv}
vlog -sv -work work +incdir+G:/Train_proj/laba_4_4a {G:/Train_proj/laba_4_4a/traffic_light_top.sv}

vlog -sv -work work +incdir+G:/Train_proj/laba_4_4a/../laba_4_3/src {G:/Train_proj/laba_4_4a/../laba_4_3/src/tb_traffic_light.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_traffic_light

add wave *
view structure
view signals
run -all
