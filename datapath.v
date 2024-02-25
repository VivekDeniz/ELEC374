module datapath(
    // Inputs
    input PCout, ZHighout, Zlowout, HIout, Loout, InPortout, Cout,
    input MDRout, R2out, R4out, MARin, PCin, MDRin, IRin, Yin, IncPC, Read,
    input [4:0] operation,
    input R5in, R2in, R4in, clk,
    input [31:0] Mdatain,
    input clr, HIin, LOin, ZHIin, ZLOin, Cin, branch_flag,
    // Outputs
    output reg [31:0] OutPort_output
);
    // Define internal signals and registers
    reg [15:0] enableReg;
    reg [15:0] Rout;

    // Initialize enableReg and Rout
    initial begin
        Rout = 16'b0;
        enableReg = 16'b0;
    end

    // Set register enable and out signals based on provided info from CPU or IR
    always @* begin
        enableReg[2] = R2in;
        enableReg[4] = R4in;
        enableReg[5] = R5in;
        Rout[13] = R2out;
        Rout[14] = R4out;
    end

    // Define wires for register outputs
    wire [31:0] BusMuxIn_IR, BusMuxIn_Y, C_sign_extend, BusMuxIn_InPort, BusMuxIn_MDR, BusMuxIn_PC, BusMuxIn_ZLO, BusMuxIn_ZHI, BusMuxIn_LO, BusMuxIn_HI;
    wire [31:0] BusMuxIn_R15, BusMuxIn_R14, BusMuxIn_R13, BusMuxIn_R12, BusMuxIn_R11, BusMuxIn_R10, BusMuxIn_R9, BusMuxIn_R8, BusMuxIn_R7, BusMuxIn_R6, BusMuxIn_R5, BusMuxIn_R4, BusMuxIn_R3, BusMuxIn_R2, BusMuxIn_R1, BusMuxIn_R0;
    wire [31:0] bus_signal, C_data_out;
    wire [31:0] BusMuxOut;

    // Instantiate registers from 0 to 15
    Register r0(clr, clk, enableReg[0], BusMuxOut, BusMuxIn_R0);
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
    Register PC(clr, clk, PCin, aluPC, BusMuxIn_PC);
    Register Y(clr, clk, Yin, BusMuxOut, BusMuxIn_Y);
    Register Z_HI(clr, clk, ZHIin, C_data_out, BusMuxIn_ZHI);
    Register Z_LO(clr, clk, ZLOin, C_data_out, BusMuxIn_ZLO);
    Register HI(clr, clk, HIin, BusMuxOut, BusMuxIn_HI);
    Register LO(clr, clk, LOin, BusMuxOut, BusMuxIn_LO);

    // Instantiate IR register
    Register IR(clr, clk, IRin, BusMuxOut, BusMuxIn_IR);

    // Instantiate MDRreg module
    MDRreg MDR(clr, clk, 1'b1, Read, Mdatain, MDRout);

    // Output assignment
    always @* begin
        OutPort_output = BusMuxOut;
    end

endmodule