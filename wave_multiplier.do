onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_multiplier/DUT/clk
add wave -noupdate /tb_multiplier/DUT/n_rst
add wave -noupdate /tb_multiplier/DUT/state
add wave -noupdate -divider {Input Values}
add wave -noupdate -radix decimal /tb_multiplier/DUT/begin_mult
add wave -noupdate -radix decimal /tb_multiplier/DUT/row_select
add wave -noupdate -divider {Output Values}
add wave -noupdate -radix decimal /tb_multiplier/DUT/done_row
add wave -noupdate -radix unsigned /tb_multiplier/DUT/row_result
add wave -noupdate -radix decimal /tb_multiplier/DUT/counter/count_out
add wave -noupdate -radix binary /tb_multiplier/DUT/overflow
add wave -noupdate -radix binary /tb_multiplier/DUT/w_result_ena
add wave -noupdate -divider {Data Values}
add wave -noupdate -radix decimal /tb_multiplier/tb_pixel_value_1
add wave -noupdate -radix decimal /tb_multiplier/tb_pixel_value_2
add wave -noupdate -radix decimal /tb_multiplier/tb_weight_value_1
add wave -noupdate -radix decimal /tb_multiplier/tb_weight_value_2
add wave -noupdate -divider Addresses
add wave -noupdate -radix hexadecimal /tb_multiplier/DUT/pixel_address
add wave -noupdate -radix hexadecimal /tb_multiplier/DUT/weight_address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7944454 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {7902370 ps} {8025418 ps}
