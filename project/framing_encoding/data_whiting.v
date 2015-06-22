`timescale 1us/100ns

module data_whiting(
    output [7:0] dout,
    output next_indicator,
    input [7:0] din,
    input indicator,
    input clk,
    input reset_n
);

localparam RANDOM_INIT = 9'b1_1111_1111;

localparam WAITING = 0,
           PADDING = 1,
           ENCODING = 2;

reg [1:0] state, next_state;
reg [6:0] count, next_count;

reg [8:0] random_regs, next_random_regs;
reg [7:0] working_random, next_working_random;
wire [8:0] next_random = {random_regs[5] ^ random_regs[0], random_regs[8:1]};

always @(*) begin
    case (state)
        WAITING: begin
            if (indicator)
                next_state = PADDING;
            else
                next_state = WAITING;
            next_count = 0;
            next_random_regs = RANDOM_INIT;
            next_working_random = RANDOM_INIT;
        end

        PADDING: begin
            if (count < 79) begin
                next_state = PADDING;
                next_count = count + 1;
                next_random_regs = RANDOM_INIT;
            end else begin
                next_state = ENCODING;
                next_count = 0;
                next_random_regs = next_random;
            end
            next_working_random = RANDOM_INIT;
        end

        ENCODING: begin
            if (indicator) begin
                next_state = WAITING;
                next_count = 0;
            end else begin
                next_state = ENCODING;
                next_count = count + 1;
            end
            next_random_regs = next_random;
            next_working_random = (count[2:0] == 7 ?
                                   random_regs :
                                   working_random);
        end

        default: begin
            next_state = WAITING;
            next_count = 0;
            next_random_regs = RANDOM_INIT;
            next_working_random = RANDOM_INIT;
        end
    endcase
end

// Update states.
always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        state <= WAITING;
        count <= 0;
        random_regs <= RANDOM_INIT;
        working_random <= RANDOM_INIT;
    end else begin
        state <= next_state;
        count <= next_count;
        random_regs <= next_random_regs;
        working_random <= next_working_random;
    end
end

assign next_indicator = indicator;

assign dout = (state == ENCODING ? din ^ working_random : din);

endmodule
