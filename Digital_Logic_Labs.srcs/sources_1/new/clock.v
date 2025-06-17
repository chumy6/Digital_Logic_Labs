//lab4：时钟模块，各部分功能如计时、复位、清零、暂停以及超时信号等操作。
module clock (
    input clk_100hz,          // 100Hz时钟输入
    input clk,                // 时钟输入
    input rst_n,              // 复位信号，低有效
    input sw_en,              // 开关使能信号
    input pause,              // 暂停信号
    input clear,              // 清零信号
    output reg [2:0] time_sec_h,  // 秒的高位（3位）
    output reg [3:0] time_sec_l,  // 秒的低位（4位）
    output reg [3:0] time_msec_h, // 毫秒的高位（4位）
    output reg [3:0] time_msec_l, // 毫秒的低位（4位）
    output reg time_out          // 超时信号
);

    // 存储内部真实计时的寄存器
    reg [2:0] time_sec_h_reg;   // 秒的高位寄存器
    reg [3:0] time_sec_l_reg, time_msec_h_reg, time_msec_l_reg; // 秒低位，毫秒高位和毫秒低位寄存器

    // 处理毫秒低位计时
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_l_reg <= 4'b0;  // 复位时，毫秒低位为0
        else if (clear) 
            time_msec_l_reg <= 4'b0;  // 清零时，毫秒低位为0
        else if (sw_en) 
            time_msec_l_reg <= (time_msec_l_reg == 4'd9) ? 4'd0 : time_msec_l_reg + 1;  // 启用时，按秒递增，最大为9
        else 
            time_msec_l_reg <= time_msec_l_reg; // 否则保持原值

    // 处理毫秒高位计时
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_h_reg <= 4'b0;  // 复位时，毫秒高位为0
        else if (clear) 
            time_msec_h_reg <= 4'b0;  // 清零时，毫秒高位为0
        else if (sw_en && time_msec_l_reg == 4'd9)  // 当毫秒低位为9时，递增毫秒高位
            time_msec_h_reg <= (time_msec_h_reg == 4'd9) ? 4'd0 : time_msec_h_reg + 1;  // 如果高位已为9，则清零
        else 
            time_msec_h_reg <= time_msec_h_reg; // 否则保持原值

    // 处理秒低位计时
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_l_reg <= 4'b0;  // 复位时，秒低位为0
        else if (clear) 
            time_sec_l_reg <= 4'b0;  // 清零时，秒低位为0
        else if (sw_en && time_msec_h_reg == 4'd9 && time_msec_l_reg == 4'd9)  // 当毫秒高位和低位都为9时，秒低位递增
            time_sec_l_reg <= (time_sec_l_reg == 4'd9) ? 4'd0 : time_sec_l_reg + 1;  // 如果秒低位为9，则清零
        else 
            time_sec_l_reg <= time_sec_l_reg; // 否则保持原值

    // 处理秒高位计时
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_h_reg <= 3'b0;  // 复位时，秒高位为0
        else if (clear) 
            time_sec_h_reg <= 3'b0;  // 清零时，秒高位为0
        else if (sw_en && time_sec_l_reg == 4'd9 && time_msec_h_reg == 4'd9 && time_msec_l_reg == 4'd9)  // 秒低位和毫秒都为9时，秒高位递增
            time_sec_h_reg <= (time_sec_h_reg == 3'd5) ? 3'd0 : time_sec_h_reg + 1;  // 如果秒高位为5，则清零
        else 
            time_sec_h_reg <= time_sec_h_reg; // 否则保持原值

    // 将寄存器值传递到输出端口，用于显示
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_l <= 4'b0;  // 复位时，毫秒低位为0
        else if (clear) 
            time_msec_l <= 4'b0;  // 清零时，毫秒低位为0
        else if (pause) 
            time_msec_l <= time_msec_l;  // 暂停时，保持当前值
        else 
            time_msec_l <= time_msec_l_reg;  // 否则更新为寄存器的值

    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_h <= 4'b0;  // 复位时，毫秒高位为0
        else if (clear) 
            time_msec_h <= 4'b0;  // 清零时，毫秒高位为0
        else if (pause) 
            time_msec_h <= time_msec_h;  // 暂停时，保持当前值
        else 
            time_msec_h <= time_msec_h_reg;  // 否则更新为寄存器的值

    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_l <= 4'b0;  // 复位时，秒低位为0
        else if (clear) 
            time_sec_l <= 4'b0;  // 清零时，秒低位为0
        else if (pause) 
            time_sec_l <= time_sec_l;  // 暂停时，保持当前值
        else 
            time_sec_l <= time_sec_l_reg;  // 否则更新为寄存器的值

    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_h <= 3'b0;  // 复位时，秒高位为0
        else if (clear) 
            time_sec_h <= 3'b0;  // 清零时，秒高位为0
        else if (pause) 
            time_sec_h <= time_sec_h;  // 暂停时，保持当前值
        else 
            time_sec_h <= time_sec_h_reg;  // 否则更新为寄存器的值

    // 超时信号判断
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_out <= 1'b0;  // 复位时，超时信号为0
        else if ((time_sec_h_reg == 5 && time_sec_l_reg == 9 && time_msec_h_reg == 9 && time_msec_l_reg == 9) || clear)
            time_out <= 1'b0;  // 超过设定时间，清零超时信号
        else if (time_sec_h_reg == 1 && time_sec_l_reg == 0 && time_msec_h_reg == 0 && time_msec_l_reg == 0)
            time_out <= 1'b1;  // 达到超时时间，设置超时信号
        else 
            time_out <= time_out;  // 否则保持原值

endmodule
