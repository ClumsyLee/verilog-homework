module counter(num, signal, enable, reset_n);

parameter WIDTH = 4,
          MAX = 1 << WIDTH;

output [WIDTH - 1:0] num;
input signal, enable, reset_n;

wire enabled_signal = signal & enable;

always @(posedge enabled_signal or negedge reset_n) begin
    if(~reset_n) begin
        num <= 0;
    end else begin
        num <= num + 1'b1;
    end
end

endmodule
