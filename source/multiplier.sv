// $Id: $
// File name:   controller.sv
// Created:     11/28/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Module declaration for multiplier block
//
//				Four states: idle, setup, mult, and done
//				Includes flex_counter module
//				
//				Operation:	wait for begin_mult signal to be asserted
//						  	advance to setup state to set initial addresses
//							advance and continue in mult state for 392 cycles
//							advance to done state to write results
//
// Compile: 	make -f mult_makefile sim_full_mapped

module multiplier
(
	input wire clk,
	input wire n_rst,
	input wire [3:0] row_select,
	input wire begin_mult,
	input wire [15:0] pixel_value,
	input wire [31:0] weight_value,
	output wire [9:0] pixel_address,
	output wire [11:0] weight_address,
	output wire done_row,
	output wire [31:0] row_result,
	output wire overflow,
	output wire w_result_ena
);

parameter PIXEL_ADDR_START = 10'h000;
parameter WEIGHT_ADDR_START = 12'h00;

logic count_enable;
logic row_complete;
logic rollover_flag;

logic write_enable;
logic next_w_ena;

logic [32:0] result;
logic [32:0] next_result;
logic [9:0] count;

logic [31:0] product_1;
logic [31:0] product_2;

logic [9:0] pixel_addr;
logic [11:0] weight_addr;

assign row_result = result[31:0];
assign overflow = (result[32:31] == 2'b01) || (result[32:31] == 2'b10);
assign done_row = row_complete;
assign pixel_address = pixel_addr;
assign weight_address = weight_addr;

assign w_result_ena = write_enable;

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
		write_enable <= 'b0;
	end
	else begin
		state <= next_state;
		result <= next_result;
		write_enable <= next_w_ena;
	end
end

/////////////////////
// NEXT STATE LOGIC
/////////////////////

always_comb begin

	// DEFINE DEFAULT VALUES

	next_state = state;
	next_w_ena = write_enable;

	// OUTPUT LOGIC CASES

	case (state)
		// IDLE

		idle: begin
			next_w_ena = 1'b0;
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
				next_w_ena = 1'b1;
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
	pixel_addr = PIXEL_ADDR_START;
	weight_addr = WEIGHT_ADDR_START;
	next_result = result;

	// OUTPUT LOGIC CASES

	case (state)

		idle: begin
			count_enable = 0;
		end

		setup: begin
			next_result = 0;

			pixel_addr = PIXEL_ADDR_START;
			weight_addr = WEIGHT_ADDR_START + (row_select * 10'd392);
		end

		mult: begin
			product_1 = $signed({8'b0,pixel_value[15:8]}) * $signed(weight_value[31:16]);
			product_2 = $signed({8'b0,pixel_value[7:0]}) * $signed(weight_value[15:0]);

			next_result = result + product_1 + product_2;

			if (!rollover_flag) begin
				pixel_addr = (PIXEL_ADDR_START + count);
				weight_addr = WEIGHT_ADDR_START + (row_select * 10'd392) + count;
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
	.clear(row_complete),
	.count_enable(count_enable), 
	.rollover_val(10'd392),
	.count_out(count), 			// out
	.rollover_flag(rollover_flag)
);

endmodule
