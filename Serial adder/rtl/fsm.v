//////////////////////////////////////////////////////////////////////////////////////////////////
//  File name         : fsm.v                                                                   //
//  Port description  : Inputs  :  i_clk, i_start, i_resetn                                     //
//                      Outputs :  o_reset, o_load, o_enable                                    //
//                                                                                              //
//                                                                                              //
//                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////
module fsm(input i_clk,input i_start,input i_resetn,output o_reset,output o_load,output o_enable);
 parameter res=0,l=1,en=2;
 reg [2:0]state,next_s;
 always@(posedge i_clk) begin
 if(!i_resetn) begin
 state<=res;
 end
 else
 state<=next_s;
 end
 always@(*) begin
 case(state)
 res:begin
 if(i_resetn) begin
 next_s<=l;
 end
 else begin
 next_s<=res;
 end
 end
 l:begin
 if(i_resetn==1 && i_start==1) begin
 next_s<=en;
 end
 else
 next_s<=res;
 end
 en:begin
 if(i_start==0 || i_resetn==0)
 next_s<=res;
 end
 endcase
 end
 assign o_reset=~i_resetn;
 assign o_load=(state==l);
 assign o_enable=(state==en);
endmodule


module tb_fsm();
 reg i_clk;
 reg i_start;
 reg i_resetn;
 wire o_reset;
 wire o_enable;
 wire o_load;
 fsm uut(i_clk,i_start,i_resetn,o_reset,o_load,o_enable);
 always #5 i_clk=~i_clk;
 initial begin
 i_resetn=0;i_start=0;i_clk=0;
 repeat(2) @(posedge i_clk); i_resetn=1;
 repeat(2) @(posedge i_clk); i_start=1;
 repeat(4) @(posedge i_clk); i_start=0;i_resetn=0;
 repeat(2) @(posedge i_clk); i_resetn=1;i_start=1;
 end
endmodule



