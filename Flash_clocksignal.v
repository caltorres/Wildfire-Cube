`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: Flash_clocksignal.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module Flash_clocksignal(
    input clk,
    input UP,
    input reset,
    input DW,
    input LD,
    input [7:0]sw,
    output [7:0]Xcoordinate,
    output XcoordinateUTC,
    output DTC 
   );
   
    wire [3:0] conUTC;
    wire [3:0] conDTC;
   
   Flash_Counter3 counter1 (.clkin(clk),.UP(UP),                              .reset(reset),  .DW(DW),                               .LD(LD),.D(sw[2:0]),    .Q(Xcoordinate[2:0]),  .UTC(conUTC[0]),.DTC(conDTC[0]));
   Flash_Counter5 counter3 (.clkin(clk),.UP(UP&conUTC[0]),                    .reset(reset),  .DW(DW&conDTC[0]),                     .LD(LD),.D(sw[7:3]),    .Q(Xcoordinate[7:3]),  .UTC(conUTC[1]),.DTC(conDTC[1]));

   assign XcoordinateUTC = ~Xcoordinate[7]&~Xcoordinate[6]&~Xcoordinate[5]&~Xcoordinate[4]&Xcoordinate[3]&~Xcoordinate[2]&~Xcoordinate[1]&~Xcoordinate[0];
   assign DTC = conDTC[0]&conDTC[1]&conDTC[2]&conDTC[3];
endmodule
