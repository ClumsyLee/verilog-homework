module dff(q, notq, d, s_n, r_n, clk);

output q, notq;
input d, s_n, r_n, clk;

wire [3:0] mid;

nand (mid[0], s_n, mid[3], mid[1]);
nand (mid[1], mid[0], r_n, clk);
nand (mid[2], mid[1], clk, mid[3]);
nand (mid[3], mid[2], r_n, d);

nand (q, s_n, mid[1], notq);
nand (notq, q, r_n, mid[2]);

endmodule
