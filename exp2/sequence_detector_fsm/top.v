module top(data_out, state, reset, button, data_in, clk);

output data_out;
output [2:0] state;

input reset, button, data_in, clk;

// Construct a clock from button
wire button_clk;
debounce debouncer(clk, button, button_clk);

// FSM
sequence_detector_fsm fsm(data_out, state, reset, data_in, button_clk);

endmodule
