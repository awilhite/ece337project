// $Id: $
// File name:   neural_network.sv
// Created:     12/1/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Top level module


module neural_network (
	input logic clk,    // Clock
	input logic reset_n,
	input logic write,
	input logic read,
	input logic beginbursttransfer,
	input logic [9:0] burstcount,
	input logic [10:0] address,
	input logic [31:0] writedata,
	output logic [31:0] readdata,
	output logic readdatavalid,
	//output logic writeresponsevalid,
	output logic waitrequest,
	output logic [1:0] response
);

	// DEFINE SIGNALS

	logic done_calc;
	logic [16:0] result_output;
	logic [10:0] weight_address;
	logic [10:0] pixel_address;
	logic w_enable_weights;
	logic w_enable_pixels;
	logic [15:0] store_data;
	logic [3:0] output_address;
	logic start_calc;

	logic [3:0] row_select;
	logic begin_mult;
	logic [7:0] pixel_value_1;
	logic [7:0] pixel_value_2;
	logic [15:0] weight_value_1;
	logic [15:0] weight_value_2;
	logic [9:0] pixel_address_1;
	logic [9:0] pixel_address_2;
	logic [12:0] weight_address_1;
	logic [12:0] weight_address_2;
	logic done_row;
	logic [15:0] row_result;

	avalon_interface avalon_interface_inst(
		.clk(clk),    // Clock
		.n_rst(reset_n),
		.write(write),
		.read(read),
		.beginbursttransfer(beginbursttransfer),
		.burstcount(burstcount),
		.address(address),
		.writedata(writedata),
		.readdata(readdata),
		.result_output(result_output),
		.done_calc(done_calc),
		.weight_address(weight_address),
		.pixel_address(pixel_address),
		.w_enable_weights(w_enable_weights),
		.w_enable_pixels(w_enable_pixels),
		.readdatavalid(readdatavalid),
		//.writeresponsevalid(writeresponsevalid),
		.store_data(store_data),
		.output_address(output_address),
		.waitrequest(waitrequest),
		.start_calc(start_calc),
		.response(response)
		);


	multiplier multiplier_inst
	(
		.clk(clk),
		.n_rst(n_rst),
		.row_select(row_select),
		.begin_mult(begin_mult),
		.pixel_value_1(pixel_value_1),
		.pixel_value_2(pixel_value_2),
		.weight_value_1(weight_value_1),
		.weight_value_2(weight_value_2),
		.pixel_address_1(pixel_address_1),
		.pixel_address_2(pixel_address_2),
		.weight_address_1(weight_address_1),
		.weight_address_2(weight_address_2),
		.done_row(done_row),
		.row_result(row_result)
	);

	main_controller main_controller_inst
	(
		.clk(clk),
		.n_reset(n_rst),
		.start_calc(start_calc),
		.done_row(done_row),
		.res_add(res_add),
		.begin_mult(begin_mult),
		.done_calc(done_calc)
	);

	pixel_memory	pixel_memory_inst (
		.address_a ( pixel_address ),
		.address_b ( 'b0 ),
		.clock ( clk ),
		.data_a ( store_data ),
		.data_b ( 'b0 ),
		.wren_a ( w_enable_pixels ),
		.wren_b ( 'b0 ),
		.q_a ( q_a ),
		.q_b ( q_b )
		);


endmodule
