module select_encode(
	input Gra,Grb,Grc,Rin,Rout,BAout,
	input [31:0] IR,
	output wire [15:0]Rin_to_reg,Rout_to_reg,
	output wire [31:0] C_sign_extended
);
	reg [3:0] decoder_in;
	reg [15:0] reg_select,temp_in,temp_out;
	reg [31:0] extend_temp;
	
	always@(*)begin
		if(Gra)  		decoder_in =IR[26:23];
		else if(Grb)  	decoder_in =IR[22:19];
		else if(Grc) 	decoder_in =IR[18:15];
		case(decoder_in)
			4'd15 : reg_select=16'b1000_0000_0000_0000;
			4'd14 : reg_select=16'b0100_0000_0000_0000;
			4'd13 : reg_select=16'b0010_0000_0000_0000;
			4'd12 : reg_select=16'b0001_0000_0000_0000;
			4'd11 : reg_select=16'b0000_1000_0000_0000;
			4'd10 : reg_select=16'b0000_0100_0000_0000;
			4'd9  : reg_select=16'b0000_0010_0000_0000;
			4'd8  : reg_select=16'b0000_0001_0000_0000;
			4'd7  : reg_select=16'b0000_0000_1000_0000;
			4'd6  : reg_select=16'b0000_0000_0100_0000;
			4'd5  : reg_select=16'b0000_0000_0010_0000;
			4'd4  : reg_select=16'b0000_0000_0001_0000;
			4'd3  : reg_select=16'b0000_0000_0000_1000;
			4'd2  : reg_select=16'b0000_0000_0000_0100;
			4'd1  : reg_select=16'b0000_0000_0000_0010;
			4'd0  : reg_select=16'b0000_0000_0000_0001;
		endcase
		if(Rout||BAout)  temp_out= reg_select;
		else  temp_out=16'b0;
		if(Rin)  temp_in=reg_select;
		else  temp_in=16'b0;
		
		extend_temp={{14{ IR [18]}},IR[17:0]};
		
		
	end
	
	
	assign Rin_to_reg=temp_in;
	assign Rout_to_reg=temp_out;
	assign C_sign_extended=extend_temp;
endmodule	