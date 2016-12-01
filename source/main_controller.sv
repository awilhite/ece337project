// $Id: $
// File name:   main_controller.sv
// Created:     11/29/2016
// Author:      Kshitij jain
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Main controller state machine

module main_controller
(
 input wire  clk,
 input wire  n_reset,
 input wire  data_stored,
 input wire done_row,
 output reg[3:0] res_add,
 output reg begin_mult,
 output reg done_calc
);
   
   typedef enum bit[4:0] {WRITE_OUT, MUL_DONE, MUL10, MUL9, MUL8, MUL7, MUL6, MUL5, MUL4, MUL3, MUL2, MUL1, START_CALC, IDLE} stateType;
   stateType state;
   stateType nxt_state;

   always_ff @(posedge clk, negedge n_reset)
     begin
	if(!n_reset)
	  begin
	     state <= IDLE;
	  end
	else
	  begin
	     state <= nxt_state;
	  end
     end // always_ff @

   always_comb
     begin
	nxt_state = state;
	res_add = 4'b0;
	begin_mult = 1'b0;
	done_calc = 1'b0;

	case(state)
	  IDLE:
	    begin
	       if(data_stored == 1)
		 begin
		    nxt_state = START_CALC;
		 end
	       else
		 begin
		    nxt_state = IDLE;
		 end
	    end

	  START_CALC:
	    begin
	       nxt_state = MUL1;
	       res_add = 4'b0000;		   
	    end

	  MUL1:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0000;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL2;		    
		 end
	    end

	  MUL2:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0001;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL3;		    
		 end
	    end

	  MUL3:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0010;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL4;		    
		 end
	    end

	  MUL4:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0011;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL5;		    
		 end
	    end

	  MUL5:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0100;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL6;		    
		 end
	    end

	  MUL6:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0101;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL7;		    
		 end
	    end

	  MUL7:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0110;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL8;		    
		 end
	    end

	  MUL8:
	    begin
	       begin_mult = 1;
	       res_add = 4'b0111;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL9;		    
		 end
	    end

	  MUL9:
	    begin
	       begin_mult = 1;
	       res_add = 4'b1000;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL10;		    
		 end
	    end

	  MUL10:
	    begin
	       begin_mult = 1;
	       res_add = 4'b1001;
	       if(done_row == 1)
		 begin
		    nxt_state = MUL_DONE;		    
		 end
	    end

	  MUL_DONE:
	    begin
	       nxt_state = WRITE_OUT;
	    end

	  WRITE_OUT:
	    begin
	       done_calc = 1;
	       nxt_state = IDLE;
	    end

	endcase // case (state)
     end // always_comb
endmodule
   
