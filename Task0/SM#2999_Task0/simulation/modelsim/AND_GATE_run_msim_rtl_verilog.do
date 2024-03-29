transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/being/Desktop/SB/SM#2999_Task0 {C:/Users/being/Desktop/SB/SM#2999_Task0/AND_GATE.v}

vlog -vlog01compat -work work +incdir+C:/Users/being/Desktop/SB/SM#2999_Task0 {C:/Users/being/Desktop/SB/SM#2999_Task0/And_Gate_Test_Bench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  And_Gate_Test_Bench

add wave *
view structure
view signals
run -all
