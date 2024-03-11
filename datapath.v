module datapath(
    // Inputs
    input PCout, ZHighout, Zlowout, HIout, LOout, InPortout, Cout, CONin,
    input MDRout, MARin, PCin, MDRin, IRin, Yin, IncPC, Read,Write, Gra,Grb,Grc, Rin,Rout,BAout,
    input [4:0] operation,
    input clk,
    
    input clr, HIin, LOin, ZHIin, ZLOin, Cin,
	 input outportout,
	 input [31:0] inport_data,
	 output[31:0]outport_data
	 
	 
);
    // Define internal signals and registers
    
	 
		
	
	
    // Initialize enableReg and Rout
    

	

    // Define wires for register outputs
    wire [31:0] BusMuxIn_IR, BusMuxIn_Y, C_sign_extend, BusMuxIn_InPort, BusMuxIn_MDR, BusMuxIn_PC, BusMuxIn_ZLO, BusMuxIn_ZHI, BusMuxIn_LO, BusMuxIn_HI;
    wire [31:0] BusMuxIn_R15, BusMuxIn_R14, BusMuxIn_R13, BusMuxIn_R12, BusMuxIn_R11, BusMuxIn_R10, BusMuxIn_R9, BusMuxIn_R8, BusMuxIn_R7, BusMuxIn_R6, BusMuxIn_R5, BusMuxIn_R4, BusMuxIn_R3, BusMuxIn_R2, BusMuxIn_R1, BusMuxIn_R0;
    //wire [31:0] bus_signal;
	 wire [63:0] C_data_out, BusMuxIn_MAR;
    wire [31:0] BusMuxOut,IRout_data;
	 wire [15:0] enableReg,enableRout;
	 wire [31:0] Mdatain;
	 wire [31:0] r0_out;
	 
	 Register r0(clr,clk,enableReg[0], BusMuxOut, r0_out);
	 assign BusMuxIn_R0 = {32{!BAout}} & r0_out; 
	 
    // Instantiate registers from 0 to 15
  
    Register r1(clr, clk, enableReg[1], BusMuxOut, BusMuxIn_R1);
    Register r2(clr, clk, enableReg[2], BusMuxOut, BusMuxIn_R2);
    Register r3(clr, clk, enableReg[3], BusMuxOut, BusMuxIn_R3);
    Register r4(clr, clk, enableReg[4], BusMuxOut, BusMuxIn_R4);
    Register r5(clr, clk, enableReg[5], BusMuxOut, BusMuxIn_R5);
    Register r6(clr, clk, enableReg[6], BusMuxOut, BusMuxIn_R6);
    Register r7(clr, clk, enableReg[7], BusMuxOut, BusMuxIn_R7);
    Register r8(clr, clk, enableReg[8], BusMuxOut, BusMuxIn_R8);
    Register r9(clr, clk, enableReg[9], BusMuxOut, BusMuxIn_R9);
    Register r10(clr, clk, enableReg[10], BusMuxOut, BusMuxIn_R10);
    Register r11(clr, clk, enableReg[11], BusMuxOut, BusMuxIn_R11);
    Register r12(clr, clk, enableReg[12], BusMuxOut, BusMuxIn_R12);
    Register r13(clr, clk, enableReg[13], BusMuxOut, BusMuxIn_R13);
    Register r14(clr, clk, enableReg[14], BusMuxOut, BusMuxIn_R14);
    Register r15(clr, clk, enableReg[15], BusMuxOut, BusMuxIn_R15);

    // Instantiate other registers
    Register PC(clr, clk, PCin, BusMuxOut, BusMuxIn_PC);
    Register Y(clr, clk, Yin, BusMuxOut, BusMuxIn_Y);
    Register Z_HI(clr, clk, ZHIin, C_data_out[63:32], BusMuxIn_ZHI);
    Register Z_LO(clr, clk, ZLOin, C_data_out[31:0], BusMuxIn_ZLO);
    Register HI(clr, clk, HIin, BusMuxOut, BusMuxIn_HI);
    Register LO(clr, clk, LOin, BusMuxOut, BusMuxIn_LO);

    // Instantiate IR register
    Register IR(clr, clk, IRin,BusMuxOut , IRout_data);

    // Instantiate MDRreg module
    MDRreg MDR(clr, clk, MDRin, Mdatain, BusMuxOut, Read, BusMuxIn_MDR);
	 
	 mar marUnit(clr, clk, MARin, BusMuxOut, MAR_to_ram);
	 
	 CONFF conff(branch_flag, CONin, clr, BusMuxIn_IR, BusMuxOut);
	 wire[5:0] encoderOut;
	 
	 encoder_32_5 regEncoder({8'b0000_0000,Cout,InPortout,MDRout,PCout,Zlowout,ZHighout,LOout,HIout,enableRout}, encoderOut);
	 
	 	mux_32_1 busMux(
			.BusMuxIn_R0(BusMuxIn_R0),
			.BusMuxIn_R1(BusMuxIn_R1), 
			.BusMuxIn_R2(BusMuxIn_R2),
			.BusMuxIn_R3(BusMuxIn_R3),
			.BusMuxIn_R4(BusMuxIn_R4),
			.BusMuxIn_R5(BusMuxIn_R5),
			.BusMuxIn_R6(BusMuxIn_R6),
			.BusMuxIn_R7(BusMuxIn_R7),
			.BusMuxIn_R8(BusMuxIn_R8),
			.BusMuxIn_R9(BusMuxIn_R9),
			.BusMuxIn_R10(BusMuxIn_R10),
			.BusMuxIn_R11(BusMuxIn_R11),
			.BusMuxIn_R12(BusMuxIn_R12),
			.BusMuxIn_R13(BusMuxIn_R13),
			.BusMuxIn_R14(BusMuxIn_R14),
			.BusMuxIn_R15(BusMuxIn_R15),
			.BusMuxIn_HI(BusMuxIn_HI),
			.BusMuxIn_LO(BusMuxIn_LO),
			.BusMuxIn_Z_high(BusMuxIn_ZHI),
			.BusMuxIn_Z_low(BusMuxIn_ZLO),
			.BusMuxIn_PC(BusMuxIn_PC),
			.BusMuxIn_MDR(BusMuxIn_MDR),	
			.BusMuxIn_InPort(BusMuxIn_InPort),
			.C_sign_extended(C_sign_extend),
			.BusMuxOut(BusMuxOut),
			.select(encoderOut)
			);
					
	//instantiate alu
	Alu the_alu(
		.Rb(BusMuxOut),
		.Ry(BusMuxIn_Y),
		.Opcode(operation),
		.C_out(C_data_out),
		.branch_flag(branch_flag)
	);
	select_encode select(
		.Gra(Gra),.Grb(Grb),.Grc(Grc),.Rin(Rin),.Rout(Rout),.BAout(BAout),
		.IR(IRout_data),
		.Rin_to_reg(enableReg),.Rout_to_reg(enableRout),
		.C_sign_extended(C_sign_extend)
		);

    // Output assignment
	 outport outport(
		.clr(clr),.clk(clk),.outportin(outportin), 
		.BusMuxOut(BusMuxOut),
		.outport_data(outport_data)
		);
	 
	 inport inport( 
		.clr(clr),.clk(clk),
		.inport_data(inport_data),
		.BusMuxIn(BusMuxIn_InPort)
		);
	ram ram(
		.address(Mar_to_ram),
		.clock(clk),
		.data(BusMuxOut),
		.rden(Read),
		.wren(Write),
		.q(Mdatain)
		);

endmodule
