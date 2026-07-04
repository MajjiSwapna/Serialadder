/////////////////////////////////////////////////////////////////////////////////////////////////////
//   File name         :  shiftr.v                                                                 //
//   Port description  :  Inputs  :  i_in,i_clk,i_load,i_enable                                    //
//                        Outputs :  o_out                                                         //
//                                                                                                 //
//                                                                                                 //
//                                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////

module shiftr #(parameter N=8)(input [N-1:0]i_in,input i_clk,input i_load,input i_enable,output reg o_out);
 reg [N-1:0]temp;
 always@(posedge i_clk) begin
 if(i_load)
 begin
 temp<=i_in;
 end
 else if(i_enable) begin
 o_out<= temp[0];
 temp<= {1'b0,temp[N-1:1]};
 end
 else begin
 o_out<=0;
 end
 end
endmodule

module tb_shiftr();
 parameter N=8;
 reg [N-1:0]i_in;
 reg i_clk;
 reg i_load;
 reg i_enable;
 wire o_out;
 shiftr #(N) uut(i_in,i_clk,i_load,i_enable,o_out);
 always #1 i_clk=~i_clk;
 initial begin
 i_clk=0;i_load=0;i_enable=0;i_in=0;
 repeat(2) @(posedge i_clk); i_in=8'b00110010;
 repeat(2) @(posedge i_clk); i_load=1;
 repeat(2) @(posedge i_clk); i_enable=1;i_load=0;
 repeat(10) @(posedge i_clk);i_in=8'b11111111;i_load=1;i_enable=0;
 repeat(5) @(posedge i_clk); i_enable=1;
 end
endmodule
