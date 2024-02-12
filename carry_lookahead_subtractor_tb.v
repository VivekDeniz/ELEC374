//`include "carry_lookahead_subtractor.v"
 
module carry_lookahead_subtractor_tb ();
 
  parameter WIDTH = 5;
 
  reg [WIDTH-1:0] r_ADD_1 = 0;
  reg [WIDTH-1:0] r_ADD_2 = 0;
  wire [WIDTH-1:0]  w_RESULT;
  wire w_carry_OUT;
   
  carry_lookahead_subtractor #(.WIDTH(WIDTH)) carry_lookahead_inst
    (
     .i_add1(r_ADD_1),
     .i_add2(r_ADD_2),
     .o_result(w_RESULT),
	  .c_OUT(w_carry_out)

     );
 
  initial
    begin
      #10000;
      r_ADD_1 = 5'b01000;
      r_ADD_2 = 5'b10000;
      #10000;
      r_ADD_1 = 5'b00111;
      r_ADD_2 = 5'b01011;
      #10000;
      r_ADD_1 = 5'b00000;
      r_ADD_2 = 5'b11000;
      #10000;
      r_ADD_1 = 5'b01011;
      r_ADD_2 = 5'b01011;
      #10000;
    end
 
endmodule // carry_lookahead_adder_tb