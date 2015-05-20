module serial_transceiver(dout, din, clk);

output dout;
input din, clk;

parameter BAUD_RATE = 9600,
          SAMPLE_RATIO = 16;

// If BAUD_RATE = 9600, then
//     SAMPLE_CLK_RATIO = 651,
//     WORK_CLK_RATIO = 10416,
//     real baud rate = 9600.61,
//     error = 0.00064%.
localparam SAMPLE_CLK_RATIO = 100_000_000 / BAUD_RATE / SAMPLE_RATIO,
           WORK_CLK_RATIO = SAMPLE_CLK_RATIO * SAMPLE_RATIO;

// Build clocks.
wire sample_clk, work_clk;
watchmaker #(SAMPLE_CLK_RATIO) sample_watch(sample_clk, clk);
watchmaker #(WORK_CLK_RATIO) work_watch(work_clk, clk);



endmodule
