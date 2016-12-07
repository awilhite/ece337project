// $Id: $
// File name:   avalon_controller.sv
// Created:     11/29/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: state machine for avalon interface

module avalon_controller (
	input logic clk,    // Clock
	input logic n_rst,
	input logic write,
	input logic read,
	input logic beginbursttransfer,
	input logic [9:0] burstcount,
	input logic [12:0] address,
	input logic [31:0] writedata,
	input logic done_calc,
	output logic readdatavalid,
	output logic writeresponsevalid,
	output logic [10:0] output_address,
	output logic end_wait,
	output logic w_ena,
	output logic [1:0] response
	
);



typedef enum logic [4:0]
		  {idle,begin_read,s_read,bad_addr,begin_write,s_write,burst_begin,
		  chk_burst, burst_write, burst_end, res_err } state_type;

	state_type state, next_state;
	logic [12:0] next_address;
	logic [15:0] data;
	logic [9:0] rollover, next_rollover;
	logic count_ena, clear_cnt, done_burst;
	logic [9:0] cnt;


	flex_counter #(10) burstcounter(clk,n_rst,clear_cnt,count_ena,rollover,cnt,done_burst);


	parameter MAXADDR = 11'h62C;


	always_ff@(posedge clk, negedge n_rst)
	begin
		  if(n_rst == 0)begin
		      state <= idle;
		      output_address <= 'b0;
		      rollover <= 'b0;
	  end
		  else begin
		      state <= next_state;
		      output_address <= next_address;
		      rollover <= next_rollover;
		  end
	end


	always_comb
	begin
		next_state = state;
		case(state)
			idle:begin 
				if(read == 1 && beginbursttransfer == 0) begin
					if(address >= 0 && address <= MAXADDR) begin
						next_state = begin_read;
					end
					else
						next_state = bad_addr;
				end
				if(write == 1 && beginbursttransfer == 0) begin
					if(address >= 0 && address <= MAXADDR) begin
						next_state = begin_write;
					end
					else
						next_state = bad_addr;
				end
				if(write == 1 && beginbursttransfer == 1) begin
					if(address >= 0 && (address + burstcount) <= MAXADDR) begin
						next_state = burst_begin;
					end
					else
						next_state = bad_addr;
				end
			end

			bad_addr:begin 
				next_state = idle;
			end

			begin_read:begin 
				next_state = s_read;
			end
			s_read:begin 
				next_state = idle;

			end

			begin_write:begin 
				next_state = s_write;
			end


			s_write:begin 
				next_state = idle;
			end

			chk_burst:begin 
				if(done_burst) begin
					next_state = burst_end;
				end
				else
					next_state = burst_write;
			end

			burst_begin:begin 
				next_state = burst_write;
			end

			burst_write:begin
				next_state = chk_burst;
			end

			burst_end:begin
				next_state = idle;
			end

			res_err:begin 

			end

		endcase // state
	end

	always_comb begin
		end_wait = 0;
		response = 2'b00;
		writeresponsevalid = 1'b0;
		next_address = output_address;
		next_rollover = rollover;
		readdatavalid = 1'b0;
		w_ena = 1'b0;
		count_ena = 1'b0;
		clear_cnt = 1'b0;
		case(state)
			idle:begin 

			end

			begin_read:begin 
				next_address = address;
				end_wait = 1'b1;
			end

			begin_write:begin 
				next_address = address;
				w_ena = 1'b1;
				//end_wait = 1'b1;
			end

			s_read:begin 
				response = 2'b00;
				//data = result_output;
				readdatavalid = 1'b1;
				end_wait = 1'b1;
			end

			s_write:begin 
				end_wait = 1'b1;
				next_address = address;
				writeresponsevalid = 1'b1;
				response = 2'b00;
				data = writedata;
				w_ena = 1'b1;

			end

			chk_burst:begin 
			end

			burst_begin:begin 
				next_address = address + cnt;
				next_rollover = burstcount + 1;
				count_ena = 1'b1; 
			end

			burst_write:begin 
				end_wait = 1'b1;
				next_address = address + cnt;
				data = writedata;
				w_ena = 1'b1;
				count_ena = 1'b1; 

			end

			burst_end:begin
				clear_cnt = 1'b1;
				next_rollover = 'b0;
			end

			bad_addr:begin 
				response = 2'b11;
				end_wait = 1'b1;
			end

			res_err:begin 

			end

		endcase // state
	end

endmodule