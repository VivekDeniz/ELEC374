`timescale 1ns/10ps

module mux_32_1(
    // Data from general purpose registers
    input [31:0] BusMuxIn_R0,
    input [31:0] BusMuxIn_R1,
    input [31:0] BusMuxIn_R2,
    input [31:0] BusMuxIn_R3, 
    input [31:0] BusMuxIn_R4,
    input [31:0] BusMuxIn_R5,
    input [31:0] BusMuxIn_R6,
    input [31:0] BusMuxIn_R7,
    input [31:0] BusMuxIn_R8,
    input [31:0] BusMuxIn_R9,
    input [31:0] BusMuxIn_R10,
    input [31:0] BusMuxIn_R11,
    input [31:0] BusMuxIn_R12,
    input [31:0] BusMuxIn_R13,
    input [31:0] BusMuxIn_R14,
    input [31:0] BusMuxIn_R15,
    
    // Data from special registers
    input [31:0] BusMuxIn_HI,
    input [31:0] BusMuxIn_LO,
    input [31:0] BusMuxIn_Z_high,
    input [31:0] BusMuxIn_Z_low,
    input [31:0] BusMuxIn_PC,
    input [31:0] BusMuxIn_MDR,  
    input [31:0] BusMuxIn_InPort,
    input [31:0] C_sign_extended,
    
    // Output to the bus
    output wire [31:0] BusMuxOut,
    
    // Select signal
    input wire [5:0] select
);	
	reg [31:0] temp;

always @* begin
    // Assign output data based on select signal
    case (select)
        5'd0 : temp = BusMuxIn_R0[31:0];
        5'd1 : temp = BusMuxIn_R1[31:0];
        5'd2 : temp = BusMuxIn_R2[31:0];
        5'd3 : temp = BusMuxIn_R3[31:0];
        5'd4 : temp = BusMuxIn_R4[31:0];
        5'd5 : temp = BusMuxIn_R5[31:0];
        5'd6 : temp = BusMuxIn_R6[31:0];
        5'd7 : temp = BusMuxIn_R7[31:0];
        5'd8 : temp = BusMuxIn_R8[31:0];
        5'd9 : temp = BusMuxIn_R9[31:0];
        5'd10: temp = BusMuxIn_R10[31:0];
        5'd11: temp = BusMuxIn_R11[31:0];
        5'd12: temp = BusMuxIn_R12[31:0];
        5'd13: temp = BusMuxIn_R13[31:0];
        5'd14: temp = BusMuxIn_R14[31:0];
        5'd15: temp = BusMuxIn_R15[31:0];
        5'd16: temp = BusMuxIn_HI[31:0];
        5'd17: temp = BusMuxIn_LO[31:0];
        5'd18: temp = BusMuxIn_Z_high[31:0];
        5'd19: temp = BusMuxIn_Z_low[31:0];
        5'd20: temp = BusMuxIn_PC[31:0];
        5'd21: temp = BusMuxIn_MDR[31:0];
        5'd22: temp = BusMuxIn_InPort[31:0];
        5'd23: temp = C_sign_extended[31:0];
        default: temp = 32'd0;
    endcase
	 
	 
	end
	assign BusMuxOut = temp;
endmodule
