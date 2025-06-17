//����FIFO����λ���ת��������8bit���3bit
//���ܣ�8����3�����fifo
// ʵ��˼·����8to8fifo�Ļ����ϣ������������Ϊ״̬��������

module FIFO_8_to_3(
    input   clk,
    input   rst_n,
    input   w_en,
    input   r_en,
    input   [7:0] data_w,
    
    output   full,
    output   empty,
    output   half_full,
    output   reg overflow,
    output reg  [2:0]   data_r
);
    //��дָ���Ϊ5bit��4bit����ָʾλreg�ĵ�ַ��MSB�����ж�����
    reg  [4:0] wr_ptr;
    reg  [4:0] rd_ptr;
    
    // 16��8biy�Ĵ��������ڴ洢fifo����
    reg [7:0] fifo_mem [0:15];
    
    // fifo���״̬���¸�״̬��״ֵ̬��Ӧ��ǰҪ�����3bit������8bit�Ĵ����Ĺ�ϵ��״ֵ̬��Ϊ��ǰҪ�������8bit�ڲ���λ�ã����ƶε�ַ��ƫ�Ƶ�ַ
    reg [2:0] read_state_cur,read_state_next;
    
    // ���״̬���룬ÿ3��8bit�ܹ�����3������3��8bit�Ĵ����У�ƫ�Ƶ�ַ��8�ֿ���ֵ����Ӧ8��״̬������ƫ�Ƶ�ַ��Ϊ״̬��
    // ״̬����������3��8bitΪһ�飬�������е�һ������ʾ�ڼ���8bit�Ĵ������ڶ�������ʾ����Ĵ����еڼ������ܵ����λ��
    parameter STATE1_1  = 3'b000;
    parameter STATE1_2  = 3'b011;
    parameter STATE1_3  = 3'b110; //���Խ����8bit
    parameter STATE2_1  = 3'b001;
    parameter STATE2_2  = 3'b100;
    parameter STATE2_3  = 3'b111; //���Խ����8bit
    parameter STATE3_1  = 3'b010;
    parameter STATE3_2  = 3'b101;
    
    
    // ���״̬Ǩ��
    always @(posedge clk or negedge rst_n) 
       if (~rst_n)
          read_state_cur <= STATE1_1;
       else if (r_en && ~empty)
          read_state_cur <= read_state_next;
       else 
          read_state_cur <= read_state_cur;
    
    // ���״̬ѡ��
    always @(*) 
       case(read_state_cur)
          STATE1_1: read_state_next = STATE1_2;
          STATE1_2: read_state_next = STATE1_3;
          STATE1_3: read_state_next = STATE2_1;
          STATE2_1: read_state_next = STATE2_2;
          STATE2_2: read_state_next = STATE2_3;
          STATE2_3: read_state_next = STATE3_1;
          STATE3_1: read_state_next = STATE3_2;
          STATE3_2: read_state_next = STATE1_1;
       endcase
    
    //write function
    always @(posedge clk)
        if(w_en && ~full)
           fifo_mem[wr_ptr[3:0]]<=data_w;
        else
           fifo_mem[wr_ptr[3:0]]<=fifo_mem[wr_ptr[3:0]];
    
     //wr_ptr
    always @(posedge clk or negedge rst_n)
        if(!rst_n)
           wr_ptr<=0;
        else if(w_en && ~full) // дʹ����û����ʱ����д
           wr_ptr<=wr_ptr+1;
        else
           wr_ptr<=wr_ptr;
     
    //read function 
    // ���ε�ַrd_ptr��ƫ�Ƶ�ַ����ǰ���״̬��read_state_cer��������õ���ǰҪ�����3bit���ݣ���������������£�3bit�ֱ�λ������8bit�Ĵ����У���Ҫ�ֱ�ȡֵȻ��ƴ��
    // �Ĵ�����ѡ��һ������ʱ�������ñ�����Ϊ����
    always @(posedge clk or negedge rst_n)
        if(!rst_n)
           data_r<=3'b0;
        else if(r_en && ~empty)
           case(read_state_cur) // ע�⣺������ĳ�����ö����λ����Ϊ�����ֽ�λ�����ܲ�ȷ������x
              STATE1_1: data_r <= fifo_mem[rd_ptr[3:0]][STATE1_1+3'd2:STATE1_1];
              STATE1_2: data_r <= fifo_mem[rd_ptr[3:0]][STATE1_2+3'd2:STATE1_2];
              STATE1_3: data_r <= {fifo_mem[rd_ptr[3:0]+4'd1][0],fifo_mem[rd_ptr[3:0]][7:STATE1_3]};
              STATE2_1: data_r <= fifo_mem[rd_ptr[3:0]][STATE2_1+3'd2:STATE2_1];
              STATE2_2: data_r <= fifo_mem[rd_ptr[3:0]][STATE2_2+3'd2:STATE2_2];
              STATE2_3: data_r <= {fifo_mem[rd_ptr[3:0]+4'd1][1:0],fifo_mem[rd_ptr[3:0]][STATE2_3]};
              STATE3_1: data_r <= fifo_mem[rd_ptr[3:0]][STATE3_1+3'd2:STATE3_1];
              STATE3_2: data_r <= fifo_mem[rd_ptr[3:0]][STATE3_2+3'd2:STATE3_2];
           endcase
        else
           data_r<=3'bzzz;
    
    //read_ptr
    // �����rd_ptr�Ƕε�ַ��ֻ�з���3bit�ֱ�λ������8bitʱ�Ż�仯��ǡ�ö�������3��3��8bitʱҲ��仯���ʽ�����Щ����¸ı�rd_ptr
    always @(posedge clk or negedge rst_n)
        if(!rst_n)
           rd_ptr<=0;
        else if(r_en && ~empty) // ��ʹ����û�п�ʱ���Զ� 
           case(read_state_cur)
              STATE1_3: rd_ptr <= rd_ptr+1;
              STATE2_3: rd_ptr <= rd_ptr+1;
              STATE3_2: rd_ptr <= rd_ptr+1;
              default: rd_ptr <= rd_ptr;
           endcase
        else
           rd_ptr<=rd_ptr;
    
    //�п�
    //������3bitʱ���������Ҳ��գ���������Ͽ�Խ����8bit�������������
    assign  empty=(rd_ptr[4:0] == wr_ptr[4:0]) || ((wr_ptr[4:0] == (rd_ptr[4:0]+1)) && (read_state_cur == STATE1_3)) || ((wr_ptr[4:0] == (rd_ptr[4:0]+1)) && (read_state_cur == STATE2_3));
    
    //������������
    assign  full=(rd_ptr[4] ^ wr_ptr[4]) && (rd_ptr[3:0]==wr_ptr[3:0]);
    
    //�а���
    //ԭ�������������8bit����û��ʣ�������
    assign  half_full=(((wr_ptr>rd_ptr)? (wr_ptr-rd_ptr):(rd_ptr-wr_ptr))==5'd8)&&(read_state_cur == STATE1_1);
    //overflow
    //�����������
    always @(posedge clk or negedge rst_n)
        if(!rst_n)
           overflow<=0;
        else if (w_en & full)
           overflow<=1;
        else
           overflow<=0;
           
endmodule
