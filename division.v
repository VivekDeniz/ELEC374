module division (
    input wire [31:0] dividend,
    input wire [31:0] divisor,
    output reg [63:0] result
);

// Initalize registers
reg [32:0] a;
reg [31:0] q;
integer i;
reg [31:0] abs_q;
reg [31:0] abs_m;

always @(*) begin

    if (divisor == 0) begin
        result = {2*32{1'b1}};

    end else if (dividend == 0) begin
        result = 0;

    end else begin


        q = 0;
        a = 0;

        // If signed bit it 1 then get absolute value of dividend and divisor 
        abs_q = dividend[31] ? -dividend : dividend;
        abs_m = divisor[31] ? -divisor : divisor;


        for (i = 31; i >= 0; i = i -1) begin

            a = a << 1;
            a[0] = abs_q[i];

            a = a - abs_m;

            if (a[32]) begin

                q[i] = 0;
                a = a + abs_m;

            end else begin

                q[i] = 1;

            end
        end


        if (dividend[31] != divisor[31]) begin
            q = -q;
        end

 
        result = {a[32-1:0], q};
    end
end
endmodule