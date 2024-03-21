module PC_reg #(parameter VAL = 90)(
    input clr, clk, enable, 
    input [31:0] D, 
    output wire [31:0] Q
);
	reg [31:0] temp;
    initial temp<= VAL;

    always@(posedge clk)
    begin
        if (clr)            //if clr is 1, set to 0
            temp <= 0;
        else if(enable)     //if enable is 1 and clr is 0, Q=D
            temp <= D;
    end
		assign Q = temp;
	 
endmodule
