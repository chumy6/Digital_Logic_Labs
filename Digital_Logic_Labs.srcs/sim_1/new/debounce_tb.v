`timescale 1ns / 1ns

module debounce_tb();

    reg CLK;
    reg ButtonIn;
    wire ButtonOut;
    
    debounce #(.N(8)) uut_debounce (
        .CLK(CLK),
        .ButtonIn(ButtonIn),
        .ButtonOut(ButtonOut)
    );
    
    always #5 CLK=~CLK;
    
    initial begin
        CLK <= 0;
        ButtonIn <= 0;
        #402;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #400;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
         ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #4;
        ButtonIn <= 1;
        #4;
        ButtonIn <= 0;
        #700;        
    end
    
endmodule
