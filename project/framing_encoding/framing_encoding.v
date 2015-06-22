`timescale 1us/100ns

module framing_encoding(
    output framing_encoding_out,
    output framing_encoding_out_valid,
    input [7:0] phr_psdu_in,
    input phr_psdu_in_valid,
    input clk,
    input reset_n
);

wire [7:0] fifo_out;
wire fifo_indicator;

fifo queue(fifo_out,
           fifo_indicator,
           phr_psdu_in,
           phr_psdu_in_valid,
           clk,
           reset_n);

wire [7:0] framing_crc_out;
wire framing_crc_indicator;

framing_crc framer(framing_crc_out, framing_crc_indicator,
                   fifo_out, fifo_indicator, clk, reset_n);

wire [7:0] whiting_out;
wire whiting_out_indicator;

data_whiting whiter(whiting_out, whiting_out_indicator,
                    framing_crc_out, framing_crc_indicator, clk, reset_n);

serializing serializer(framing_encoding_out, framing_encoding_out_valid,
                       whiting_out, whiting_out_indicator, clk, reset_n);

endmodule
