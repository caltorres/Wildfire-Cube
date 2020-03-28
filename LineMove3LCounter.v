`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: Line1Move3LCounter.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module Line1Move3LCounter(
  input clkin,
  input UP,
  input reset,
  input DW,
  input LD,
  input [2:0]D,
  output [2:0]Q,
  output UTC,
  output DTC 
  //testing the reset
  //input reset
  
  );
  
   wire [2:0]connection;
   
   FDRE #(.INIT(1'b0)) flip1 (.C(clkin), .R(reset), .CE(UP|DW|LD), .D(connection[0]), .Q(Q[0]));
   FDRE #(.INIT(1'b0)) flip2 (.C(clkin), .R(reset), .CE(UP|DW|LD), .D(connection[1]), .Q(Q[1]));                                                                                              
   FDRE #(.INIT(1'b0)) flip3 (.C(clkin), .R(reset), .CE(UP|DW|LD), .D(connection[2]), .Q(Q[2]));
   
   assign connection[0] = ((~Q[0]& UP&~DW&~LD)|(~Q[0]& ~UP&DW&~LD)|(D[0] & LD));
   assign connection[1] = ((( Q[1]^Q[0])& UP&~DW&~LD)|((~Q[0]&~Q[1]|Q[0]&Q[1])&~LD& ~UP&DW)|(D[1]& LD));
   assign connection[2] = (((Q[2]^Q[1]&Q[0])& UP&~DW&~LD)|((Q[2]&Q[0]|Q[1]&Q[2]|~Q[2]&~Q[1]&~Q[0])& ~UP&DW&~LD)|(D[2]& LD));
   assign UTC           = Q[0]&Q[1]&Q[2];
   assign DTC           = ~Q[0]&~Q[1]&~Q[2];
   
endmodule
