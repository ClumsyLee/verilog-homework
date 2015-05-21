module serial_transceiver_tb;

wire dout;
reg din = 1, clk = 0;

serial_transceiver transceiver(dout, din, clk);

always #1 clk = ~clk;

initial begin
    $monitor($time, " dout: %b, din: %b", dout, din);

    #10416 din = 0;
    #10416 din = 1;
    #10416 din = 1;
    #10416 din = 0;
    #10416 din = 0;
    #10416 din = 0;
    #10416 din = 1;
    #10416 din = 1;
    #10416 din = 0;
    #10416 din = 1;

    #400000 din = 0;
    #10416 din = 0;
    #10416 din = 1;
    #10416 din = 1;
    #10416 din = 1;
    #10416 din = 0;
    #10416 din = 0;
    #10416 din = 0;
    #10416 din = 1;
    #10416 din = 1;

    #400000 $finish;
end

endmodule
