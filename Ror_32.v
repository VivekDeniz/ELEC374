`timescale 1ns / 1ps



module Ror_32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	//shift right by up to 31 bits, and OR it with a left shift of the opposit size
	assign Rz =  (Ra >> Rb[3:0])|(Ra << 32-Rb[3:0]);
endmodule
