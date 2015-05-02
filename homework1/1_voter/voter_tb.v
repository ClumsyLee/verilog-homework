module voter_tb;

reg [2:0] agree;
wire indicator;

voter voter1(indicator, agree);

initial begin
    $monitor("agree: %b, indicator: %b", agree, indicator);

    #5 agree = 3'b000;
    #5 agree = 3'b001;
    #5 agree = 3'b010;
    #5 agree = 3'b011;
    #5 agree = 3'b100;
    #5 agree = 3'b101;
    #5 agree = 3'b110;
    #5 agree = 3'b111;

    $finish;
end

endmodule
