module watchmaker(new_clk, clk);

output reg new_clk;
input clk;

parameter RATIO = 100_000_000;  // V10 = 10MHz

integer counter;

always @(clk) begin
    if (counter >= RATIO) begin
        counter <= 1;
        new_clk <= ~new_clk;
    end else begin
        counter <= counter + 1;
    end
end

endmodule
