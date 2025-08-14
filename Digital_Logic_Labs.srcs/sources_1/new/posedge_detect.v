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
	        D <= {D[0],btn};  	//��λ�Ĵ���
	    end
	end

    // �� D[1] Ϊ 0����ʾ btn ��ǰһʱ���ǵ͵�ƽ������ D[0] Ϊ 1����ʾ��ǰ btn �Ǹߵ�ƽ��
    // �������˴ӵ͵�ƽ���ߵ�ƽ�Ĺ���ʱ��pos_edge �ᱻ��Ϊ 1����ʾ btn �źŷ����������ء�
	assign  pos_edge = ~D[1] & D[0];  //pos_edge �� D[1] �� D[0] ������ж�
	
endmodule