module thermometer_to_bcd(bcd, thermometer);

output [7:0] bcd;
input [15:0] thermometer;

assign bcd = (thermometer == 16'b0) ? 0 :
             (thermometer == 16'b1) ? 1 :
             (thermometer == 16'b11) ? 2 :
             (thermometer == 16'b111) ? 3 :
             (thermometer == 16'b1111) ? 4 :
             (thermometer == 16'b11111) ? 5 :
             (thermometer == 16'b111111) ? 6 :
             (thermometer == 16'b1111111) ? 7 :
             (thermometer == 16'b11111111) ? 8 :
             (thermometer == 16'b111111111) ? 9 :
             (thermometer == 16'b1111111111) ? 9 :
             (thermometer == 16'b11111111111) ? {4'd1, 4'd0} :
             (thermometer == 16'b111111111111) ? {4'd1, 4'd1} :
             (thermometer == 16'b1111111111111) ? {4'd1, 4'd2} :
             (thermometer == 16'b11111111111111) ? {4'd1, 4'd3} :
             (thermometer == 16'b111111111111111) ? {4'd1, 4'd4} :
             (thermometer == 16'b1111111111111111) ? {4'd1, 4'd5} : {4'd1, 4'd6};

endmodule
