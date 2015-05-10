module three_eight_decoder(d, a);

output [7:0] d;
input [2:0] a;

wire [2:0] nota;
not not_gates[2:0](nota, a);

and (d[0], nota[2], nota[1], nota[0]);
and (d[1], nota[2], nota[1],    a[0]);
and (d[2], nota[2],    a[1], nota[0]);
and (d[3], nota[2],    a[1],    a[0]);
and (d[4],    a[2], nota[1], nota[0]);
and (d[5],    a[2], nota[1],    a[0]);
and (d[6],    a[2],    a[1], nota[0]);
and (d[7],    a[2],    a[1],    a[0]);

endmodule
