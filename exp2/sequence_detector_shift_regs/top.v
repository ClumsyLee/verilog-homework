module top(data_out, shift_regs, reset, button, data_in, clk);

output data_out;
output [6:0] shift_regs;

input reset, button, data_in, clk;

// Construct a clock from button
wire button_clk;
debounce debouncer(clk, button, button_clk);

// Shift registers
sequence_detector_shift_regs detector(data_out, shift_regs,
                                      reset, data_in, button_clk);

endmodule
