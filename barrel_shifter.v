// Name: barrel_shifter.v
// Module: SHIFT32_L , SHIFT32_R, SHIFT32
//
// Notes: 32-bit barrel shifter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

// 32-bit shift amount shifter
module SHIFT32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [31:0] S;
input LnR;

// TBD

endmodule

// Shift with control L or R shift
module BARREL_SHIFTER32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;
input LnR;

// TBD

endmodule

// Right shifter
module SHIFT32_R(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

// TBD

endmodule

// Left shifter
module SHIFT32_L(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

wire [31:0] mux1_result, mux2_result, mux3_result, mux4_result; //results of each row of bit shifters

genvar i;
generate
for(i = 0; i < 32; i = i + 1) //first row of bit shifters
begin : left_shift_loop_1
  if(i == 0)
  begin
    MUX1_2x1 mux(mux1_result[i], D[i], 0, S[0]); //load the first instance with 0 
  end
  else
  begin
    MUX1_2x1 mux(mux1_result[i], D[i], D[i-1], S[0]); 
  end
end
endgenerate

genvar j;
generate
for(j = 0; j < 32; j = j + 1) //second row of bit shifters
begin : left_shift_loop_2
  if(j <= 1)
  begin
    MUX1_2x1 mux(mux2_result[j], mux1_result[j], 0, S[1]); //load the first instance with 0 
  end
  else
  begin
    MUX1_2x1 mux(mux2_result[j], mux1_result[j], mux1_result[j-2], S[1]); 
  end
end
endgenerate

genvar k;
generate
for(k = 0; k < 32; k = k + 1) //third row of bit shifters
begin : left_shift_loop_3
  if(k <= 2)
  begin
    MUX1_2x1 mux(mux3_result[k], mux2_result[k], 0, S[2]); //load the first instance with 0 
  end
  else
  begin
    MUX1_2x1 mux(mux3_result[k], mux2_result[k], mux2_result[k-3], S[2]); 
  end
end
endgenerate

genvar l;
generate
for(l = 0; l < 32; l = l + 1) //fourth row of bit shifters
begin : left_shift_loop_4
  if(l <= 3)
  begin
    MUX1_2x1 mux(mux4_result[l], mux3_result[l], 0, S[3]); //load the first instance with 0 
  end
  else
  begin
    MUX1_2x1 mux(mux4_result[l], mux3_result[l], mux3_result[l-4], S[3]); 
  end
end
endgenerate

genvar m;
generate
for(m = 0; m < 32; m = m + 1) //fourth row of bit shifters
begin : left_shift_loop_5
  if(m <= 4)
  begin
    MUX1_2x1 mux(Y[m], mux4_result[m], 0, S[4]); //load the first instance with 0 
  end
  else
  begin
    MUX1_2x1 mux(Y[m], mux4_result[m], mux4_result[m-5], S[3]); 
  end
end
endgenerate

endmodule

