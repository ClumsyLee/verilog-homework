module stimulus;

reg clk = 0;
reg reset = 1;
reg data_in = 0;

wire data_out;
wire [2:0] state;

sequence_detector_fsm fsm(data_out, state, reset, data_in, clk);

// Set monitor.
always #10 $display($time, " data_in: %b, data_out: %b, state: %b",
                    data_in, data_out, state);

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

    #10 $finish;
end

endmodule
