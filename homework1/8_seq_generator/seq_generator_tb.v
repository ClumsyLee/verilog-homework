module sequence_detector_fsm_tb;

reg clk = 0;
reg reset_n = 0;

wire data_out;

seq_generator fsm(data_out, reset_n, clk);

// Set clock.
always #5 clk = ~clk;

// Test data.
initial begin
    $monitor($time, " data_out: %b, state: %b",
             data_out, fsm.state);

    #1 reset_n = 1;
    #200 $finish;
end

endmodule
