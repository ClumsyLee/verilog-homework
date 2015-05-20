module serial_sender(dout, din, strobe, clk);

output reg dout;
input [7:0] din;
input strobe, clk;

reg [8:0] shift_reg = 0;  // If we do not initialize it here,
                          // it will become 0 after 7 clk posedge.
                          // So why not?

always @(posedge clk) begin
    if (strobe)  // din is valid, load it.
        shift_reg <= {din, ~^din};
    else  // Shift leftward.
        shift_reg <= {shift_reg[7:0], 1'b0};

    // Set output.
    dout <= shift_reg[8];
end

endmodule
