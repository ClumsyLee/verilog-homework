module stimulus;

reg clk = 0;
reg reset = 1;
reg data_in = 0;

wire data_out;
wire [6:0] shift_regs;

sequence_detector_shift_regs detector(data_out, shift_regs,
                                      reset, data_in, clk);

// Set monitor.
initial $monitor($time, " reset: %b, data_in: %b, data_out: %b, shift_regs: %b",
                 reset, data_in, data_out, shift_regs);

// Set clock.
always #5 clk = ~clk;

// Test data.
initial begin
    #1 reset = 0;

    data_in = 0;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 0;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 0;

    $finish;
end

endmodule
