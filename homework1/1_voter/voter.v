module voter(indicator, agree);

output indicator;
input [2:0] agree;

assign indicator = (agree[0] & agree[1] |
                    agree[1] & agree[2] |
                    agree[0] & agree[2]) ? 1 : 0;

endmodule
