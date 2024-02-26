module MDRreg (
    input clr, clk, enable, read,
    input [31:0] Mdatain, BusMuxOut,
    output wire [31:0] MDRout
);

    wire [31:0] MDRin;
    Register #(
        .DATA_WIDTH_IN(32),
        .DATA_WIDTH_OUT(32),
        .INIT(32'h0)
    ) MDRRegister (
        .clear(clr),
        .clock(clk),
        .enable(enable),
        .BusMuxOut(BusMuxOut),
        .BusMuxIn(MDRin)
    );

    assign MDRout = read ? MDRin : Mdatain;

endmodule
