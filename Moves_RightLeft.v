`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: Moves_RightLeft.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module Moves_RightLeft(
    input clk,
    input UP,
    input reset,
    input DW,
    input LD,
    input [15:0]sw,
    output [15:0]Xcoordinate,
    output XcoordinateUTC,
    output DTC 
    
   );
   
    wire [3:0] conUTC;
    wire [3:0] conDTC;
   
   countUD3L counter1 (.clkin(clk),.UP(UP),                              .reset(reset),  .DW(DW),                               .LD(LD),.D(sw[2:0]),    .Q(Xcoordinate[2:0]),  .UTC(conUTC[0]),.DTC(conDTC[0]));
   countUD5L counter3 (.clkin(clk),.UP(UP&conUTC[0]),                    .reset(reset),  .DW(DW&conDTC[0]),                     .LD(LD),.D(sw[7:3]),    .Q(Xcoordinate[7:3]),  .UTC(conUTC[1]),.DTC(conDTC[1]));
   countUD5L counter4 (.clkin(clk),.UP(UP&conUTC[0]&conUTC[1]),          .reset(reset),  .DW(DW&conDTC[0]&conDTC[1]),           .LD(LD),.D(sw[12:8]),   .Q(Xcoordinate[12:8]), .UTC(conUTC[2]),.DTC(conDTC[2]));
   countUD3L counter2 (.clkin(clk),.UP(UP&conUTC[0]&conUTC[1]&conUTC[2]),.reset(reset),  .DW(DW&conDTC[0]&conDTC[1]&conDTC[2]), .LD(LD),.D(sw[15:13]),  .Q(Xcoordinate[15:13]),.UTC(conUTC[3]),.DTC(conDTC[3]));
   
   assign XcoordinateUTC = ~Xcoordinate[15]&~Xcoordinate[14]&~Xcoordinate[13]&~Xcoordinate[12]&~Xcoordinate[11]&~Xcoordinate[10]&Xcoordinate[9]&~Xcoordinate[8]&~Xcoordinate[7]&Xcoordinate[6]&~Xcoordinate[5]&Xcoordinate[4]&Xcoordinate[3]&Xcoordinate[2]&~Xcoordinate[1]&Xcoordinate[0];
   assign DTC = conDTC[0]&conDTC[1]&conDTC[2]&conDTC[3];
   
   
endmodule
