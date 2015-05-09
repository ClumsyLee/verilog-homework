module top(
    input [1:0] testmode,
    input sysclk,
    input modecontrol,
    output higfreq,
    output [7:0] cathodes,
    output [3:0] anodes
);

wire sigin;
signalinput signalin(testmode, sysclk, sigin);
freq_meter freq(anodes, cathodes, higfreq, sigin, modecontrol, sysclk);

endmodule
