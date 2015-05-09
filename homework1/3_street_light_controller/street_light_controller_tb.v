module street_light_controller_tb;

wire light;
reg [3:0] all_switches = 0;
wire [2:0] switches = all_switches[2:0];
wire master_switch = all_switches[3];

street_light_controller controller(light, switches, master_switch);

initial begin
    $monitor("master_switch: %b, switches: %b, light: %b",
             master_switch, switches, light);

    repeat (15) #5 all_switches = all_switches + 1;

    $finish;
end

endmodule
