module graduate_judger(eligible_to_graduate, pass);

output eligible_to_graduate;
input [3:0] pass;

assign eligible_to_graduate = pass[3] & (pass[2] | pass[0] &
                                                   pass[1]);

endmodule
