module divider(new_signal, range, signal);

output new_signal;
input range, signal;

parameter RATIO = 10,
          HALF_RATIO = RATIO / 2;

reg [3:0] counter;

reg divided_signal = 0;
assign new_signal = (range ? divided_signal : signal);

always @(posedge signal) begin
    // Use a higher range.
    if (counter >= HALF_RATIO) begin
        counter <= 1;
        divided_signal <= ~divided_signal;  // Flip.
    end else begin
        counter <= counter + 1'b1;
    end
end

endmodule
