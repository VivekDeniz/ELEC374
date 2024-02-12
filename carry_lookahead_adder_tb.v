//`include "carry_lookahead_adder.v"
 
module carry_lookahead_adder_tb ();
 
  parameter WIDTH = 4;
 
  reg [WIDTH-1:0] r_ADD_1 = 0;
  reg [WIDTH-1:0] r_ADD_2 = 0;
  wire [WIDTH-1:0]  w_RESULT;
  wire w_carry_OUT;
   
  carry_lookahead_adder #(.WIDTH(WIDTH)) carry_lookahead_inst
    (
     .i_add1(r_ADD_1),
     .i_add2(r_ADD_2),
     .o_result(w_RESULT),
	  .c_OUT(w_carry_out)

     );
 
  initial
    begin
      #1000;
      r_ADD_1 = 4'b1000;
      r_ADD_2 = 4'b1000;
      #1000;
      r_ADD_1 = 4'b0111;
      r_ADD_2 = 4'b0111;
      #1000;
      r_ADD_1 = 4'b0000;
      r_ADD_2 = 4'b0000;
      #1000;
      r_ADD_1 = 4'b1011;
      r_ADD_2 = 4'b1011;
      #1000;
    end
 
endmodule // carry_lookahead_adder_tb