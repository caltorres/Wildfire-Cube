`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: BlueBoders.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module BlueBoders(
    input clk,
    output Walls
    ); 
     
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

    wire Wallblue1;
    wire Wallblue2;
    wire Wallblue3;
    wire Wallblue4;
       
    assign Wallblue1 = ((Xcoordinate >= 10'd0  )&(Xcoordinate <= 10'd8  )&(Ycoordinate >= 10'd0  )&(Ycoordinate <= 10'd524));    
    assign Wallblue2 = ((Xcoordinate >= 10'd631)&(Xcoordinate <= 10'd639)&(Ycoordinate >= 10'd0  )&(Ycoordinate <= 10'd524));     
    assign Wallblue3 = ((Xcoordinate >= 10'd0  )&(Xcoordinate <= 10'd639)&(Ycoordinate >= 10'd0  )&(Ycoordinate <= 10'd8  ));
    assign Wallblue4 = ((Xcoordinate >= 10'd0  )&(Xcoordinate <= 10'd639)&(Ycoordinate >= 10'd471)&(Ycoordinate <= 10'd479));
    
    assign Walls = Wallblue1|Wallblue2|Wallblue3|Wallblue4;       
endmodule
