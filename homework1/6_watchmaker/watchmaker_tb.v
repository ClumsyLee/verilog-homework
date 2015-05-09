module watchmaker_tb;

wire quick_clk, slow_clk;
reg clk = 0, reset_n = 1;

watchmaker #(2) quick_watch(quick_clk, clk, reset_n);
watchmaker #(20) slow_watch(slow_clk, clk, reset_n);

always #100 clk = ~clk;  // f = 10 MHz

initial begin
    $monitor($time, "ns 10M-clk: %b, 5M-clk: %b, 500k-clk: %b",
             clk, quick_clk, slow_clk);

    reset_n = 0;
    #5 reset_n = 1;

    #6000 $finish;
end

endmodule
