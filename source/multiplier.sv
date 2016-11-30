// $Id: $
// File name:   controller.sv
// Created:     11/28/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Module declaration for multiplier block

module multiplier
(
	input wire clk,
	input wire n_reset,
	input wire row_select,
	input wire begin_mult,
	input wire [7:0] pixel_value_1,
	input wire [7:0] pixel_value_2,
	input wire [15:0] weight_value_1,
	input wire [15:0] weight_value_2,
	output wire [9:0] pixel_address_1,
	output wire [9:0] pixel_address_2,
	output wire [12:0] weight_address_1,
	output wire [12:0] weight_address_2,
	output wire done_row
);

wire count_enable;
wire rollover_flag;

reg [15:0] row_result;
reg [9:0] count;

typedef enum logic[1:0] 
{
	idle, calculate, done
} states;

states next_state;
states state;

always_ff @(posedge clk, negedge n_reset) begin
	if (~n_reset) begin
		state <= idle;
	end
	else begin
		state <= next_state;
	end
end

/////////////////////
// NEXT STATE LOGIC
/////////////////////

always_comb begin
	next_state = state;
	next_row_result = row_result;

	case (state)
		// IDLE

		idle: begin
			if (begin_mult) begin
				next_state = setup;
			end
		end

		setup: begin
			next_state = load;
		end

		load: begin
			if (count < 783) begin
				next_state = mult;
			end
			else
				next_state = idle;
			end
		end

		mult: begin
			next_state = idle;
		end

	endcase	// end cases
end

/////////////////
// OUTPUT LOGIC
/////////////////

always_comb begin

	done_row = 0;
	count_enable = 0;

	case (state)

		idle: begin

		end

		setup: begin
			count_enable = 1;
			row_result = 0;
		end

		load: begin
			pixel_address_1 = 0;
			pixel_address_2 = 0;
			weight_address_1 = 0;
			weight_address_2 = 0;
		end

		mult: begin
			product_1 = pixel_value_1 * weight_value_1;
			product_2 = pixel_value_2 * weight_value_2;

			row_result = row_result + product_1 + product_2;
		end

	endcase
end

flex_counter #(
	.NUM_CNT_BITS(10)
)
counter
(
	.clk(clk), 
	.n_rst(n_reset), 
	.clear(begin_mult),
	.count_enable(count_enable), 
	.rollover_val(10'd783),
	.count_out(count), 			// out
	.rollover_flag(rollover_flag)
);

endmodule
