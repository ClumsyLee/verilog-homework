`timescale 10ns/1ns

module receiver(rx_data, rx_status, din, clk, sample_clk);

output reg [7:0] rx_data = 0;
output reg rx_status;
input din, clk, sample_clk;

wire sample_sig;
sampler sampler1(sample_sig, din, sample_clk);

reg [7:0] shift_reg;
reg [3:0] counter = 0;
wire rst_n = ~rx_status;

always @(posedge sample_sig or negedge rst_n) begin
    if(~rst_n) begin
        shift_reg <= 0;
        counter <= 0;
    end else begin
        shift_reg <= {din, shift_reg[7:1]};
        counter <= counter + 4'b1;
    end
end

always @(posedge clk) begin
    if (counter == 4'd8) begin
        rx_data <= shift_reg;
        rx_status <= 1'b1;
    end else begin
        rx_data <= rx_data;
        rx_status <= 1'b0;
    end
end

endmodule
