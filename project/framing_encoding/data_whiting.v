module data_whiting(
    output reg [7:0] dout,
    output next_indicator,
    input [7:0] din,
    input indicator,
    input clk,
    input reset_n
);

localparam RANDOM_INIT = 1;

localparam WAITING = 0,
           PADDING = 1,
           ENCODING = 2,
           RIGHT_PADDING = 3;

reg [1:0] state, next_state;
reg [6:0] count, next_count;

reg [7:0] next_dout;

reg [8:0] random_regs, next_random_regs;
wire [8:0] next_random = {random_regs[5] ^ random_regs[0], random_regs[8:1]};

always @(*) begin
    case (state)
        WAITING: begin
            if (indicator)
                next_state = PADDING;
            else
                next_state = WAITING;
            next_count = 0;
            next_dout = 0;
            next_random_regs = RANDOM_INIT;
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

            // Making a 8-clk delay.
            next_dout = (count[2:0] == 7 ? din : dout);
        end

        ENCODING: begin
            if (indicator) begin
                next_state = RIGHT_PADDING;
                next_count = 0;
            else
                next_state = ENCODING;
                next_count = count + 1;
            next_dout = (count[2:0] == 7 ? din ^ random_regs[7:0] : dout);
            next_random_regs = next_random;
        end

        RIGHT_PADDING: begin
            if (count < 7) begin
                next_state = RIGHT_PADDING;
                next_count = count + 1;
                next_dout = dout;
                next_random_regs = next_random;
            end else begin
                next_state = WAITING;
                next_count = 0;
                next_dout = 0;
                next_random_regs = RANDOM_INIT;
            end
        end

        default: begin
            next_state = WAITING;
            next_count = 0;
            next_dout = 0;
        end
    endcase
end

// Update states.
always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        state <= WAITING;
        count <= 0;
        dout <= 0;
    end else begin
        state <= next_state;
        count <= next_count;
        dout <= next_dout;
    end
end

assign next_indicator = (state == WAITING && indicator ||
                         state == RIGHT_PADDING && count == 7);

endmodule
