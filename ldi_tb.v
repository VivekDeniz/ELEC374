`timescale 1ns/10ps

module ldi_tb();
    reg PCout, ZHighout, Zlowout, Hiout, Loout, InPortout, Cout,CONin, MDRout;
    reg MARin, PCin, MDRin, IRin, Yin, read, write,IncPC, Gra,Grb,Grc, Rin,Rout,BAout;
    
    reg  HIin, LOin, ZHighin, Cin, Zlowin, Clock, Clear;
    reg [31:0] Mdatain,inport_data;
	 reg branch_flag;
	 wire [31:0] outport_data;
    parameter Default = 4'b0001, T0 = 4'b0010,  T1= 4'b0011, T2 = 4'b0100,
             T3 = 4'b0101,  T4= 4'b0110,  T5= 4'b0111, T6 = 4'b1000, T7= 4'b1001;
    reg [3:0] Present_state = Default;

    datapath DUT(
        .PCout(PCout), .ZHighout(ZHighout), .Zlowout(Zlowout), .HIout(Hiout), .LOout(Loout), .InPortout(InPortout), .Cout(Cout),.CONin(CONin), .MDRout(MDRout), 
        .MARin(MARin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin),
        .IncPC(IncPC), .Read(read), .Write(write),  
        .clk(Clock), .clr(Clear), .HIin(HIin), .LOin(LOin), .ZHIin(ZHighin), .ZLOin(Zlowin), .Cin(Cin),
		  .Gra(Gra),.Grb(Grb),.Grc(Grc), .Rin(Rin),.Rout(Rout),.BAout(BAout),.inport_data(inport_data), .outport_data(outport_data)
    );

    // Clock generation
    initial begin
        Clear = 0;
        Clock = 0;
			Rout = 0;
			Present_state= 4'b0000;
			HIin=0;
			LOin=0;
			Zlowin=0;
			ZHighin=0;
			Cin=0;
			BAout=0;
			Gra=0;
			Grb=0;
			Grc=0;
			Rin=0;
         inport_data=32'b0;
			CONin=0;
			
    end
	always #10 Clock = ~Clock;
    
    always @(negedge Clock) begin

		Present_state=Present_state+1;
    end

    // FSM state behavior
    always @(Present_state) begin
        case (Present_state)
            Default: begin
                // Initialize signals
                {PCout, Zlowout, ZHighout, MDRout,  MARin, Zlowin, PCin, MDRin, IRin, Yin, IncPC, read,write, branch_flag, Hiout, Loout, InPortout, Cout, Mdatain} <= 0;
                 
					 
            end

            T0: begin
				    
                PCout <= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
					 #15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
            end
            T1: begin
					
					
                Zlowout <= 1; PCin <= 1; read <= 1; MDRin <= 1;

					 
					 #15 Zlowout <= 0; PCin <= 0; read <= 0; MDRin <= 0;
            end
            T2: begin
					 
                MDRout <= 1; IRin <= 1;
					 #15 MDRout <= 0; IRin <= 0;
            end
            T3: begin
					
                BAout <= 1; Yin <= 1;Grb<=1;
					 #15 Yin <= 0; BAout<= 0;Grb<=0;
            end
            T4: begin
                
                Cout<=1; Zlowin <= 1;

					 #15 Cout<=0; Zlowin <= 0;
            end
            T5: begin
					
               Zlowout <= 1; Gra<=1;Rin<=1;
					#15 Zlowout <= 0; Gra<=0;Rin<=0;Present_state<=0000;
            end
        endcase
    end
endmodule