module four_one_mux(z, c, s);

output z;
input [3:0] c;
input [1:0] s;

wire y1, y2;

two_one_mux mux1(y1, c[0], c[1], s[0]);
two_one_mux mux2(y2, c[0], c[1], s[0]);
two_one_mux mux3(z, y1, y2, s[1]);

endmodule
