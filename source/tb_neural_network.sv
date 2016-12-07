// $Id: $
// File name:   tb_neural_network.sv
// Created:     12/1/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Top level testbench

`timescale 1ns / 100ps


module tb_neural_network (
	input clk,    // Clock
	input clk_en, // Clock Enable
	input rst_n  // Asynchronous reset active low
	
);

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



endmodule