`timescale 1ns / 1ps



module Shr_32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	//shift right Ra by Rb bits and assign to Rz

	assign Rz = Ra >> Rb;
	
endmodule 
