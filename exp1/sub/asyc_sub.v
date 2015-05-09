module asyc_sub(leds, SW0, BTNS, clk);

output [6:0] leds;

input SW0;
input BTNS;
input clk;

// Construct a clock from button
// wire button_clk = BTNS;  // for debugging
wire button_clk;
debounce debounce1(clk, BTNS, button_clk);

wire [3:0] digit;
wire [6:0] bcd;
wire clk1, clk2, clk3;

BCD7 bcd71(digit, bcd);
assign leds = ~bcd;  // Display the digit

TT Q0(digit[0], , 1'b1, button_clk, SW0);
TT Q1(digit[1], , 1'b1, clk1, SW0);
TT Q2(digit[2], , 1'b1, clk2, SW0);
TT Q3(digit[3], , 1'b1, clk3, SW0);

assign clk1 = digit[0],
       clk2 = digit[1],
       clk3 = digit[2];

endmodule


module TT(q, notq, t, clk, reset);

output reg q = 0;
output notq;

input t, clk, reset;

assign notq = ~q;

always @(posedge clk, negedge reset) begin
    if (~reset)  // Reset to zero
        q <= 0;
    else if (t)  // Flip
        q <= ~q;
end

endmodule

