`timescale 1ns/10ps
module control_unit(
		input [31:0] IR,
		input clk,reset,stop,
		output reg  PCout, ZHighout, Zlowout, Hiout, Loout, InPortout,outportin, Cout, 
						MDRout, MARin, PCin, MDRin, IRin, Yin, IncPC, read,write, Gra,Grb,Grc, 
						Rin,Rout,BAout,JAL,clr,HIin, LOin, ZHighin, Zlowin, Cin,CONin,Run					
	);
	parameter Add =5'b00011,Sub =5'b00100,Shr =5'b00101,Shra=5'b00110,Shl =5'b00111,Ror =5'b01000,
				Rol =5'b01001,And =5'b01010,Or  =5'b01011,Addi=5'b01100,Andi=5'b01101,Ori =5'b01110,
				Mul =5'b01111,Div =5'b10000,Neg =5'b10001,Not =5'b10010,ld=5'b00000,ldi =5'b00001,
				st  =5'b00010,br  =5'b10011,jr  =5'b10100,jal =5'b10101,in=5'b10110,out=5'b10111,mfhi=5'b11000,
				mflo=5'b11001,nop=5'b11010,halt=5'b11011,
				
				Reset_state = 6'b0001, fetch0 = 6'b0010,  fetch1= 6'b0011, fetch2 = 6'b0100,A5_3=6'b0101,A5_4=6'b0110,
				A5_5=6'b0111,Ai_3=6'b1000,Ai_4=6'b1001,Ai_5=6'b1010,A6_3=6'b1011,A6_4=6'b1100,A6_5=6'b1101,
				A6_6=6'b1110,A4_3=6'b1111,A4_4=6'b10000,Br_3=6'b10001,Br_4=6'b10010,Br_5=6'b10011,Br_6=6'b10100,
				ld_3=6'b10101,ld_4=6'b10110,ld_5=6'b10111,ld_6=6'b11000,ld_7=6'b11001,ldi_3=6'b11010,
				ldi_4=6'b11011,ldi_5=6'b11100,st_3=6'b11101,st_4=6'b11110,st_5=6'b11111,st_6=6'b100000,
				st_7=6'b100001,Jr_3=6'b100010,Jal_3=6'b100011,Jal_4=6'b100100,Jal_5=6'b100101,in_3=6'b100110,
				out_3=6'b100111,mfhi_3=6'b101000,mflo_3=6'b101001,nop_3=6'b101010,halt_3=6'b101011;
             
   reg [5:0] Present_state = 6'b0;
	reg halt_out;
	always@(negedge clk) begin
		if(reset==1) Present_state = Reset_state;
		if(stop)begin
			Present_state=halt_3;
		end
		if(Present_state==fetch2)begin
			case(IR[31:27])
				Add,Sub,Shr,Shra,Shl,Ror,Rol,And,Or:Present_state=A5_3;//5 cycle arithmatic 
				Addi,Andi,Ori: Present_state=Ai_3;//immediate arithmatic
				Mul,Div: Present_state=A6_3;//6 cycle arithmatic
				Neg,Not: Present_state=A4_3;//4 cycle arithmatic
				br: Present_state=Br_3;//branch
				ld: Present_state=ld_3;//load
				ldi:Present_state=ldi_3;//load immediate
				st: Present_state=st_3;//store
				jr: Present_state=Jr_3;//jump
				jal:Present_state=Jal_3;//jump and link
				in: Present_state=in_3;//in
				out:Present_state=out_3;//out
				mfhi:Present_state=mfhi_3;
				mflo:Present_state=mflo_3;
				nop:Present_state=nop_3;
				halt:Present_state=halt_3;
			endcase
		end
		else begin
			case (Present_state)
				A5_5:Present_state=fetch0;
				Ai_5:Present_state=fetch0;
				A6_6:Present_state=fetch0;
				A4_4:Present_state=fetch0;
				Br_6:Present_state=fetch0;
				ld_7:Present_state=fetch0;
				ldi_5:Present_state=fetch0;
				st_7:Present_state=fetch0;
				Jr_3:Present_state=fetch0;
				Jal_5:Present_state=fetch0;
				in_3:Present_state=fetch0;
				out_3:Present_state=fetch0;
				mfhi_3:Present_state=fetch0;
				mflo_3:Present_state=fetch0;
				nop_3:Present_state=fetch0;
				default: Present_state=Present_state+1;
			endcase
		end
	end
	
	always@(Present_state)begin
		case(Present_state)
			Reset_state:begin
				PCout<=0;
				ZHighout<=0;
				Zlowout<=0;
				Hiout<=0;
				Loout<=0;
				InPortout<=0;
				outportin<=0;
				Cout<=0;
				MDRout<=0;
				MARin<=0;
				PCin<=0;
				MDRin<=0;
				IRin<=0;
				Yin<=0;
				IncPC<=0;
				read<=0;
				write<=0;
				Gra<=0;
				Grb<=0;
				Grc<=0;
				Rin<=0;
				Rout<=0;
				BAout<=0;
				JAL<=0;
				clr<=1;
				Run<=1;
				HIin<=0;
				LOin<=0;
				ZHighin<=0;
				Zlowin<=0;
				Cin<=0;
				halt_out<=0;
				#15 clr<=0;
			end
			fetch0:begin
				PCout <= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
				#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
			end
			fetch1:begin
				 Zlowout <= 1; PCin <= 1; read <= 1; MDRin <= 1;
				 #15 Zlowout <= 0; PCin <= 0; read <= 0; MDRin <= 0;
			end
			fetch2: begin
				 MDRout <= 1; IRin <= 1;
				#15 MDRout <= 0; IRin <= 0;
         end
			A5_3:begin
				Rout <= 1; Yin <= 1;Grb<=1;
				#15 Yin <= 0;Rout<= 0;Grb<=0;				
			end
			A5_4:begin
				Rout <= 1; Zlowin<= 1;Grc<=1;
				#15 Zlowin <= 0;Rout<= 0;Grc<=0;
			end
			A5_5:begin
				Zlowout <= 1; Gra<=1;Rin<=1;
				#15 Zlowout <= 0; Gra<=0;Rin<=0;
			end
			Ai_3:begin
				Rout <= 1; Yin <= 1;Grb<=1;
				#15 Yin <= 0;Rout<= 0;Grb<=0;
			end
			Ai_4:begin
				Cout<=1; Zlowin <= 1;

				#15 Cout<=0; Zlowin <= 0;			
			end
			Ai_5:begin
				Zlowout <= 1; Gra<=1;Rin<=1;
				#15 Zlowout <= 0; Gra<=0;Rin<=0;
			end
			A6_3:begin
				Rout <= 1; Yin <= 1;Gra<=1;
				#15 Yin <= 0;Rout<= 0;Gra<=0;				
			end
			A6_4:begin
				Rout <= 1; Zlowin<= 1;ZHighin<=1;Grb<=1;
				#15 Zlowin <= 0;Rout<= 0;ZHighin<=0;Gra<=0;
			end
			A6_5:begin
				Zlowout <= 1; LOin<=1;
				#15 Zlowout <= 0; LOin<=0;
			end
			A6_6:begin
				ZHighout <= 1; HIin<=1;
				#15 ZHighout <= 0; HIin<=0;
			end
			A4_3:begin
				Rout <= 1; Zlowin <= 1;Grb<=1;
				#15 Zlowin <= 0;Rout<= 0;Grb<=0;
			end
			A4_4:begin
				Zlowout <= 1; Gra<=1;Rin<=1;
				#15 Zlowout <= 0; Gra<=0;Rin<=0;			
			end
			Br_3:begin
				Rout <= 1; CONin <= 1;Gra<=1;
				#15 CONin <= 0;Rout<= 0;Gra<=0;				
			end
			Br_4:begin
				PCout<=1; Yin <= 1;
				#15 PCout<=0; Yin <= 0;
			end
			Br_5:begin
				Cout <= 1;Zlowin <=1;
				#15 Cout <= 0;Zlowin <=0;
			end
			Br_6:begin
				Zlowout<= 1;PCin <=1;
				#15 Zlowout<= 0;PCin <=0;
			end
			ld_3:begin
				BAout <= 1; Yin <= 1;Grb<=1;
				#15 Yin <= 0; BAout<= 0;Grb<=0;
			end
			ld_4:begin
				Cout<=1; Zlowin <= 1;
				#15 Cout<=0; Zlowin <= 0;
			end
			ld_5:begin
				Zlowout <= 1; MARin<=1;
				#15 Zlowout <= 0; MARin<=0;
			end
			ld_6:begin
				read<=1; MDRin<=1;
				#15 read<=0; MDRin<=0;
			end
			ld_7:begin
				MDRout<=1; Gra<=1;Rin<=1;
				#15 MDRout<=0; Gra<=0;Rin<=0;
			end
			ldi_3:begin
				BAout <= 1; Yin <= 1;Grb<=1;
				#15 Yin <= 0; BAout<= 0;Grb<=0;				
			end
			ldi_4:begin
				Cout<=1; Zlowin <= 1;
				#15 Cout<=0; Zlowin <= 0;
			end
			ldi_5:begin
				Zlowout <= 1; Gra<=1;Rin<=1;
				#15 Zlowout <= 0; Gra<=0;Rin<=0;
			end
			st_3:begin
				BAout <= 1; Yin <= 1;Grb<=1;
				#15 Yin <= 0; BAout<= 0;Grb<=0;
			end
			st_4:begin
				Cout<=1; Zlowin <= 1;
				#15 Cout<=0; Zlowin <= 0;
			end
			st_5:begin
				Zlowout <= 1; MARin<=1;
				#15 Zlowout <= 0; MARin<=0;
			end
			st_6:begin
				Gra<=1;Rout<=1; MDRin<=1;
				#15 Gra<=0;Rout<=0; MDRin<=0;
			end
			st_7:begin
				MDRout<=1; write=1;
				#15 MDRout<=0;write=0; 
			end
			Jr_3:begin
				Rout <= 1; PCin <= 1;Gra<=1;
				#15 PCin <= 0;Rout<= 0;Gra<=0; 
			end
			Jal_3:begin
				PCout <= 1;Zlowin<=1;
				#15 PCout <= 0;Zlowin<=0;
			end
			Jal_4:begin
				Zlowout<=1;JAL<=1;
				#15 Zlowout<=0;JAL<=0;
			end
			Jal_5:begin
				Rout <= 1; PCin <= 1;Gra<=1;
				#15 PCin <= 0;Rout<= 0;Gra<=0; 
			end
			in_3:begin
				Rin <= 1; InPortout <= 1;Gra<=1;
				#15 Rin <= 0;InPortout<= 0;Gra<=0;
			end
			out_3:begin
				Rout <= 1; outportin <= 1;Gra<=1;
				#15 Rout<= 0;outportin<= 0;Gra<=0;
			end
			mfhi_3:begin
				Rin <= 1; Hiout <= 1;Gra<=1;
				#15 Rin <= 0;Hiout<= 0;Gra<=0;
			end
			mflo_3:begin
				Rin <= 1; Loout <= 1;Gra<=1;
				#15 Rin <= 0;Loout<= 0;Gra<=0;
			end
			nop_3:begin
				
			end
			halt_3:begin
				Run<=0;
			end
		endcase
	end
endmodule 