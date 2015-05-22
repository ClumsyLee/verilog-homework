module serial_transceiver(dout, rx_data, cathodes, anodes, din, clk);

output dout;
output [7:0] rx_data;  // Make it easier to debug.
output [7:0] cathodes;
output [3:0] anodes;
input din, clk;

parameter BAUD_RATE = 9600,
          SAMPLE_RATIO = 16,
          CLK_FREQUENCY = 100_000_000,
          LED_SCAN_RATE = 1000;

// If BAUD_RATE = 9600, then
//     SAMPLE_CLK_RATIO = 651,
//     SEND_CLK_RATIO = 10416,
//     real baud rate = 9600.61,
//     error = 0.00064%.
localparam SAMPLE_CLK_RATIO = CLK_FREQUENCY / BAUD_RATE / SAMPLE_RATIO,
           SEND_CLK_RATIO = SAMPLE_CLK_RATIO * SAMPLE_RATIO,
           LED_SCAN_RATIO = CLK_FREQUENCY / LED_SCAN_RATE;

// Build clocks.
wire sample_clk, send_clk, led_scan_clk;
watchmaker #(SAMPLE_CLK_RATIO) sample_watch(sample_clk, clk);
watchmaker #(SEND_CLK_RATIO) send_watch(send_clk, clk);
watchmaker #(LED_SCAN_RATIO) led_scan_watch(led_scan_clk, clk);

// Receiver.
wire rx_status;
receiver receiver1(rx_data, rx_status, din, clk, sample_clk);

// Sender.
wire tx_status;
wire tx_en = tx_status & rx_status;  // Enable only when in idle state.

wire [7:0] tx_data = (rx_data[7] ? ~rx_data : rx_data);
sender sender1(dout, tx_status, tx_data, tx_en, clk, send_clk);

hex_led led(anodes, cathodes, {rx_data, tx_data}, led_scan_clk);

endmodule
