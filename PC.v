`timescale 1ns / 10ps

module PC #(parameter qInitial = 0)(
    input IncPC,
    input [31:0] inputPC,
    output wire[31:0] newPC
    );
	reg [31:0] temp;
	initial temp = qInitial;
	
	always@(IncPC)begin
		if (IncPC)
		  temp = inputPC + 1;
	end
	assign newPC= temp;
endmodule
