`timescale 1ns / 1ps



module Rol_32(
	
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	
	reg [31:0]temp_a,temp_shift;
	reg	[4:0] i;
	reg [3:0] temp_b;
	reg temp_rotate;
	
			

	
	initial begin
		i=4'b0;
		temp_a<= Ra;
		temp_b<= Rb[3:0];
		
		for(i=0; i < temp_b ; i = i +1)begin
			temp_rotate=temp_a[31];
			
			temp_a<= temp_a << 1;
			temp_a[0]<=temp_rotate;
		end
		
		
	end
	assign Rz = temp_a;	
	
endmodule 