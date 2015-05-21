module sender(dout, tx_status, tx_data, tx_en, clk, send_clk);

output dout;
output reg tx_status = 1;
input [7:0] tx_data;
input tx_en, clk, send_clk;

// 1 padding, 1 start-bit, 8 data-bits, 1 end-bit.
localparam COUNTER_MAX = 4'd11;

reg [9:0] shift_reg = 10'b11_1111_1111;
assign dout = shift_reg[0];

reg [3:0] counter = COUNTER_MAX;
wire rst_n = ~tx_en;

always @(posedge send_clk or negedge rst_n) begin
    if(~rst_n) begin
        // Load data.
        // Make sure that start-bit lasts 1 send_clk.
        shift_reg <= {tx_data, 2'b01};  // Load data.
        counter <= 0;
    end else begin
        shift_reg <= {1'b1, shift_reg[9:1]};

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
