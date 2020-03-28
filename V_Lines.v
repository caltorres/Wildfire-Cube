`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: V_Lines.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module V_Lines(
    input clk,
    output v_lines
    ); 
    
    wire DW; 
    wire UP;
    wire LD;
    wire [15:0]Xcoordinate;
    wire [15:0]Ycoordinate;
    wire XcoordinateUTC;
    wire YcoordinateUTC;
    wire DTC;
    
    HorizontalCounter   XcoorBlue (.clk(clk),.UP(UP),.reset(YcoordinateUTC|XcoordinateUTC),.DW(DW),.LD(LD),.Xcoordinate(Xcoordinate),.XcoordinateUTC(XcoordinateUTC),.DTC(DTC));
    VerticalCounter     ycoorBlue (.clk(clk),.UP(XcoordinateUTC),.reset(YcoordinateUTC),.DW(DW),.LD(LD),.Ycoordinate(Ycoordinate),.YcoordinateUTC(YcoordinateUTC),.DTC(DTC)); 
    
    assign UP = 1'b1;

    wire vline0;
    wire vline1;
    wire vline2;
    wire vline3;
    wire vline4;
    wire vline5;
    wire vline6;
    wire [7:0]length;
    wire [7:0]final_length;
    
    assign vline0 = ((Xcoordinate >= 10'd158  )&(Xcoordinate <= 10'd166  )&(Ycoordinate >= 10'd9  )&(Ycoordinate < 10'd471));    
    assign vline1 = ((Xcoordinate >= 10'd208  )&(Xcoordinate <= 10'd216  )&(Ycoordinate >= 10'd9  )&(Ycoordinate < 10'd471)); 
    assign vline2 = ((Xcoordinate >= 10'd258  )&(Xcoordinate <= 10'd266  )&(Ycoordinate >= 10'd9  )&(Ycoordinate < 10'd471));
    assign vline3 = ((Xcoordinate >= 10'd308  )&(Xcoordinate <= 10'd316  )&(Ycoordinate >= 10'd9  )&(Ycoordinate < 10'd471));
    assign vline4 = ((Xcoordinate >= 10'd358  )&(Xcoordinate <= 10'd366  )&(Ycoordinate >= 10'd9  )&(Ycoordinate < 10'd471));
    assign vline5 = ((Xcoordinate >= 10'd408  )&(Xcoordinate <= 10'd416  )&(Ycoordinate >= 10'd9  )&(Ycoordinate < 10'd471));
    assign vline6 = ((Xcoordinate >= 10'd458  )&(Xcoordinate <= 10'd466  )&(Ycoordinate >= 10'd9  )&(Ycoordinate < 10'd471));
    
    assign v_lines = vline0|vline1|vline2|vline3|vline4|vline5|vline6;  
       
endmodule
