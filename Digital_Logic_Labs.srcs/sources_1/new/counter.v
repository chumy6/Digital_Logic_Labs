//lab1:part1
module counter#(
    parameter threshold = 100 //计数100次后输出out_en
)(
    input wire clk,
    input rst_n, 
    output reg out_en  //always块内赋值的信号应该为reg
);
    //$clog2()用于计算一个数字的对数值，返回的是一个大于或等于该值的二进制对数（以 2 为底）
    localparam log_threshold = $clog2(threshold);
    
    reg [log_threshold - 1 : 0] counter;
    
    always @ (posedge clk or negedge rst_n) begin
        if(rst_n)
            if(counter < threshold - 1)
                counter <= counter + 1; //时序逻辑非阻塞赋值
            else 
                counter <= {log_threshold{1'b0}}; //这一句什么意思？
        else
            //将 1'b0（一个位宽为 1 的二进制 0）重复 log_threshold 次，
            //构造一个宽度为 log_threshold 的值
            counter <= {log_threshold{1'b0}};
    end
    
    always @(*) begin
        if(counter == threshold - 1)
            out_en = 1'b1;  //组合逻辑用阻塞赋值
        else
            out_en = 1'b0;
    end

endmodule