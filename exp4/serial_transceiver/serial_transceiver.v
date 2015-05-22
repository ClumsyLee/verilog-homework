module serial_transceiver(dout, led, cathodes, anodes, din, sws, clk);

output dout;
output [7:0] led;
output [7:0] cathodes;
output [3:0] anodes;

input [1:0] sws;
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
wire [7:0] rx_data;
wire rx_status;
receiver receiver1(rx_data, rx_status, din, clk, sample_clk);

// Sender.
wire tx_status;
wire tx_en = rx_status;  // Enable only when in idle state.

wire [7:0] tx_data = (rx_data[7] ? ~rx_data : rx_data);
sender sender1(dout, tx_status, tx_data, tx_en, clk, send_clk);


// Output.
wire [7:0] datas = (sws[0] ? tx_data : rx_data);  // Choose between datas.
wire [7:0] status = (sws[0] ? current_load : {6'b0, rx_status, tx_status});

assign led = (sws[1] ? status : datas);
hex_led hex_led1(anodes, cathodes, {rx_data, tx_data}, led_scan_clk);

// Current load.
reg [7:0] current_load = 0;
// Display load between 4 & 512 bit/s.
reg [9:0] count = 0, load_count = 0;
always @(posedge send_clk) begin
    if (count == 10'd512) begin
        current_load[7] <= (load_count >= 10'd4);
        current_load[6] <= (load_count >= 10'd8);
        current_load[5] <= (load_count >= 10'd16);
        current_load[4] <= (load_count >= 10'd32);
        current_load[3] <= (load_count >= 10'd64);
        current_load[2] <= (load_count >= 10'd128);
        current_load[1] <= (load_count >= 10'd256);
        current_load[0] <= (load_count >= 10'd512);

        count <= 0;
        load_count <= (tx_status ? 1'b0 : 1'b1);
    end else begin
        count <= count + 1'b1;

        if (tx_status == 1'b0)  // Busy.
            load_count <= load_count + 1'b1;
        else
            load_count <= load_count;
    end
end

endmodule
