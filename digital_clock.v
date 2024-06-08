`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 11:09:42
// Design Name: 
// Module Name: digital_clock
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

module digital_clock(
    input clk,
    input reset,
    input hup,
    input mup,
    input stw,
    output [3:0] an,
    output [6:0] seg,
    input [4:0] almhr,
    output reg [5:0] sec,
    input swreset,
    input swstart,
    input almmup,
    input almset,
    input almen,
    input almstop,
    input snooze,
    output reg almled,
    output reg almy,   
    input tmren,
    input tmrset,     
    input tsec,
    input tmin,
    input tmrreset  
    );
    
//  parameters

wire clkdvd,t1,t2,t3,t4,t5,finalreset;
    clkdvd myclk(.clk(clk),.clkout(clkdvd));
    reg [3:0]sec_ones;
    reg [3:0]sec_tens;
    reg [3:0]min_ones;
    reg [3:0]min_tens;
    reg [3:0]hr_ones;
    reg [3:0]hr_tens;
    reg [3:0] clr_sec;
    reg [3:0] clr_min;
    reg [3:0] clr_hr;
    wire [5:0] almhrset;
    wire [5:0] almminset;
    reg [3:0] disp_1;
    reg [3:0] disp_2;
    reg [3:0] disp_3;
    reg [3:0] disp_4;
    reg [5:0] tsecc;
    reg [5:0] tminc;
    wire [3:0]tso;
    wire [3:0]tst;
    wire [3:0]tmt;
    wire [3:0]tmo;
    wire [3:0] reg_d0, reg_d1, reg_d2, reg_d3;
    stopwatch sw1(clk,swreset,swstart,reg_d0, reg_d1, reg_d2, reg_d3);
    timer tmr(clk,tmrset,tsec,tmin,tmrreset,tst,tso,tmt,tmo);
    alarm alm(clkdvd,almhr,almmup,almen,almhrset,almminset,almset,snooze);
//seconds
    always@(posedge clkdvd)
    begin
	   if(reset | clr_sec)begin
	   sec_ones <= 0;
	   sec_tens<=0;
	   clr_sec<=0;
	   sec<=0;
	   end
	   else begin
	   if(sec_ones<9)begin
	   sec_ones <= sec_ones + 1;
	   sec<=sec+1;
	   end
	   else if(sec_ones==9 & sec_tens<5)begin
	   sec_tens<=sec_tens+1;
	   sec_ones<=0;
	   sec<=sec+1;
	   end
    clr_sec = ((sec_ones == 9)&(sec_tens==5));
    end
    end
    
//	  mintues 
    always@(posedge clkdvd)
    begin
	   if(reset | clr_min) begin
	   min_ones <= 0;
	   min_tens<=0;
	   clr_min<=0;
	   end
	   else if(clr_sec | mup)begin
	   if(min_ones<9)begin
	   min_ones <= min_ones + 1;
	   end
	   else if(min_ones==9 & min_tens<5)begin
	   min_tens<=min_tens+1;
	   min_ones<=0;
	   end
    clr_min = ((min_ones == 9)&(min_tens==5));
    end
    end
    
//    hours
    always@(posedge clkdvd)
    begin
	   if(reset | clr_hr)begin
	   hr_ones <= 0;
	   hr_tens<=0;
	   clr_hr<=0;
	   end
	   else if(clr_min | hup)begin
	   if(hr_ones<9)hr_ones <= hr_ones + 1;
	   else if(hr_ones==9 & hr_tens<2)begin
	   hr_tens<=hr_tens+1;
	   hr_ones<=0;
	   end
    clr_hr = ((hr_ones == 3)&(hr_tens==2)) ;
    end
     end

always @(posedge clkdvd)begin
if(hr_ones==almhrset%10 & hr_tens==almhrset/10 & min_ones==almminset%10 & min_tens==almminset/10 & almset & almstop==0)almled<=~almled;
else almled<=0;
if(almset)almy<=1;
else if(almset==0)almy<=0;
end
//7-segment display
always @(*) begin
    if (stw) begin
      disp_4=reg_d3;
      disp_3=reg_d2;
      disp_2=reg_d1;
      disp_1=reg_d0;
   end
   else if (tmren)begin
        disp_4=tmt;
        disp_3=tmo;
        disp_2=tst;
        disp_1=tso;
        end
   else if (almen) begin
      disp_4=almhrset/10;
      disp_3=almhrset%10;
      disp_2=almminset/10;
      disp_1=almminset%10;
      end
      else begin
      disp_4=hr_tens;
      disp_3=hr_ones;
      disp_2=min_tens;
      disp_1=min_ones;
      end
      
   end  
sevenseg_driver seg7(clk,1'b0,disp_4,disp_3,disp_2,disp_1,seg,an);
endmodule