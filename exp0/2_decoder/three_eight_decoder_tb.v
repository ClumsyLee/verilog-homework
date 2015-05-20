module three_eight_decoder_tb;

reg [2:0] a;
wire [7:0] d;

three_eight_decoder decoder(d, a);

initial begin
    $monitor($time, " d: %b, a: %b", d, a);

    a = 0;
    repeat (7)
        #5 a = a + 1;
end

endmodule
