`timescale 1ns / 1ns

module posedge_detect(
    input   CLK,
    input   RST,
    input   btn,	
	output  pos_edge   
);
    reg[1:0]   D;     
    always @(posedge CLK or negedge RST)begin
	    if(~RST)begin
            D <= 2'b00;
	    end else  begin
	        D <= {D[0],btn};  	//移位寄存器
	    end
	end

    // 当 D[1] 为 0（表示 btn 的前一时刻是低电平），而 D[0] 为 1（表示当前 btn 是高电平）
    // 即发生了从低电平到高电平的过渡时，pos_edge 会被置为 1，表示 btn 信号发生了上升沿。
	assign  pos_edge = ~D[1] & D[0];  //pos_edge 由 D[1] 和 D[0] 的组合判断
	
endmodule