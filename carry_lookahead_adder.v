module carry_lookahead_subtractor
  //adjustable datawidth, set to 32
  #(parameter WIDTH = 32)
  (
   input [WIDTH-1:0] i_add1,
   input [WIDTH-1:0] i_add2,
   output [WIDTH:0]  o_result,
	output c_OUT
   );
  //carry wire   
  wire [WIDTH:0]     w_C;
  //generator, propogate, and sum signals
  wire [WIDTH-1:0]   w_G, w_P, w_SUM;
  //creates the amount of full adders based on parameter size
  genvar             ii;
  generate
    for (ii=0; ii<WIDTH; ii=ii+1) 
      begin: gen_loop
        full_adder full_adder_inst
            ( 
		//bitwise assignment to individual full adders
	      .in_bit1(in_add1[ii]),
	      .in_bit2(in_add2[ii]),
              .in_carry(w_C[ii]),
              .out_sum(w_SUM[ii]),
              .out_carry()
              );
      end
  endgenerate
 
  //Generate (G) Terms:  Gi=Ai*Bi
  //Propagate (P) Terms: Pi=Ai+Bi
  //use carry-lookahead-logic to calculate terms in advance
  genvar             jj;
  generate
    for (jj=0; jj<WIDTH; jj=jj+1) 
      begin: gen_loop1
	assign w_G[jj]   = in_add1[jj] & in_add2[jj];
	assign w_P[jj]   = in_add1[jj] | in_add2[jj];
        assign w_C[jj+1] = w_G[jj] | (w_P[jj] & w_C[jj]);
      end
  endgenerate
   
  assign w_C[0] = 1'b0; //no carry input on first adder
 
  assign out_result = {w_C[WIDTH], w_SUM};   //concatenation
 
  assign c_OUT = w_C[WIDTH];
 
endmodule //carry_lookahead_adder

module full_adder(
   input i_bit1,
   input i_bit2,
   input i_carry,
   output o_sum,
   output o_carry

);
//basic full adder module used by CLA
assign out_sum = in_bit1 ^ in_bit2 ^ in_carry;
	assign out_carry = (in_bit1 & in_bit2) | (in_bit2 & in_carry) | (in_bit1 & in_carry);

endmodule
