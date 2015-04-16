module syc_add(leds, SW0, BTNS, clk);

output [6:0] leds;

input SW0;
input BTNS;
input clk;

// Construct a clock from button
// wire button_clk = BTNS;  // for debugging
debounce debounce1(clk, BTNS, button_clk);

reg [3:0] digit = 0;
wire [6:0] bcd;
wire clk1, clk2, clk3;

BCD7 bcd71(digit, bcd);
assign leds = ~bcd;  // Display the digit

always @(posedge button_clk or negedge SW0) begin
    if(~SW0)
        digit <= 1'b0;
    else
        digit <= digit + 1'b1;
end

endmodule
