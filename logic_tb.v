`include "prj_definition.v"

module logic_tb;
wire [31:0] Y;
reg [31:0] A;
wire Q, Qbar;
reg S, R, C, nP, nR, D;

//TWOSCOMP32 compliment(Y, A);
//SR_LATCH sr(Q,Qbar, S, R, C, nP, nR);
//D_LATCH dl(Q, Qbar, D, C, nP, nR);
D_FF flipflop(Q, Qbar, D, C, nP, nR);

initial
begin
  #5 nP = 1; nR = 1; D = 0; C = 1;
  #5 nP = 1; nR = 1; D = 0; C = 0;
  #5 nP = 1; nR = 0;
  #5 nP = 1; nR = 1; D = 1; C = 1;
  #5 nP = 1; nR = 1; D = 1; C = 0;   
  #5 nP = 0; nR = 0;
  #5 nP = 0; nR = 1;
  //#5 nP = 1; nR = 1; S = 1; R = 0; C = 1; 
  //#5 A = 0;
  /*#5 A = -12;
  #5 A = -8;
  #5 A = 4;
  #5 A = 5;
  #5 A = 37;*/
end
endmodule
