`timescale 1ns / 1ns

module debounce#(
    parameter N=8 //�ȴ���������
)(
    input CLK,
    input ButtonIn,
    output reg ButtonOut
);

    reg [N-1:0] ButtonBuffer;
    
    always@(posedge CLK)
    begin
        // ���� N λ�ļĴ����������洢��ť�������ź���ʷ��
        // ��ʱ�ӱ��أ�posedge CLK����λ������λ������ ButtonIn �����ź��Ƶ����λ��
        ButtonBuffer <= {ButtonBuffer[N-2:0],ButtonIn};
        
        if (&ButtonBuffer == 1) begin
            ButtonOut <= 1; //����ťһֱ����
        end else if (|ButtonBuffer == 0)begin
            ButtonOut <= 0;
        end
    end
    
endmodule

