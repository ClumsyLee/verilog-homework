module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			8'd0 : Instruction <= {6'h08, 5'd0, 5'd4, 16'd3};
			8'd1 : Instruction <= {6'h03, 26'd3};
			8'd2 : Instruction <= {6'h04, 5'd0, 5'd0, -16'd1};
			8'd3 : Instruction <= {6'h08, 5'd29, 5'd29, -16'd8};
			8'd4 : Instruction <= {6'h2b, 5'd29, 5'd31, 16'd4};
			8'd5 : Instruction <= {6'h2b, 5'd29, 5'd4, 16'd0};
			8'd6 : Instruction <= {6'h0a, 5'd4, 5'd8, 16'd1};
			8'd7 : Instruction <= {6'h04, 5'd8, 5'd0, 16'd3};
			8'd8 : Instruction <= {6'h00, 5'd0, 5'd0, 5'd2, 5'd0, 6'h26};
			8'd9 : Instruction <= {6'h08, 5'd29, 5'd29, 16'd8};
			8'd10: Instruction <= {6'h00, 5'd31, 15'd0, 6'h08};
			8'd11: Instruction <= {6'h08, 5'd4, 5'd4, -16'd1};
			8'd12: Instruction <= {6'h03, 26'd3};
			8'd13: Instruction <= {6'h23, 5'd29, 5'd4, 16'd0};
			8'd14: Instruction <= {6'h23, 5'd29, 5'd31, 16'd4};
			8'd15: Instruction <= {6'h08, 5'd29, 5'd29, 16'd8};
			8'd16: Instruction <= {6'h00, 5'd4, 5'd2, 5'd2, 5'd0, 6'h20};
			8'd17: Instruction <= {6'h00, 5'd31, 15'd0, 6'h08};
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
