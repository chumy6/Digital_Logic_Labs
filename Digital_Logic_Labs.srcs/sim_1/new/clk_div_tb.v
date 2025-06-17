`timescale 1ns/1ns

module clk_div_tb ();

  reg clk, rst;
  wire clk_100, clk_25;
  
  always #5 clk = ~clk;

  clk_div u_clk_div(
      .clk(clk),
      .rst_n(rst),
      .clk_100hz(clk_100),
      .clk_25mhz(clk_25)
  );

  initial begin
    clk = 0;
    rst = 0;
    #25;
    rst = 1;
    #1000;
    $finish;
  end

endmodule
