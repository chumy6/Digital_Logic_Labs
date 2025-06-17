//lab1:part2 
//根据电路图写代码
//实际上是组合逻辑和时序逻辑的练习
module Lab1_task2(
    input clk,
    input rst_n,
    output q
);
    wire d1,d2,d3;
    wire q1,q2,q3;
    
    assign d1 = (~q1 & q2 & q3) | (q1 & ~q2) | (q1 & ~q3);
    assign d2 = (q2 ^ q3);
    assign d3 = ~q3;
    
    assign q = ~q3;
    
    D_ff u1_D_ff(
        .d(d1),
        .clk(clk),
        .rst_n(rst_n),
        .q(q1)
    );
    
    D_ff u2_D_ff(
        .d(d2),
        .clk(clk),
        .rst_n(rst_n),
        .q(q2)
    );
    
    D_ff u3_D_ff(
        .d(d3),
        .clk(clk),
        .rst_n(rst_n),
        .q(q3)
    );

endmodule
