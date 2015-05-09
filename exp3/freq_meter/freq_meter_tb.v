module freq_meter_tb;

wire [3:0] anodes;
wire [7:0] cathodes;
wire range_now;

reg signal = 0, range = 0, clk = 0;

always #1 clk = ~clk;
always #1_000_000 signal = ~signal;

freq_meter freq(anodes, cathodes, range_now, signal, range, clk);

initial begin
    $monitor($time, " anodes:%b, cathodes: %b, range_now: %b, count: %b, ctrl: %b, reset_n: %b",
             anodes, cathodes, range_now, freq.four_bit_counter.num, freq.control_clk, freq.reset_n);

    #1_000_000_000 $finish;
end

endmodule
