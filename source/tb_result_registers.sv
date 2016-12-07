// $Id: $
// File name:   tb_result_registers.sv
// Created:     12/06/2016
// Author:      
// Lab Section: 04
// Version:     1.0  Initial Design Entry
// Description: Test bench for result registers

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

	logic [3:0] tb_out_sel;
	logic [3:0] tb_in_sel;
	logic tb_w_enable;
	logic tb_clear_data;
	logic [15:0] tb_in_data;
	logic [15:0] tb_out_data;

	// ESTABLISH DUT

	result_registers result_registers_inst (
		.clk(clk),
		.n_rst(n_rst),
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

	initial begin


	end
	
endmodule