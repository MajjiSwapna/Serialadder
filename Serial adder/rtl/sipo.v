//////////////////////////////////////////////////////////////////////////////////////////
//   File name        : sipo.v                                                          //
//   Port description : Inputs  : i_in, i_reset, i_enable, i_clk                        //
//                      Outputs : o_sum                                                 //
//                                                                                      //
//                                                                                      //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////

module sipo #(parameter N=8)(input i_in,input i_reset,input i_enable,input i_clk,output [N:0]o_sum);
 reg [N:0]temp;
 always@(posedge i_clk) begin
 if(i_reset) begin
 temp<=0;
 end
 else if(i_enable) begin
 temp<={i_in,temp[N:1]};
 end
 end
 assign o_sum=temp;
endmodule

module tb_sipo();
 parameter N=8;
 reg i_clk;
 reg i_enable;
 reg i_reset;
 reg i_in;
 wire [N:0]o_sum;
 sipo #(N) uut(i_in,i_reset,i_enable,i_clk,o_sum);
 always #1 i_clk=~i_clk;
 initial begin
 i_clk=0;i_enable=0;i_reset=0;i_in=0;
 repeat(2) @(posedge i_clk); i_reset=1;
 repeat(2) @(posedge i_clk); i_reset=0;i_in=1;i_enable=1;
 repeat(2) @(posedge i_clk); i_in=1;
 repeat(2) @(posedge i_clk); i_in=0;
 repeat(4) @(posedge i_clk); i_in=1;
 repeat(6) @(posedge i_clk); i_in=0;
 $monitor("sum is=%b",o_sum);
 end
endmodule

