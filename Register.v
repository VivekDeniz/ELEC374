module Register #(
  parameter DATA_WIDTH_IN = 32,
  parameter DATA_WIDTH_OUT = 32,
  parameter INIT = 32'h0
)(
  input clear, clock, enable,
  input [DATA_WIDTH_OUT-1:0] BusMuxOut,
  output wire [DATA_WIDTH_OUT-1:0] BusMuxIn
);
//create a 32 bit register
  reg [DATA_WIDTH_IN-1:0] q;
//fill with 0's
  initial q = INIT;
//at each clock cycle check the clear and enable
  always @(posedge clock) begin
    if (clear) begin
      //clear the register to 0
      q <= {DATA_WIDTH_IN{1'b0}};
    end
    else if (enable) begin
      //input the bus into the register
      q <= BusMuxOut;
    end
  end

  assign BusMuxIn = q[DATA_WIDTH_OUT-1:0];

endmodule
