module Alu(
	input wire 	[31:0] Rb,
	input wire	[31:0] Ry,
	input wire	[4:0]  Opcode,
	input wire branch_flag,
	input wire IncPC,
	input wire [31:0] inputPC,
	output reg [63:0] C_out
	);
	
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
					Not =5'b10010,
					ld	 =5'b00000,
					ldi =5'b00001,
					st  =5'b00010,
					br  =5'b10011,
					jr  =5'b10100,
					jal =5'b10101;
					
	wire	[31:0] Add_out,Sub_out,Shr_out,Shra_out,Shl_out,Ror_out,Rol_out,And_out,Or_out,Neg_out,Not_out, Div_out_r, Div_out_q,newPC;
	wire	[63:0] Mul_out;
	wire add_overflow;
	always @(*)
		begin
			if(IncPC)begin
				C_out[31:0]<= newPC;
				end
			else begin	
				case (Opcode)
					
					Add,ld,ldi,st,jr,Addi : begin
						C_out[31:0] <= Add_out;
						C_out[63:32]<= 32'b0;
					end
					jal: begin
						C_out[31:0] <= Add_out+1;
						C_out[63:32]<= 32'b0;
					end
					Sub : begin
						C_out[31:0] <= Sub_out;
						C_out[63:32]<= 32'b0;
					end
					Shr : begin
						C_out[31:0] <= Shr_out;
						C_out[63:32]<= 32'b0;
					end
					Shra: begin
						C_out[31:0] <= Shra_out;
						C_out[63:32]<= 32'b0;
					end
					Shl : begin
						C_out[31:0] <= Shl_out;
						C_out[63:32]<= 32'b0;
					end
					Ror : begin
						C_out[31:0] <= Ror_out;
						C_out[63:32]<= 32'b0;
					end
					Rol : begin
						C_out[31:0] <= Rol_out;
						C_out[63:32]<= 32'b0;
					end
					And,Andi : begin
						C_out[31:0] <= And_out;
						C_out[63:32]<= 32'b0;
					end
					Or,Ori  : begin
						C_out[31:0] <= Or_out;
						C_out[63:32]<= 32'b0;
					end
					Neg : begin
						C_out[31:0] <= Neg_out;
						C_out[63:32]<= 32'b0;
					end
					Not : begin
						C_out[31:0] <= Not_out;
						C_out[63:32]<= 32'b0;
					end
					Div : begin
						C_out[31:0] <= Div_out_q;
						C_out[63:32]<= Div_out_r;
					end
					Mul : begin
						C_out <= Mul_out;
					end
					br :begin
						if(branch_flag)begin
							C_out[31:0] <= Add_out+1;
							C_out[63:32]<= 32'b0;
						end
						else begin
							C_out[31:0] <= Ry;
							C_out[63:32]<= 32'b0;
						end
					end 
					default : begin
						C_out<= 64'd 18446744073709551615;
					end
				endcase
			end
		end
		
		Carry_lookahead_adder add(.i_add1(Ry), .i_add2(Rb),.o_result( Add_out),.c_OUT(add_overflow));
		carry_lookahead_subtractor sub(.i_add1(Ry), .i_add2(Rb),.o_result( Sub_out),.c_OUT(add_overflow));
		Shr_32 shr_32(Ry,Rb, Shr_out);
		Shra_32 shra_32(Ry,Rb, Shra_out);
		Shl_32 shl_32(Ry,Rb, Shl_out);
		Ror_32 ror_32(Ry,Rb, Ror_out);
		Rol_32 rol_32(Ry,Rb, Rol_out);
		And_32 and_32(Ry, Rb, And_out);
		Or_32 or_32(Ry, Rb, Or_out);
		Neg_32 neg_32(Ry,Neg_out);
		Not_32 not_32(Ry, Not_out);
		division Division(Ry, Rb, Div_out_q,Div_out_r);
		Mul_64 mul_64(Ry, Rb, Mul_out);
		PC pc(IncPC,inputPC,newPC);
		
		
		
endmodule 