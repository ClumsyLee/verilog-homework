module led_tb;

wire [3:0] anodes;
wire [7:0] cathodes;
reg [15:0] num = 5789;
reg clk = 0;

led led1(anodes, cathodes, num, clk);

// Set the clock.
always #5 clk = ~clk;

initial begin
    $monitor($time, "anodes: %b, cathodes: %b", anodes, cathodes);
    #50 $finish;
end

endmodule
