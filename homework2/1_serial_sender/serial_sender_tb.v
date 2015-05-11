module serial_sende_tb;

wire dout;
reg [7:0] din = 0;
reg strobe = 0, clk = 0;

serial_sender sender(dout, din, strobe, clk);

// Set clk.
always #5 clk = ~clk;

// Set strobe.
initial begin
    #20 strobe = 1;
    #10 strobe = 0;
    #140 strobe = 1;
    #10 strobe = 0;
end

// Set din.
initial begin
    #20 din = 'h5A;
    #10 din = 0;
    #140 din = 'hff;
    #10 din = 0;
end

// Set monitor.
initial begin
    $monitor($time, " strobe: %b, clk: %b, din: %b, dout: %b",
             strobe, clk, din, dout);

    #300 $finish;
end

endmodule
