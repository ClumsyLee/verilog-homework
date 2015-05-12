module remote_decoder(dout, strobe, din, clk);

output [3:0] dout;
output strobe;
input din, clk;

reg [9:0] shift_reg = 0;

always @(posedge clk)
    shift_reg <= (strobe ? 10'b0 :                  // Clear.
                           {shift_reg[8:0], din});  // Shift leftward.

// Calculate output.
assign strobe = (shift_reg[9:6] == 4'b0101 &&  // Sync code.
                 ^shift_reg[9:1]);             // Odd parity.

assign dout = (strobe ? shift_reg[5:2] : 4'b0);

endmodule
