// $Id: $
// File name:   flex_counter.sv
// Created:     9/8/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flexible size rollover counter

module flex_counter
#(
    parameter NUM_CNT_BITS = 4
)
(
    input wire clk,
    input wire n_rst,
    input wire clear,
    input wire count_enable,
    input wire [(NUM_CNT_BITS-1):0] rollover_val,
    output reg [(NUM_CNT_BITS-1):0] count_out,
    output reg rollover_flag
);

reg [(NUM_CNT_BITS-1):0] next_count;
reg next_flag;

// counter register
always_ff @(posedge clk, negedge n_rst)
begin
    if(n_rst == 0)
    begin
        count_out <= '0;
    end
    else
    begin
        count_out <= next_count;
    end
end
// next counter value logic
always_comb
begin
    next_count = count_out;
    next_flag = 1'b0;

    if(clear == 1'b1)
    begin
        next_count = '0;
    end
    else if(count_enable == 1)
    begin
        if(rollover_flag == 1)
				begin
        	next_count = 1;
				end
    		else
    		begin
       	 next_count = count_out + 1'b1;
    		end
    end
		if(next_count == rollover_val)
		begin
			next_flag = 1'b1;
		end
end

// rollover_flag register
always_ff @(posedge clk, negedge n_rst)
begin
    if(n_rst == 0)
    begin
        rollover_flag <= 1'b0;
    end
    else
    begin
        rollover_flag <= next_flag;
    end
end
// next rollover flag logic
/*
always_comb
begin
    if(clear == 1'b1)
    begin
        next_flag = 1'b0;
    end
    else if(count_enable == 1'b1)
    begin
        if((count_out + 1'b1) == rollover_val)
        begin
            next_flag = 1'b1;
        end
    end
    else
    begin
        if((count_out) == rollover_val)
        begin
            next_flag = 1'b1;
        end
    end

end*/
endmodule
