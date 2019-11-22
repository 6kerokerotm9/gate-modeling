`include "prj_definition.v"

module logic_tb;
wire [31:0] Y;
reg [31:0] A;
wire Q, Qbar;
reg S, R, C, nP, nR, D, L;

//TWOSCOMP32 compliment(Y, A);f
//SR_LATCH sr(Q,Qbar, S, R, C, nP, nR);
//D_LATCH dl(Q, Qbar, D, C, nP, nR);
D_FF flipflop(Q, Qbar, D, C, nP, nR);
//REG1 register(Q, Qbar, D, L, C, nP, nR);

initial
begin
  /*SR latch testing
  #5 nP = 1; nR = 1; C = 1; S = 1; R = 1;
  #5 C = 1; S = 1; R = 0;
  #5 C = 1; S = 0; R = 0;
  #5 nP = 1; nR = 0; C = 1; S = 1; R = 0;
  #5 nP = 1; nR = 1; C = 1; S = 0; R = 0;
  #5 C = 1; S = 0; R = 1;
  #5 C = 0; S = 1; R = 1;
  #5 C = 1; S = 1; R = 0;
  #5 C = 0; S = 1; R = 0;*/

  /*D latch testing
  #5 nP = 1; nR = 1; C = 1; D = 1; 
  #5 C = 0; D = 0;
  #5 C = 1; D = 0;
  #5 C = 0; D = 0;*/
  
  /*D flip flop*/
  #5 nP = 1; nR = 1; D = 0; C = 1;
  #5 nP = 1; nR = 1; D = 0; C = 0;
  #5 nP = 1; nR = 0;
  #5 nP = 1; nR = 1; D = 1; C = 1;
  #5 nP = 1; nR = 1; D = 1; C = 0;   
  #5 nP = 0; nR = 0;
  #5 nP = 0; nR = 1;
  //#5 A = 0;
  /*#5 A = -12;
  #5 A = -8;
  #5 A = 4;
  #5 A = 5;
  #5 A = 37;*/
end
endmodule
