//lab4��ʱ��ģ�飬�����ֹ������ʱ����λ�����㡢��ͣ�Լ���ʱ�źŵȲ�����
module clock (
    input clk_100hz,          // 100Hzʱ������
    input clk,                // ʱ������
    input rst_n,              // ��λ�źţ�����Ч
    input sw_en,              // ����ʹ���ź�
    input pause,              // ��ͣ�ź�
    input clear,              // �����ź�
    output reg [2:0] time_sec_h,  // ��ĸ�λ��3λ��
    output reg [3:0] time_sec_l,  // ��ĵ�λ��4λ��
    output reg [3:0] time_msec_h, // ����ĸ�λ��4λ��
    output reg [3:0] time_msec_l, // ����ĵ�λ��4λ��
    output reg time_out          // ��ʱ�ź�
);

    // �洢�ڲ���ʵ��ʱ�ļĴ���
    reg [2:0] time_sec_h_reg;   // ��ĸ�λ�Ĵ���
    reg [3:0] time_sec_l_reg, time_msec_h_reg, time_msec_l_reg; // ���λ�������λ�ͺ����λ�Ĵ���

    // ��������λ��ʱ
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_l_reg <= 4'b0;  // ��λʱ�������λΪ0
        else if (clear) 
            time_msec_l_reg <= 4'b0;  // ����ʱ�������λΪ0
        else if (sw_en) 
            time_msec_l_reg <= (time_msec_l_reg == 4'd9) ? 4'd0 : time_msec_l_reg + 1;  // ����ʱ��������������Ϊ9
        else 
            time_msec_l_reg <= time_msec_l_reg; // ���򱣳�ԭֵ

    // ��������λ��ʱ
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_h_reg <= 4'b0;  // ��λʱ�������λΪ0
        else if (clear) 
            time_msec_h_reg <= 4'b0;  // ����ʱ�������λΪ0
        else if (sw_en && time_msec_l_reg == 4'd9)  // �������λΪ9ʱ�����������λ
            time_msec_h_reg <= (time_msec_h_reg == 4'd9) ? 4'd0 : time_msec_h_reg + 1;  // �����λ��Ϊ9��������
        else 
            time_msec_h_reg <= time_msec_h_reg; // ���򱣳�ԭֵ

    // �������λ��ʱ
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_l_reg <= 4'b0;  // ��λʱ�����λΪ0
        else if (clear) 
            time_sec_l_reg <= 4'b0;  // ����ʱ�����λΪ0
        else if (sw_en && time_msec_h_reg == 4'd9 && time_msec_l_reg == 4'd9)  // �������λ�͵�λ��Ϊ9ʱ�����λ����
            time_sec_l_reg <= (time_sec_l_reg == 4'd9) ? 4'd0 : time_sec_l_reg + 1;  // ������λΪ9��������
        else 
            time_sec_l_reg <= time_sec_l_reg; // ���򱣳�ԭֵ

    // �������λ��ʱ
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_h_reg <= 3'b0;  // ��λʱ�����λΪ0
        else if (clear) 
            time_sec_h_reg <= 3'b0;  // ����ʱ�����λΪ0
        else if (sw_en && time_sec_l_reg == 4'd9 && time_msec_h_reg == 4'd9 && time_msec_l_reg == 4'd9)  // ���λ�ͺ��붼Ϊ9ʱ�����λ����
            time_sec_h_reg <= (time_sec_h_reg == 3'd5) ? 3'd0 : time_sec_h_reg + 1;  // ������λΪ5��������
        else 
            time_sec_h_reg <= time_sec_h_reg; // ���򱣳�ԭֵ

    // ���Ĵ���ֵ���ݵ�����˿ڣ�������ʾ
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_l <= 4'b0;  // ��λʱ�������λΪ0
        else if (clear) 
            time_msec_l <= 4'b0;  // ����ʱ�������λΪ0
        else if (pause) 
            time_msec_l <= time_msec_l;  // ��ͣʱ�����ֵ�ǰֵ
        else 
            time_msec_l <= time_msec_l_reg;  // �������Ϊ�Ĵ�����ֵ

    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_msec_h <= 4'b0;  // ��λʱ�������λΪ0
        else if (clear) 
            time_msec_h <= 4'b0;  // ����ʱ�������λΪ0
        else if (pause) 
            time_msec_h <= time_msec_h;  // ��ͣʱ�����ֵ�ǰֵ
        else 
            time_msec_h <= time_msec_h_reg;  // �������Ϊ�Ĵ�����ֵ

    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_l <= 4'b0;  // ��λʱ�����λΪ0
        else if (clear) 
            time_sec_l <= 4'b0;  // ����ʱ�����λΪ0
        else if (pause) 
            time_sec_l <= time_sec_l;  // ��ͣʱ�����ֵ�ǰֵ
        else 
            time_sec_l <= time_sec_l_reg;  // �������Ϊ�Ĵ�����ֵ

    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_sec_h <= 3'b0;  // ��λʱ�����λΪ0
        else if (clear) 
            time_sec_h <= 3'b0;  // ����ʱ�����λΪ0
        else if (pause) 
            time_sec_h <= time_sec_h;  // ��ͣʱ�����ֵ�ǰֵ
        else 
            time_sec_h <= time_sec_h_reg;  // �������Ϊ�Ĵ�����ֵ

    // ��ʱ�ź��ж�
    always @(posedge clk_100hz or negedge rst_n)
        if (~rst_n) 
            time_out <= 1'b0;  // ��λʱ����ʱ�ź�Ϊ0
        else if ((time_sec_h_reg == 5 && time_sec_l_reg == 9 && time_msec_h_reg == 9 && time_msec_l_reg == 9) || clear)
            time_out <= 1'b0;  // �����趨ʱ�䣬���㳬ʱ�ź�
        else if (time_sec_h_reg == 1 && time_sec_l_reg == 0 && time_msec_h_reg == 0 && time_msec_l_reg == 0)
            time_out <= 1'b1;  // �ﵽ��ʱʱ�䣬���ó�ʱ�ź�
        else 
            time_out <= time_out;  // ���򱣳�ԭֵ

endmodule
