`timescale 1ns / 1ns

module debounce#(
    parameter N=8 //等待的周期数
)(
    input CLK,
    input ButtonIn,
    output reg ButtonOut
);

    reg [N-1:0] ButtonBuffer;
    
    always@(posedge CLK)
    begin
        // 具有 N 位的寄存器，用来存储按钮的输入信号历史。
        // 按时钟边沿（posedge CLK）逐位向右移位，并将 ButtonIn 输入信号移到最低位。
        ButtonBuffer <= {ButtonBuffer[N-2:0],ButtonIn};
        
        if (&ButtonBuffer == 1) begin
            ButtonOut <= 1; //即按钮一直按下
        end else if (|ButtonBuffer == 0)begin
            ButtonOut <= 0;
        end
    end
    
endmodule

