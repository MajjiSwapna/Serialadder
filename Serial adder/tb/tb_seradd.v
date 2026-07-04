`include "../rtl/seradd.v"
module tb_seradd();
  parameter N = 8;
  reg i_clock;
  reg i_resetn;
  reg i_start;
  reg [N-1:0] i_A;
  reg [N-1:0] i_B;
  wire [N:0] o_sum;
  wire [N:0] temp;
  wire enable;
  seradd #(N) dut (
      i_clock,
      i_resetn,
      i_start,
      o_sum,
      i_A,
      i_B,
      enable,
      temp
  );
  always #2 i_clock = ~i_clock;
  initial begin
    i_clock = 0;
    i_resetn = 0;
    i_start = 0;
    i_A = 0;
    i_B = 0;
    repeat (5) @(posedge i_clock);
    i_resetn = 1;
    i_A = 8'b00001111;
    i_B = 8'b00110011;
    repeat (2) @(posedge i_clock);
    i_start = 1;

    $monitor("sum is=%b", o_sum);
    $monitor("temp=%b", temp);

    repeat (70) @(posedge i_clock);
    i_resetn = 0;
    i_start  = 0;
    repeat (5) @(posedge i_clock);
    i_resetn = 1;
    i_A = 8'b11110000;
    i_B = 8'b11001100;
    repeat (22) @(posedge i_clock);
    i_start = 1;

    repeat (70) @(posedge i_clock);
    i_resetn = 0;
    i_start  = 0;
    repeat (5) @(posedge i_clock);
    i_resetn = 1;
    i_A = 8'b00001111;
    i_B = 8'b00000000;
    repeat (22) @(posedge i_clock);
    i_start = 1;

    repeat (70) @(posedge i_clock);
    i_resetn = 0;
    i_start  = 0;
    repeat (5) @(posedge i_clock);
    i_resetn = 1;
    i_A = 8'b11110101;
    i_B = 8'b11111111;
    repeat (22) @(posedge i_clock);
    i_start = 1;

    repeat (70) @(posedge i_clock);
    i_resetn = 0;
    i_start  = 0;
    repeat (5) @(posedge i_clock);
    i_resetn = 1;
    i_A = 8'b10100110;
    i_B = 8'b11001100;
    repeat (22) @(posedge i_clock);
    i_start = 1;

    repeat (70) @(posedge i_clock);
    i_resetn = 0;
    i_start  = 0;
    repeat (5) @(posedge i_clock);
    i_resetn = 1;
    i_A = 8'b01010101;
    i_B = 8'b11000000;
    repeat (22) @(posedge i_clock);
    i_start = 1;

    repeat (70) @(posedge i_clock);
    i_resetn = 0;
    i_start  = 0;
    repeat (10) @(posedge i_clock);
    i_resetn = 1;
    i_start  = 1;
    repeat (2) @(posedge i_clock);
    i_start = 0;
    repeat (10) @(posedge i_clock);
    i_resetn = 0;
    @(posedge i_clock);
    i_resetn = 1;
    @(posedge i_clock);
    i_resetn = 0;

    repeat (20) @(posedge i_clock);
    i_A = $random;
    i_B = $random;
    i_start = 1;
    i_resetn = 1;
    @(posedge i_clock);
    i_resetn = 0;
    i_start  = 0;
    repeat (2) @(posedge i_clock);
    i_start = 1;


  end
endmodule


