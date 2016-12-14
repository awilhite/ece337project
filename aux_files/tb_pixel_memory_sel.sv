// $Id: $
// File name:   tb_pixel_memory_sel.sv
// Created:     9/15/2016
// Author:      Kshitij Jain
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Test bench for image storage block

`timescale 1ns / 100ps

module tb_pixel_memory_test
  ();

   localparam	CLK_PERIOD	= 2.5;
   
   // Clock variable
   reg tb_clk;
   
   // Clock generation block
   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   // Declare Design Under Test (DUT) portmap signals
   //reg [9:0] tb_add_a_1, tb_add_a_2, tb_address_b;
   reg tb_select, tb_wren_a, tb_wren_b;
   reg [7:0] tb_data_a, tb_data_b;
   reg [7:0] tb_q_a, tb_q_b;
   integer   file;
   
   
   // DUT port map
  // pixel_memory_sel DUT(.clk(tb_clk), .address_a_1(tb_add_a_1), .address_a_2(tb_add_a_2), .address_b(tb_address_b), .select(tb_select), .data_a(tb_data_a), .data_b(tb_data_b), .wren_a(tb_wren_a), .wren_b(tb_wren_b), .q_a(tb_q_a), .q_b(tb_q_b));
   
   // Test bench process
   initial
     begin
	file = $fopen("mem.txt","r+");
	
	#(CLK_PERIOD);	
	tb_select = 0;
	tb_data_a = 8'b10101010;
	tb_data_b = 8'b11110000;

	//Joey writes
	tb_wren_a = 1;
	$fwrite(file,"%d\n%d\n",tb_data_a, tb_data_b);
	
	#(CLK_PERIOD);
	#(CLK_PERIOD);

	//Joey reads
	tb_wren_a = 0;
	$fscanf(file,"%d\n%d\n",tb_q_a, tb_q_b);
	$fclose(file);
	
	#(CLK_PERIOD);
	#(CLK_PERIOD);

	file = $fopen("mem.txt","r+");
	
	tb_select = 1;
	tb_data_a = 8'b11111111;
	tb_data_b = 8'b00000000;

	//Austin writes
	tb_wren_b = 1;
	$fwrite(file,"%d\n%d\n",tb_data_a, tb_data_b);
	
	#(CLK_PERIOD);
	#(CLK_PERIOD);

	//Austin reads
	tb_wren_b = 0;
	$fscanf(file,"%d\n%d\n",tb_q_a, tb_q_b);
	$fclose(file);
	
     end // initial begin
endmodule // tb_pixel_memory_sel
