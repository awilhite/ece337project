// $Id: $
// File name:   avalon_interface.sv
// Created:     11/27/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Avalon MM Bus Interface for Neural Network

module avalon_interface (
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
	output logic weight_address,
	output logic pixel_address,
	output logic w_enable_weights,
	output logic w_enable_pixels,
	output logic readdatavalid,
	output logic writeresponsevalid,
	output logic [15:0] store_data,
	output logic [3:0] output_address,
	output logic waitrequest,
	output logic start_calc,
	output logic [1:0] response

);
typedef enum logic [4:0]
		  {idle,begin_read,read,bad_addr,begin_write,store,begin_burst_write,
		  chk_burst, cap_val, burst_store, burst_wait, res_err } state_type;

	state_type state, next_state;
	reg next_modwait;
	parameter MAXADDR = 3'h62C


	always_ff@(posedge clk, negedge n_rst)
	begin
		  if(n_reset == 0)begin
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
					next_state = begin_read;
				end
			end

			begin_read:begin
				if(address >0 && address < MAXADDR) begin
					next_state = read;
				end
				else
					next_state = bad_addr;
			end

			read:begin 

			end

			begin_write:begin 

			end

			store:begin 

			end

			begin_burst_write:begin 

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

	always_comb begin
		case(state)
			idle:begin 

			end

			begin_read:begin

			end

			read:begin 

			end

			begin_write:begin 

			end

			store:begin 

			end

			begin_burst_write:begin 

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
