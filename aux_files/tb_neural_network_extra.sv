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
   logic [16:0] tb_result_output;
   logic 	tb_done_calc;
   logic 	tb_overflow;
   logic [11:0] tb_weight_address;
   logic [9:0] 	tb_pixel_address;
   logic 	tb_w_enable_weights;
   logic 	tb_w_enable_pixels;
   logic 	tb_readdatavalid;
   logic 	tb_writeresponsevalid;
   logic [15:0] tb_store_data;
   logic [3:0] 	tb_output_address;
   logic 	tb_waitrequest;
   logic 	tb_start_calc;
   logic 	tb_clear_data;
   logic [1:0] 	tb_response;

   logic [3:0] 	tb_row_select;

   logic 	tb_begin_mult;
   logic [7:0] 	tb_pixel_value_1;
   logic [7:0] 	tb_pixel_value_2;
   logic [15:0] tb_weight_value_1;
   logic [15:0] tb_weight_value_2;
   logic [9:0] 	tb_pixel_address_1;
   logic [9:0] 	tb_pixel_address_2;
   logic [11:0] tb_weight_address_1;
   logic [11:0] tb_weight_address_2;
   logic 	tb_done_row;
   logic [15:0] tb_row_result;
   logic 	tb_overflow;
   logic 	tb_w_result_ena;
   
   avalon_interface DUT
      (
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
       .overflow(tb_overflow),
       .weight_address(tb_weight_address),
       .pixel_address(tb_pixel_address),
       .w_enable_weights(tb_w_enable_weights),
       .w_enable_pixels(tb_w_enable_pixels),
       .readdatavalid(tb_readdatavalid),
       .writeresponsevalid(tb_writeresponsevalid),
       .store_data(tb_store_data),
       .output_address(tb_output_address),
       .waitrequest(tb_waitrequest),
       .start_calc(tb_start_calc),
       .clear_data(tb_clear_data),
       .response(tb_response)
       );



   multiplier multiplier_inst
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
      .overflow(tb_overflow),
      .w_result_ena(tb_w_result_ena)
      );

   ////////////  Avalon interface  /////////////
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

   task read(input logic [12:0] addr);
      begin
	 @(posedge tb_clk);
	 tb_address = addr;
	 tb_read = 1'b1;
	 tb_write = 1'b0;
	 @(negedge tb_waitrequest);

	 if(tb_response == 'b0) begin
	    @(posedge tb_readdatavalid);
	 end
	 tb_address = '0;
	 tb_read = 1'b0;
      end
   endtask

   task write(input logic [12:0] addr, input logic [31:0] data);
      begin
	 @(posedge tb_clk);
	 tb_address = addr;
	 tb_writedata = data;
	 tb_write = 1'b1;
	 tb_read = 1'b0;
	 @(negedge tb_waitrequest);
	 //#(CLK_PERIOD);
	 @(posedge tb_clk);
	 tb_address = 'b0;
	 tb_write = 1'b0;
	 tb_writedata = 'b0;
      end
   endtask

   task burst_write(input logic [12:0] addr, input logic [31:0] data[0:195]);
      begin
	 @(posedge tb_clk);
	 tb_address = addr;
	 tb_write = 1'b1;
	 tb_read = 1'b0;
	 tb_beginbursttransfer= 1'b1;
	 tb_burstcount = 11'd196;
	 @(negedge tb_waitrequest)
	   for (int i = 0; i <= 195; i++) begin
	      tb_writedata = data[i];
	      @(negedge tb_waitrequest);
	      @(posedge tb_clk);
	      tb_beginbursttransfer = 1'b0;
	      tb_burstcount = 'b0;
	      tb_address = 'b0;
	      if(data[i] != tb_store_data || tb_w_enable_pixels != 1'b1 || tb_pixel_address != i) begin
		 $error("data burst failed");
	      end
	      else
		$info("burst good");
	   end
	 tb_write = 1'b0;


      end
   endtask

   logic [31:0] expected_val = 32'h0000000F;
   logic [31:0] data[0:195];

   
   task call_avalon_interface();
      begin
	 tb_beginbursttransfer = 'b0;
 	 tb_burstcount = 'b0;
 	 tb_done_calc = 0'b0;
 	 tb_result_output = 'b0;
 	 tb_read = 1'b0;
 	 tb_write = 1'b0;
 	 tb_overflow = 1'b0;

	 reset_dut();

	 write(CONTROL_REG,expected_val);
	 if(tb_response != 2'b00) begin
	    $error("bad write response");
	 end
	 read(CONTROL_REG);
	 #(CLK_PERIOD/10)
	 if(tb_response == 2'b00 && tb_readdata == expected_val) begin
	    $info("Data written sucessfully");
	 end
	 else
	   $error("Error in data write");

	 for (int i=0;i<=195;i=i+1)
    	   data[i] = 2*i;
	 burst_write(11'h000,data);

	 read(13'd5000);
	 #(CLK_PERIOD/10);
	 if(tb_response != 2'b11) begin
	    $error("No address error!");
	 end
	 read(13'd4125);
	 #(CLK_PERIOD/10);
	 if(tb_output_address != 4'd10) begin
	    $error("Bad address output");
	 end
	 read(13'd4124);
	 #(CLK_PERIOD/10);
	 if(tb_output_address != 4'd9) begin
	    $error("Bad address output");
	 end
	 tb_done_calc = 1'b1;
	 read(STATUS_REG);	  
      end
   endtask // call_avalon_interface
  
   /////////////////////////////////////////


   //////////// Multiplier ////////////////
   
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

   task call_multiplier;
      begin
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
	 // Expected Result 392
	 // One of weight values set to zero

	 tb_pixel_value_1 = 8'h01;
	 tb_pixel_value_2 = 8'h01;
	 tb_weight_value_1 = 16'h0001;
	 tb_weight_value_2 = 16'h0000;

	 tb_row_select = 1;

	 tb_expected_val = 16'd392;

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

	 // Test Case 2: Expected Result 392
	 // Overflow condition

	 tb_pixel_value_1 = 8'h01;
	 tb_pixel_value_2 = 8'h01;
	 tb_weight_value_1 = 16'd168;
	 tb_weight_value_2 = 16'h0000;

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
   endtask
   ///////////////////////////////////////



   
   /// main design module calls///   
   initial
     begin
	call_avalon_interface();
	call_multiplier();	
     end  
   
endmodule
