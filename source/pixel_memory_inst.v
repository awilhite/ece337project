// $Id: $
// File name:   pixel_memory_inst.sv
// Created:     11/29/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Pixel Memory Wrapper File

module pixel_mem_sel
(
	input wire 

)

pixel_memory	pixel_memory_inst (
	.address_a ( address_a_sig ),
	.address_b ( address_b_sig ),
	.clock ( clock_sig ),
	.data_a ( data_a_sig ),
	.data_b ( data_b_sig ),
	.wren_a ( wren_a_sig ),
	.wren_b ( wren_b_sig ),
	.q_a ( q_a_sig ),
	.q_b ( q_b_sig )
	);
