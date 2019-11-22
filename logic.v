// Name: logic.v
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
// 64-bit two's complement
module TWOSCOMP64(Y,A);
//output list
output [63:0] Y;
//input list
input [63:0] A;

wire [63:0] A_not;
wire CO;

genvar i;
generate
for(i=0; i<64; i=i+1)
begin :  TWOSCOMP32_gen_loop
  if(i < 32)
  begin
    not inverse1(A_not[i], A[i]);
  end
  else
  begin
    not inverse2(A_not[i], A[i]);
  end
end
endgenerate
RC_ADD_SUB_64 add(Y, CO, A_not, 64'b1, 1'b0);
endmodule

// 32-bit two's complement
module TWOSCOMP32(Y,A);
//output list
output [31:0] Y;
//input list
input [31:0] A;

wire [31:0] A_not;
wire CO;

genvar i;
generate
for(i=0; i<32; i=i+1)
begin :  TWOSCOMP32_gen_loop
  not inverse(A_not[i], A[i]);
end
endgenerate
RC_ADD_SUB_32 add(Y, CO, A_not, 32'b1, 1'b0);
endmodule

// 32-bit registere +ve edge, Reset on RESET=0
module REG32(Q, D, LOAD, CLK, RESET);
output [31:0] Q;

input CLK, LOAD;
input [31:0] D;
input RESET;

wire [31:0] Qbar;

genvar i;
generate
for(i=0; i<32; i=i+1)
begin : reg32_loop
  REG1 register(Q[i], Qbar[i], D[i], LOAD, CLK, 1'b1, RESET);
end
endgenerate
endmodule

// 1 bit register +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module REG1(Q, Qbar, D, L, C, nP, nR);
input D, C, L;
input nP, nR;
output Q,Qbar;

wire mux_result, Q_out;

MUX1_2x1 load(mux_result, Q_out, D, L);
D_FF flipflop(Q_out, Qbar, mux_result, C, nP, nR);
assign Q = Q_out;
endmodule

// 1 bit flipflop +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_FF(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

wire master_output, master_bar, not_clock;

D_LATCH dl(master_output, master_bar, D, C, nP, nR);
not inv_c(not_clock, C);
SR_LATCH srl(Q,Qbar, master_output, master_bar, not_clock, nP, nR);
endmodule

// 1 bit D latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_LATCH(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

wire nand_1_result, nand_2_result, nand_3_result, nand_4_result, not_d;

not inv_d(not_d, D);
nand nand_1(nand_1_result, D, C);
nand nand_2(nand_2_result, C, not_d);
nand nand_3(nand_3_result, nand_1_result, nand_4_result, nP);
nand nand_4(nand_4_result, nand_2_result, nand_3_result, nR);

assign Q = nand_3_result;
assign Qbar = nand_4_result;
endmodule

// 1 bit SR latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module SR_LATCH(Q,Qbar, S, R, C, nP, nR);
input S, R, C;
input nP, nR;
output Q,Qbar;

wire nand_1_result, nand_2_result, nand_3_result, nand_4_result;

nand nand_1(nand_1_result, S, C);
nand nand_2(nand_2_result, R, C);
nand nand_3(nand_3_result, nand_1_result, nand_4_result, nP);
nand nand_4(nand_4_result, nand_2_result, nand_3_result, nR);

assign Q = nand_3_result;
assign Qbar = nand_4_result;
endmodule

// 5x32 Line decoder
module DECODER_5x32(D,I);
// output
output [31:0] D;
// input
input [4:0] I;

// TBD

endmodule

// 4x16 Line decoder
module DECODER_4x16(D,I);
// output
output [15:0] D;
// input
input [3:0] I;

// TBD


endmodule

// 3x8 Line decoder
module DECODER_3x8(D,I);
// output
output [7:0] D;
// input
input [2:0] I;

//TBD


endmodule

// 2x4 Line decoder
module DECODER_2x4(D,I);
// output
output [3:0] D;
// input
input [1:0] I;

// TBD

endmodule