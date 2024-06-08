`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:47:45
// Design Name: 
// Module Name: test
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


module Decoder_7_segment(
     input [3:0] in,
     output reg [6:0]seg
    );
// Cathode patterns of the 7-segment LED display 
always @(in)
begin
    case(in)
    1: seg = 7'b1001111;
    2: seg = 7'b0010010;
    3: seg = 7'b0000110;
    4: seg = 7'b1001100;
    5: seg = 7'b0100100;
    6: seg = 7'b0100000;
    7: seg = 7'b0001111;
    8: seg = 7'b0000000;
    9: seg = 7'b0001100;
    default: seg = 7'b0000001; 
    endcase
end
endmodule

module binarytoBCD(
	input [11:0] binary,
	output reg [3:0]tens, 
	output reg [3:0]ones);

reg [11:0] bcd_data=0;

	always @(binary)
	begin

		bcd_data<=binary;
		tens<=bcd_data/10;
		ones<=bcd_data%10;

	end
endmodule
module sevenseg_driver(
	input clk,
	input clr,
	input [3:0] in1,
	input [3:0] in2,
	input [3:0] in3,
	input [3:0] in4,
	output reg [6:0] seg,
	output reg [3:0] an );

wire [6:0] seg1, seg2, seg3, seg4;
reg [12:0] segclk;

localparam LEFT=2'b00, MIDLEFT=2'b01, MIDRIGHT=2'b10, RIGHT=2'b11;
reg [1:0] state=LEFT;

always @(posedge clk)
segclk<=segclk+1'b1;

always @(posedge segclk[12] or posedge clr)
begin
if(clr==1)
	begin
	seg<=7'b0000000;
	an<=4'b0000;
	state<=LEFT;
end
else
	begin
		case(state)
			LEFT:
				begin 
				seg<=seg1;
				an<=4'b0111;
				state<=MIDLEFT;
				end
			MIDLEFT:
				begin
				seg <=seg2;
				an<=4'b1011;
				state<=MIDRIGHT;
				end
			MIDRIGHT:
				begin 
				seg <=seg3;
				an<=4'b1101;
				state<=RIGHT;
                end
			RIGHT:
				begin
				seg<=seg4;
				an<=4'b1110;
				state<=LEFT;
				end
		endcase
	end
end
Decoder_7_segment DS_1(in1,seg1);
Decoder_7_segment DS_2(in2,seg2);
Decoder_7_segment DS_3(in3,seg3);
Decoder_7_segment DS_4(in4,seg4);

endmodule