// $Id: $
// File name:   tb_counter_10bit.sv
// Created:     11/29/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Test bench for a 10-bit wrapper of the flexible counter

`timescale 1ns / 100ps

module tb_counter_10bit
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

reg [9:0] rollover_val, n_rst, clear, count_enable;
wire [9:0] count_out, rollover_flag;
	
// DUT port map
flex_counter DUT(.clk(tb_clk), .n_rst(n_rst), .clear(clear), .count_enable(count_enable), .rollover_val(rollover_val), .count_out(count_out), .rollover_flag(rollover_flag));

// Test bench process
initial
begin

// Reset

n_rst = 0;

#(CLK_PERIOD);

// Initial Values

n_rst = 1; 
clear = 1;
count_enable = 1;
rollover_val = 8;

// Normal Increment

#(CLK_PERIOD);

assert (count_out == 1)
	$info("Correct count");
else
	$error("Failed count");

assert (rollover_flag == 0)
	$info("Correct rollover");
else
	$error("Failed rollover");

// Reset

n_rst = 0; 
clear = 1;
count_enable = 1;
rollover_val = 8;

#(CLK_PERIOD);

n_rst = 1; 
clear = 1;
count_enable = 0;
rollover_val = 8;

assert (count_out == 0)
	$info("Correct count");
else
	$error("Failed count");

assert (rollover_flag == 0)
	$info("Correct rollover");
else
	$error("Failed rollover");

// Rollover

n_rst = 1; 
clear = 0;
count_enable = 1;
rollover_val = 8;

#(CLK_PERIOD);
#(CLK_PERIOD);

assert (count_out == 2)
	$info("Correct count");
else
	$error("Failed count");

assert (rollover_flag == 1)
	$info("Correct rollover");
else
	$error("Failed rollover");

// Clear

n_rst = 1; 
clear = 0;
count_enable = 1;
rollover_val = 4;

#(CLK_PERIOD)

assert (count_out == 0)
	$info("Correct count");
else
	$error("Failed count");

assert (rollover_flag == 0)
	$info("Correct rollover");
else
	$error("Failed rollover");

// Edge Rollover

n_rst = 1; 
clear = 0;
count_enable = 1;
rollover_val = 5;

#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);
#(CLK_PERIOD);

assert (count_out == 15)
	$info("Correct count");
else
	$error("Failed count");

assert (rollover_flag == 1)
	$info("Correct rollover");
else
	$error("Failed rollover");

// Toggle enable while roll over

n_rst = 1; 
clear = 0;
count_enable = 1;
rollover_val = 6;

#(CLK_PERIOD);

assert (count_out == 15)
	$info("Correct count");
else
	$error("Failed count");

assert (rollover_flag == 1)
	$info("Correct rollover");
else
	$error("Failed rollover");

#(CLK_PERIOD);

n_rst = 1; 
clear = 0;
count_enable = 1;
rollover_val = 7;

assert (count_out == 1)
	$info("Correct count");
else
	$error("Failed count");

assert (rollover_flag == 1)
	$info("Correct rollover");
else
	$error("Failed rollover");
// 

end
endmodule
