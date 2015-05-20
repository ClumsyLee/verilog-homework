module stop_watch(ms, key, clk);

output [31:0] ms;
input key, clk;

parameter CLK_PER_MS = 1;

reg [31:0] current_clks, first_arrival_clks;
reg [2:0] state = 0;

assign ms = current_clks / CLK_PER_MS;

// State transfer.
always @(posedge key) begin
    if (state == 2'd1)  // Need to record the clks here.
        first_arrival_clks <= current_clks;

    if (state < 4)
        state <= state + 1'b1;
    else
        state <= 0;
end

// Calculate output.
always @(posedge clk) begin
    case (state)
    3'd1, 3'd2: current_clks <= current_clks + 1;
    3'd3: ;// Do nothing here.
    3'd4: current_clks <= first_arrival_clks;
    default: current_clks <= 0;
    endcase
end

endmodule
