module sequence_detector_shift_regs(data_out, shift_regs, reset, data_in, clk);

output data_out;
output reg [6:0] shift_regs;

input reset, data_in, clk;

// For data_out.
parameter FOUND =  1'b1,
          NOT_FOUND = 1'b0;

// For state.
parameter INITIAL = 7'b000_0000,
          GOAL = 6'b101_011;

// Update state.
always @(posedge clk or posedge reset) begin
    if (reset)
        shift_regs <= INITIAL;
    else
        shift_regs <= {shift_regs[5:0], data_in};
end

// Calculate data_out.
assign data_out = (shift_regs[6:1] == GOAL ? FOUND : NOT_FOUND);

endmodule
