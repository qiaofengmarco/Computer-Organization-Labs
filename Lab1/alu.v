`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:16:42 03/19/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input rst_n,
    input [31:0] src1,
    input [31:0] src2,
    input [3:0] ALU_control,
	 input [2:0] bonus_control,
    output reg [31:0]result,
    output zero,
	 output cout,
    output overflow
    );
reg less_temp;
reg less_greater_equal_temp;
wire greater_temp1, equal_temp1;
wire [31:0] c_temp;
wire [31:0] r_temp;
wire b_nega, less_temp1;
assign b_nega = ((ALU_control == 4'b0110) || (ALU_control == 4'b0111))? 1 : 0;
always @(r_temp)
begin
	result = r_temp;
end
/*always @(less_temp1)
begin
	less_temp = less_temp1;
end*/
always @(less_temp1 or greater_temp1 or equal_temp1)
begin
	if (ALU_control == 4'b0111)
		case (bonus_control)
			3'b000: less_greater_equal_temp = less_temp1;
			3'b001: less_greater_equal_temp = greater_temp1;
			3'b010: less_greater_equal_temp = less_temp1 | equal_temp1;
			3'b011: less_greater_equal_temp = greater_temp1 | equal_temp1;
			3'b110: less_greater_equal_temp = equal_temp1;
			3'b100: less_greater_equal_temp = ~equal_temp1;
		endcase
end  
alu_top lsb(
	.result(r_temp[0]),
	.cout(c_temp[0]),
	.a(src1[0]),
	.b(src2[0]),
	.cin(b_nega),
	.less_greater_equal(less_greater_equal_temp),
	.control(ALU_control),
	.bonus(bonus_control)
);
genvar i;
generate
for (i = 1; i < 32; i = i + 1)
begin : alu_block
		alu_top a_t(
		.result(r_temp[i]),
		.cout(c_temp[i]),
		.a(src1[i]),
		.b(src2[i]),
		.cin(c_temp[i - 1]),
		.less_greater_equal(1'b0),
		.control(ALU_control),
		.bonus(bonus_control)
		);	
end
endgenerate 
assign less_temp1 = src1[31] ^ (~src2[31]) ^ c_temp[30];
assign greater_temp1 = (~src1[31]) ^ src2[31] ^ c_temp[30];
assign equal_temp1 = c_temp[0] & c_temp[1] & c_temp[2] & c_temp[3] & c_temp[4] & c_temp[5] & c_temp[6] & c_temp[7] & c_temp[8] & c_temp[9] & c_temp[10] & c_temp[11] & c_temp[12] & c_temp[13] & c_temp[14] & c_temp[15] & c_temp[16] & c_temp[17] & c_temp[18] & c_temp[19] & c_temp[20] & c_temp[21] & c_temp[22] & c_temp[23] & c_temp[24] & c_temp[25] & c_temp[26] & c_temp[27] & c_temp[28] & c_temp[29] & c_temp[30] & c_temp[31];
assign zero = ~(result[0] | result[1] | result[2] | result[3] | result[4] | result[5] | result[6] | result[7] | result[8] | result[9] | result[10] | result[11] | result[12] | result[13] | result[14] | result[15] | result[16] | result[17] | result[18] | result[19] | result[20] | result[21] | result[22] | result[23] | result[24] | result[25] | result[26] | result[27] | result[28] | result[29] | result[30] | result[31]);
assign overflow = c_temp[30] ^ c_temp[31];
endmodule
