module Neg_32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	
	assign Rz = ~Ra +1;
	
	
	
endmodule 