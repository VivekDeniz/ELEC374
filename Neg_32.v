module Neg_32(
	input wire [31:0] Ra,
	output wire [31:0] Rz
	);
	
	assign Rz = ~Ra +1;
	
	
	
endmodule 