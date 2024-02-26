`timescale 1ns / 1ps



module And_32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	
	//Assigns the result of anding The contents of Ra and Rb into Rz
	assign Rz = Ra & Rb;
	
endmodule 
