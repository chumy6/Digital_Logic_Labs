//Lab2: task2: ������
//ʵ������״̬��
module Lab2_task2(
    input clk,
    input rst_n,
    input data_in,
    output [2:0] data_out
);
    //state definition
    localparam zero  = 3'b000; //����Ϊ0
    localparam one   = 3'b001; //����Ϊ1
    localparam two   = 3'b010; //����Ϊ2
    localparam three = 3'b011; //����Ϊ3
    localparam four  = 3'b100; //����Ϊ4
    localparam five  = 3'b101; //����Ϊ5
    localparam six   = 3'b110; //����Ϊ6
    
    //state reg
    reg [2:0] state_cur,state_next;
    
    //data reg
    reg [15:0] data;
    
    //state transfer
    always @(posedge clk or negedge rst_n) begin
        if(~clk)
            state_cur <= zero;
        else
            state_cur <= state_next;
    end
    //16bit register
    always @(posedge clk or negedge rst_n) begin
        if(~clk)
            data <= 16'd0;
        else
            data <= {data[14:0],data_in}; //ͨ��λƴ��ʵ����λ
    end
    
    //state switch
    always @(*) begin
        if(~data[15]) begin  //���λΪ0ʱ��״̬��
            case(state_cur)
                zero : state_next = (data_in) ? one   : zero;
                one  : state_next = (data_in) ? three : two;
                two  : state_next = (data_in) ? five  : four;
                three: state_next = (data_in) ? zero  : six;
                four : state_next = (data_in) ? two   : one;
                five : state_next = (data_in) ? four  : three;
                six  : state_next = (data_in) ? six   : five;
                default: state_next = zero;
            endcase
        end
        else begin //���λΪ1ʱ��״̬��
            case(state_cur)
                zero : state_next = (data_in) ? six   : five;
                one  : state_next = (data_in) ? one   : zero;
                two  : state_next = (data_in) ? three : two;
                three: state_next = (data_in) ? five  : four;
                four : state_next = (data_in) ? zero  : six;
                five : state_next = (data_in) ? two   : one;
                six  : state_next = (data_in) ? four  : three;
                default: state_next = zero;
           endcase     
        end
    end
    
    //output
    assign data_out = state_cur; //״̬����ǵ�ǰ������

endmodule
