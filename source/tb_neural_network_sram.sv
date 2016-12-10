// $Id: $
// File name:   tb_neural_network_sram.sv
// Created:     12/7/2016
// Author:      Josef Danial
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for neural network using course sram

`timescale 1ns / 100ps

module tb_neural_network_sram (
);
	localparam CLK_PERIOD = 20;
	localparam CONTROL_REG = 13'd4126;
	localparam STATUS_REG = 13'd4127;






	
	// Test bench variables
	integer unsigned tb_init_file_number;	// Can't be larger than a value of (2^31 - 1) due to how VHDL stores unsigned ints/natural data types
	integer unsigned tb_dump_file_number;	// Can't be larger than a value of (2^31 - 1) due to how VHDL stores unsigned ints/natural data types
	integer unsigned tb_start_address;	// The first address to start dumping memory contents from
	integer unsigned tb_last_address;		// The last address to dump memory contents from
	
	reg tb_mem_clr;		// Active high strobe for at least 1 simulation timestep to zero memory contents
	reg tb_mem_init;	// Active high strobe for at least 1 simulation timestep to set the values for address in
										// currently selected init file to their corresonding values prescribed in the file
	reg tb_mem_dump;	// Active high strobe for at least 1 simulation timestep to dump all values modified since most recent mem_clr activation to
										// the currently chosen dump file. 
										// Only the locations between the "tb_start_address" and "tb_last_address" (inclusive) will be dumped
	reg tb_verbose;		// Active high enable for more verbose debuging information
	

	logic tb_clk;


	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	logic tb_n_rst;
	logic tb_write;
	logic tb_read;
	logic tb_beginbursttransfer;
	logic [9:0] tb_burstcount;
	logic [12:0] tb_address;
	logic [31:0] tb_writedata;
	logic [31:0] tb_readdata;
	logic tb_waitrequest;
	logic tb_readdatavalid;
	// logic tb_writeresponsevalid;
	logic [1:0] tb_response;
	logic read_enable;
	logic [11:0] tb_weight_address;
	logic [9:0] tb_pixel_address1;
	logic [9:0] tb_pixel_address2;
	logic tb_w_enable_weights;
	logic tb_w_enable_pixels;
	logic [15:0] tb_pixel_data1;
	logic [15:0] tb_pixel_data2;
	logic [31:0] tb_weight_data;

	logic [15:0] tb_pixel_value1;
	logic [15:0] tb_pixel_value2;
	logic [31:0] tb_weight_value;


	neural_network_sram DUT(
		.clk(tb_clk),
		.reset_n(tb_n_rst),
		.write(tb_write),
		.read(tb_read),
		.beginbursttransfer(tb_beginbursttransfer),
		.burstcount(tb_burstcount),
		.address(tb_address),
		.writedata(tb_writedata),
		.readdata(tb_readdata),
		.waitrequest(tb_waitrequest),
		.response(tb_response),
		.readdatavalid(tb_readdatavalid),
		//.writeresponsevalid(tb_writeresponsevalid),

		.weight_address(tb_weight_address),
		.weight_value(tb_weight_value),
		.w_enable_weights(tb_w_enable_weights),
		.weight_data(tb_weight_data),
		.r_enable(read_enable),

		.pixel_address1(tb_pixel_address1),
		.pixel_address2(tb_pixel_address2),
		.w_enable_pixels(tb_w_enable_pixels),
		.pixel_data1(tb_pixel_data1),
		.pixel_data2(tb_pixel_data2),
		.pixel_value1(tb_pixel_value1),
		.pixel_value2(tb_pixel_value2)
		);


	logic [13:0] weights_addr_sram;
	assign weights_addr_sram = tb_weight_address * 3'd4;
	weights_on_chip_sram weights_sram
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(tb_w_enable_weights),
		.address(weights_addr_sram),
		.read_data(tb_weight_value),
		.write_data(tb_weight_data)
	);
	logic [9:0] pixel1_addr_sram;
	assign pixel1_addr_sram = tb_pixel_address1 * 2;
	pixels_on_chip_sram pixels1_sram
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(tb_w_enable_pixels),
		.address(pixel1_addr_sram),
		.read_data(tb_pixel_value1),
		.write_data(tb_pixel_data1)
	);

	logic [9:0] pixel2_addr_sram;
	assign pixel2_addr_sram = tb_pixel_address2 * 2;

	pixels_on_chip_sram pixels2_sram
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(tb_verbose),
		.init_file_number(tb_init_file_number),
		.dump_file_number(tb_dump_file_number),
		.start_address(tb_start_address),
		.last_address(tb_last_address),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(tb_w_enable_pixels),
		.address(pixel2_addr_sram),
		.read_data(tb_pixel_value2),
		.write_data(tb_pixel_data2)
	);





	// reset
	task reset_dut;
	begin
		tb_n_rst = 1'b0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		@(posedge tb_clk);
	end
	endtask : reset_dut

	// simple avalon read
	task read(input logic [12:0] addr);
	begin
		@(posedge tb_clk);
		tb_address = addr;
		tb_read = 1'b1;
		tb_write = 1'b0;
		@(negedge tb_waitrequest);

		if(tb_response == 'b0) begin
			@(posedge tb_readdatavalid);
		end
		tb_address = '0;
		tb_read = 1'b0;



	end
	endtask

	// simple avalon write
	task write(input logic [12:0] addr, input logic [31:0] data);
	begin
		@(posedge tb_clk);
		tb_address = addr;
		tb_writedata = data;
		tb_write = 1'b1;
		tb_read = 1'b0;
		@(negedge tb_waitrequest);
		//#(CLK_PERIOD);
		@(posedge tb_clk);
		tb_address = 'b0;
		tb_write = 1'b0;
		tb_writedata = 'b0;


	end
	endtask

	// perform a burst write, checking the data is being written correctly
	task burst_write(input logic [12:0] addr, input logic [31:0] data[0:195]);
	begin
		@(posedge tb_clk);
		tb_address = addr;
		tb_write = 1'b1;
		tb_read = 1'b0;
		tb_beginbursttransfer= 1'b1;
		tb_burstcount = 11'd196;
		@(negedge tb_waitrequest)
		for (int i = 0; i <= 195; i++) begin
			tb_writedata = data[i];
			@(negedge tb_waitrequest);
			@(posedge tb_clk);
			tb_beginbursttransfer = 1'b0;
			tb_burstcount = 'b0;
			tb_address = 'b0;
			if(data[i] != {tb_pixel_data2,tb_pixel_data1} || tb_w_enable_pixels != 1'b1 || tb_pixel_address1 != i) begin
				$error("data burst failed");
			end
			else
				$info("burst good");

		end
		tb_write = 1'b0;
	end
	endtask


	// perform a burst write of the weights, checking the data is being written correctly
	task burst_write_weights(input logic [12:0] addr);
	begin
		integer stati;
		integer count;
		logic [31:0] file_data;
		@(posedge tb_clk);
		tb_address = addr;
		tb_write = 1'b1;
		tb_read = 1'b0;
		tb_beginbursttransfer= 1'b1;
		tb_burstcount = 11'd392;
		//@(negedge tb_waitrequest)

		for (int i = 0; i <= 391; i++) begin
			stati = $fscanf(weight_file,"%h   %h   ",file_data[31:16],file_data[15:0]);
			tb_writedata = file_data;
			@(negedge tb_waitrequest);
			@(posedge tb_clk);
			tb_beginbursttransfer = 1'b0;
			tb_burstcount = 'b0;
			tb_address = 'b0;
			// if(file_data != tb_weight_data || tb_w_enable_weights != 1'b1) begin//|| tb_weight_address != i) begin
			// 	$error("data burst failed");
			// end
			// else
			// 	$info("burst good");
		end
		tb_write = 1'b0;
	end
	endtask


		// perform a burst write of the weights, checking the data is being written correctly
	task burst_write_pixels(input logic [12:0] addr);
	begin
		integer stati;
		integer count,pixel_file;
		logic [31:0] file_data;
		@(posedge tb_clk);
		tb_address = addr;
		tb_write = 1'b1;
		tb_read = 1'b0;
		tb_beginbursttransfer= 1'b1;
		tb_burstcount = 11'd196;
		//@(negedge tb_waitrequest)
		pixel_file = $fopen("image2.txt","r");

		for (int i = 0; i <=195 ; i++) begin
			stati = $fscanf(pixel_file,"%d\n%d\n%d\n%d\n",file_data[7:0],file_data[15:8],file_data[23:16],file_data[31:24]);
			tb_writedata = file_data;
			@(negedge tb_waitrequest);
			@(posedge tb_clk);
			tb_beginbursttransfer = 1'b0;
			tb_burstcount = 'b0;
			tb_address = 'b0;
			// if(file_data != {tb_pixel_data2, tb_pixel_data1} || tb_w_enable_pixels != 1'b1) begin
			// 	$error("data burst failed");
			// end
			// else
			// 	$info("burst good");
		end
		tb_write = 1'b0;
	end
	endtask

	logic [31:0] expected_val = 32'h0000000F;
	logic [31:0]data[0:195];
	logic [31:0] file_data;
	integer weight_file, tmp;


initial begin 
	// Initialize all test bench control signals and DUT inputs
	tb_mem_clr					<= 0;
	tb_mem_init					<= 0;
	tb_mem_dump					<= 0;
	tb_verbose					<= 0;
	tb_init_file_number	<= 0;
	tb_dump_file_number	<= 0;
	tb_start_address		<= 0;
	tb_last_address			<= 0;

	tb_beginbursttransfer = 'b0;
	tb_burstcount = 'b0;
	tb_read = 1'b0;
	tb_write = 1'b0;

	// Initialization of memory's interface input signals
	

	reset_dut();

	weight_file = $fopen("test.txt","r");
	for (int i = 0; i < 10; i++) begin
		burst_write_weights(((392 * i) + 196));
		tmp = $fgetc(weight_file);
		#(CLK_PERIOD * 4);
	end


	burst_write_pixels(13'd0);


	// start computation
	#(CLK_PERIOD *4);

	write(CONTROL_REG,31'b1000);

	#(CLK_PERIOD * 4);

	write(CONTROL_REG,31'b0000);

	#(CLK_PERIOD * 4);
	read(STATUS_REG);

	// waid for computation
	while(tb_readdata != 13'b01) begin
		#(CLK_PERIOD * 4);
		read(STATUS_REG);
	end

	// read result
	read(13'd4122);


	// Data clear operation
	write(CONTROL_REG,13'b1);
	#(CLK_PERIOD * 2);
	write(CONTROL_REG, 13'b0);
	#(CLK_PERIOD);
	read(13'd4124);


	#(CLK_PERIOD);
	read(13'd5000);
end
endmodule