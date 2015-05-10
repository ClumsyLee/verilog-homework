module shift_reg_tb;

wire [3:0] q;
reg [3:0] d = 0;
reg load = 0, reset_n = 0, clk = 0;

shift_reg testee(q, d, load, reset_n, clk);

// Set up clk.
always #5 clk = ~clk;

initial begin
    $monitor($time, " q: %b, d: %b, load: %b, reset_n: %b",
             q, d, load, reset_n);

    #1 reset_n = 1;  // Release reset_n.
    
    $display("Testing shifting");
    d[0] = 1;
    #10 d[0] = 1;
    #10 d[0] = 1;
    #10 d[0] = 0;
    #10 d[0] = 1;
    #10 d[0] = 1;
    #10 d[0] = 1;
    #10 d[0] = 1;
    #10 d[0] = 0;
    #10 d[0] = 0;
    #10 d[0] = 1;
    #10 d[0] = 0;
    #10 d[0] = 0;
    #10 d[0] = 0;
    #10 d[0] = 1;
    #10 d[0] = 0;

    $display("Testing reseting");
    #5 reset_n = 0;
    #5 reset_n = 1;

    $display("Testing loading");
    load = 1;

    $display("loading 1101");
    d = 4'b1101;

    #10 $display("Loading 0001");
    d = 4'b0001;

    // Stop loading.
    #10 d = 0;
    load = 0;

    #50 $finish;
end

endmodule
