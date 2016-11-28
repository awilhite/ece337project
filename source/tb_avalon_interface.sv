// $Id: $
// File name:   tb_avalon_interface.sv
// Created:     11/27/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for avalon interface block

`timescale 1ns / 100ps

module tb_avalon_interface ();
	localparam CLK_PERIOD = 20;
	reg tb_clk;


	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	logic tb_n_rst;
	logic tb_write;
	logic tb_read;
	logic tb_beginbursttransfer;
	logic [9:0] tb_burstcount;
	logic [10:0] tb_address;
	logic [31:0] tb_writedata;
	logic [31:0] tb_readdata;
	logic [31:0] tb_result_output;
	logic tb_done_calc;
	logic tb_weight_address;
	logic tb_pixel_address;
	logic tb_w_enable_weights;
	logic tb_w_enable_pixels;
	logic tb_readdatavalid;
	logic tb_writeresponsevalid;
	logic [15:0] tb_store_data;
	logic [3:0] tb_output_address;
	logic tb_waitrequest;
	logic [1:0] response;

	avalon_interface DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.write(tb_write),
		.read(tb_read),
		.beginbursttransfer(tb_beginbursttransfer),
		.burstcount(tb_burstcount),
		.address(tb_address),
		.writedata(tb_writedata),
		.readdata(tb_readdata),
		.result_output(tb_result_output),
		.done_calc(tb_done_calc),
		.weight_address(tb_weight_address),
		.pixel_address(tb_pixel_address),
		.w_enable_weights(tb_w_enable_weights),
		.w_enable_pixels(tb_w_enable_pixels),
		.readdatavalid(tb_readdatavalid),
		.writeresponsevalid(tb_writeresponsevalid),
		.store_data(tb_store_data),
		.output_address(tb_output_address),
		.watirequest(tb_waitrequest),
		.response(tb_response)
		);


	task reset_dut;
	begin
		tb_n_rst = 1'b0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		@(posedge tb_clk);
	end
	endtask

	task read(input logic [10:0] addr);
	begin
		@(posedge tb_clk);
		tb_address = addr;
		tb_read = 1'b1;
		tb_write = 1'b0;
		#(CLK_PERIOD);
		@(negedge tb_waitrequest);
		tb_address = '0;
		tb_read = 1'b0;

		@(posedge tb_readdatavalid);


	end

	task write(input logic [10:0] addr, input logic [31:0] data);
	begin
		@(posedge tb_clk);
		tb_address = addr;
		tb_write = 1'b1;
		tb_read = 1'b0;
		#(CLK_PERIOD);
		@(negedge tb_waitrequest);
		@(posedge tb_clk);
		tb_address = 'b0;
		tb_write = 1'b0;
		tb_writedata = 'b0;

	end

	task burst_write(input logic [10:0] addr, input logic [31:0] data[0:784]);
	begin
		@(posedge tb_clk);
		tb_address = addr;
		tb_write = 1'b1;
		tb_read = 1'b0;
		tb_beginbursttransfer= 1'b1;
		tb_burstcount = 3'd784
		for (int i = 0; i < 784; i++) begin
			tb_writedata = data[i]
			@(negedge tb_waitrequest);
			@(posedge tb_clk);

		end
	end

	initial begin 
		reset_dut();
		logic [31:0] expected_val = 8'hF0F0F0F0
		write(3'h001,expected_val);
		if(tb_response != 2'b00) begin
			$error("bad write response");
		end
		read(3'h001);
		if(tb_response == 2'b00 && tb_readdata == expected_val) begin
			$info("Data written sucessfully");
		end
		else
			$error("Error in data write");
	end 

endmodule