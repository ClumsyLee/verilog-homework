module sequence_detector_fsm(data_out, data_in, reset_n, clk);

output data_out;
input data_in, reset_n, clk;

reg [2:0] state, next_state;

// Update state.
always @(posedge clk or negedge reset_n) begin
    if (~reset_n)
        state <= 0;
    else
        state <= next_state;
end

// Calculate data_out.
assign data_out = (state == 4 ? 1'b1 : 1'b0);

// Calculate next state.
always @(state, data_in) begin
    case (state)
        0: next_state = (data_in ? 1 : 0);
        1: next_state = (data_in ? 2 : 0);
        2: next_state = (data_in ? 3 : 0);
        3: next_state = (data_in ? 4 : 0);
        4: next_state = (data_in ? 4 : 0);
        default: next_state = 0;
    endcase
end

endmodule
