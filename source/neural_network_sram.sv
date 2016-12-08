// $Id: $
// File name:   neural_network.sv
// Created:     12/1/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Top level module


module neural_network_sram (
	input logic clk,    // Clock
	input logic reset_n,
	input logic write,
	input logic read,
	input logic beginbursttransfer,
	input logic [9:0] burstcount,
	input logic [12:0] address,
	input logic [31:0] writedata,
	output logic [31:0] readdata,
	output logic readdatavalid,
	//output logic writeresponsevalid,
	output logic waitrequest,
	output logic [1:0] response,

	output logic [9:0] pixel_address1,
	output logic [9:0] pixel_address2,
	output logic [11:0] weight_address,
	output logic [15:0] pixel_data1,
	output logic [15:0] pixel_data2,
	output logic [31:0] weight_data,
	output logic w_enable_pixels,
	output logic w_enable_weights,
	output logic r_enable,


	input logic [15:0] pixel_value1,
	input logic [15:0] pixel_value2,
	input logic [31:0] weight_value
);

	// DEFINE SIGNALS

	logic done_calc;
	logic [16:0] result_output;
	logic [11:0] weight_address_ava, weight_address_mul;
	logic [9:0] pixel_address1_ava, pixel_address2_ava, pixel_address_mul;
	logic [15:0] store_data;
	logic [3:0] output_address;
	logic start_calc;

	logic [3:0] row_select;
	logic begin_mult;
	
	logic done_row;

	logic [15:0] row_result;
	logic overflow;
	logic w_result_ena;

	logic [3:0] out_sel;
	logic [3:0] in_sel;
	logic clear_data;
	logic [15:0] out_data;
	logic [15:0] pixel_value;

	assign weight_address = done_calc ? weight_address_ava : weight_address_mul;
	assign pixel_address1 = done_calc ? pixel_address1_ava : pixel_address_mul;
	assign pixel_address2 = done_calc ? pixel_address2_ava : pixel_address_mul;
	assign pixel_value = (pixel_address_mul[0] == 0) ? pixel_value1 : pixel_value2;
	assign r_enable = !done_calc;

	avalon_interface avalon_interface_inst(
		.clk(clk),
		.n_rst(reset_n),
		.write(write),
		.read(read),
		.beginbursttransfer(beginbursttransfer),
		.burstcount(burstcount),
		.address(address),
		.writedata(writedata),
		.readdata(readdata),
		.result_output(out_data),
		.done_calc(done_calc),
		.overflow(overflow),
		.weight_address(weight_address_ava),
		.pixel_address1(pixel_address1_ava),
		.pixel_address2(pixel_address2_ava),
		.w_enable_weights(w_enable_weights),
		.w_enable_pixels(w_enable_pixels),
		.readdatavalid(readdatavalid),
		.writeresponsevalid(writeresponsevalid),
		.pixel_data1(pixel_data1),
		.pixel_data2(pixel_data2),
		.weight_data(weight_data),
		.output_address(output_address),
		.waitrequest(waitrequest),
		.start_calc(start_calc),
		.clear_data(clear_data),
		.response(response)
		);


	multiplier multiplier_inst
	(
		.clk(clk),
		.n_rst(reset_n),
		.row_select(row_select),
		.begin_mult(begin_mult),
		.pixel_value(pixel_value),
		.weight_value(weight_value),
		.pixel_address(pixel_address_mul),
		.weight_address(weight_address_mul),
		.done_row(done_row),
		.row_result(row_result),
		.overflow(overflow),
		.w_result_ena(w_result_ena)
	);

	main_controller main_controller_inst
	(
		.clk(clk),
		.n_reset(reset_n),
		.start_calc(start_calc),
		.done_row(done_row),
		.res_add(row_select),
		.begin_mult(begin_mult),
		.done_calc(done_calc)
	);
   
   result_registers result_registers_inst (
		.clk(clk),    // Clock
		.n_rst(reset_n),  // Asynchronous reset active low
		.out_sel(output_address),
		.in_sel(row_select),
		.w_enable(w_result_ena),
		.clear_data(clear_data),
		.in_data(row_result),
		.out_data(out_data)
	);


   
	/*pixel_mem_16bit	pixel_mem_inst (
		.address_a ( pixel_address ),
		.address_b ( 'b0 ),
		.clock ( clk ),
		.data_a ( store_data ),
		.data_b ( 'b0 ),
		.wren_a ( w_enable_pixels ),
		.wren_b ( 'b0 ),
		.q_a ( q_a ),
		.q_b ( q_b )
	);*/

	/*weights_mem_32bit	weights_mem_inst (
		.address_a ( weights_address ),
		.address_b ( 'b0 ),
		.clock ( clk ),
		.data_a ( store_data ),
		.data_b ( 'b0 ),
		.wren_a ( w_enable_pixels ),
		.wren_b ( 'b0 ),
		.q_a ( q_a ),
		.q_b ( q_b )
	);*/


endmodule
