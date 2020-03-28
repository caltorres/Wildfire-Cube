`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: HVsync.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module HVsync(
    input clk,
    input UP,
    
    output [15:0]Xcoordinate,
    output [15:0]Ycoordinate,
    output XcoordinateUTC,
    output YcoordinateUTC,
    
    output Hsyncsignal,
    output Vsyncsignal,
    output frame 
    ); 
    
    
    wire DW;
    wire LD;
    wire [15:0]sw;
    wire DTC;
    
    HorizontalCounter Xcood (.clk(clk),.UP(1'b1),.reset(YcoordinateUTC|XcoordinateUTC),.DW(DW),.LD(LD),.sw(sw),.Xcoordinate(Xcoordinate),.XcoordinateUTC(XcoordinateUTC),.DTC(DTC)); 
    VerticalCounter   Ycood (.clk(clk),.UP(XcoordinateUTC),.reset(YcoordinateUTC),.DW(DW),.LD(LD),.sw(sw),.Ycoordinate(Ycoordinate),.YcoordinateUTC(YcoordinateUTC),.DTC(DTC)); 
    
    assign Hsyncsignal = ~((Xcoordinate >= 10'd655)&(Xcoordinate <= 10'd750)&(Ycoordinate >= 10'd0  )&(Ycoordinate <= 10'd524));
    assign Vsyncsignal = ~((Xcoordinate >= 10'd0  )&(Xcoordinate <= 10'd799)&(Ycoordinate >= 10'd489)&(Ycoordinate <= 10'd490));
    
    //assign frame = XcoordinateUTC&YcoordinateUTC;
     assign frame = (Xcoordinate==10'd639 & Ycoordinate==10'd479);
endmodule
