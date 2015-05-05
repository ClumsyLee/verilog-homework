module sequence_detector_fsm_tb;

reg clk = 0;
reg reset_n = 0;
reg data_in = 0;

wire data_out;

sequence_detector_fsm fsm(data_out, data_in, reset_n, clk);

// Set clock.
always #5 clk = ~clk;
always #10 $display($time, " reset_n: %b, data_in: %b, data_out: %b, state: %b",
                    reset_n, data_in, data_out, fsm.state);

// Test data.
initial begin
    #2 reset_n = 1;
    data_in = 0;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;

    $finish;
end

endmodule
