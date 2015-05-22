`timescale 10ns/1ns

module serial_transceiver_tb;

wire dout;
reg din = 1, clk = 0;

serial_transceiver transceiver(dout, , , , din, 2'b0, clk);

always #1 clk = ~clk;

initial begin
    $monitor($time, " dout: %b, din: %b", dout, din);

    #300000 din = 0;
    #20832 din = 1;
    #20832 din = 1;
    #20832 din = 0;
    #20832 din = 0;
    #20832 din = 0;
    #20832 din = 1;
    #20832 din = 1;
    #20832 din = 0;
    #20832 din = 1;

    #80000 din = 0;
    #20832 din = 0;
    #20832 din = 1;
    #20832 din = 1;
    #20832 din = 1;
    #20832 din = 0;
    #20832 din = 0;
    #20832 din = 0;
    #20832 din = 1;
    #20832 din = 1;

    #800000 $finish;
end

endmodule
