// $Id: $
// File name:   tb_result_registers.sv
// Created:     12/06/2016
// Author:      
// Lab Section: 04
// Version:     1.0  Initial Design Entry
// Description: Test bench for result registers
//
//				Includes four test cases: 
//
// 				write and read to address
// 				write and read different data to same address
// 				attempt write without write_enable
//				clear data operation

`timescale 1ns / 100ps

module tb_result_registers();

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
	logic [3:0] tb_out_sel;
	logic [3:0] tb_in_sel;
	logic tb_w_enable;
	logic tb_clear_data;
	logic [31:0] tb_in_data;
	logic [31:0] tb_out_data;

	// ESTABLISH DUT

	result_registers result_registers_inst (
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.out_sel(tb_out_sel),
		.in_sel(tb_in_sel),
		.w_enable(tb_w_enable),
		.clear_data(tb_clear_data),
		.in_data(tb_in_data),
		.out_data(tb_out_data)
	);

	// DEFINE TASKS

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

	task check_true(input logic bool, input logic [3:0] test_case);
	begin
		if (bool) begin
			$info("Test Case %d: Result Correct", test_case);
		end
		else begin
			$error("Test Case %d: Result Incorrect", test_case);
		end
	end
	endtask

	logic [15:0] tb_expected_val;

	initial begin

	tb_n_rst = 1;

	tb_out_sel = 4'd0;
	tb_in_sel = 4'd0;
	tb_w_enable = 1'b0;
	tb_clear_data = 1'b0;
	tb_in_data = 16'h0000;

	reset_dut();

	// Test Case 1:
	// Write and read from address

	tb_in_sel = 4'd0;
	tb_in_data = 'h0001;
	tb_w_enable = 1;

	delay_cycles(2);

	tb_w_enable = 0;
	tb_out_sel = 4'd0;

	check_true(tb_in_data == tb_out_data, 1);

	delay_cycles(5);

	// Test Case 2:
	// Write and read from same address

	tb_in_sel = 4'd0;
	tb_in_data = 'h0002;
	tb_w_enable = 1;

	delay_cycles(2);

	tb_w_enable = 0;
	tb_out_sel = 4'd0;

	check_true(tb_in_data == tb_out_data, 2);

	delay_cycles(5);

	// Test Case 3:
	// Attempt write without write enable asserted

	tb_in_sel = 4'd0;
	tb_in_data = 'h0003;
	tb_w_enable = 0;

	delay_cycles(2);

	tb_out_sel = 4'd0;
	tb_expected_val = 'h0002; // value from previous test case

	check_true(tb_expected_val == tb_out_data, 3);

	delay_cycles(5);

	// Test Case 4:
	// Clear data

	tb_clear_data = 1;

	delay_cycles(1);

	tb_clear_data = 0;

	for (int i = 0; i < 10; i = i+1) begin
		tb_out_sel = i;
		delay_cycles(1);
		check_true(0 == tb_out_data, 4);
	end

	delay_cycles(5);

	// Test Case 5:
	// Write and read from address

	tb_in_sel = 4'd9;
	tb_in_data = 'h0005;
	tb_w_enable = 1;

	delay_cycles(2);

	tb_w_enable = 0;
	tb_out_sel = 4'd9;

	check_true(tb_in_data == tb_out_data, 5);

	delay_cycles(5);

	end

endmodule