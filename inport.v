module inport(
	input clr,clk, 
	input [31:0]inport_data,
	output [31:0] BusMuxIn
	);
	wire data_out;
	Register	inportreg(clr, clk, 1'b1,inport_data, data_out);
	assign BusMuxIn=data_out;
		
endmodule 