// $Id: $
// File name:   tb_neural_network.sv
// Created:     12/1/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Top level testbench

`timescale 1ns / 100ps

module tb_neural_network ();
   
   localparam	CLK_PERIOD	= 2.5;
   
   // Clock variable
   logic clk;    // Clock
   
   // Clock generation block
   always
     begin
	clk = 1'b0;
	#(CLK_PERIOD/2.0);
	clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   //Portmap signals

   logic n_rst;	
   logic read;
   logic beginbursttransfer;
   logic write;
   logic [9:0] burstcount;
   logic [10:0] address; 
   logic [31:0] writedata;
   logic [31:0] readdata;
   logic readdatavalid;
   logic waitrequest;
   logic [1:0] response;
   
   //Other Signals
   logic       done_calc;
   logic [16:0] result_output;
   logic [10:0] weight_address;
   logic [10:0] pixel_address;
   logic 	w_enable_weights;
   logic 	w_enable_pixels;
   logic [15:0] store_data;
   logic [3:0] 	output_address;
   logic 	start_calc;

   logic [3:0] 	row_select;
   logic 	begin_mult;
   logic [7:0] 	pixel_value_1;
   logic [7:0] 	pixel_value_2;
   logic [15:0] weight_value_1;
   logic [15:0] weight_value_2;
   logic [9:0] 	pixel_address_1;
   logic [9:0] 	pixel_address_2;
   logic [12:0] weight_address_1;
   logic [12:0] weight_address_2;
   logic 	done_row;
   logic [15:0] row_result; 

   //DUT portmap
   avalon_interface avalon_interface_inst
     (
      .clk(clk),    // Clock
      .n_rst(n_rst),
      .write(write),
      .read(read),
      .beginbursttransfer(beginbursttransfer),
      .burstcount(burstcount),
      .address(address),
      .writedata(writedata),
      .readdata(readdata),
      .result_output(result_output),
      .done_calc(done_calc),
      .weight_address(weight_address),
      .pixel_address(pixel_address),
      .w_enable_weights(w_enable_weights),
      .w_enable_pixels(w_enable_pixels),
      .readdatavalid(readdatavalid),
      //.writeresponsevalid(writeresponsevalid),
      .store_data(store_data),
      .output_address(output_address),
      .waitrequest(waitrequest),
      .start_calc(start_calc),
      .response(response)
      );

/*
   multiplier multiplier_inst
     (
      .clk(clk),
      .n_rst(n_rst),
      .row_select(row_select),
      .begin_mult(begin_mult),
      .pixel_value_1(pixel_value_1),
      .pixel_value_2(pixel_value_2),
      .weight_value_1(weight_value_1),
      .weight_value_2(weight_value_2),
      .pixel_address_1(pixel_address_1),
      .pixel_address_2(pixel_address_2),
      .weight_address_1(weight_address_1),
      .weight_address_2(weight_address_2),
      .done_row(done_row),
      .row_result(row_result)
      );

   main_controller main_controller_inst
     (
      .clk(clk),
      .n_reset(n_rst),
      .start_calc(start_calc),
      .done_row(done_row),
      .res_add(res_add),
      .begin_mult(begin_mult),
      .done_calc(done_calc)
      );

   pixel_memory	pixel_memory_inst 
     (
      .address_a ( pixel_address ),
      .address_b ( 'b0 ),
      .clock ( clk ),
      .data_a ( store_data ),
      .data_b ( 'b0 ),
      .wren_a ( w_enable_pixels ),
      .wren_b ( 'b0 ),
      .q_a ( q_a ),
      .q_b ( q_b )
      );
*/

   ////////////  Avalon interface  /////////////
   task reset_dut;
      begin
	 n_rst = 1'b0;
	 @(posedge clk);
	 @(posedge clk);
	 n_rst = 1'b1;
	 @(posedge clk);
	 @(posedge clk);
      end
   endtask : reset_dut

   task _read_(input logic [10:0] addr);
      begin
	 @(posedge clk);
	 address = addr;
	 read = 1'b1;
	 write = 1'b0;
	 @(negedge waitrequest);
	 @(posedge readdatavalid);
	 address = '0;
	 read = 1'b0;



      end
   endtask

   task _write_(input logic [10:0] addr, input logic [31:0] data);
      begin
	 @(posedge clk);
	 address = addr;
	 writedata = data;
	 write = 1'b1;
	 read = 1'b0;
	 @(negedge waitrequest);
	 #(CLK_PERIOD);
	 @(posedge clk);
	 address = 'b0;
	 write = 1'b0;
	 writedata = 'b0;


      end
   endtask

   task burst_write(input logic [10:0] addr, input logic [31:0] data[0:10]);
      begin
	 @(posedge clk);
	 address = addr;
	 write = 1'b1;
	 read = 1'b0;
	 beginbursttransfer= 1'b1;
	 burstcount = 11'd10;
	 for (int i = 0; i < 10; i++) begin
	    writedata = data[i];
	    @(negedge waitrequest);
	    @(posedge clk);
	    beginbursttransfer = 1'b0;
	    burstcount = 'b0;
	    address = 'b0;

	 end
	 write = 1'b0;


      end
   endtask

   logic [31:0] expected_val = 32'h00000008;
   logic [31:0] data[0:10];

   /////////////////////////////////////////
   initial
     begin
	beginbursttransfer = 'b0;
 	burstcount = 'b0;
 	done_calc = 0'b0;
 	result_output = 'b0;

	reset_dut();

	_write_(11'h001,expected_val);
	if(response != 2'b00) begin
	   //$error("bad write response");
	end
	_read_(11'h001);
	if(response == 2'b00 && readdata == expected_val) begin
	   $info("Data written sucessfully");
	end
	else
	  //	$error("Error in data write");
	  for (int i=0;i<=10;i=i+1)
    	    data[i] = 2*i;
	burst_write(11'h000,data);
     end  
   
endmodule
