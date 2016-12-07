// $Id: $
// File name:   result_registers.sv
// Created:     12/6/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: register file for results


module result_registers (
	input clk,    // Clock
	input n_rst,  // Asynchronous reset active low
	input [3:0] out_sel,
	input [3:0] in_sel,
	input w_enable,
	input clear_data,
	input [15:0] in_data,
	output [15:0] out_data
);

	logic [15:0] regs [10:0];

	always_ff @(posedge clk or negedge n_rst) begin : proc_regs
		if(~n_rst) begin
			for (int i = 0; i < 10; i = i + 1) begin
				regs[i] <= 'b0;
			end
		end else begin
			if(w_enable) begin
				regs[in_sel] <= in_data;
			end
			else if(clear_data) begin
				for (int i = 0; i < 10; i = i + 1) begin
					regs[i] <= 'b0;
				end
			end
		end
	end

	assign out_data = regs[out_sel];
endmodule
