// $Id: $
// File name:   pixel_memory_sel.sv
// Created:     11/29/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Pixel memory with address select

module pixel_memory_sel
(
	input wire clk,
	input wire [9:0] address_a_1,
	input wire [9:0] address_a_2,
	input wire [9:0] address_b,
	input wire select,
	input wire [15:0] data_a,
	input wire [15:0] data_b,
	input wire wren_a,
	input wire wren_b,
	output wire [15:0] q_a,
	output wire [15:0] q_b
);

wire address_a;

assign address_a = select ? address_a_2 : address_a_1;

pixel_mem_16bit pixel_mem_inst(
	.address_a(address_a),
	.address_b(address_b),
	.clock(clk),
	.data_a(data_a),
	.data_b(data_b),
	.wren_a(wren_a),
	.wren_b(wren_b),
	.q_a(q_a),
	.q_b(q_b)
);

endmodule
