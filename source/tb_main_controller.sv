// $Id: $
// File name:   tb_main_controller.sv
// Created:     9/15/2016
// Author:      Kshitij Jain
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Test bench for main_controller

`timescale 1ns / 100ps

module tb_main_controller
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
   reg tb_n_reset, tb_data_stored, tb_done_row;
   reg [3:0] tb_res_add;
   reg tb_begin_mult, tb_done_calc;
   
   
   // DUT port map
   main_controller DUT(.clk(tb_clk), .n_reset(tb_n_reset), .data_stored(tb_data_stored), .done_row(tb_done_row), .res_add(tb_res_add), .begin_mult(tb_begin_mult), .done_calc(tb_done_calc));
   

   // Test bench process
   initial
     begin

	// Reset
	tb_n_reset = 0;
	
	#(CLK_PERIOD);

	// Initial Values
	tb_data_stored = 0;
	tb_done_row = 0;
	// Normal Increment

	#(CLK_PERIOD);
	tb_n_reset = 1;
	
	#(CLK_PERIOD)
	tb_data_stored = 1;
	
	assert (tb_res_add == 4'b0)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 0)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");
	// Reset
	
	#(CLK_PERIOD)
	tb_data_stored = 0;
		
	assert (tb_res_add == 4'b0)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 0)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	
	//////////  MUL1  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	#(CLK_PERIOD);
	
	assert (tb_res_add == 4'b0)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	#(CLK_PERIOD);
	
	assert (tb_res_add == 4'b0)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL1  //////////


	//////////  MUL2  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0001)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b0001)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL2  //////////	


	//////////  MUL3  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0010)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b0010)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL3  //////////	


	//////////  MUL4  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0011)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b0011)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL4  ////////////
       

	//////////  MUL5  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0100)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b0100)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL5  //////////



	//////////  MUL6  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0101)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b0101)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL6  //////////	



	//////////  MUL7  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0110)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b0110)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL7  //////////


	//////////  MUL8  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0111)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b0111)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL8  //////////	
	


	//////////  MUL9  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b1000)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b1000)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL9  //////////



	//////////  MUL10  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b1001)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	#(CLK_PERIOD)
	tb_done_row = 1;
	
	assert (tb_res_add == 4'b1001)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 1)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL10  //////////	



	//////////  MUL_DONE  //////////
	#(CLK_PERIOD);
	tb_done_row = 0;
	
	assert (tb_res_add == 4'b0)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 0)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 0)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");
	
	//////////  end MUL_DONE  //////////


	
	//////////  WRITE_OUT  //////////
	#(CLK_PERIOD)
	
	assert (tb_res_add == 4'b0)
	  $info("Correct address");
	else
	  $error("Failed address");

	assert (tb_begin_mult == 0)
	  $info("Correct begin_mult");
	else
	  $error("Failed begin_mult");

	assert (tb_done_calc == 1)
	  $info("Correct done_calc");
	else
	  $error("Failed done_calc");

	//////////  end MUL_DONE  //////////

	
     end
endmodule

