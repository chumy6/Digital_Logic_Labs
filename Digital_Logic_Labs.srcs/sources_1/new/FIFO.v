//Lab3
module FIFO(
    input clk,
    input rst_n,
    input w_en, //读使能
    input r_en, //写使能
    input [7:0] data_w,
    output full,  //满标志
    output empty, //空标志
    output half_full, //半满标志
    output reg overflow, //溢出标志
    output reg [7:0] data_r
);
           
    //读写指针
    //N=2^n的FIFO其地址的位宽为n，其读写地址的位宽也为n
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
    assign empty = (rd_ptr[4:0] == wr_ptr[4:0]); //读指针等于写指针时为空
    
    // full
    assign full = (rd_ptr[4] ^ wr_ptr[4]) && (rd_ptr[3:0] == wr_ptr[3:0]);//指针最高位不同而剩下位相同，此时两者之间恰好装了等于最大容量的数据
       
    //half-full
    //存储8个数据为半满，即写指针与读指针之间差8
    //因为循环队列，读写指针大小关系不一定，如果减出负数影响判断，需要保证是大减小
    assign half_full = (((wr_ptr>rd_ptr)?(wr_ptr - rd_ptr):(rd_ptr - wr_ptr)) == 5'd8);
      
    //overflow
    always @(posedge clk or negedge rst_n)
       if(!rst_n)
           overflow <= 0;
       else if(w_en & full)
           overflow <= 1;
       else
           overflow <= 0;
           
     reg [7:0] fifo_mem [0:15];  //深度为16，位宽为8
    
    //write function
    always @(posedge clk)
        if(w_en && ~full)
            fifo_mem[wr_ptr[3:0]] <= data_w;  //为什么是wr_ptr[3:0]？
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
