module sampler(sample_sig, din, sample_clk);

output sample_sig;
input din, sample_clk;

parameter SAMPLE_RATIO;
localparam PADDING_TIME = SAMPLE_RATIO / 2 - 1;

reg [1:0] state = 0, next_state;
localparam STANDING_BY = 2'd0,
           PADDING = 2'd1,
           SAMPLING = 2'd2;

// Assume SAMPLE_RATIO <= 16
reg [3:0] count = 0, next_count,
          bit_count = 0;

// Calculate next values.
always @(*) begin
    case (state)
    STANDING_BY:
        next_state = (din ? STANDING_BY : PADDING);
        next_count = 4'b0;
        next_bit_count = 4'b0;

    PADDING:  // Wait PADDING_TIME clk.
        if (count < PADDING_TIME - 1) begin
            next_state = PADDING;
            next_count = count + 4'b1;
        end else begin
            next_state = SAMPLING;
            next_count = 4'b0;
        end
        next_bit_count = 4'b0;

    SAMPLING:  // Cycle = SAMPLE_RATIO.
        next_state = (bit_count == 4'd8 ? STANDING_BY : SAMPLING);

        if (count < SAMPLE_RATIO - 1) begin
            next_count = count + 4'b1;
            next_bit_count = bit_count;
        end else begin
            next_count = 4'b0;
            next_bit_count = bit_count + 1;
        end

    default:
        next_state = 0;
        next_count = 0;
        next_bit_count = 0;
    endcase
end

// Update values.
always @(posedge sample_clk) begin
    state <= next_state;
    count <= next_count;
    bit_count <= next_bit_count;
end

// Calculate outputs.
assign sample_sig = (state == SAMPLING &&
                     count == SAMPLE_RATIO - 4'b1);

endmodule
