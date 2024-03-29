// Name: logic_32_bit.v
// Module: 
// Input: 
// Output: 
//
// Notes: Common definitions
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//

// 32-bit NOR
module NOR32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

genvar i;
generate
for(i=0; i<32; i=i+1)
begin : nor32_gen_loop
  nor nor_inst(Y[i], A[i], B[i]);
end
endgenerate
endmodule

//unary NOR
module NOR2x1(Y, A); 
//output 
output Y;
//input
input [31:0] A;

wire [31:0] result;
assign result[0] = A[0];

genvar i;
generate
for(i=1; i<32; i=i+1)
begin : nor32_gen_loop
  or nor_inst(result[i], A[i], result[i-1]);  
end
endgenerate
not inverse(Y, result[31]);
endmodule

// 32-bit AND
module AND32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

genvar i;
generate
for(i=0; i<32; i=i+1)
begin : nor32_gen_loop
  and and_inst(Y[i], A[i], B[i]);
end
endgenerate
endmodule

// 32-bit inverter
module INV32_1x1(Y,A);
//output 
output [31:0] Y;
//input
input [31:0] A;

genvar i;
generate
for(i=0; i<32; i=i+1)
begin : not32_gen_loop
  not not_inst(Y[i], A[i]);
end
endgenerate
endmodule

// 32-bit OR
module OR32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

genvar i;
generate
for(i=0; i<32; i=i+1)
begin : or32_gen_loop
  or or_inst(Y[i], A[i], B[i]);
end
endgenerate
endmodule
