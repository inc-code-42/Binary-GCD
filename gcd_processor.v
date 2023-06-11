//-------------------------------------------------------------------//
// Author	: Inc
// Module	: gcd_processor.v
// Date		: June 23
// Version	: v1
// Remarks	: Initial Draft
//
//
// ------------------------------------------------------------------//
`timescale 1 ns/ 1 ns

module gcd_processor #(parameter BIT_LEN = 8) (
  input wire                clk_i  ,
  input wire                reset_n,

  input wire [BIT_LEN-1:0]  num_0  ,
  input wire [BIT_LEN-1:0]  num_1  ,
  input wire                start  ,
 
  output reg                busy   ,
  output wire [BIT_LEN-1:0] gcd_op ,
  output reg                done  
);

localparam IDLE         = 3'd0,
	   PRE_PROCESS  = 3'd1,
	   POST_PROCESS = 3'd2,
	   DONE         = 3'd3;


reg [2:0]         gcd_state_reg;   
reg [2:0]         gcd_state_nxt;

reg [BIT_LEN-1:0] num_0_reg;
reg [BIT_LEN-1:0] num_0_nxt;

reg [BIT_LEN-1:0] num_1_reg;
reg [BIT_LEN-1:0] num_1_nxt;


reg [BIT_LEN-1:0] gcd_op_reg;
reg [BIT_LEN-1:0] gcd_op_nxt;

reg [BIT_LEN-1:0] mult_cntr_reg;
reg [BIT_LEN-1:0] mult_cntr_nxt;

assign gcd_op = gcd_op_reg;



always @(posedge clk_i, negedge reset_n) begin
  if (!reset_n) begin
    gcd_state_reg      <= IDLE;
    num_0_reg          <= 'd0;
    num_1_reg          <= 'd0;
    gcd_op_reg         <= 'd0;
    mult_cntr_reg      <= 'd0;
  end else begin
    gcd_state_reg      <= gcd_state_nxt;
    num_0_reg          <= num_0_nxt;
    num_1_reg          <= num_1_nxt;
    gcd_op_reg         <= gcd_op_nxt;
    mult_cntr_reg      <= mult_cntr_nxt;
  end
end


always @* begin
  gcd_state_nxt = gcd_state_reg;
  num_0_nxt     = num_0_reg;
  num_1_nxt     = num_1_reg;
  gcd_op_nxt    = gcd_op_reg;
  mult_cntr_nxt = mult_cntr_reg;
  done          = 1'b0;
  busy          = 1'b0; 
  case (gcd_state_reg)
    IDLE: begin	    
      if (start) begin
	num_0_nxt       = num_0;      
	num_1_nxt       = num_1;
        busy            = 1'b1;
        mult_cntr_nxt   = 'd0;	
        gcd_state_nxt   = PRE_PROCESS;
        if ((num_0 == 'd0) && (num_1 == 'd0)) begin
          gcd_state_nxt = DONE;
	  gcd_op_nxt    = 'd0; 
        end
        else if (num_0 == 'd0) begin
          gcd_state_nxt = DONE;
	  gcd_op_nxt    = num_1; 
        end		
        else if (num_1 == 'd0) begin
          gcd_state_nxt = DONE;
	  gcd_op_nxt    = num_0; 
        end	
      end	      
    end
    PRE_PROCESS: begin
      busy              = 1'b1;	    
      if (num_0_reg == 'd0) begin
        gcd_state_nxt   = POST_PROCESS;
        gcd_op_nxt      = num_1_reg;	
      end
      else if (num_1_reg == 'd0) begin
        gcd_state_nxt   = POST_PROCESS;
        gcd_op_nxt      = num_0_reg;	
      end      
      else if (~num_0_reg[0] & ~num_1_reg[0]) begin     // Num-0 and NUm-1 are Even
        num_0_nxt      = num_0_reg >> 1;   
        num_1_nxt      = num_1_reg >> 1;  
        mult_cntr_nxt  = mult_cntr_reg + 1'b1;
        gcd_state_nxt  = PRE_PROCESS;	
      end	      
      else if (~num_0_reg[0]) begin                    // Num-0 is Even
        num_0_nxt      = num_0_reg >> 1;   
        gcd_state_nxt  = PRE_PROCESS;	
      end
      else if (~num_1_reg[0]) begin                    // Num-0 is Even
        num_1_nxt      = num_1_reg >> 1;   
        gcd_state_nxt  = PRE_PROCESS;	
      end
      else if (num_0_reg > num_1_reg) begin           // Both are ODD
        num_0_nxt      = (num_0_reg - num_1_reg) >> 1;
        gcd_state_nxt  = PRE_PROCESS;	
      end
      else  begin                                     // Both are Odd
        num_1_nxt      = (num_1_reg - num_0_reg) >> 1;
        gcd_state_nxt  = PRE_PROCESS;	
      end
    end
    POST_PROCESS: begin
      busy            = 1'b1;	    
      if (mult_cntr_reg > 0) begin
        gcd_state_nxt = POST_PROCESS;
	gcd_op_nxt    = gcd_op_reg << 1;
	mult_cntr_nxt = mult_cntr_reg - 1'b1;
      end
      else begin
        gcd_state_nxt  = DONE;	
      end      
    end
    DONE: begin
      done          = 1'b1;
      busy          = 1'b1;      
      gcd_state_nxt = IDLE;
    end    
  endcase	 
end

endmodule
