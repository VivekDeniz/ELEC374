module Neg_32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	//converts to two's complement negative form by inverting all bits and adding 1
	assign Rz = ~Ra +1;
	
	
	
endmodule 
