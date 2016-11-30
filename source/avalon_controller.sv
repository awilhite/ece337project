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
	input logic [10:0] address,
	input logic [31:0] writedata,
	output logic [31:0] readdata,
	input logic [31:0] result_output,
	input logic done_calc,
	input logic done_burst,
	output logic readdatavalid,
	output logic writeresponsevalid,
	output logic [3:0] output_address,
	output logic end_wait,
	output logic start_calc,
	output logic [1:0] response
	
);

typedef enum logic [4:0]
		  {idle,begin_read,s_read,bad_addr,begin_write,store,begin_burst_write,
		  chk_burst, cap_val, burst_store, burst_wait, res_err } state_type;

	state_type state, next_state;
	reg next_modwait;
	parameter MAXADDR = 3'h62C;


	always_ff@(posedge clk, negedge n_rst)
	begin
		  if(n_rst == 0)begin
		      state <= idle;
	  end
		  else begin
		      state <= next_state;
		  end
	end


	always_comb
	begin
		next_state = state;
		case(state)
			idle:begin 
				if(read == 1 && beginbursttransfer == 0) begin
					if(address > 0 && address < MAXADDR) begin
						next_state = s_read;
					end
					else
						next_state = bad_addr;
				end
				if(write == 1 && beginbursttransfer == 0) begin
					if(address > 0 && address < MAXADDR) begin
						next_state = store;
					end
					else
						next_state = bad_addr;
				end
				if(write == 1 && beginbursttransfer == 1) begin
					if(address > 0 && (address + burstcount) < MAXADDR) begin
						next_state = chk_burst;
					end
					else
						next_state = bad_addr;
				end
			end


			s_read:begin 
				next_state = idle;
			end



			store:begin 
				next_state = idle;
			end

			begin_burst_write:begin 

			end

			chk_burst:begin 
				if(done_burst) begin
					next_state = idle;
				end
			end

			cap_val:begin 

			end

			burst_store:begin 

			end

			burst_wait:begin

			end

			res_err:begin 

			end

		endcase // state
	end

	always_comb begin
		end_wait = 0;
		case(state)
			idle:begin 

			end

			s_read:begin 
				response = 2'b00;
				readdata = 
				end_wait = 1'b1;
			end

			store:begin 
				end_wait = 1'b1;
			end

			chk_burst:begin 

			end

			cap_val:begin 

			end

			burst_store:begin 

			end

			burst_wait:begin

			end

			res_err:begin 

			end

		endcase // state
	end

endmodule