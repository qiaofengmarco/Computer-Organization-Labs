`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:35:35 03/18/2017 
// Design Name: 
// Module Name:    alu_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu_top(
    output reg result,
    output reg cout,
    input a,
    input b,
    input cin,
	 input less_greater_equal,
    input [3:0] control,
	 input [2:0] bonus
    );
always @(*)
begin
	case (control)
		4'b0000: result = a & b;
		4'b0001: result = a | b;
		4'b0010: 
		begin
			result = a ^ b ^ cin;
			cout = (a & b) | (cin & (a ^ b));
		end
		4'b0110:
		begin
			result = a ^ (~b) ^ cin;
			cout = (a & ~b) | (cin & (a ^ ~b));
		end
		/*4'b0111:
		begin
			result = less_greater_equal;
			cout = (a & ~b) | (cin & (a ^ ~b));
		end*/
		4'b1100: result = (~a) & (~b);
		4'b1101: result = (~a) | (~b);
		4'b0111:
		begin 
			case (bonus)
				3'b000:
				begin
					result = less_greater_equal;
					cout = (a & ~b) | (cin &(a ^ ~b));
				end
				3'b001:
				begin
					result = less_greater_equal;
					cout = (~a & b) | (cin &(~a ^ b));
				end
				3'b010:
				begin
					result = less_greater_equal;
					cout = (a & ~b) | (cin &(a ^ ~b));
				end
				3'b011:
				begin
					result = less_greater_equal;
					cout = (~a & b) | (cin &(~a ^ b));
				end		
				3'b110:
				begin
					result = less_greater_equal;
					cout = (a & ~b) | (cin &(a ^ ~b));
				end
				3'b100:
				begin
					result = less_greater_equal;
					cout = (a & ~b) | (cin &(a ^ ~b));
				end
			endcase
		end
	endcase
end

endmodule
