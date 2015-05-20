module two_one_mux(y, a, b, s);

output y;
input a, b, s;

wire nots;
wire choose_a, choose_b;

not (nots, s);
and (choose_a, nots, a);
and (choose_b, s, b);

or (y, choose_a, choose_b);

endmodule
