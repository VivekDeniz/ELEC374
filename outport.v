module outport(
	input clr,clk,outportin, 
	input [31:0]BusMuxOut,
	output [31:0]outport_data
	);
	wire data_out;
	Register	outportreg(clr, clk, outportin,BusMuxOut, data_out);
	assign outport_data=data_out;
					
endmodule 
