module Registers #(parameter VAL = 0)(
    input clr, clk, enable, 
    input [31:0] D, 
    output reg [31:0] Q
);

    initial Q = VAL;

    always@(posedge clk)
    begin
        if (clr)            //if clr is 1, set to 0
            Q = 0;
        else if(enable)     //if enable is 1 and clr is 0, Q=D
            Q = D;
    end
endmodulemodule Registers #(parameter VAL = 0)(
    input clr, clk, enable, 
    input [31:0] D, 
    output reg [31:0] Q
);

    initial Q = VAL;

    always@(posedge clk)
    begin
        if (clr)            //if clr is 1, set to 0
            Q = 0;
        else if(enable)     //if enable is 1 and clr is 0, Q=D
            Q = D;
    end
endmodule
