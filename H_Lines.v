`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: H_Lines.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module H_Lines(
   input clk,
   output h_lines
   ); 
   
   wire DW; 
   wire UP;
   wire LD;
   wire [15:0]sw;
   wire [15:0]Xcoordinate;
   wire [15:0]Ycoordinate;
   wire XcoordinateUTC;
   wire YcoordinateUTC;
   wire DTC;
   
   HorizontalCounter   XcoorBlue (.clk(clk),.UP(UP),.reset(YcoordinateUTC|XcoordinateUTC),.DW(DW),.LD(LD),.sw(sw),.Xcoordinate(Xcoordinate),.XcoordinateUTC(XcoordinateUTC),.DTC(DTC));
   VerticalCounter     ycoorBlue (.clk(clk),.UP(XcoordinateUTC),.reset(YcoordinateUTC),.DW(DW),.LD(LD),.sw(sw),.Ycoordinate(Ycoordinate),.YcoordinateUTC(YcoordinateUTC),.DTC(DTC)); 
   
   assign UP = 1'b1;

   wire hline0;
   wire hline1;
   wire hline2;
   wire hline3;
   wire hline4;
   wire hline5;
   wire hline6;
 
   assign hline0 = ((Xcoordinate > 10'd8 )&(Xcoordinate < 10'd631 )&(Ycoordinate >= 10'd78   )&(Ycoordinate <= 10'd86));    
   assign hline1 = ((Xcoordinate > 10'd8 )&(Xcoordinate < 10'd631 )&(Ycoordinate >= 10'd128  )&(Ycoordinate <= 10'd136)); 
   assign hline2 = ((Xcoordinate > 10'd8 )&(Xcoordinate < 10'd631 )&(Ycoordinate >= 10'd178  )&(Ycoordinate <= 10'd186));
   assign hline3 = ((Xcoordinate > 10'd8 )&(Xcoordinate < 10'd631 )&(Ycoordinate >= 10'd228  )&(Ycoordinate <= 10'd236));
   assign hline4 = ((Xcoordinate > 10'd8 )&(Xcoordinate < 10'd631 )&(Ycoordinate >= 10'd278  )&(Ycoordinate <= 10'd286));
   assign hline5 = ((Xcoordinate > 10'd8 )&(Xcoordinate < 10'd631 )&(Ycoordinate >= 10'd328  )&(Ycoordinate <= 10'd336));
   assign hline6 = ((Xcoordinate > 10'd8 )&(Xcoordinate < 10'd631 )&(Ycoordinate >= 10'd378  )&(Ycoordinate <= 10'd386));
   
   assign h_lines = hline0|hline1|hline2|hline3|hline4|hline5|hline6;  
   
endmodule