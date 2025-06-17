//Lab3
module FIFO(
    input clk,
    input rst_n,
    input w_en, //��ʹ��
    input r_en, //дʹ��
    input [7:0] data_w,
    output full,  //����־
    output empty, //�ձ�־
    output half_full, //������־
    output reg overflow, //�����־
    output reg [7:0] data_r
);
           
    //��дָ��
    //N=2^n��FIFO���ַ��λ��Ϊn�����д��ַ��λ��ҲΪn
    //16=2^4
    reg [4:0] wr_ptr;
    reg [4:0] rd_ptr;
           
    //wr_ptr
    always @(posedge clk or negedge rst_n)
       if(!rst_n)
           wr_ptr <= 0;
       else if(w_en && ~full)
           wr_ptr <= wr_ptr + 1;
       else
           wr_ptr <= wr_ptr;
           
    //read_ptr
    always @(posedge clk or negedge rst_n)
       if(!rst_n)
           rd_ptr <= 0;
       else if(r_en && ~empty)
           rd_ptr <= rd_ptr + 1;
       else
           rd_ptr <= rd_ptr;
       
    // empty
    assign empty = (rd_ptr[4:0] == wr_ptr[4:0]); //��ָ�����дָ��ʱΪ��
    
    // full
    assign full = (rd_ptr[4] ^ wr_ptr[4]) && (rd_ptr[3:0] == wr_ptr[3:0]);//ָ�����λ��ͬ��ʣ��λ��ͬ����ʱ����֮��ǡ��װ�˵����������������
       
    //half-full
    //�洢8������Ϊ��������дָ�����ָ��֮���8
    //��Ϊѭ�����У���дָ���С��ϵ��һ���������������Ӱ���жϣ���Ҫ��֤�Ǵ��С
    assign half_full = (((wr_ptr>rd_ptr)?(wr_ptr - rd_ptr):(rd_ptr - wr_ptr)) == 5'd8);
      
    //overflow
    always @(posedge clk or negedge rst_n)
       if(!rst_n)
           overflow <= 0;
       else if(w_en & full)
           overflow <= 1;
       else
           overflow <= 0;
           
     reg [7:0] fifo_mem [0:15];  //���Ϊ16��λ��Ϊ8
    
    //write function
    always @(posedge clk)
        if(w_en && ~full)
            fifo_mem[wr_ptr[3:0]] <= data_w;  //Ϊʲô��wr_ptr[3:0]��
        else
            fifo_mem[wr_ptr[3:0]] <= fifo_mem[wr_ptr[3:0]];
            
    //read function
    always @(posedge clk or negedge rst_n)
       if(!rst_n)
           data_r <= 8'bzzzzzzzz;
       else if (r_en && ~empty)
           data_r <= fifo_mem[rd_ptr[3:0]];
       else
           data_r <= 8'bzzzzzzzz;
            
endmodule
