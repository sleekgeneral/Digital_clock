`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2024 12:30:27
// Design Name: 
// Module Name: tff
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module clkDivider(input clk, output reg clkOut);
reg [25:0] count;
always @(negedge clk)
begin
    count <= count + 1;
    if (count == 50000000)
    begin
        clkOut <= ~clkOut;
        count <=0;
    end
end
endmodule
module tenhzclk(input clk, output reg clkOut);
reg [25:0] count;
always @(negedge clk)
begin
    count <= count + 1;
    if (count == 2500000)
    begin
        clkOut <= ~clkOut;
        count <=0;
    end
end
endmodule

module jkff(
    input j,
    input k,
    input clr,
    input clk,
    output reg q
    );
    always@(negedge clk, posedge clr)
    begin
    if(clr|(~j&k))
    begin
     q<=0;
    end
    else if(j&~k)
    begin
        q<=1;
    end
    else if(~j&~k)
    begin
        q<=q;
    end
    else
    begin
        q<=~q;
    end
    end
endmodule

