module sequence_detector_fsm(data_out, state, reset, data_in, clk);

output data_out;
output reg [2:0] state;  // Matching progress.

input reset, data_in, clk;

// For data_out.
parameter FOUND =  1'b1,
          NOT_FOUND = 1'b0;

// For state.
parameter S0 = 3'd0,
          S1 = 3'd1,
          S2 = 3'd2,
          S3 = 3'd3,
          S4 = 3'd4,
          S5 = 3'd5,
          S6 = 3'd6;

reg [2:0] next_state;

// Update state.
always @(posedge clk or posedge reset) begin
    if (~reset)
        state <= 0;
    else
        state <= next_state;
end

// Calculate data_out.
assign data_out = (state == S6 ? FOUND : NOT_FOUND);

// Calculate next state.
always @(state, data_in) begin
    case (state)
        S0: next_state = (data_in ? S1 : S0);
        S1: next_state = (data_in ? S1 : S2);
        S2: next_state = (data_in ? S3 : S0);
        S3: next_state = (data_in ? S1 : S4);
        S4: next_state = (data_in ? S5 : S0);
        S5: next_state = (data_in ? S6 : S4);
        S6: next_state = (data_in ? S1 : S2);
        default: next_state = S0;
    endcase
end

endmodule
