// lab4: ��Ƶ��
module clk_div (
    input rst_n,         // ��λ�źţ�����Ч
    input clk,           // ����ʱ���ź�
    output reg clk_100hz,  // ��� 100Hz ʱ���ź�
    output reg clk_25mhz   // ��� 25MHz ʱ���ź�
);

    parameter DIV_CNT = 16'd50000;  // ��Ƶ������������ֵ�����ڿ������ʱ��Ƶ��

    reg [19:0] cnt;  // ����20λ������

    // ��Ƶ���������������ɲ�ͬƵ�ʵ�ʱ��
    always @(posedge clk or negedge rst_n)  // ÿ��ʱ�������ػ�λ�ź��½��ش���
        if (~rst_n)  // �����λ�ź���Ч���͵�ƽ��������������
            cnt <= 19'b0;
        else if (cnt == DIV_CNT)  // ����������ﵽ�趨��DIV_CNTֵ
            cnt <= 19'd1;  // ���ü�����Ϊ1
        else 
            cnt <= cnt + 1'b1;  // �����������1

    // ����100Hz��ʱ���ź�
    always @(posedge clk or negedge rst_n)  // ÿ��ʱ�������ػ�λ�ź��½��ش���
        if (~rst_n)  // �����λ�ź���Ч�����100Hzʱ���ź�Ϊ0
            clk_100hz <= 1'b0;
        else if (cnt == DIV_CNT)  // ���������ﵽDIV_CNTʱ����ת100Hzʱ���ź�
            clk_100hz <= ~clk_100hz;  // ���ʱ���ź�ȡ��
        else
            clk_100hz <= clk_100hz;  // ���򱣳ֵ�ǰ״̬

    // ����25MHz��ʱ���ź�
    always @(posedge clk or negedge rst_n)  // ÿ��ʱ�������ػ�λ�ź��½��ش���
        if (~rst_n)  // �����λ�ź���Ч�����25MHzʱ���ź�Ϊ0
            clk_25mhz <= 1'b0;
        else if ((cnt[0] == 1'b0) && cnt)  // �������������λΪ0�Ҽ�������Ϊ0ʱ����ת25MHzʱ���ź�
            clk_25mhz <= ~clk_25mhz;  // ���ʱ���ź�ȡ��
        else 
            clk_25mhz <= clk_25mhz;  // ���򱣳ֵ�ǰ״̬

endmodule
