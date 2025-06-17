`timescale 1ns / 1ns
//测试relu和counter
module Lab1_tb();
    localparam clock_period = 10;
    localparam counter_threshold = 120;  //1200ns
    
    reg clk_reg;
    reg reset_n_reg;
    wire out_en;
    reg [7:0] relu_input_data;
    wire [7:0] relu_output_data;
    
    always #(clock_period / 2) clk_reg = ~clk_reg;
    
    counter#(
        .threshold(counter_threshold)
    ) u_counter(
        .clk(clk_reg),
        .rst_n(reset_n_reg), 
        .out_en(out_en)  //always块内赋值的信号应该为reg
    );
    
     ReLU u_ReLU(
        .clk(clk_reg),
        .rst_n(reset_n_reg),
        .out_en(out_en),
        .input_data(relu_input_data),
        .output_data(relu_output_data)
    );
    
    initial begin
        clk_reg = 0;
        reset_n_reg = 0;
        relu_input_data = 8'b10011010;
        #100;
        reset_n_reg = 1;
        #2200;
        relu_input_data = 8'b00101110;
        #3000;
        $finish;
    end
    
    
endmodule
