//lab1:part1
module ReLU(
    input wire clk,
    input wire rst_n,
    input out_en,
    input wire [7:0] input_data,
    output reg [7:0] output_data
);
    wire [7:0] cal_data; //assign只能赋值wire
    
    //assign 语句可以用于在组合逻辑中更新 cal_data，但无法直接用来更新 output_data，
    //因为 output_data 必须根据时钟的变化进行更新。
    assign cal_data = input_data[7] ? 8'b0 : input_data; //为什么不直接写这一句话就可以了？
    
    //设计目标是实现一个带时钟的 ReLU 模块，不仅仅是一个简单的组合逻辑。
    //output_data 的更新需要在时钟信号（clk）的控制下进行，因此必须使用 always 块来保证其时序行为。
    
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)
            output_data <= 8'b0;
        else begin
            if(out_en) //输出使能
                output_data <= cal_data;
            else
                output_data <= output_data; //保持不变
        end
    end

endmodule
