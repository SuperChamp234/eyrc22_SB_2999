onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/tx
add wave -noupdate /tb/tx_exp
add wave -noupdate /tb/check
add wave -noupdate /tb/time_err
add wave -noupdate /tb/flag
add wave -noupdate /tb/fd
add wave -noupdate /tb/fw
add wave -noupdate /tb/j
add wave -noupdate /tb/str
add wave -noupdate /tb/uut/data
add wave -noupdate -radix decimal /tb/uut/index
add wave -noupdate -radix decimal /tb/uut/index_hold
add wave -noupdate /tb/uut/data_out
add wave -noupdate /tb/uut/clk
add wave -noupdate /tb/uut/index_jump
add wave -noupdate /tb/uut/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {120832000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {131072 ns}
restart -f
