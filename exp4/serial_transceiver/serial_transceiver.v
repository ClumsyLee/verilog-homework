module serial_transceiver(dout, din, clk);

output dout;
input din, clk;

parameter BAUD_RATE = 9600,
          SAMPLE_RATIO = 16;

// If BAUD_RATE = 9600, then
//     SAMPLE_CLK_RATIO = 651,
//     SEND_CLK_RATIO = 10416,
//     real baud rate = 9600.61,
//     error = 0.00064%.
localparam SAMPLE_CLK_RATIO = 100_000_000 / BAUD_RATE / SAMPLE_RATIO,
           SEND_CLK_RATIO = SAMPLE_CLK_RATIO * SAMPLE_RATIO;

// Build clocks.
wire sample_clk, send_clk;
watchmaker #(SAMPLE_CLK_RATIO) sample_watch(sample_clk, clk);
watchmaker #(SEND_CLK_RATIO) send_watch(send_clk, clk);

// Receiver.
wire [7:0] rx_data;
wire rx_status;
receiver receiver1(rx_data, rx_status, din, clk, sample_clk);

// Sender.
wire [7:0] tx_data = (rx_data[7] ? ~rx_data : rx_data);


endmodule
