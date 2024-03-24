module ram(	input  [31:0]data_in,
				input  [8:0]address,
				input  read, write,clk,
				output wire [31:0] data_out
				);
	reg[31:0] memory [0:511];
	initial begin
//ld test	
//		memory[90] =32'b00000_0010_0000_0000_000000010010101;//load using C only
//		memory[91] =32'b00000_0000_0010_0000_000000000111000;//load using Rb and c
//		memory[149] =32'b10;//2
//		memory[58] =32'b101;//5
		
//ldi test	
//		memory[90] =32'b00001_0010_0000_0000_000000010010101;//load using C only
//		memory[91] =32'b00001_0000_0010_0000_000000000111000;//load using Rb and c
 
		
//st test
//		memory[90] =32'b00000_0001_0000_0000_000000010010101;//load using C only into R1
//		memory[91] =32'b00010_0001_0000_0000_000000010000111;//st using C only
//		memory[92] =32'b00000_0010_0000_0000_000000010000111;//load using C only into R2
//		
//		memory[93] =32'b00010_0001_0001_0000_000000010000111;//st using Rb and c
//		memory[94] =32'b00000_0011_0001_0000_000000010000111;//load using C and Rb only into R3
//		memory[149]=32'b10010101;

//addi test
//		memory[90] =32'b00001_0100_0000_0000_000000000000111;//load using C only into R4
//		memory[91] =32'b00010_0011_0100_1111_111111111111011; //add R4 and -5 into r3
//		

//andi test
//		memory[90] =32'b00001_0100_0000_0000_000000000000111;//load using C only into R4
//		memory[91] =32'b01010_0011_0100_0000_000000001010011; // R4 and 0x53 into r3
//		
//ori test
//		memory[90] =32'b00001_0100_0000_0000_000000000000111;//load using C only into R4
//		memory[91] =32'b01110_0011_0100_0000_000000001010011; // R4 and 0x53 into r3
		
//br test
//		memory[90] =32'b00001_0101_0000_0000_000000000000111;//load using C only into R5

//		memory[91] =32'b10011_0101_0000_0000_000000000001110; //brzr
//		memory[91] =32'b10011_0101_0001_0000_000000000001110; //brnz		
//		memory[91] =32'b10011_0101_0010_0000_000000000001110; //brpl
//		memory[91] =32'b10011_0101_0011_0000_000000000001110; //brmi

//jr test
//		memory[90] =32'b00001_0110_0000_0000_000000000000111;//load using C only into R6
//		memory[91] =32'b10100_0110_0000_0000_000000000000000; // jr R6
//jal test
//		memory[90] =32'b00001_0110_0000_0000_000000000000111;//load using C only into R6
//		memory[91] =32'b10101_0110_1111_0000_000000000000000; // jal R6, double check on how they want this
//mfhi test
//		memory[90] =32'b00001_0000_0000_0000_000000000000111;//modded loadi using C only into HI
//		memory[91] =32'b11000_0110_0000_0000_000000000000000; // mfhi R6
//mflo test
//		memory[90] =32'b00001_0000_0000_0000_000000000000111;// modded loadi using C only into LO
//		memory[91] =32'b11001_0111_0000_0000_000000000000000; // mflo R7
//out test
//		memory[90] =32'b00001_0011_0000_0000_000000000000111;// loading 7 into R3
//		memory[91] =32'b10111_0011_0000_0000_000000000000000; // outputting R3
//in test
		
		memory[90] =32'b10110_0100_0000_0000_000000000000000; // tajing input into R4
	end
	reg [31:0] temp;
	always @(*) begin
		if(write) begin
			memory[address] <=data_in;
		end
		if(read)  begin
			temp <= memory[address];
		end
	end

	assign data_out =temp;

endmodule