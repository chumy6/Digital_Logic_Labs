//Lab2: task1: –Ú¡–ºÏ≤‚
// detect the 101101 in the seqences(non-overlapping)
module seq_detect(
    input clk,
    input rst_n,
    input data_in,
    output detector
);
    localparam state_0 = 3'b000;
    localparam state_1 = 3'b001;
    localparam state_2 = 3'b010;
    localparam state_3 = 3'b011;
    localparam state_4 = 3'b100;
    localparam state_5 = 3'b101;
    
    reg [2:0] state_cur, state_next;
    
    always @ (posedge clk or negedge rst_n) begin
        if(!rst_n)
            state_cur <= state_0;
        else
            state_cur <= state_next;
    end
    
    always @(*) begin
        case(state_cur)
            state_0:
                if(data_in)
                    state_next = state_1;
                else
                    state_next = state_0;
            state_1:
                if(data_in)
                    state_next = state_1;
                else
                    state_next = state_2;
            state_2:
                if(data_in)
                    state_next = state_3;
                else
                    state_next = state_0;
            state_3:
                if(data_in)
                    state_next = state_4;
                else
                    state_next = state_2;
            state_4:
                if(data_in)
                    state_next = state_1;
                else
                    state_next = state_5;
            state_5:
                if(data_in)
                    state_next = state_1;
                else
                    state_next = state_0;       
            default: state_next = state_0;     
       endcase
    end
    
    assign detector = (state_cur == state_5) && data_in;
    
endmodule
