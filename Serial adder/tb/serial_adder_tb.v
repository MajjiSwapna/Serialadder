`include "../rtl/seradd.v"
module serial_adder_tb ();
  parameter N = 8;
  reg i_clock;
  reg i_resetn;
  reg i_start;
  reg [N-1:0] i_A;
  reg [N-1:0] i_B;
  wire [N:0] o_sum;
  wire [N:0] temp;
  wire enable;
  integer seed;
  reg [N:0] expected_sum;

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

  task case1();
    begin
      i_resetn = 1;
      i_A = $urandom_range(0,255);
      i_B = $urandom_range(0,255);
      repeat (2) @(posedge i_clock);
      i_start = 1;
      $monitor("case1 %d %d %d", i_A, i_B, o_sum);
      repeat (70) @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;
      repeat (5) @(posedge i_clock);
      
    end
  endtask

  task case2();
    begin
      i_resetn = 1;
      i_A = $urandom_range(0,255);
      i_B = $urandom_range(0,255);
      repeat (2) @(posedge i_clock);
      i_start = 1;
      repeat (70) @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;
      repeat (5) @(posedge i_clock);
      $display("case2 %d %d %d", i_A, i_B, o_sum);
    end
  endtask

  task case3();
    begin
      i_resetn = 1;
      i_A =$urandom_range(0,255);
      i_B = $urandom_range(0,255);
      repeat (2) @(posedge i_clock);
      i_start = 1;
      repeat (70) @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;
      repeat (5) @(posedge i_clock);
      i_resetn = 1;
      i_A =$urandom_range(0,255);
      i_B =$urandom_range(0,255);
      repeat (2) @(posedge i_clock);
      i_start = 1;
      repeat (70) @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;
      repeat (5) @(posedge i_clock);
      i_resetn = 1;
      i_A = $urandom_range(0,255);
      i_B = $urandom_range(0,255);
      repeat (2) @(posedge i_clock);
      i_start = 1;
      repeat (70) @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;
      repeat (5) @(posedge i_clock);
    end
  endtask

  task case4();
    begin
      i_resetn = 1;
      i_A =$urandom_range(0,255);
      i_B = $urandom_range(0,255);
      repeat (2) @(posedge i_clock);
      i_start = 1;
      repeat (70) @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;
      repeat (5) @(posedge i_clock);
      i_resetn = 1;
      i_A =$urandom_range(0,255);
      i_B = $urandom_range(0,255);
      repeat (2) @(posedge i_clock);
      i_start = 1;
      repeat (70) @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;

      repeat (5) @(posedge i_clock);
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
      i_A = $urandom_range(0,255);
      i_B = $urandom_range(0,255);
      i_start = 1;
      i_resetn = 1;
      @(posedge i_clock);
      i_resetn = 0;
      i_start  = 0;
      repeat (2) @(posedge i_clock);
      i_start = 1;
    end
  endtask

  initial begin
  expected_sum = i_A + i_B;
  if(o_sum !== expected_sum)
  begin
   $error("FAIL A=%0d B=%0d Expected=%0d Got=%0d",
           i_A,i_B,expected_sum,o_sum);
           end
           else
           begin
           $display("PASS");
           end
    //$monitor("A = %d, B = %d, Sum = %d", i_A, i_B, o_sum);
    end
    
  initial begin
    i_clock = 0;
    i_resetn = 0;
    i_start = 0;
    i_A = 0;
    i_B = 0;

    if(!$value$plusargs("SEED=%d", seed))
        seed = 12345;

    $display("Using SEED = %0d", seed);
	//void'($urandom(seed));

    if ($test$plusargs("Case1")) case1();
    if ($test$plusargs("Case2")) case2();
    if ($test$plusargs("Case3")) case3();
    if ($test$plusargs("Case4")) case4();
    if ($test$plusargs("Case5"))
	begin
	case1();
    case2();
    case3();
    case4();
    end

    repeat (4) @(posedge i_clock);
    $finish;
  end
endmodule














