transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/zain/Code_n_Projects/Eyantra/SB#2999_Task1C/freq_counter {/home/zain/Code_n_Projects/Eyantra/SB#2999_Task1C/freq_counter/freq_counter.v}

vlog -vlog01compat -work work +incdir+/home/zain/Code_n_Projects/Eyantra/SB#2999_Task1C/freq_counter/simulation/modelsim {/home/zain/Code_n_Projects/Eyantra/SB#2999_Task1C/freq_counter/simulation/modelsim/freq_counter_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  freq_counter_tb

add wave *
view structure
view signals
run 1100 ps
