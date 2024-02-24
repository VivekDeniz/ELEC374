`timescale 1ns / 1ps

module datapath_tb;

    // Define parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Inputs
    reg PCout, ZHighout, Zlowout, HIout, Loout, InPortout, Cout;
    reg MDRout, R2out, R4out, MARin, PCin, MDRin, IRin, Yin, IncPC, Read;
    reg [4:0] operation;
    reg R5in, R2in, R4in, clk;
    reg [31:0] Mdatain;
    reg clr, HIin, LOin, ZHIin, ZLOin, Cin, branch_flag;

    // Outputs
    wire [31:0] OutPort_output;

    // Declare enableReg
    reg [15:0] enableReg;

    // Instantiate the datapath module
    datapath dut (
        // Inputs
        .PCout(PCout), .ZHighout(ZHighout), .Zlowout(Zlowout), .HIout(HIout), .Loout(Loout), .InPortout(InPortout), .Cout(Cout),
        .MDRout(MDRout), .R2out(R2out), .R4out(R4out), .MARin(MARin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .IncPC(IncPC), .Read(Read),
        .operation(operation), .R5in(R5in), .R2in(R2in), .R4in(R4in), .clk(clk),
        .Mdatain(Mdatain),
        .clr(clr), .HIin(HIin), .LOin(LOin), .ZHIin(ZHIin), .ZLOin(ZLOin), .Cin(Cin), .branch_flag(branch_flag),
        // Outputs
        .OutPort_output(OutPort_output)
    );

    // Clock generation
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Initial values
    initial begin
        // Initialize inputs
        clr = 1'b0; // Clear signal initially off
        clk = 1'b0; // Initialize clock
        // Other inputs can be initialized as needed

        // Add a delay before starting the testbench
        #100;

        // Activate clear signal to initialize registers
        clr = 1'b1;
        #10;
        clr = 1'b0;

        // Write a value to a register (for example, register R2)
        // This can be any value you want to write to the register
        Mdatain = 32'h12345678;
        enableReg = 16'b0000000000010000; // Enable register R2
        // Other control signals can be set as needed

        // Wait for a few clock cycles
        #100;

        // Read from another register (for example, register R4)
        // This should contain the value written to register R2
        enableReg = 16'b0000000000000100; // Enable register R4 for reading

        // Add some delay for observation
        #100;

        // End simulation
        $finish;
    end

endmodule
