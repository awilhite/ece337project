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
	output reg cnt_up,
	output reg clear,
	output wire modwait,
	output reg [2:0] op,
	output reg [3:0] src1,
	output reg [3:0] src2,
	output reg [3:0] dest,
	output reg err
);

typedef enum logic[5:0] 
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
	next_modwait = mod;
	//next_err = 0;	// remove for comb

	case (state)
		// IDLE

		idle: begin
			if (dr) begin
				next_state = store;
				next_modwait = 1;
			end
		end

		// LOAD COEFFICIENTS

		load1: begin
			next_modwait = 0;
			next_state = wait2;
		end

		wait2: begin
			if (lc) begin
				next_modwait = 1;
				next_state = load2;
			end
			else begin
				next_modwait = 0;
				next_state = wait2;
			end
		end

		load2: begin
			next_modwait = 0;
			next_state = wait3;
		end

		wait3: begin
			if (lc) begin
				next_modwait = 1;
				next_state = load3;
			end
			else begin
				next_modwait = 0;
				next_state = wait3;
			end
		end

		load3: begin
			next_modwait = 0;
			next_state = wait4;
		end

		wait4: begin
			if (lc) begin
				next_modwait = 1;
				next_state = load4;
			end
			else begin
				next_modwait = 0;
				next_state = wait4;
			end
		end

		load4: begin
			next_modwait = 0;
			next_state = idle;
		end

		store: begin
			if (dr) begin
				next_state = zero;
				next_modwait = 1;
			end
			else begin
				next_state = eidle;
				next_modwait = 0;
				//next_err = 1;
			end
		end

	endcase	// end cases
end

/////////////////
// OUTPUT LOGIC
/////////////////

always_comb begin

	error = 0;
	cnt_up = 0;
	op = NOP;
	dest = reg0;
	src1 = reg0;
	src2 = reg0;
	clear = 0;

	case (state)
		// IDLE

		idle: begin
		end

		// ERROR IDLE

		eidle: begin
			error = 1;
		end

		// LOAD COEFFICIENTS

		load1: begin
			op = LOAD2;
			dest = reg7;
			clear = 1;
		end

		wait2: begin
		end

		load2: begin
			op = LOAD2;
			dest = reg8;
		end

		wait3: begin

		end

		load3: begin
			op = LOAD2;
			dest = reg9;
		end

		wait4: begin

		end

		load4: begin
			op = LOAD2;
			dest = reg10;
		end

		store: begin
			op = LOAD1;
			dest = reg5;
		end

	endcase	// end cases
end

endmodule
