// $Id: $
// File name:   tb_multiplier.sv
// Created:     12/01/2016
// Author:      
// Lab Section: 04
// Version:     1.0  Initial Design Entry
// Description: Test bench for multiplier block
//
//				Includes three test cases:
//
//				pixels = {1, 1}, weights = {1, 1}
//				pixels = {5, 2}, weights = {7, 9}
//				overflow condition

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
	logic [15:0] tb_pixel_value;
	logic [31:0] tb_weight_value;
	logic [9:0] tb_pixel_address;
	logic [11:0] tb_weight_address;
	logic tb_done_row;
	logic [31:0] tb_row_result;
	logic tb_overflow;
	logic tb_w_result_ena;

	logic [7:0] tb_pixel_value_1;
	logic [7:0] tb_pixel_value_2;
	logic [15:0] tb_weight_value_1;
	logic [15:0] tb_weight_value_2;

	assign tb_weight_value = {tb_weight_value_1, tb_weight_value_2};
	assign tb_pixel_value = {tb_pixel_value_1, tb_pixel_value_2};

	// ESTABLISH DUT

	multiplier DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.row_select(tb_row_select),
		.begin_mult(tb_begin_mult),
		.pixel_value(tb_pixel_value),
		.weight_value(tb_weight_value),
		.pixel_address(tb_pixel_address),
		.weight_address(tb_weight_address),
		.done_row(tb_done_row),
		.row_result(tb_row_result),
		.overflow(tb_overflow),
		.w_result_ena(tb_w_result_ena)
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
	end
	endtask

	logic [15:0] tb_expected_val;

	// EXECUTE TESTS

	initial begin

		// Initial Conditions

		tb_n_rst = 1;
		tb_begin_mult = 0;

		// Test Case 1: 
		// Expected Result 784
		// Both weight values set to 1

		tb_pixel_value_1 = 8'h01;
		tb_pixel_value_2 = 8'h01;
		tb_weight_value_1 = 16'h0001;
		tb_weight_value_2 = 16'h0001;

		tb_row_select = 0;

		tb_expected_val = 16'd784;

		reset_dut();
		assert_begin();

		delay_cycles(20);

		@(posedge tb_done_row);

		if (tb_row_result == tb_expected_val) begin
			$info("Result Computed Correctly");
		end
		else begin
			$error("Result Incorrect");
		end

		delay_cycles(10);

		// Test Case 2: 
		// Expected Result 20776
		// One of weight values set to zero

		tb_pixel_value_1 = 8'd05;
		tb_pixel_value_2 = 8'd02;
		tb_weight_value_1 = 16'd0007;
		tb_weight_value_2 = 16'd0009;

		tb_row_select = 1;

		tb_expected_val = 16'd20776;

		reset_dut();
		assert_begin();

		delay_cycles(20);

		@(posedge tb_done_row);

		if (tb_row_result == tb_expected_val) begin
			$info("Result Computed Correctly");
		end
		else begin
			$error("Result Incorrect");
		end

		delay_cycles(10);

		/*// Test Case 3: 
		// Expected Result: 
		// Signed Number

		tb_pixel_value_1 = 8'h01;
		tb_pixel_value_2 = 8'h01;
		tb_weight_value_1 = 16'hFF00;
		tb_weight_value_2 = 16'h0000;

		tb_row_select = 1;

		tb_expected_val = 16'd392;

		reset_dut();
		assert_begin();

		delay_cycles(20);

		@(posedge tb_done_row);*/

		delay_cycles(10);

		// Test Case 4: Expected Result 392
		// Overflow condition

		tb_pixel_value_1 = 8'hFF;
		tb_pixel_value_2 = 8'hFF;
		tb_weight_value_1 = 16'd30000;
		tb_weight_value_2 = 16'd30000;

		tb_row_select = 1;

		tb_expected_val = 16'd392;

		reset_dut();
		assert_begin();

		delay_cycles(20);

		@(posedge tb_done_row);

		if (tb_overflow == 'b1) begin
			$info("Overflow flag set correctly");
		end
		else begin
			$error("Overflow flag was not set");
		end

		delay_cycles(10);

	end 

endmodule