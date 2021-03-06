`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: vline_move_6.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module vline_move_6 (
    input clk,
    input UP,
    input reset,
    input DW,
    input LD,
    input [15:0]sw,
    output [15:0]Ycoordinate,
    output YcoordinateUTC,
    output DTC 
    
   );
   
    wire [3:0] conUTC;
    wire [3:0] conDTC;
   
   Line1Move3LCounter counter1 (.clkin(clk),.UP(UP),                              .reset(reset),  .DW(DW),                               .LD(LD),.D(sw[2:0]),    .Q(Ycoordinate[2:0]),  .UTC(conUTC[0]),.DTC(conDTC[0]));
   Line1Move5LCounter counter3 (.clkin(clk),.UP(UP&conUTC[0]),                    .reset(reset),  .DW(DW&conDTC[0]),                     .LD(LD),.D(sw[7:3]),    .Q(Ycoordinate[7:3]),  .UTC(conUTC[1]),.DTC(conDTC[1]));
   Line1Move5LCounter counter4 (.clkin(clk),.UP(UP&conUTC[0]&conUTC[1]),          .reset(reset),  .DW(DW&conDTC[0]&conDTC[1]),           .LD(LD),.D(sw[12:8]),   .Q(Ycoordinate[12:8]), .UTC(conUTC[2]),.DTC(conDTC[2]));
   Line1Move3LCounter counter2 (.clkin(clk),.UP(UP&conUTC[0]&conUTC[1]&conUTC[2]),.reset(reset),  .DW(DW&conDTC[0]&conDTC[1]&conDTC[2]), .LD(LD),.D(sw[15:13]),  .Q(Ycoordinate[15:13]),.UTC(conUTC[3]),.DTC(conDTC[3]));
   
   assign YcoordinateUTC = ~Ycoordinate[15]&~Ycoordinate[14]&~Ycoordinate[13]&~Ycoordinate[12]&~Ycoordinate[11]&~Ycoordinate[10]&~Ycoordinate[9]&Ycoordinate[8]&Ycoordinate[7]&Ycoordinate[6]&Ycoordinate[5]&~Ycoordinate[4]&~Ycoordinate[3]&Ycoordinate[2]&Ycoordinate[1]&Ycoordinate[0];
   assign DTC = ~Ycoordinate[15]&~Ycoordinate[14]&~Ycoordinate[13]&~Ycoordinate[12]&~Ycoordinate[11]&~Ycoordinate[10]&~Ycoordinate[9]&~Ycoordinate[8]&~Ycoordinate[7]&~Ycoordinate[6]&~Ycoordinate[5]&Ycoordinate[4]&~Ycoordinate[3]&~Ycoordinate[2]&Ycoordinate[1]&~Ycoordinate[0];
   
endmodule
