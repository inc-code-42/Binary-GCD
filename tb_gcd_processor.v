//-------------------------------------------------------------------//
// Author	: Inc
// Module	: tb_gcd_processor.v
// Date		: June 23
// Version	: v1
// Remarks	: Initial Draft
//
//
// ------------------------------------------------------------------//
`timescale 1 ns/ 1 ns

module tb_gcd_processor;
  parameter BIT_LEN = 32 ;
  reg                clk_i   = 0;
  reg                reset_n = 0; 

  reg [BIT_LEN-1:0]  num_0  = 0;
  reg [BIT_LEN-1:0]  num_1  = 0;
  reg                start  = 0;
 
  wire                busy     ;
  wire [BIT_LEN-1:0] gcd_op    ;
  wire               done      ;


gcd_processor #(.BIT_LEN(BIT_LEN) )GCD_PROCESSOR_U1 (
  .clk_i         (clk_i    ),
  .reset_n       (reset_n  ),
  .num_0         (num_0    ),
  .num_1         (num_1    ),
  .start         (start    ),
  .busy          (busy     ),
  .gcd_op        (gcd_op   ),
  .done          (done     )
);

always #10 clk_i = ~ clk_i;

task async_reset_generator; begin
  reset_n = 1'b1;
  #100;
  reset_n = 1'b0;
  #100;
  reset_n = 1'b1;
end
endtask



initial begin
  $dumpfile ("tb_gcd_processor.vcd");
  $dumpvars(0,tb_gcd_processor);
  #100;
  async_reset_generator;
  #100;

  wait (reset_n == 1'b1);
  $display ("De asserted reset");

  num_0 = 'd2;
  num_1 = 'd20261;

  @(negedge clk_i);
  start = 1'b1;  
  @(negedge clk_i);
  start = 1'b0;  

  wait (done);
  $display ("Completed Process...");
  $display ("GCD = %d",gcd_op);
  
  #100;
  $finish;

end








endmodule
