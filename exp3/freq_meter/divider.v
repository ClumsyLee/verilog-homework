module divider(new_signal, range, signal);

output reg new_signal;
input range, signal;

parameter RATIO = 10;

reg [3:0] counter;

always @(signal) begin
    if (range) begin
        // Use a higher range.
        if (counter >= RATIO) begin
            counter <= 1;
            new_signal <= ~new_signal;  // Flip.
        end else begin
            counter <= counter + 1;
        end
    end else begin
        // Just pass the signal
        new_signal <= signal;
    end
end

endmodule
