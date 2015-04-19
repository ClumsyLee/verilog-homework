module asyc_add_tb;

reg reset = 1;
reg button = 0;
reg clk = 0;

wire [6:0] leds;

asyc_add add1(leds, reset, button, clk);

initial begin
    $monitor($time, " reset: %b, button: %b, digit: %b, leds: %b",
             reset, button, add1.digit, leds);

    #0 reset = 1'b0;
    #10 reset = 1'b1;

    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;

    #10 reset = 1'b0;
    #10 reset = 1'b1;

    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
    #5 button = 1'b1;
    #5 button = 1'b0;
end

initial forever #1 clk <= ~clk;
initial #400 $finish;

endmodule
