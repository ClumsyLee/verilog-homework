module two_one_mux_tb;

reg a, b, s;
wire y;

two_one_mux mux(y, a, b, s);

initial begin
    $monitor($time, " y: %b, a: %b, b: %b, s: %b",
             y, a, b, s);

    a = 0;
    b = 1;
    s = 1;

    #10 b = 0;
    #10 a = 1;
    #10 b = 1;
    #10 s = 0;
    #10 b = 0;
    #10 a = 0;
    #10 b = 1;

    #20 $finish;
end

endmodule
