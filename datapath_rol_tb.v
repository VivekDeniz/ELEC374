`timescale 1ns/10ps

module datapath_rol_tb();
    reg PCout, ZHighout, Zlowout, Hiout, Loout, InPortout, Cout, MDRout;
    reg MARin, PCin, MDRin, IRin, Yin, read, IncPC;
    reg [4:0] opCode;
    reg  HIin, LOin, ZHighin, Cin, Zlowin, Clock, Clear;
    reg [31:0] Mdatain;
	 reg branch_flag;
	 reg [15:0] enableReg, Rout;
    parameter Default = 4'b0001, Reg_load1a = 4'b0010, Reg_load1b = 4'b0011, Reg_load2a = 4'b0100,
             Reg_load2b = 4'b0101, Reg_load3a = 4'b0110, Reg_load3b = 4'b0111, T0 = 4'b1000,
             T1 = 4'b1001, T2 = 4'b1010, T3 = 4'b1011, T4 = 4'b1100, T5 = 4'b1101;
    reg [3:0] Present_state = Default;

    datapath DUT(
        .PCout(PCout), .ZHighout(ZHighout), .Zlowout(Zlowout), .HIout(Hiout), .LOout(Loout), .InPortout(InPortout), .Cout(Cout), .MDRout(MDRout), 
        .MARin(MARin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin),
        .IncPC(IncPC), .Read(read), .operation(opCode), 
        .clk(Clock), .Mdatain(Mdatain), .clr(Clear), .HIin(HIin), .LOin(LOin), .ZHIin(ZHighin), .ZLOin(Zlowin), .Cin(Cin), .branch_flag(branch_flag), .enableReg(enableReg),.Rout(Rout)
    );

    // Clock generation
    initial begin
        Clear = 0;
        Clock = 0;
		  enableReg = 16'b0;
			Rout = 16'b0;
			Present_state= 4'b0000;
			HIin=0;
			LOin=0;
			Zlowin=0;
			ZHighin=0;
			Cin=0;
         // Toggle clock every 10 time units
    end
	always #10 Clock = ~Clock;
    // FSM definition
    always @(negedge Clock) begin

		Present_state=Present_state+1;
    end

    // FSM state behavior
    always @(Present_state) begin
        case (Present_state)
            Default: begin
                // Initialize signals
                {PCout, Zlowout, ZHighout, MDRout,  MARin, Zlowin, PCin, MDRin, IRin, Yin, IncPC, read, branch_flag, Hiout, Loout, InPortout, Cout, Mdatain} <= 0;
                opCode = 5'b00000; 
					 
            end
            Reg_load1a: begin
                Mdatain <= 32'hf0000000;
                 read <= 0; MDRin <= 1;
                 #15 read <= 1; MDRin <= 0;
            end
            Reg_load1b: begin
					 
                MDRout <= 1; enableReg[2]<= 1;
					 #15 MDRout <= 0; enableReg[2] <= 0;
            end
            Reg_load2a: begin
					 
                Mdatain <= 32'h0000003;
                 read = 0; MDRin = 1;
                #15read <= 0; MDRin <= 0;
            end
            Reg_load2b: begin
					
					MDRout <= 1; enableReg[3] <= 1;
					#15 MDRout <= 0; enableReg[3] <= 0;

            end
            Reg_load3a: begin
					
                Mdatain <= 32'h00000018;
                read <= 0; MDRin <= 1;
                #15 read <= 0; MDRin <= 0;
            end
            Reg_load3b: begin
					
               MDRout <= 1; enableReg[1] <= 1;
					#15 MDRout <= 0; enableReg[1] <= 0;
            end
            T0: begin
				    

                PCout <= 1; MARin <= 1; IncPC <= 1; ZHighin <= 1;
					 #15 PCout <= 0; MARin <= 0; IncPC <= 0; ZHighin <= 0;
            end
            T1: begin
					//deassert
					
                Zlowout <= 1; PCin <= 1; read <= 0; MDRin <= 1;
                Mdatain <= 32'h28918000; // opcode for "and R1, R2, R3"
					 
					 #15 Zlowout <= 0; PCin <= 0; read <= 1; MDRin <= 0;
            end
            T2: begin
					 
                MDRout <= 1; IRin <= 1;
					 #15 MDRout <= 0; IRin <= 0;
            end
            T3: begin
					
                Rout[2] <= 1; Yin <= 1;
					 #15 Yin <= 0; Rout[2] <= 0;
            end
            T4: begin
                 // Assuming logical AND is performed elsewhere
                Rout[3]<=1; Zlowin <= 1;opCode = 5'b01001;
					 #15 Rout[3]<=0; Zlowin <= 0;opCode = 5'b00000;
            end
            T5: begin
					
               Zlowout <= 1; enableReg[1] <= 1;
					#15 Zlowout <= 0; enableReg[1] <= 0;
            end
        endcase
    end
endmodule