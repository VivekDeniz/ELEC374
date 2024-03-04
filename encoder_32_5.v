`timescale 1ns/10ps

module encoder_32_5 (
    input wire [31:0] Cin,
    output reg [5:0] Cout
);

    always @ (Cin) begin
        case (Cin)
            32'h00000001: Cout <= 6'd0; 
            32'h00000002: Cout <= 6'd1;
            32'h00000004: Cout <= 6'd2;
            32'h00000008: Cout <= 6'd3;
            32'h00000010: Cout <= 6'd4;
            32'h00000020: Cout <= 6'd5;
            32'h00000040: Cout <= 6'd6;
            32'h00000080: Cout <= 6'd7;
            32'h00000100: Cout <= 6'd8;
            32'h00000200: Cout <= 6'd9;
            32'h00000400: Cout <= 6'd10;
            32'h00000800: Cout <= 6'd11;
            32'h00001000: Cout <= 6'd12;
            32'h00002000: Cout <= 6'd13;
            32'h00004000: Cout <= 6'd14;
            32'h00008000: Cout <= 6'd15;
            32'h00010000: Cout <= 6'd16;
            32'h00020000: Cout <= 6'd17;
            32'h00040000: Cout <= 6'd18;
            32'h00080000: Cout <= 6'd19;
            32'h00100000: Cout <= 6'd20;
            32'h00200000: Cout <= 6'd21;
            32'h00400000: Cout <= 6'd22;
            32'h00800000: Cout <= 6'd23;
            default     : Cout <= 6'd31; // 11111 means no acceptable input
        endcase
		  
    end

endmodule
