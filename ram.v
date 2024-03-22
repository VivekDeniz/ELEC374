module ram(	input  [31:0]data_in,
				input  [8:0]address,
				input  read, write,clk,
				output wire [31:0] data_out
				);
	reg[31:0] memory [0:511];
	initial begin
//ld test	
//		memory[90] =32'b00000_0001_0000_0000_000000000001010;//load using C only
//		memory[91] =32'b00000_0010_0001_0000_000000000000000;//load using Rb only
//		memory[92] =32'b00000_0011_0010_0000_000000000000011;//load using Rb and c
//		
//		memory[10] =32'b11010;//26
//		memory[26] =32'b101;//5
//		memory[8]  =32'b110;//6

//ldi test	
		memory[90] =32'b00000_0001_0000_0000_000000000001010;//loadi using C only
		memory[91] =32'b00000_0010_0001_0000_000000000000000;//loadi using Rb only
		memory[92] =32'b00000_0011_0010_1111_111111111111101;//loadi using Rb and c
		

	end
	reg [31:0] temp;
	always @(*) begin
		if(write) begin
			memory[address] <=data_in;
		end
		if(read)  begin
			temp <= memory[address];
		end
		//else temp <=32'b0;
	end

	assign data_out =temp;

endmodule