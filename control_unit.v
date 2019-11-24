// Name: control_unit.v
// Module: CONTROL_UNIT
// Output: CTRL  : Control signal for data path
//         READ  : Memory read signal
//         WRITE : Memory Write signal
//
// Input:  ZERO : Zero status from ALU
//         CLK  : Clock signal
//         RST  : Reset Signal
//
// Notes: - Control unit synchronize operations of a processor
//          Assign each bit of control signal to control one part of data path
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"
module CONTROL_UNIT(CTRL, READ, WRITE, ZERO, INSTRUCTION, CLK, RST); 
// Output signals
output [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL;
output READ, WRITE;

// input signals
input ZERO, CLK, RST;
input [`DATA_INDEX_LIMIT:0] INSTRUCTION;

reg READ, WRITE; 
reg [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL;
reg [`DATA_INDEX_LIMIT:0] inst;
wire [2:0] proc_state;

PROC_SM proc(proc_state,CLK,RST);

//ctrl template: 0000 0000 0000 0000 0000 0000 0000 0000

always @ (proc_state)
begin 
  if(proc_state == `PROC_FETCH)
  begin 
    READ = 1;
    WRITE = 0;
    CTRL = 'b00010000000000000000000000010110; 
  end

  else if(proc_state == `PROC_DECODE)
  begin
    inst = INSTRUCTION;
    CTRL = 'b00000000000000011000000000000001;
    //CTRL[26:21] = inst[];
  end
  
  else if(proc_state == `PROC_DECODE)
  begin 
    if(inst[31:26] == 6'h00)
    begin 
      if(inst[5:0] == 6'h20) //add
        CTRL = 'b00000000001010001000100000000000; //'b0000 0000 0010 1000 1000 1000 0000 0000;
      else if(inst[5:0] == 6'h22) //sub
        CTRL = 'b00000000010010001000100000000000; //'b0000 0000 0100 1000 1000 1000 0000 0000;
      else if(inst[5:0] == 6'h2c) //mult
        CTRL = 'b00000000011010001000100000000000; //'b0000 0000 0110 1000 1000 1000 0000 0000;
      else if(inst[5:0] == 6'h24) //and
        CTRL = 'b00000000110010001000100000000000; //'b0000 0000 1100 1000 1000 1000 0000 0000;
      else if(inst[5:0] == 6'h25) //or
        CTRL = 'b00000000111010001000100000000000; //'b0000 0000 1110 1000 1000 1000 0000 0000;
      else if(inst[5:0] == 6'h27) //nor
        CTRL = 'b00000001000010001000100000000000; //'b0000 0001 0000 1000 1000 1000 0000 0000;
      else if(inst[5:0] == 6'h2a) //slt
        CTRL = 'b00000001001010001000100000000000; //'b0000 0001 0010 1000 1000 1000 0000 0000;
      else if(inst[5:0] == 6'h01) //sll
        CTRL = 'b00000000101000001000101000000000; //'b0000 0000 1010 0000 1000 1010 0000 0000;
      else if(inst[5:0] == 6'h02) //srl
        CTRL = 'b00000000100000001000101000000000; //'b0000 0000 1000 0000 1000 1010 0000 0000;
      else if(inst[5:0] == 6'h08) //jr
        CTRL = 'b00000000000000001000101000000000; //'b0000 0000 0000 0000 1000 1010 0000 0000;
    end
    //i-type
    else if(inst[31:26] == 6'h08) //addi
      CTRL = 'b00000000001000001000010000000000; //'b0000 0000 0010 0000 1000 0100 0000 0000;
    else if(inst[31:26] == 6'h1d) //multi
      CTRL = 'b00000000011000001000010000000000; //'b0000 0000 0110 0000 1000 0100 0000 0000;
    else if(inst[31:26] == 6'h0c) //andi
      CTRL = 'b00000000110000001000010000000000; //'b0000 0000 1100 0000 1000 0100 0000 0000;
    else if(inst[31:26] == 6'h0c) //ori
      CTRL = 'b00000000111000001000010000000000; //'b0000 0000 1110 0000 1000 0100 0000 0000;
  end
end
endmodule


//------------------------------------------------------------------------------------------
// Module: PROC_SM
// Output: STATE      : State of the processor
//         
// Input:  CLK        : Clock signal
//         RST        : Reset signal
//
// INOUT: MEM_DATA    : Data to be read in from or write to the memory
//
// Notes: - Processor continuously cycle witnin fetch, decode, execute, 
//          memory, write back state. State values are in the prj_definition.v
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
module PROC_SM(STATE,CLK,RST);
// list of inputs
input CLK, RST;
// list of outputs
output [2:0] STATE;

//registers for the state and the next stage
reg [2:0] STATE_REG;
reg [2:0] NEXT_STATE;	

assign STATE = STATE_REG; 

initial
begin 
  STATE_REG = 3'bxxx; 
  NEXT_STATE = `PROC_FETCH; //set the next state to fetch the process
end

//reset at the negative edge of the clock
always@(negedge RST)
begin 
  STATE_REG = 3'bxxx; 
  NEXT_STATE = `PROC_FETCH; 
end

always@(posedge CLK) //fetch the next state from the current state
begin
  STATE_REG = NEXT_STATE; //assign the current state to the next state
  if(STATE_REG === `PROC_FETCH) //these control statements will find the next state
    NEXT_STATE = `PROC_DECODE;
  else if(STATE_REG === `PROC_DECODE)
    NEXT_STATE = `PROC_EXE;
  else if(STATE_REG === `PROC_EXE)
    NEXT_STATE = `PROC_MEM;
  else if(STATE_REG ===  `PROC_MEM)
    NEXT_STATE = `PROC_WB;
  else if(STATE_REG === `PROC_WB)
    NEXT_STATE = `PROC_FETCH;
end
endmodule;