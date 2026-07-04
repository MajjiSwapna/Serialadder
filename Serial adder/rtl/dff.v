///////////////////////////////////////////////////////////////////////////////////////////////
//  File name        : dff.v                                                                 //
//  Port description : Inputs : i_clk, i_reset, i-D                                          //
//                     Outputs:  o_Q                                                         //
//                                                                                           //
//                                                                                           //
//                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////

module dff(input i_clk,input i_reset,input i_D,output reg o_Q);
 always@(posedge i_clk)
 begin
 if(i_reset) begin
 o_Q<=1'b0;
 end
 else
 o_Q<=i_D;
 end
endmodule


module dff_tb();
 reg i_clk;
 reg i_reset;
 reg i_D;
 wire o_Q;
 dff dut(i_clk,i_reset,i_D,o_Q);
 always #2 i_clk=~i_clk;
 initial begin
 i_clk=0;
 i_reset=1;
 @(posedge i_clk); i_reset=0;
 repeat(2) @(posedge i_clk); i_D=1;
 @(posedge i_clk); i_D=0;
 @(posedge i_clk); i_D=1;
 repeat(2) @(posedge i_clk); i_reset=1;
 repeat(2) @(posedge i_clk); i_D=1;
end
endmodule

