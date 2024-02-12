`timescale 1ns/10ps

module boothtb;

    reg signed [31:0] x, y;
    wire signed [63:0] out;

    // Instantiate the module
    booths uut (
        .operand_x(x),
        .operand_y(y),
        .out(out)
    );

    // Clock generation
    reg clk = 0;
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Test Case 1
        x = 8;
        y = 5;
        #10;
        $display("Test Case 1: operand_x = %d, operand_y = %d, out = %d", x, y, out);

        // Test Case 2
        x = -7;
        y = 3;
        #10;
        $display("Test Case 2: operand_x = %d, operand_y = %d, out = %d", x, y, out);


        // Finish simulation
        #10;
        $finish;
    end

    // Apply clock to the design
    always #1 clk = ~clk;

endmodule
