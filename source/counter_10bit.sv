// $Id: $
// File name:   counter_10bit.sv
// Created:     11/29/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: A 10-bit wrapper for the flexible counter

module counter_10bit
(
	input clk, 
	input n_rst, 
	input clear, 
	input count_enable, 
	input [9:0] rollover_val,
	output [9:0] count_out, 
	output rollover_flag
);

flex_counter #(10) C10 (.clk(clk), .n_rst(n_rst), .clear(clear), .count_enable(count_enable), .rollover_val(rollover_val), .count_out(count_out), .rollover_flag(rollover_flag));

endmodule

