// $Id: $
// File name:   tb_multiplier.sv
// Created:     12/01/2016
// Author:      
// Lab Section: 04
// Version:     1.0  Initial Design Entry
// Description: Test bench for multiplier block

`timescale 1ns / 100ps

module tb_multiplier();

	// DEFINE CLOCK PARAMETERS

	localparam CLK_PERIOD = 20;

	reg tb_clk;

	// CLOCK GENERATION BLOCK

	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	// DEFINE DUT SIGNALS

	logic tb_n_rst;
	logic [3:0] tb_row_select;
	logic tb_begin_mult;
	logic [7:0] tb_pixel_value_1;
	logic [7:0] tb_pixel_value_2;
	logic [15:0] tb_weight_value_1;
	logic [15:0] tb_weight_value_2;
	logic [9:0] tb_pixel_address_1;
	logic [9:0] tb_pixel_address_2;
	logic [12:0] tb_weight_address_1;
	logic [12:0] tb_weight_address_2;
	logic tb_done_row;
	logic [15:0] tb_row_result;

	// ESTABLISH DUT

	multiplier DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.row_select(tb_row_select),
		.begin_mult(tb_begin_mult),
		.pixel_value_1(tb_pixel_value_1),
		.pixel_value_2(tb_pixel_value_2),
		.weight_value_1(tb_weight_value_1),
		.weight_value_2(tb_weight_value_2),
		.pixel_address_1(tb_pixel_address_1),
		.pixel_address_2(tb_pixel_address_2),
		.weight_address_1(tb_weight_address_1),
		.weight_address_2(tb_weight_address_2),
		.done_row(tb_done_row),
		.row_result(tb_row_result)
	);

	// TASK: reset_dut

	task reset_dut;
	begin
		tb_n_rst = 1'b0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		@(posedge tb_clk);
	end
	endtask : reset_dut

	// TASK: delay_cycles

	task delay_cycles(input logic [10:0] cycles);
	begin
		repeat (cycles) begin
			@(posedge tb_clk);
		end
	end
	endtask

	// TASK: assert_begin

	task assert_begin;
	begin
		tb_begin_mult = 1'b1;
		@(posedge tb_clk);
		tb_begin_mult = 1'b0;
		@(posedge tb_clk);
	end
	endtask

	logic [15:0] tb_expected_val;

	// EXECUTE TESTS

	initial begin

		// Test Case 1: Expected Result 784

		tb_pixel_value_1 = 8'h01;
		tb_pixel_value_2 = 8'h01;
		tb_weight_value_1 = 16'h0001;
		tb_weight_value_2 = 16'h0001;

		tb_row_select = 0;

		tb_expected_val = 16'd784;

		reset_dut();
		assert_begin();

		@(posedge tb_done_row);

		if (tb_row_result == tb_expected_val) begin
			$info("Result Computed Correctly");
		end

		// Test Case 2: Expected Result 382

		tb_pixel_value_1 = 8'h01;
		tb_pixel_value_2 = 8'h01;
		tb_weight_value_1 = 16'h0001;
		tb_weight_value_2 = 16'h0000;

		tb_row_select = 1;

		tb_expected_val = 16'd392;

		reset_dut();
		assert_begin();

		@(posedge tb_done_row);

		if (tb_row_result == tb_expected_val) begin
			$info("Result Computed Correctly");
		end
		else begin
			$error("Result Incorrect");
		end

	end 

endmodule