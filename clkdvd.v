`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2024 12:49:30
// Design Name: 
// Module Name: clkdvd
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

module clkdvd(
input clk,
output reg clkout
);
reg [25:0] count;//an internal register just like a variable
always@(negedge clk) //responding to the posedge of the clock
begin
count <=count + 1;
if (count == 50000000)
begin
clkout <= ~ clkout;//change of state fo clock every 0.5s
count <= 0;
end
end
endmodule

