module stop_watch_tb;

wire [31:0] ms;
reg key = 0, clk = 0;

stop_watch watch(ms, key, clk);

// Set clk.
always #5 clk = ~clk;

// Set monitor.
initial begin
    $monitor($time, " key: %b, %d ms", key, ms);

    #20 key = 1;  // 1st.
    #10 key = 0;

    #60 key = 1;  // 2nd.
    #10 key = 0;

    #40 key = 1;  // 3rd.
    #10 key = 0;

    #20 key = 1;  // 4th.
    #10 key = 0;

    #20 key = 1;  // 5th.
    #10 key = 0;

    #20 $finish;
end

endmodule
