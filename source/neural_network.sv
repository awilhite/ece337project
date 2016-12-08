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
	input logic [12:0] address,
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
	logic [12:0] weight_address;
	logic [9:0] pixel_address;
	logic w_enable_weights;
	logic w_enable_pixels;
	logic [15:0] store_data;
	logic [3:0] output_address;
	logic start_calc;

	logic [3:0] row_select;
	logic begin_mult;
	logic [15:0] pixel_value;
	logic [31:0] weight_value;
	logic done_row;
	logic [15:0] row_result;
	logic overflow;
	logic w_result_ena;

	logic [3:0] out_sel;
	logic [3:0] in_sel;
	logic clear_data;
	logic [15:0] out_data;

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
		.pixel_value(pixel_value),
		.weight_value(weight_value),
		.pixel_address(pixel_address),
		.weight_address(weight_address),
		.done_row(done_row),
		.row_result(row_result),
		.overflow(overflow),
		.w_result_ena(w_result_ena)
	);

	main_controller main_controller_inst
	(
-		.clk(clk),
		.n_reset(n_rst),
		.start_calc(start_calc),
		.done_row(done_row),
		.res_add(res_add),
		.begin_mult(begin_mult),
		.done_calc(done_calc)
	);
   
   result_registers result_registers_inst (
		.clk(clk),    // Clock
		.n_rst(n_rst),  // Asynchronous reset active low
		.out_sel(out_sel),
		.in_sel(in_sel),
		.w_enable(w_result_ena),
		.clear_data(clear_data),
		.in_data(row_result),
		.out_data(out_data)
	);

   pixel_memory_test pixel_memory_inst
     (
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
