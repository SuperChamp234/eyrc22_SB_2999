transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/zain/Code_n_Projects/Swatchhata-bot/Task2/SB#2999_Task2B/uart {/home/zain/Code_n_Projects/Swatchhata-bot/Task2/SB#2999_Task2B/uart/uart.v}

vlog -vlog01compat -work work +incdir+/home/zain/Code_n_Projects/Swatchhata-bot/Task2/SB#2999_Task2B/uart/simulation/modelsim {/home/zain/Code_n_Projects/Swatchhata-bot/Task2/SB#2999_Task2B/uart/simulation/modelsim/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run 670000 ns
