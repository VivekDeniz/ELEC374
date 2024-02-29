`timescale 1ns / 1ps



module Shra_32(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	reg [31:0] temp;
	always @* begin
		if(Ra[31]==1)begin
			temp = (Ra >> Rb[3:0])|(4294967295<<32-Rb[3:0]);
		end
		else begin
			temp = (Ra >> Rb[3:0]);
		end
	end
	assign Rz =temp;
	
endmodule 
