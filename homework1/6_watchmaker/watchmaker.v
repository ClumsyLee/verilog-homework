module watchmaker(new_clk, clk, reset_n);

output reg new_clk;
input clk, reset_n;

parameter RATIO = 100_000_000,  // V10 = 10MHz
          HALF_RATIO = RATIO / 2;

integer counter;

always @(posedge clk, negedge reset_n) begin
    if (~reset_n) begin
        counter <= 1;
        new_clk <= 0;
    end else if (counter >= HALF_RATIO) begin
        counter <= 1;
        new_clk <= ~new_clk;
    end else begin
        counter <= counter + 1;
    end
end

endmodule
