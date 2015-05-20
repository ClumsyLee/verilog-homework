module sampler_tb;

wire sample_sig;
reg din = 1, sample_clk = 0;

sampler sampler1(sample_sig, din, sample_clk);

// Set clock.
always #5 sample_clk = ~sample_clk;

initial begin
    $monitor($time, " sample_sig: %b, din: %b, sample_clk: %b, state: %b, count: %b, bit_count: %b",
             sample_sig, din, sample_clk, sampler1.state, sampler1.count, sampler1.bit_count);
    #20 din = 0;
    #160 din = 1;
    #160 din = 0;
    #160 din = 1;
    #160 din = 0;
    #160 din = 1;
    #160 din = 1;
    #160 din = 1;
    #160 din = 0;
    #160 din = 1;

    #200 $finish;
end

endmodule
