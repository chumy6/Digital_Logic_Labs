// lab4: 分频器
module clk_div (
    input rst_n,         // 复位信号，低有效
    input clk,           // 输入时钟信号
    output reg clk_100hz,  // 输出 100Hz 时钟信号
    output reg clk_25mhz   // 输出 25MHz 时钟信号
);

    parameter DIV_CNT = 16'd50000;  // 分频计数器的上限值，用于控制输出时钟频率

    reg [19:0] cnt;  // 定义20位计数器

    // 分频计数器，用于生成不同频率的时钟
    always @(posedge clk or negedge rst_n)  // 每次时钟上升沿或复位信号下降沿触发
        if (~rst_n)  // 如果复位信号有效（低电平），计数器清零
            cnt <= 19'b0;
        else if (cnt == DIV_CNT)  // 如果计数器达到设定的DIV_CNT值
            cnt <= 19'd1;  // 重置计数器为1
        else 
            cnt <= cnt + 1'b1;  // 否则计数器加1

    // 生成100Hz的时钟信号
    always @(posedge clk or negedge rst_n)  // 每次时钟上升沿或复位信号下降沿触发
        if (~rst_n)  // 如果复位信号有效，输出100Hz时钟信号为0
            clk_100hz <= 1'b0;
        else if (cnt == DIV_CNT)  // 当计数器达到DIV_CNT时，翻转100Hz时钟信号
            clk_100hz <= ~clk_100hz;  // 输出时钟信号取反
        else
            clk_100hz <= clk_100hz;  // 否则保持当前状态

    // 生成25MHz的时钟信号
    always @(posedge clk or negedge rst_n)  // 每次时钟上升沿或复位信号下降沿触发
        if (~rst_n)  // 如果复位信号有效，输出25MHz时钟信号为0
            clk_25mhz <= 1'b0;
        else if ((cnt[0] == 1'b0) && cnt)  // 当计数器的最低位为0且计数器不为0时，翻转25MHz时钟信号
            clk_25mhz <= ~clk_25mhz;  // 输出时钟信号取反
        else 
            clk_25mhz <= clk_25mhz;  // 否则保持当前状态

endmodule
