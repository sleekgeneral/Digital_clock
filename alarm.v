`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2024 12:09:19
// Design Name: 
// Module Name: alarm
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


module alarm(
    input clk,
    input [4:0] almhr,
    input almmup,
    input almen,
    output reg[5:0] hr,
    output reg[5:0] min,
    input en,
    input snooze
    );
    always @(posedge clk)begin
    if(almmup & en==0)begin
    if(min<59)min<=min+1;
    else if(min==59 & hr<23)begin
    min<=0;
    hr<=hr+1;
    end
    else if(min==59 & hr==23) begin
    min<=0;
    hr<=0;
    end
    end
    if(en==0)begin
    hr<=almhr%24;
    end
    else if(en & snooze)begin
    if(min<54)min<=min+5;
    else if(min==55 & hr<23)begin
    min<=0;
    hr<=hr+1;
    end
    else if(min==55 & hr==23) begin
    min<=0;
    hr<=0;
    end
    end
    end
endmodule
