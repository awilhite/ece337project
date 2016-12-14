// $Id: $
// File name:   tb_neural_network.sv
// Created:     12/1/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Top level testbench

`timescale 1ns / 100ps


module tb_neural_network ();
   localparam CLK_PERIOD = 20;
   localparam CONTROL_REG = 13'd4126;
   localparam STATUS_REG = 13'd4127;
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
   logic [12:0] tb_address;
   logic [31:0] tb_writedata;
   logic [31:0] tb_readdata;
   logic 	tb_readdatavalid;
   logic 	tb_waitrequest;
   logic [1:0] 	tb_response;

   //DUT
   neural_network DUT(.clk(tb_clk), .reset_n(tb_n_rst), .write(tb_write), .read(tb_read), .beginbursttransfer(tb_beginbursttransfer), .burstcount(tb_burstcount), .address(tb_address), .writedata(tb_writedata), .readdata(tb_readdata), .readdatavalid(tb_readdatavalid), .waitrequest(tb_waitrequest), .response(tb_response));

   //Tasks
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

   
   initial
     begin
	
     end
endmodule
