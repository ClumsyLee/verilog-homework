`timescale 10ns/1ns

module sender(dout, tx_status, tx_data, tx_en, clk, send_clk);

output dout;
output reg tx_status;
input [7:0] tx_data;
input tx_en, clk, send_clk;

// 1 padding, 1 start-bit, 8 data-bits, 1 end-bit.
localparam COUNTER_MAX = 4'd11;

reg [8:0] shift_reg;
assign dout = shift_reg[0];

reg [3:0] counter = 0;
wire rst_n = ~tx_en;

always @(posedge send_clk or negedge rst_n) begin
    if(~rst_n) begin
        counter <= 0;
    end else begin
        if (counter == 4'b0)
            shift_reg <= {tx_data, 1'b0};  // Load data.
        else
            shift_reg <= {1'b1, shift_reg[8:1]};  // Shift.

        if (counter < COUNTER_MAX)
            counter <= counter + 4'b1;
        else
            counter <= counter;
    end
end

always @(posedge clk) begin
    tx_status <= (counter < COUNTER_MAX ? 1'b0 : 1'b1);
end

endmodule
