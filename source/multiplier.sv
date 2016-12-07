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
	output wire [15:0] row_result,
	output wire overflow
);

parameter PIXEL_ADDR_START = 8'h00;
parameter WEIGHT_ADDR_START = 8'h00;

logic count_enable;
logic row_complete;
logic rollover_flag;


logic [16:0] result;
logic [16:0] next_result;
logic [9:0] count;

logic [15:0] product_1;
logic [15:0] product_2;

logic [9:0] pixel_addr_1;
logic [9:0] pixel_addr_2;
logic [12:0] weight_addr_1;
logic [12:0] weight_addr_2;

assign row_result = result[15:0];
assign overflow = result[16];
assign done_row = row_complete;
assign pixel_address_1 = pixel_addr_1;
assign pixel_address_2 = pixel_addr_2;
assign weight_address_1 = weight_addr_1;
assign weight_address_2 = weight_addr_2;

// DEFINE STATES

typedef enum logic[1:0] 
{
	idle, setup, mult, done
} states;

states next_state;
states state;

// STATE MACHINE

always_ff @(posedge clk, negedge n_rst) begin
	if (~n_rst) begin
		state <= idle;
		result <= 'b0;
	end
	else begin
		state <= next_state;
		result <= next_result;
	end
end

/////////////////////
// NEXT STATE LOGIC
/////////////////////

always_comb begin

	// DEFINE DEFAULT VALUES

	next_state = state;

	// OUTPUT LOGIC CASES

	case (state)
		// IDLE

		idle: begin
			if (begin_mult) begin
				next_state = setup;
			end
		end

		setup: begin
			next_state = mult;
		end

		mult: begin
			if (!rollover_flag) begin
				// continue loading data and multiplying until row is complete
				next_state = mult;
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

	// DEFINE DEFAULT VALUES
	row_complete = 0;
	count_enable = 1;
	pixel_addr_1 = PIXEL_ADDR_START;
	pixel_addr_2 = PIXEL_ADDR_START + 1'b1;
	weight_addr_1 = WEIGHT_ADDR_START;
	weight_addr_2 = WEIGHT_ADDR_START + 1'b1;
	next_result = result;

	// OUTPUT LOGIC CASES

	case (state)

		idle: begin
			count_enable = 0;
		end

		setup: begin
			next_result = 0;

			pixel_addr_1 = PIXEL_ADDR_START;
			pixel_addr_2 = PIXEL_ADDR_START + 1'b1;

			weight_addr_1 = WEIGHT_ADDR_START + (row_select * 10'd784);
			weight_addr_2 = WEIGHT_ADDR_START + (row_select * 10'd784) + 1'b1;
		end

		mult: begin
			product_1 = pixel_value_1 * weight_value_1;
			product_2 = pixel_value_2 * weight_value_2;

			next_result = result + product_1 + product_2;

			if (!rollover_flag) begin
				pixel_addr_1 = PIXEL_ADDR_START + (count * 2);
				pixel_addr_2 = PIXEL_ADDR_START + (count * 2 + 1'b1);

				weight_addr_1 = WEIGHT_ADDR_START + (row_select * 10'd784) + (count * 2);
				weight_addr_2 = WEIGHT_ADDR_START + (row_select * 10'd784) + (count * 2 + 1'b1);
			end
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
	.rollover_val(10'd392),
	.count_out(count), 			// out
	.rollover_flag(rollover_flag)
);

endmodule
