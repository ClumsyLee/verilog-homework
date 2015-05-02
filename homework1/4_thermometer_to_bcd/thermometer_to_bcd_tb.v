module thermometer_to_bcd_tb;

wire [3:0] bcd;
reg [15:0] thermometer = 0;

thermometer_to_bcd translator(bcd, thermometer);

initial begin
    $monitor("thermometer: %b, bcd: %b, dec: %d",
             thermometer, bcd, bcd);
    
    repeat (9) #5 thermometer = {thermometer[14:0], 1'b1};

    $finish;
end

endmodule
