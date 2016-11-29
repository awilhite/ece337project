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

logic [9:0] cnt;
logic count_ena;
logic done_burst;

avalon_controller AC(
		.clk(clk),
		.n_rst(n_rst),
		.write(write),
		.read(read),
		.beginbursttransfer(beginbursttransfer),
		.burstcount(burstcount),
		.address(address),
		.writedata(writedata),
		.readdata(readdata),
		.result_output(result_output),
		.done_calc(done_calc),
		.done_burst(done_burst),
		.readdatavalid(readdatavalid),
		.writeresponsevalid(writeresponsevalid),
		.output_address(output_address),
		.end_wait(end_wait),
		.start_calc(start_calc),
		.response(response)

		);
flex_counter #(10) burstcounter(clk,n_rst,burstcount,count_ena,cnt,done_burst);
assign waitrequest = (write || read) && !end_wait;
endmodule
