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
output range_now;

input signal, range, clk;

assign range_now = range;

wire new_signal;
divider divider1(new_signal, range, signal);

// Build internal clocks.
wire control_clk, scan_clk;
watchmaker #(100_000_000) control_watchmaker(control_clk, clk);
watchmaker #(100_000) scan_watchmaker(scan_clk, clk);

// Central control.
wire [15:0] num;
reg [15:0] led_num;  // Number to be displayed on the LED.
reg reset_n;
counter #(16, 9999) four_bit_counter(num, new_signal, 1'b1, reset_n);

// Reset counter on control_clk
always @(posedge control_clk) begin
    led_num <= num;
    reset_n <= 0;
    @(posedge clk) reset_n <= 1;
end

// Display the number
led led1(anodes, cathodes, num, scan_clk);

endmodule
