`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2024 09:50:32
// Design Name: 
// Module Name: tmr
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

module timer(
    input clk,      
    input en,     
    input seconds,
    input minutes,  
    input tmrreset,
    output wire [3:0] sec_tens,
    output wire [3:0] sec_ones,
    output wire [3:0] min_tens,
    output wire [3:0] min_ones              
);
wire clkdvd;
clkdvd c(clk,clkdvd);
reg [5:0] tmrs;
reg [5:0] tmrm; 
always @(posedge clkdvd)begin
if(tmrreset)begin
tmrs<=0;
tmrm<=0;
end
else begin
if(en==0)begin
if(seconds)begin
if(tmrs<59)tmrs<=tmrs+1;
else if(tmrs==59)begin
tmrs<=0;
if(tmrm<59)tmrm<=tmrm+1;
else if(tmrm==59)tmrm<=0;
end
end
if(minutes)begin
if(tmrm<59)tmrm<=tmrm+1;
else if(tmrm==59)tmrm<=0;
end
end
else begin
if(tmrs>0)tmrs<=tmrs-1;
else if(tmrs==0)begin
if(tmrm>0)begin
tmrm<=tmrm-1;
tmrs<=59;
end
end
end
end
end
binarytoBCD secco(tmrs,sec_tens,sec_ones);
binarytoBCD minco(tmrm,min_tens,min_ones);
     
     endmodule