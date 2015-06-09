module framing_crc(
    output reg [7:0] dout,
    output next_indicator,
    input [7:0] din,
    input indicator,
    input clk,
    input reset_n
);

localparam CRC_INIT = 16'hffff;

localparam WAITING = 0,
           SHR = 1,
           PHR_PSDU = 2,
           FCS = 3;

reg [1:0] state, next_state;
reg [6:0] count, next_count;

reg [15:0] crc, next_crc;
wire crc_in = din[(count[2:0])-:1] ^ crc[0];

always @(*) begin
    case (state)
        WAITING: begin
            if (indicator)
                next_state = SHR;
            else
                next_state = WAITING;
            next_count = 0;
            next_crc = CRC_INIT;
        end

        SHR: begin
            if (count < 79) begin
                next_state = SHR;
                next_count = count + 1;
            end else begin
                next_state = PHR_PSDU;
                next_count = 0;
            end
            next_crc = CRC_INIT;
        end

        PHR_PSDU: begin
            next_state = (indicator ? FCS : PHR_PSDU);
            next_count = (count == 7 ? 0 : count + 1);
            next_crc = {crc_in,
                        crc[15:12],
                        crc[11] ^ crc_in,
                        crc[10:5],
                        crc[4] ^ crc_in,
                        crc[3:1]};
        end

        FCS: begin
            if (count < 15) begin
                next_state = FCS;
                next_count = count + 1;
                next_crc = crc;
            end else begin
                next_state = WAITING;
                next_count = 0;
                next_crc = CRC_INIT;
            end
        end

        default: begin
            next_state = WAITING;
            next_count = 0;
            next_crc = CRC_INIT;
        end
    endcase
end

// Update states.
always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        state <= WAITING;
        count <= 0;
        crc <= CRC_INIT;
    end else begin
        state <= next_state;
        count <= next_count;
        crc <= next_crc;
    end
end

always @(*) begin
    case (state)
        SHR:
            if (count < 64)
                dout = 8'haa;
            else if (count < 72)
                dout = 8'hf3;
            else
                dout = 8'h98;
        
        PHR_PSDU:
            dout = din;

        FCS:
            dout = ~(count < 8 ? crc[7:0] : crc[15:8]);

        default:
            dout = 0;
    endcase
end

assign next_indicator = (state == WAITING && indicator ||
                         state == FCS && count == 15);

endmodule
