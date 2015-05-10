module two_one_mux(y, a, b, s);

output y;
input a, b, s;

wire nots;
wire choose_a, choose_b;

not #(5) (nots, s);
and #(5) (choose_a, nots, a);
and #(5) (choose_b, s, b);

or #(5) (y, choose_a, choose_b);

endmodule
