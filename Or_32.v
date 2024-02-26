`timescale 1ns / 1ps



module 	Or_32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	//assign Ra or Rb to Rz
	assign Rz = Ra | Rb;
	
endmodule 
