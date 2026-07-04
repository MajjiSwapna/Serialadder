////////////////////////////////////////////////////////////////////////////////////////////
//   File name        :  adda.v                                                           //
//   Port description :  Inputs : i_A, i_B, i_Cin                                         //
//                       Outputs: o_Sum_out, o_c_out                                      //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////
module add(input i_A,i_B,input i_Cin,output o_Sum_out,o_c_out);
 assign o_Sum_out= i_A ^ i_B ^ i_Cin;
 assign o_c_out= i_A & i_B | i_B & i_Cin | i_Cin & i_A;
endmodule


module add_tb();
 reg i_A;
 reg i_B;
 reg i_Cin;
 wire o_Sum_out;
 wire o_c_out;
 add dut(i_A,i_B,i_Cin,o_Sum_out,o_c_out);
 initial begin
 i_A=0;i_B=0;i_Cin=0;
 #5 i_A=1;
 #5 i_A=0;i_B=1;
 #5 i_Cin=1;
 #10 i_A=1;i_B=1;i_Cin=1;
end
endmodule
