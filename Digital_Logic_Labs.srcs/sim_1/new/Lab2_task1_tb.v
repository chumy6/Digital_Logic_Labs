`timescale 1ns / 1ns
//Lab2: task1: 序列检测

module Lab2_task1_tb();
    
    reg clk,rst_n,data_in;
    wire detector;
    
    always #5 clk = ~clk;
    
//    seq_detect u_seq_detect(
//        .clk(clk),
//        .rst_n(rst_n),
//        .data_in(data_in),
//        .detector(detector)
//    );
    
    seq_detect_overlap u_seq_detect_overlap(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .detector(detector)
    );
    
    initial begin
        clk = 0; //必须有，否则时钟一直为X
        rst_n = 1;
        data_in = 0;
        #20;
        rst_n = 0;
        #20;
        rst_n = 1;
        //test sequence
        #10 data_in = 1;
        #100 data_in =0;
        #100 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =1;
        #10 data_in =1;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =0;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =1;
        #10 data_in =0;
        #10 data_in =1;
        #10 data_in =0;
        #500;
        $finish;
    end

endmodule
