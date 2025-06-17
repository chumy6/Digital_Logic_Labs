`timescale 1ns / 1ns

module Lab1_task2_tb();
    localparam clock_period = 10;
    
    reg clk_in, rst_n_in;
    
    wire q_out;
    
    always #(clock_period / 2) clk_in = ~clk_in;
    
    Lab1_task2 u_Lab1_task2(
        .clk(clk_in),
        .rst_n(rst_n_in),
        .q(q_out)
    );
    
    initial begin
        clk_in = 0;
        rst_n_in = 1;
        #10;
        rst_n_in = 0; //低电平有效
        #10;
        rst_n_in = 1;
    end

endmodule
