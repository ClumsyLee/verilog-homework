module shift_reg(q, d, load, reset_n, clk);

output [3:0] q;
input [3:0] d;
input load, reset_n, clk;

wire d1, d2, d3;

two_one_mux mux1(d1, q[0], d[1], load);
two_one_mux mux2(d2, q[1], d[2], load);
two_one_mux mux3(d3, q[2], d[3], load);

dff dff1(q[0], , d[0], 1'b1, reset_n, clk);
dff dff2(q[1], , d1  , 1'b1, reset_n, clk);
dff dff3(q[2], , d2  , 1'b1, reset_n, clk);
dff dff4(q[3], , d3  , 1'b1, reset_n, clk);

endmodule
