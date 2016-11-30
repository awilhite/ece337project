// $Id: $
// File name:   flex_counter.sv
// Created:     9/15/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Flexible Counter

module flex_counter
#(
	NUM_CNT_BITS = 4
)
(
	input clk, n_rst, clear, count_enable, [(NUM_CNT_BITS - 1):0] rollover_val,
	output reg [(NUM_CNT_BITS - 1):0] count_out, 
	output reg rollover_flag
);

reg [(NUM_CNT_BITS - 1):0] next;
reg flag;

always_ff @(posedge clk, negedge n_rst) begin
	if (~n_rst) begin
		count_out <= 0;
		rollover_flag <= 0;
	end
	else begin
		count_out <= next;
		rollover_flag <= flag;
	end
end

always_comb begin
	if (clear)
	begin
		flag = 0;
    	next = 0;
	end // if
	else 
	begin
		if (count_enable)
		begin
    		if (count_out == rollover_val)
				next = 1;				 
			else
				next = count_out + 1;
		end // if
    	else 
		begin
			next = count_out;
		end // else

		if (next == rollover_val)
    		flag = 1;
		else
			flag = 0;
	end // else
end // always

endmodule
