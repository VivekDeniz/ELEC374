module mux_2_1 (
    input [31:0] muxIn_1, 
    input [31:0] muxIn_2, 
    input signal, 
    output reg [31:0] muxOut
);
 
always @* begin
    if (!signal) begin
        muxOut = muxIn_1;
    end
    else begin
        muxOut = muxIn_2;
    end
end

endmodule
