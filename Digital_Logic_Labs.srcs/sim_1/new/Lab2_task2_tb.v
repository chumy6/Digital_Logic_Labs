`timescale 1ns / 1ns

module Lab2_task2_tb();
    reg clk,rst_n,data_in;
    wire [2:0] data_out;
    
    Lab2_task2 u_Lab2_task2(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    //���ڼĴ������ݲ���ģ�������˿ڣ���testbench�в���ֱ�ӵ���
    //����ģ��һ��ͬ���ļĴ������жϽ���Ƿ���ȷ
    reg [15:0] data_reg;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)
            data_reg <= 16'b0;
        else
            data_reg <= {data_reg[14:0],data_in};
    end
    
    integer i;
    initial begin
        clk = 0;
        rst_n = 1;
        data_in = 0;
        #20;
        rst_n = 0;
        #20;
        rst_n = 1;
        for (i=0; i<2000; i=i+1) begin
            #4;
            data_in = {$random}%(2'd2);  // ����0/1���
            #1; clk = ~clk; //������
            if(data_out != (data_reg % 3'd7))begin
                $display("Error: data_out = %d, data_reg = %d, i = %d", data_out,data_reg,i);
            end
            #5; clk = ~clk; //�½���   
        end
        $finish; 
    end
    
endmodule
