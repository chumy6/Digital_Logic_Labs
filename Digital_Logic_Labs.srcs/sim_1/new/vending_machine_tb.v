`timescale 1ns / 1ns

module vending_machine_tb();

    reg Enable;
    reg RST;
    reg CLK;
    reg OneDollar;
    reg FiftyCents;
    reg TenCents;
    reg FiveCents;
    wire Deliver;
    wire [7:0] Money;
    
    vending_machine uut_vending_machine (
        .Enable(Enable),
        .RST(RST),
        .CLK(CLK),
        .OneDollar(OneDollar),
        .FiftyCents(FiftyCents),
        .TenCents(TenCents),
        .FiveCents(FiveCents),
        .Deliver(Deliver),
        .Money(Money)
    );
    
    always #5 CLK=~CLK;
    
    initial begin
        CLK <= 0;
        RST <= 0;
        Enable <= 0;
        OneDollar <= 0;
        FiftyCents <= 0;
        TenCents <= 0;
        FiveCents <= 0;
        #100;
        RST <= 1;
        #30;
        OneDollar <= 1;
        #30;
        OneDollar <= 0;
        #20;
        Enable <= 1;
        #100;
        Enable <= 0;
        #20;
        OneDollar <= 1;
        #30;
        OneDollar <= 0;
        #100;
        FiftyCents <= 1;
        #30;
        FiftyCents <= 0;
        #50;
        Enable <= 1;
        #100;
        FiftyCents <= 1;
        #30;
        FiftyCents <= 0;
        #100;
        Enable <= 0;
        FiftyCents <= 1;
        #30;
        FiftyCents <= 0;
        #100;
        FiveCents <= 1;
        #30;
        FiveCents <= 0;
        #100;
        FiveCents <= 1;
        #30;
        FiveCents <= 0;
        #100;
        FiveCents <= 1;
        #30;
        FiveCents <= 0;
        #100;
        FiveCents <= 1;
        #30;
        FiveCents <= 0;
        #100;
        FiveCents <= 1;
        #30;
        FiveCents <= 0;
        #200;
    end
    
endmodule
