module remote_decoder(dout, strobe, din, clk);

output [3:0] dout;
output strobe;
input din, clk;

reg [5:0] shift_reg = 0;
reg [2:0] state = 0, next_state = 0;

localparam AWAIT = 0,
           RECEIVE1 = 1,
           RECEIVE2 = 2,
           RECEIVE3 = 3,
           RECEIVE4 = 4,
           CHECK = 5,
           OUTPUT = 6;

// Calculate next state.
always @(state, shift_reg) begin
    case (state)
        AWAIT:
            next_state = (shift_reg[3:0] == 4'b0101 ? RECEIVE1 : AWAIT);
        RECEIVE1, RECEIVE2, RECEIVE3, RECEIVE4:
            next_state = next_state + 1'b1;
        CHECK:
            next_state = (^shift_reg[4:0] ? OUTPUT : AWAIT);
        default:
            next_state = AWAIT;
    endcase
end

// State transfer.
always @(posedge clk) begin
    // Shift leftward
    shift_reg <= {shift_reg[4:0], din};
    state <= next_state;
end

// Calculate output.
assign strobe = (state == OUTPUT),
       dout = (state == OUTPUT ? shift_reg[5:2] : 0);

endmodule
