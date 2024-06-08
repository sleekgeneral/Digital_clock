`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 20:16:28
// Design Name: 
// Module Name: stw
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

module stopwatch(
    input clk,
    input reset,
    input start,
    output reg [3:0] reg_d0, reg_d1, reg_d2, reg_d3
    );

reg [22:0] ticker;
wire click,clkout;
tenhzclk clky(clk,clkout);
always @ (posedge clkout or posedge reset)
begin
 if(reset)
  ticker <= 0;
 else if(ticker) 
  ticker <= 0;
 else if(start) 
  ticker <= ticker + 1;
end

assign click = ((ticker)?1'b1:1'b0);
always @ (posedge clkout or posedge reset)
begin
 if (reset)
  begin
   reg_d0 <= 0;
   reg_d1 <= 0;
   reg_d2 <= 0;
   reg_d3 <= 0;
  end
  
 else if (click)
  begin
   if(reg_d0 == 9)
   begin  
    reg_d0 <= 0;
    
    if (reg_d1 == 9) 
    begin  
     reg_d1 <= 0;
     if (reg_d2 == 5)
     begin 
      reg_d2 <= 0;
      if(reg_d3 == 9) 
       reg_d3 <= 0;
      else
       reg_d3 <= reg_d3 + 1;
     end
     else 
      reg_d2 <= reg_d2 + 1;
    end
    
    else 
     reg_d1 <= reg_d1 + 1;
   end 
   
   else 
    reg_d0 <= reg_d0 + 1;
  end
end
endmodule


