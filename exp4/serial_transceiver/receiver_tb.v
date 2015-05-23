module receiver_tb;

wire [7:0] rx_data;
wire rx_status;
reg din = 1, clk = 0, sample_clk = 0;

receiver receiver1(rx_data, rx_status, din, clk, sample_clk);

// Set clock.
always #1 clk = ~clk;
always #5 sample_clk = ~sample_clk;

initial begin
    $monitor($time, " rx_data: %b, rx_status: %b",
             rx_data, rx_status);
    #20 din = 0;
    #160 din = 1;
    #160 din = 0;
    #160 din = 1;
    #160 din = 0;
    #160 din = 1;
    #160 din = 1;
    #160 din = 1;
    #160 din = 0;
    #160 din = 1;

    #200 $finish;
end

endmodule
