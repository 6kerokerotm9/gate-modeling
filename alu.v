// Name: alu.v
// Module: ALU
// Input: OP1[32] - operand 1
//        OP2[32] - operand 2
//        OPRN[6] - operation code
// Output: OUT[32] - output result for the operation
//
// Notes: 32 bit combinatorial ALU
// 
// Supports the following functions
//	- Integer add (0x1), sub(0x2), mul(0x3)
//	- Integer shift_rigth (0x4), shift_left (0x5)
//	- Bitwise and (0x6), or (0x7), nor (0x8)
//  - set less than (0x9)
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module ALU(OUT, ZERO, OP1, OP2, OPRN);
// input list
input [`DATA_INDEX_LIMIT:0] OP1; // operand 1
input [`DATA_INDEX_LIMIT:0] OP2; // operand 2
input [`ALU_OPRN_INDEX_LIMIT:0] OPRN; // operation code

// output list
output [`DATA_INDEX_LIMIT:0] OUT; // result of the operation.
output ZERO;

//wires
wire SnA, CO;
wire oprn_not, oprn_and;
wire [31:0] rc_output, mult_hi, mult_lo, shift_output, and_output, or_output, nor_output;
wire [31:0] I = 32'b0;

//addition operation
not oprn_0(oprn_not, OPRN[0]); //finding SnA using the formula provided in the slides
and oprn_3_0(oprn_and, OPRN[3], OPRN[0]);
or oprn_result(SnA, oprn_not, oprn_and);
RC_ADD_SUB_32 rc(rc_output, CO, OP1, OP2, SnA);

//multiplier
MULT32 mult(mult_hi, mult_lo, OP1, OP2);

//shift operation
SHIFT32 shift(shift_output, OP1, OP2, OPRN[0]);

//logical AND
AND32_2x1 and_op(and_output, OP1, OP2);

//logical OR
OR32_2x1 or_op(or_output, OP1, OP2);

//logical NOR
NOR32_2x1 nor_op(nor_output, OP1, OP2);

//multiplexer to pick the result
MUX32_16x1 final_result(OUT, I, rc_output, rc_output, mult_lo, shift_output, shift_output, and_output, or_output,
                     nor_output, {31'b0, rc_output[31]}, I, I, I, I, I, I, OPRN[3:0]);

nor nor_zero(ZERO, OUT);
endmodule
