module signalinput(
    input [1:0] testmode,  // 00, 01, 10, 11 分别代表4种频率,
                           // 分别为 3125, 250, 50, 12500Hz, 使用 SW1~SW0 来控制
    input sysclk,  // 系统时钟100M
    output sigin1  // 输出待测信号
);

reg [20:0] state;
reg [20:0] divide;
reg sigin;

assign sigin1 = sigin;

initial
begin
    sigin = 0;
    state = 21'b000000000000000000000;
    divide = 21'b0_0000_0111_1101_0000_0000;
end

always @(testmode)
begin
    case(testmode[1:0])
    2'b00: divide = 21'b0_0000_0111_1101_0000_0000;  // 3125Hz, 分频比为32000
    2'b01: divide = 21'b0_0110_0001_1010_1000_0000;  // 250Hz, 分频比为400000
    2'b10: divide = 21'b1_1110_1000_0100_1000_0000;  // 50Hz, 分频比为2000000
    2'b11: divide = 21'b0_0000_0001_1111_0100_0000;  // 12500Hz, 分频比为8000
    endcase
end

always @(posedge sysclk)  // 按divide分频
begin
    if(state == 0)
        sigin = ~sigin;
    state = state + 21'd2;
    if(state == divide)
        state = 0;
end

endmodule
