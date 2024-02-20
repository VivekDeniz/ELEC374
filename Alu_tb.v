`timescale 1ns/10ps
module Alu_tb;
	
	reg 	[31:0]Ry;
	reg 	[31:0]Rb;
	reg 	clock;
	reg 	[3:0]state;
	reg	[4:0] Opcode;
	wire 	[63:0]C_out;
	Alu dp(Rb,Ry,Opcode,C_out);
	
	parameter 	Add =5'b00011,
					Sub =5'b00100,
					Shr =5'b00101,
					Shra=5'b00110,
					Shl =5'b00111,
					Ror =5'b01000,
					Rol =5'b01001,
					And =5'b01010,
					Or  =5'b01100,
					Addi=5'b01100,
					Andi=5'b01101,
					Ori =5'b01110,
					Mul =5'b01111,
					Div =5'b10000,
					Neg =5'b10001,
					Not =5'b10010;

	initial begin
		clock=0;
		#5 state=4'b1111;
		
	end
	
	always #5 clock=~clock;
	
	always @(posedge clock)state= state+1;
	
	always @(posedge clock)begin
		case(state)
		//add
		0	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Add;
			end
		1	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Sub;
			end
		2	:	begin
			Ry<=32'd32;
			Rb<=32'd5;
			Opcode<=Shr;
			end
		3	:	begin
			Ry<=32'd1024;
			Rb<=32'd5;
			Opcode<=Shra;
			end
		4	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Shl;
			end
		5	:	begin
			Ry<=32'd15;
			Rb<=32'd1;
			Opcode<=Ror;
			end
		6	:	begin
			Ry<=32'd15;
			Rb<=32'd1;
			Opcode<=Rol;
			end
		7	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=And;
			end
		8	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Or;
			end
		9	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Mul;
			end
		10	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Div;
			end
		11	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Neg;
			end
		12	:	begin
			Ry<=32'd15;
			Rb<=32'd5;
			Opcode<=Not;
			end
		endcase
			
	end

endmodule 
