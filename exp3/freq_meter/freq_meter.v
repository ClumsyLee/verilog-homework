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
wire reset_n;
counter #(16, 9999) four_bit_counter(num, new_signal, 1'b1, reset_n);


reg [1:0] state = 0, next_state = 0;
always @(state, control_clk) begin
    case (state)
        2'd0: next_state = (control_clk ? 2'd1 : 2'd0);
        2'd1: next_state = 2;
        2'd2: next_state = (control_clk ? 2'd2 : 2'd0);
        default: next_state = 0;
    endcase
end

assign reset_n = (state == 1 ? 1'b0 : 1'b1);

always @(posedge clk) begin
    state <= next_state;
end

reg [15:0] led_num = 0;  // Number to be displayed on the LED.
always @(posedge control_clk) begin
    led_num <= num;
end

// Display the number
led led1(anodes, cathodes, led_num, scan_clk);

endmodule
