
module MDRreg (clr, clk, enable, Mdatain, BusMuxOut, read, MDRout);
    input clr, clk, enable, read;
    input [31:0] Mdatain, BusMuxOut;
    output  wire [31:0] MDRout;
	
    wire [31:0] MDRin;
    mux_2_1 MDMux (Mdatain, BusMuxOut, read, MDRin);
    Register regMDR (clr, clk, enable, MDRin, MDRout);
		
endmodule
