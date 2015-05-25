module sender_tb;

wire dout, tx_status;
reg [7:0] tx_data = 0;
reg tx_en = 0, clk = 0, send_clk = 0;

sender sender1(dout, tx_status, tx_data, tx_en, clk, send_clk);

// Set clock.
always #1 clk = ~clk;
always #5 send_clk = ~send_clk;

initial begin
    $monitor($time, " dout: %b, tx_status: %b, tx_data: %b, tx_en: %b",
             dout, tx_status, tx_data, tx_en);
    #20 tx_data = 8'b1100_0101;
    #5 tx_en = 1;
    #2 tx_en = 0;

    #200 tx_data = 8'b0010_0111;
    #5 tx_en = 1;
    #2 tx_en = 0;

    #200 $finish;
end

endmodule
