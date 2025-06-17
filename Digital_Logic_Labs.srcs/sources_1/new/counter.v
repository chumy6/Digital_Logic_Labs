//lab1:part1
module counter#(
    parameter threshold = 100 //����100�κ����out_en
)(
    input wire clk,
    input rst_n, 
    output reg out_en  //always���ڸ�ֵ���ź�Ӧ��Ϊreg
);
    //$clog2()���ڼ���һ�����ֵĶ���ֵ�����ص���һ�����ڻ���ڸ�ֵ�Ķ����ƶ������� 2 Ϊ�ף�
    localparam log_threshold = $clog2(threshold);
    
    reg [log_threshold - 1 : 0] counter;
    
    always @ (posedge clk or negedge rst_n) begin
        if(rst_n)
            if(counter < threshold - 1)
                counter <= counter + 1; //ʱ���߼���������ֵ
            else 
                counter <= {log_threshold{1'b0}}; //��һ��ʲô��˼��
        else
            //�� 1'b0��һ��λ��Ϊ 1 �Ķ����� 0���ظ� log_threshold �Σ�
            //����һ�����Ϊ log_threshold ��ֵ
            counter <= {log_threshold{1'b0}};
    end
    
    always @(*) begin
        if(counter == threshold - 1)
            out_en = 1'b1;  //����߼���������ֵ
        else
            out_en = 1'b0;
    end

endmodule