module remote_decoder_tb;

wire [3:0] dout;
wire strobe;
reg din = 0, clk = 0;

remote_decoder decoder(dout, strobe, din, clk);

// Set clk.
always #5 clk = ~clk;

initial begin
    $monitor($time, " clk: %b, din: %b, strobe: %b, dout: %b",
             clk, din, strobe, dout);

    #10 din = 1;
    #10 din = 0;
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;
    #20 din = 0;
    #10 din = 1;
    #10 din = 0;

    #30 $finish;
end

endmodule
