// Name: full_adder.v
// Module: FULL_ADDER
//
// Output: S : Sum
//         CO : Carry Out
//
// Input: A : Bit 1
//        B : Bit 2
//        CI : Carry In
//
// Notes: 1-bit full adder implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module FULL_ADDER(S,CO,A,B, CI);
output S,CO;
input A,B, CI;

wire HA1_XOR, HA1_AND, HA2_AND;

HALF_ADDER HA1(.Y(HA1_XOR), .C(HA1_AND), .A(A), .B(B));
HALF_ADDER HA2(.Y(S), .C(HA2_AND), .A(HA1_XOR), .B(CI));
or OR(CO, HA2_AND, HA1_AND);

endmodule;
