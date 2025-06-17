//lab1:part1
module ReLU(
    input wire clk,
    input wire rst_n,
    input out_en,
    input wire [7:0] input_data,
    output reg [7:0] output_data
);
    wire [7:0] cal_data; //assignֻ�ܸ�ֵwire
    
    //assign ����������������߼��и��� cal_data�����޷�ֱ���������� output_data��
    //��Ϊ output_data �������ʱ�ӵı仯���и��¡�
    assign cal_data = input_data[7] ? 8'b0 : input_data; //Ϊʲô��ֱ��д��һ�仰�Ϳ����ˣ�
    
    //���Ŀ����ʵ��һ����ʱ�ӵ� ReLU ģ�飬��������һ���򵥵�����߼���
    //output_data �ĸ�����Ҫ��ʱ���źţ�clk���Ŀ����½��У���˱���ʹ�� always ������֤��ʱ����Ϊ��
    
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)
            output_data <= 8'b0;
        else begin
            if(out_en) //���ʹ��
                output_data <= cal_data;
            else
                output_data <= output_data; //���ֲ���
        end
    end

endmodule
