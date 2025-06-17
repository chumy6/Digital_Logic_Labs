//lab2: part1
// detect the 101101 in the seqences(overlapping
module seq_detect_overlap(
    input clk,
    input rst_n,
    input data_in,
    
    output detector
);
    //set state
    localparam state_0 = 3'b000;
    localparam state_1 = 3'b001;
    localparam state_2 = 3'b010;
    localparam state_3 = 3'b011;
    localparam state_4 = 3'b100;
    localparam state_5 = 3'b101;
    
    reg [2:0] state_cur, state_next;
    
    //state transfer
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)
            state_cur <= state_0;
        else
            state_cur <= state_next;
    end
    
    //state switch
    always @(*) begin
        case (state_cur)
            state_0: state_next = (data_in) ? state_1 : state_0;
            state_1: state_next = (data_in) ? state_1 : state_2;
            state_2: state_next = (data_in) ? state_3 : state_0;
            state_3: state_next = (data_in) ? state_4 : state_2;
            state_4: state_next = (data_in) ? state_1 : state_5;
            state_5: state_next = (data_in) ? state_3 : state_0; //与非重叠不同
            default: state_next = state_0;
        endcase
    end
    
    //output
    assign detector = (state_cur == state_5) && data_in;

endmodule
