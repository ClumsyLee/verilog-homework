module four_one_mux_tb;

reg [5:0] inputs;
wire z;

four_one_mux mux(z, inputs[5:2], inputs[1:0]);

initial begin
    $monitor($time, " z: %b, c: %b, s: %b",
             z, inputs[5:2], inputs[1:0]);
    inputs = 0;
    repeat (63)
        #10 inputs = inputs + 1;

    #50 $finish;
end

endmodule
