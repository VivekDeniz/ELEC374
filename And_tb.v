`timescale 1ns/10ps
module 	And_tb;


	reg 	[31:0]Ra;
	reg 	[31:0]Rb;
	reg 	prev_Rz, clock;
	reg 	[3:0]state;
	
	wire 	[31:0]Rz;
	And_32 dp( Ra,Rb,Rz);
	
	initial begin
		clock=0;
		state=4'd0;
	end
	
	always #10 clock=~clock;
	
	always @(negedge clock)state= state+1;
	
	always @(posedge clock)begin
		case(state)
		
		0	:	begin
			Ra<=32'h0;
			Rb<=32'h0;
			end
		1	:	begin
			Ra<=32'hffff_ffff;
			Rb<=32'hffff_ffff;
			end
		2	:	begin
			Ra<=32'h0000_0000;
			Rb<=32'hffff_ffff;
			end
		3	:	begin
			Ra<=32'hffff_ffff;
			Rb<=32'hffff_0000;
			end
		4	:	begin
			Ra<=32'hffff_ffff;
			Rb<=32'h0000_ffff;
			end
		default	:begin
			Ra<=32'h0000_0000;
			Rb<=32'h0000_0000;
			end
		endcase
			
	end
		

			

endmodule 