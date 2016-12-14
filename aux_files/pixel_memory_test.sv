// $Id: $
// File name:   tb_pixel_memory_sel.sv
// Created:     9/15/2016
// Author:      Kshitij Jain
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Test bench for image storage block

`timescale 1ns / 100ps

module pixel_memory_test
(
 input [8:0]   address_a,
 input [8:0]   address_b,
 input 	       clk,
 input 	       select,
 input [15:0]  data_a,
 input [15:0]  data_b,
 input 	       wren_a,
 input 	       wren_b,
 output [15:0] q_a,
 output [15:0] q_b
);

   integer   file;
   
   /*
    * always_ff @(posedge clk)
     begin
	
     end
    */
   
   always_comb
     begin
	file = $fopen("mem.txt","r+");
	$fwrite(file,"%d\n%d\n",data_a, data_b);
	$fclose(file);
     end

   /*
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
    */
   
endmodule // tb_pixel_memory_sel
