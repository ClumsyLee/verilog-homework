module freq_meter
(
    anodes,  // Anodes of LED
    cathodes,  // Cathodes of LED
    range_now,
    signal,
    range,  // 1 for a wider range.
    clk
);

output [3:0] anodes;
output [7:0] cathodes;
output range_now = range;

input signal, range, clk;

wire new_signal;

divider divider1(new_signal, range, signal);



endmodule
