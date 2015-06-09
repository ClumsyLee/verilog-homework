`timescale 1us/100ns

module serializing(
    output dout,
    output dout_valid,
    input [7:0] din,
    input indicator,
    input clk,
    input reset_n
);

localparam WAITING = 0,
           SENDING = 1;

reg state;
wire next_state;

reg [2:0] count;
wire [2:0] next_count;

assign next_state = (indicator ? ~state : state),
       next_count = (state == WAITING ? 0 : count + 1);

// Update states.
always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        state <= WAITING;
        count <= 0;
    end else begin
        state <= next_state;
        count <= next_count;
    end
end

assign dout = din[count-:1],
       dout_valid = (state == SENDING);

endmodule
