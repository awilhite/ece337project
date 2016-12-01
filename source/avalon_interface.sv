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
	input logic [16:0] result_output,
	input logic done_calc,
	output logic [10:0] weight_address,
	output logic [10:0] pixel_address,
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

logic [9:0] cnt;
logic count_ena;
logic done_burst;
logic w_ena;
logic [10:0] int_addr;
logic [31:0] csr, next_csr;

avalon_controller AC(
		.clk(clk),
		.n_rst(n_rst),
		.write(write),
		.read(read),
		.beginbursttransfer(beginbursttransfer),
		.burstcount(burstcount),
		.address(address),
		.writedata(writedata),
		.done_calc(done_calc),
		.done_burst(done_burst),
		.readdatavalid(readdatavalid),
		.writeresponsevalid(writeresponsevalid),
		.output_address(int_addr),
		.end_wait(end_wait),
		.w_ena(w_ena),
		.response(response)

		);
flex_counter #(10) burstcounter(clk,n_rst,1'b0,count_ena,burstcount,cnt,done_burst);

parameter PIXEL_ADDR_MAX = 11'h30f;
parameter WEIGHT_ADDR_MAX = 11'h61f;
parameter RESULT_ADDR_MAX = 11'h62a;

assign waitrequest = !end_wait;
assign start_calc = csr[3];

always_comb begin
	next_csr = csr;
	pixel_address = 'b0;
	w_enable_pixels = 1'b0;
	w_enable_weights = 1'b0;
	readdata = 'b0;
	if(w_ena == 1'b0) begin
		if(int_addr < PIXEL_ADDR_MAX) begin
			// shouldn't need to read from pixel data
		end 
		else if(int_addr < WEIGHT_ADDR_MAX) begin
			// shouldn't need to read from weights
		end
		else if(int_addr <= RESULT_ADDR_MAX) begin 
			output_address = int_addr[3:0];
			readdata = result_output;
		end
		else begin 
			readdata = csr;
		end
	end
	else begin 
		if(int_addr < PIXEL_ADDR_MAX) begin
			pixel_address = int_addr;
			w_enable_pixels = 1'b1;
		end 
		else if(int_addr < WEIGHT_ADDR_MAX) begin
			weight_address = int_addr - PIXEL_ADDR_MAX;
			w_enable_weights = 1'b1;
		end
		else if(int_addr <= RESULT_ADDR_MAX) begin 
			// shouldn't write to results
		end
		else begin 
			next_csr = writedata;
		end
	end
end

always_ff @(posedge clk or negedge n_rst) begin : proc_csr
	if(~n_rst) begin
		csr <= 32'h0000;
	end else begin
		csr <= next_csr;
	end
end



endmodule
