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
	input logic [12:0] address,
	input logic [31:0] writedata,
	output logic [31:0] readdata,
	input logic [16:0] result_output,
	input logic done_calc,
	input logic overflow,
	output logic [11:0] weight_address,
	output logic [9:0] pixel_address1,
	output logic [9:0] pixel_address2,
	output logic w_enable_weights,
	output logic w_enable_pixels,
	output logic readdatavalid,
	output logic writeresponsevalid,
	output logic [31:0] weight_data,
	output logic [15:0] pixel_data1,
	output logic [15:0] pixel_data2,
	output logic [3:0] output_address,
	output logic waitrequest,
	output logic start_calc,
	output logic clear_data,
	output logic [1:0] response

);

logic w_ena, end_wait;
logic [12:0] int_addr;
logic [12:0] temp_addr;
logic [31:0] control, next_control, status, next_status;

// FSM controller portmap
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
		.readdatavalid(readdatavalid),
		.writeresponsevalid(writeresponsevalid),
		.output_address(int_addr),
		.end_wait(end_wait),
		.w_ena(w_ena),
		.response(response)
		);




parameter PIXEL_ADDR_MAX = 13'd195;
parameter WEIGHT_ADDR_MAX = 13'd4115;
parameter RESULT_ADDR_MAX = 13'd4125;
parameter CONTROL_REG = 13'd4126;
parameter STATUS_REG = 13'd4127;

// output signal mapping
assign waitrequest = !end_wait;
assign start_calc = control[3];
assign clear_data = control[0];


// address mapping 
always_comb begin
	next_control = control;
	temp_addr = 'b0;
	pixel_data1 = 'b0;
	pixel_data2 = 'b0;
	weight_data = 'b0;
	output_address = 'b0;
	pixel_address1 = 'b0;
	pixel_address2 = 'b0;
	w_enable_pixels = 1'b0;
	w_enable_weights = 1'b0;
	weight_address = 'b0;
	readdata = 'b0;
	next_status = {30'b0,overflow,done_calc};

	// reads
	if(w_ena == 1'b0) begin
		if(int_addr <= PIXEL_ADDR_MAX) begin
			// shouldn't need to read from pixel data
		end 
		else if(int_addr <= WEIGHT_ADDR_MAX) begin
			// shouldn't need to read from weights
		end
		else if(int_addr <= RESULT_ADDR_MAX) begin 
			temp_addr = (int_addr - WEIGHT_ADDR_MAX);
			output_address = temp_addr[3:0];
			readdata = result_output;
		end
		else if(int_addr == CONTROL_REG) begin
			readdata = control;
		end
		else if (int_addr == STATUS_REG) begin 
			readdata = status;
		end
	end
	// writes
	else begin 
		if(int_addr <= PIXEL_ADDR_MAX) begin
			pixel_address1 = int_addr[9:0];
			pixel_address2 = int_addr[9:0] + 1;
			w_enable_pixels = 1'b1;
			pixel_data1 = writedata[15:0];
			pixel_data2 = writedata[31:16];
		end 
		else if(int_addr <= WEIGHT_ADDR_MAX) begin
			temp_addr = int_addr - PIXEL_ADDR_MAX;
			weight_address = temp_addr[11:0];
			w_enable_weights = 1'b1;
			weight_data = writedata;
		end
		else if(int_addr <= RESULT_ADDR_MAX) begin 
			// shouldn't write to result registers
		end
		else if(int_addr == CONTROL_REG) begin
			next_control = writedata;
		end
		else if (int_addr == STATUS_REG) begin 
			// shouldn't write to status register
		end
	end
end


// control and status register updates
always_ff @(posedge clk or negedge n_rst) begin : proc_csr
	if(~n_rst) begin
		control <= 31'h0000;
		status <= 31'h0;
	end else begin
		control <= next_control;
		status <= next_status;
	end
end



endmodule
