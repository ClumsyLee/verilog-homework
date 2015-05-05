module seq_generator(data_out, reset_n, clk);

output reg data_out;
input reset_n, clk;

reg [2:0] state;
wire [2:0] next_state;

// Update state.
always @(posedge clk or negedge reset_n) begin
    if (~reset_n)
        state <= 0;
    else
        state <= next_state;
end

// Calculate next state.
assign next_state = (state == 10) ? 0 : state + 1;

// Calculate data_out.
// 01001011001
always @(state) begin
    case (state)
        0: data_out = 0;
        1: data_out = 1;
        2: data_out = 0;
        3: data_out = 0;
        4: data_out = 1;
        5: data_out = 0;
        6: data_out = 1;
        7: data_out = 1;
        8: data_out = 0;
        9: data_out = 0;
        10: data_out = 1;
        default: data_out = 0;
    endcase
end

endmodule
