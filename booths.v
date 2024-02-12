module booths( input signed [31:0] operand_x, input signed [31:0] operand_y, output     signed [63:0] out);

    reg [2:0] combination_bits [15:0]; 				
    reg signed [32:0] partial_products [15:0];  		
    reg signed [63:0] shifted_partial_products [15:0];
	 reg signed [63:0] sum_of_partial_products;
	 
	 wire signed[32:0] neg_operand_x;
	 
	 integer i;

	 assign neg_operand_x = -operand_x;
	 always @ (operand_x or operand_y or neg_operand_x)
    begin
        // Generate Booth's Algorithm Combination Bits
        combination_bits[0] = {operand_y[1], operand_y[0], 1'b0};
            
        for(i=1; i<16; i=i+1) begin
             combination_bits[i] = {operand_y[2*i+1], operand_y[2*i], operand_y[2*i-1]};
        end

        // Calculate Partial Products based on Combination Bits
        for(i=0; i<16; i=i+1) begin // Case check for each bit
            case(combination_bits[i])
                3'b001, 3'b010 : partial_products[i] = {operand_x[31], operand_x};
                3'b011 : partial_products[i] = {operand_x, 1'b0};
                3'b100 : partial_products[i] = {neg_operand_x[31:0], 1'b0};
                3'b101, 3'b110 : partial_products[i] = neg_operand_x;
                default : partial_products[i] = 0;
            endcase
            
            // Sign-extend the Partial Products
            shifted_partial_products[i] = partial_products[i] << (2*i);
        end

        // Sum up the Shifted Partial Products
        sum_of_partial_products = shifted_partial_products[0];
        
        for(i=1; i<16; i=i+1) begin // Add product to total
            sum_of_partial_products = sum_of_partial_products + shifted_partial_products[i];
        end
    end
   
    // Assign the result after all shifts and additions
    assign out = sum_of_partial_products;

endmodule
