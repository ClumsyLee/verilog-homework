module street_light_controller(light, switches, master_switch);

output light;
input [2:0] switches;
input master_switch;

assign light = master_switch & ^switches;

endmodule
