// $Id: $
// File name:   controller.sv
// Created:     9/28/2016
// Author:      Austin Wilhite
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: Module declaration for the control unit

module multiplier
(
	input wire clk,
	input wire n_reset,
	input wire dr,
	input wire lc,
	input wire overflow,
	output reg cnt_up,
	output reg clear,
	output wire modwait,
	output reg [2:0] op,
	output reg [3:0] src1,
	output reg [3:0] src2,
	output reg [3:0] dest,
	output reg err
);

enum bit[2:0]
{
	NOP, COPY, LOAD1, LOAD2, ADD, SUB, MUL
} opcodes;

enum bit[4:0]
{
	reg0, reg1, reg2, reg3, reg4, reg5, 
	reg6, reg7, reg8, reg9, reg10, reg11
} regs;

typedef enum logic[5:0] 
{
	idle, store, eidle, zero, inc_count,
	sort1, sort2, sort3, sort4, 
	mul1, mul2, mul3, mul4, add1, add2, sub1, sub2,
	load1, wait2, load2, wait3, load3, wait4, load4
} states;

states next_state;
states state;

always_ff @(posedge clk, negedge n_reset) begin
	if (~n_reset) begin
		state <= idle;
		mod <= 0;
		//error <= 0; // remove for comb
	end
	else begin
		state <= next_state;
		mod <= next_modwait;
		//error <= next_err; // remove for comb
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
