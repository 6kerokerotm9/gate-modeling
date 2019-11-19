`include "prj_definition.v"

module rc_add_sub_32_tb;
reg[31:0] A, B;
reg CI;
wire[31:0] Y;
wire C;

RC_ADD_SUB_32 rc(.Y(Y), .CO(C), .A(A), .B(B), .SnA(CI));

initial 
begin
  #5 A = 2; B = 1; CI = 1;
  #5 A = 2; B = 1; CI = 0;
  #5 A = 100; B = 79; CI = 1;
  #5 A = 12; B = 15; CI = 0;
  #5 A = 10; B = 3; CI = 1;
end 
endmodule;
