// $Id: $
// File name:   tb_neural_network_sram.sv
// Created:     12/7/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for neural network using course sram

`timescale 1ns / 100ps

module tb_neural_network_sram (
);
	localparam CLK_PERIOD = 20;
	localparam CONTROL_REG = 13'd4126;
	localparam STATUS_REG = 13'd4127;






	
	// Test bench variables
	integer unsigned tb_init_file_number;	// Can't be larger than a value of (2^31 - 1) due to how VHDL stores unsigned ints/natural data types
	integer unsigned tb_dump_file_number;	// Can't be larger than a value of (2^31 - 1) due to how VHDL stores unsigned ints/natural data types
	integer unsigned tb_start_address;	// The first address to start dumping memory contents from
	integer unsigned tb_last_address;		// The last address to dump memory contents from
	
	reg tb_mem_clr;		// Active high strobe for at least 1 simulation timestep to zero memory contents
	reg tb_mem_init;	// Active high strobe for at least 1 simulation timestep to set the values for address in
										// currently selected init file to their corresonding values prescribed in the file
	reg tb_mem_dump;	// Active high strobe for at least 1 simulation timestep to dump all values modified since most recent mem_clr activation to
										// the currently chosen dump file. 
										// Only the locations between the "tb_start_address" and "tb_last_address" (inclusive) will be dumped
	reg tb_verbose;		// Active high enable for more verbose debuging information
	



	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	logic tb_clk;
	logic tb_n_rst;
	logic tb_write;
	logic tb_read;
	logic tb_beginbursttransfer;
	logic [9:0] tb_burstcount;
	logic [12:0] tb_address;
	logic [31:0] tb_writedata;
	logic [31:0] tb_readdata;
	logic tb_waitrequest;
	logic tb_readdatavalid;
	// logic tb_writeresponsevalid;
	logic [1:0] tb_response;

	logic [11:0] tb_weight_address;
	logic [9:0] tb_pixel_address1;
	logic [9:0] tb_pixel_address2;
	logic tb_w_enable_weights;
	logic tb_w_enable_pixels;
	logic [15:0] tb_pixel_data1;
	logic [15:0] tb_pixel_data2;
	logic [31:0] tb_weight_data;

	logic [15:0] tb_pixel_value1;
	logic [15:0] tb_pixel_value2;
	logic [32:0] tb_weight_value;


	neural_network_sram DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.write(tb_write),
		.read(tb_read),
		.beginbursttransfer(tb_beginbursttransfer),
		.burstcount(tb_burstcount),
		.address(tb_address),
		.writedata(tb_writedata),
		.readdata(tb_readdata),
		.waitrequest(tb_waitrequest),
		.response(tb_response),
		.readdatavalid(tb_readdatavalid),
		//.writeresponsevalid(tb_writeresponsevalid),

		.weight_address(tb_weight_address),
		.weight_value(tb_weight_value)
		.w_enable_weights(tb_w_enable_weights),
		.weight_data(tb_weight_data),

		.pixel_address1(tb_pixel_address1),
		.pixel_address2(tb_pixel_address2),
		.w_enable_pixels(tb_w_enable_pixels),
		.pixel_data1(tb_pixel_data1),
		.pixel_data2(tb_pixel_data2),
		.pixel_value1(tb_pixel_value1),
		.pixel_value2(tb_pixel_value2),
		);

	weights_on_chip_sram weights_sram
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		// Memory interface signals
		.read_enable(1'b1),
		.write_enable(tb_w_enable_weights),
		.address(tb_weight_address),
		.read_data(tb_weight_value),
		.write_data(tb_weight_data)
	);

	pixels_on_chip_sram pixels1_sram
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		// Memory interface signals
		.read_enable(1'b1),
		.write_enable(tb_w_enable_pixels),
		.address(tb_pixel_address1),
		.read_data(tb_pixel_value1),
		.write_data(tb_pixel_data1)
	);


	pixels_on_chip_sram pixels2_sram
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		// Memory interface signals
		.read_enable(1'b1),
		.write_enable(tb_w_enable_pixels),
		.address(tb_pixel_address2),
		.read_data(tb_pixel_value2),
		.write_data(tb_pixel_data2)
	);


endmodule