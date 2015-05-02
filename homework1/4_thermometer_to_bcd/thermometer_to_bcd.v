module thermometer_to_bcd(bcd, thermometer);

output [3:0] bcd;
input [15:0] thermometer;

assign bcd = (thermometer == 16'b0) ? 4'd0 :
             (thermometer == 16'b1) ? 4'd1 :
             (thermometer == 16'b11) ? 4'd2 :
             (thermometer == 16'b111) ? 4'd3 :
             (thermometer == 16'b1111) ? 4'd4 :
             (thermometer == 16'b11111) ? 4'd5 :
             (thermometer == 16'b111111) ? 4'd6 :
             (thermometer == 16'b1111111) ? 4'd7 :
             (thermometer == 16'b11111111) ? 4'd8 :
             (thermometer == 16'b111111111) ? 4'd9 : 4'd0;


endmodule
