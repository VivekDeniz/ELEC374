`timescale 1ns/10ps

module CONFF (
    output reg control_output,   // Output to control unit
    input control_input, clear,  // Control input signals
    input [1:0] instruction_register_bits, 
    input [31:0] bus_mux_output  
);

    wire instruction_bit_0 = instruction_register_bits[0];
    wire instruction_bit_1 = instruction_register_bits[1];
  
    reg [4:0] decoder_output;
  
    wire decoder_output_active, and_gate_0, and_gate_1, and_gate_2, and_gate_3, nor_gate_output;
    wire or_lt_0, or_gte_0, or_nonzero, or_bit_0;
  
    always @ (*)
    begin
        case ({instruction_bit_1, instruction_bit_0})
            2'b00: decoder_output = 4'b0001;
            2'b01: decoder_output = 4'b0010;
            2'b10: decoder_output = 4'b0100;
            2'b11: decoder_output = 4'b1000;
            default: decoder_output = 4'bx;
        endcase
    end

    assign nor_gate_output = (bus_mux_output == 32'd0) ? 1'b1 : 1'b0;
    assign or_bit_0 = decoder_output[0] & nor_gate_output;                    
    assign or_nonzero = (!(nor_gate_output)) & decoder_output[1];
  
    assign or_gte_0 = decoder_output[2] & (!(bus_mux_output[31]));
    assign or_lt_0 = decoder_output[3] & bus_mux_output[31];
    assign decoder_output_active = or_bit_0 | or_nonzero | or_gte_0 | or_lt_0;
                    
                   
                    
    always @ (*)
    begin
        if (clear == 0)
            control_output <= 0;
        else if (control_input)
            control_output <= decoder_output_active;
    end

endmodule
