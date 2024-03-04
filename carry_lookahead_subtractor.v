module carry_lookahead_subtractor
    //adjustable datawidth, set to 32
    #(parameter WIDTH = 32)(
    input [WIDTH-1:0] i_add1,
    input [WIDTH-1:0] i_add2,
    output [WIDTH-1:0] o_result,
    output c_OUT
);

  wire [WIDTH:0]     w_C;
  wire [WIDTH-1:0]   w_G, w_P, w_SUM;
  
  wire [WIDTH:0] twos_complement_output;

  //Invert and add 1 to compute two's complement
  assign twos_complement_output = ~i_add2 + 1;
  //Subtractor uses same logic as carry_lookahead_adder, but negates the first operand in the expression
  //creates the amount of full adders based on parameter size
  genvar ii;
  generate
    for (ii = 0; ii < WIDTH; ii = ii + 1) begin: gen_loop1
      full_adder_sub full_adder_sub_inst (
        .i_bit1(i_add1[ii]),
        .i_bit2(twos_complement_output[ii]),
        .i_carry(w_C[ii]),
        .o_sum(w_SUM[ii]),
        .o_carry()
      );
    end
  endgenerate
 
  //Generate (G) Terms:  Gi=Ai*Bi
  //Propagate (P) Terms: Pi=Ai+Bi
  //use carry-lookahead-logic to calculate terms in advance
  genvar jj;
  generate
    for (jj = 0; jj < WIDTH; jj = jj + 1) begin: gen_loop2
      assign w_G[jj]   = i_add1[jj] & twos_complement_output[jj];
      assign w_P[jj]   = i_add1[jj] | twos_complement_output[jj];
      assign w_C[jj+1] = w_G[jj] | (w_P[jj] & w_C[jj]);
    end
  endgenerate
   
  assign w_C[0] = 1'b0; //no carry input on first adder
 
  assign o_result = w_SUM;   // Removed concatenation since w_SUM is already [WIDTH-1:0]
 
  assign c_OUT = w_C[WIDTH];
 
endmodule //carry_lookahead_subtractor

module full_adder_sub(
   input i_bit1,
   input i_bit2,
   input i_carry,
   output o_sum,
   output o_carry

);

assign o_sum = i_bit1 ^ i_bit2 ^ i_carry;
assign o_carry = (i_bit1 & i_bit2) | (i_bit2 & i_carry) | (i_bit1 & i_carry);

endmodule 
