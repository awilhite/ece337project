onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix symbolic /tb_result_registers/result_registers_inst/clk
add wave -noupdate -radix symbolic /tb_result_registers/result_registers_inst/n_rst
add wave -noupdate -radix unsigned -childformat {{{/tb_result_registers/result_registers_inst/out_sel[3]} -radix decimal} {{/tb_result_registers/result_registers_inst/out_sel[2]} -radix decimal} {{/tb_result_registers/result_registers_inst/out_sel[1]} -radix decimal} {{/tb_result_registers/result_registers_inst/out_sel[0]} -radix decimal}} -subitemconfig {{/tb_result_registers/result_registers_inst/out_sel[3]} {-height 17 -radix decimal} {/tb_result_registers/result_registers_inst/out_sel[2]} {-height 17 -radix decimal} {/tb_result_registers/result_registers_inst/out_sel[1]} {-height 17 -radix decimal} {/tb_result_registers/result_registers_inst/out_sel[0]} {-height 17 -radix decimal}} /tb_result_registers/result_registers_inst/out_sel
add wave -noupdate -radix unsigned /tb_result_registers/result_registers_inst/in_sel
add wave -noupdate -radix binary /tb_result_registers/result_registers_inst/w_enable
add wave -noupdate -radix binary /tb_result_registers/result_registers_inst/clear_data
add wave -noupdate -radix hexadecimal /tb_result_registers/result_registers_inst/in_data
add wave -noupdate -radix hexadecimal -childformat {{{/tb_result_registers/result_registers_inst/out_data[15]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[14]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[13]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[12]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[11]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[10]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[9]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[8]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[7]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[6]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[5]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[4]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[3]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[2]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[1]} -radix hexadecimal} {{/tb_result_registers/result_registers_inst/out_data[0]} -radix hexadecimal}} -subitemconfig {{/tb_result_registers/result_registers_inst/out_data[15]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[14]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[13]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[12]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[11]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[10]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[9]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[8]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[7]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[6]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[5]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[4]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[3]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[2]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[1]} {-height 17 -radix hexadecimal} {/tb_result_registers/result_registers_inst/out_data[0]} {-height 17 -radix hexadecimal}} /tb_result_registers/result_registers_inst/out_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {913830 ps} 0}
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
WaveRestoreZoom {0 ps} {2048 ns}
