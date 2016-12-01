// $Id: $
// File name:   controller.sv
// Created:     11/28/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Module declaration for multiplier block
// Compile: make -f mult_makefile sim_full_source

module multiplier
(
	input wire clk,
	input wire n_rst,
	input wire [3:0] row_select,
	input wire begin_mult,
	input wire [7:0] pixel_value_1,
	input wire [7:0] pixel_value_2,
	input wire [15:0] weight_value_1,
	input wire [15:0] weight_value_2,
	output wire [9:0] pixel_address_1,
	output wire [9:0] pixel_address_2,
	output wire [12:0] weight_address_1,
	output wire [12:0] weight_address_2,
	output wire done_row,
	output wire [15:0] row_result
);

parameter PIXEL_ADDR_START = 8'h00;
parameter WEIGHT_ADDR_START = 8'h00;

logic count_enable;
logic row_complete;
logic rollover_flag;

logic [15:0] result;
logic [9:0] count;

logic [15:0] product_1;
logic [15:0] product_2;

logic [9:0] pixel_addr_1;
logic [9:0] pixel_addr_2;
logic [12:0] weights_addr_1;
logic [12:0] weights_addr_2;

assign row_result = result;
assign done_row = row_complete;
assign pixel_address_1 = pixel_addr_1;
assign pixel_address_2 = pixel_addr_2;
assign weights_address_1 = weights_addr_1;
assign weights_address_1 = weights_addr_2;

// DEFINE STATES

typedef enum logic[2:0] 
{
	idle, setup, load, mult, done
} states;

states next_state;
states state;

// STATE MACHINE

always_ff @(posedge clk, negedge n_rst) begin
	if (~n_rst) begin
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
			next_state = mult;
		end

		mult: begin
			if (count < 381) begin
				// continue loading data and multiplying until row is complete
				next_state = load;
			end
			else begin
				// row is complete
				next_state = done;
			end
		end

		done: begin
			next_state = idle;
		end

	endcase	// end cases
end

/////////////////
// OUTPUT LOGIC
/////////////////

always_comb begin

	row_complete = 0;
	count_enable = 1;

	case (state)

		idle: begin
			count_enable = 0;
		end

		setup: begin
			result = 0;
		end

		load: begin
			pixel_addr_1 = PIXEL_ADDR_START + (row_select * 784) + (count * 2);
			pixel_addr_2 = PIXEL_ADDR_START + (row_select * 784) + (count * 2 + 1);
			weights_addr_1 = WEIGHT_ADDR_START + (row_select * 784) + (count * 2);
			weights_addr_2 = WEIGHT_ADDR_START + (row_select * 784) + (count * 2 + 1);
		end

		mult: begin
			product_1 = pixel_value_1 * weight_value_1;
			product_2 = pixel_value_2 * weight_value_2;

			result = result + product_1 + product_2;
		end

		done: begin
			row_complete = 1;
		end

	endcase
end

// COUNTER

flex_counter #(
	.NUM_CNT_BITS(10)
)
counter
(
	.clk(clk), 
	.n_rst(n_rst), 
	.clear(begin_mult),
	.count_enable(count_enable), 
	.rollover_val(10'd391),
	.count_out(count), 			// out
	.rollover_flag(rollover_flag)
);

endmodule
