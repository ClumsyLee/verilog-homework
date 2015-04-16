`timescale 1ns/1ns
module BCD7(din,dout);
input [3:0] din;
output [6:0] dout;

assign dout=(din==0)?7'b111_1110:
            (din==1)?7'b011_0000:
            (din==2)?7'b110_1101:
            (din==3)?7'b111_1001:
            (din==4)?7'b011_0011:
            (din==5)?7'b101_1011:
            (din==6)?7'b101_1111:
            (din==7)?7'b111_0000:
            (din==8)?7'b111_1111:
            (din==9)?7'b111_1011:7'b0;
endmodule
