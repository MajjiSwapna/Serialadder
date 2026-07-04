/////////////////////////////////////////////////////////////////////////////////////////////
//  File name         :  Serial Adder                                                      //  
//  Port description  :  Inputs  : i_clock,i_resetn,i_start,i_A,i_B                        //
//                       Outputs : o_sum                                                   //
//                                                                                         //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////

`include "sipo.v"
`include "fsm.v"
`include "shiftr.v"
`include "dff.v"
`include "adda.v"

module seradd #(
    parameter N = 8
) (
    input i_clock,
    input i_resetn,
    input i_start,
    output [N:0] o_sum,
    input [N-1:0] i_A,
    input [N-1:0] i_B,
    output enable,
    output [N:0] temp
);
  wire reset, load, sum_out, carry_in, c_out, A_out, B_out;
  reg [$clog2(N):0] count;

  dff d1 (
      i_clock,
      reset,
      c_out,
      carry_in
  );
  sipo s1 (
      sum_out,
      reset,
      enable,
      i_clock,
      temp
  );
  add a1 (
      A_out,
      B_out,
      carry_in,
      sum_out,
      c_out
  );
  fsm f1 (
      i_clock,
      i_start,
      i_resetn,
      reset,
      load,
      enable
  );
  shiftr h1 (
      i_A,
      i_clock,
      load,
      enable,
      A_out
  );
  shiftr h2 (
      i_B,
      i_clock,
      load,
      enable,
      B_out
  );
  always @(posedge i_clock) begin
    if (i_start == 0 || i_resetn == 0) begin
      count <= 0;
    end else if (count <= N + 2 && enable) begin
      count <= count + 1'b1;
    end else if (count > N + 2) begin
      count <= N + 3;
    end
  end
  assign o_sum = (reset) ? 1'b0 : ((count == (N + 2)) ? temp : o_sum);
endmodule



  

    
    
    


