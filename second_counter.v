`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: second_counter.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module second_counter(
    input clk,
    input UP,
    input DW,
    input reset,
    input LD,
    input [4:0]D,
    output [4:0]Q,
    output UTC,
    output DTC 

    );
    
     wire [4:0]connection;
    
     FDRE #(.INIT(1'b0)) flip1 (.C(clk), .R(reset), .CE(UP|DW|LD), .D(connection[0]), .Q(Q[0]));
     FDRE #(.INIT(1'b0)) flip2 (.C(clk), .R(reset), .CE(UP|DW|LD), .D(connection[1]), .Q(Q[1]));                                                                                              
     FDRE #(.INIT(1'b0)) flip3 (.C(clk), .R(reset), .CE(UP|DW|LD), .D(connection[2]), .Q(Q[2]));
     FDRE #(.INIT(1'b0)) flip4 (.C(clk), .R(reset), .CE(UP|DW|LD), .D(connection[3]), .Q(Q[3]));
     FDRE #(.INIT(1'b0)) flip5 (.C(clk), .R(reset), .CE(UP|DW|LD), .D(connection[4]), .Q(Q[4])); 
    
     assign connection[0] = ((~Q[0]& UP&~DW&~LD)|(~Q[0]& ~UP&DW&~LD)|(D[0] & LD));
     assign connection[1] = (((Q[1]^Q[0])& UP&~DW&~LD)|((~Q[0]&~Q[1]|Q[0]&Q[1])&~LD& ~UP&DW)|(D[1]& LD));
     assign connection[2] = (((Q[2]^Q[1]&Q[0])& UP&~DW&~LD)|((Q[2]&Q[0]|Q[1]&Q[2]|~Q[2]&~Q[1]&~Q[0])& ~UP&DW&~LD)|(D[2]& LD));
     assign connection[3] = (((Q[3]^Q[2]&Q[1]&Q[0])& UP&~DW&~LD)|(( Q[3]&Q[2]|Q[1]&Q[3]|Q[3]&Q[0]|~Q[3]&~Q[2]&~Q[1]&~Q[0])&~UP&DW&~LD)|(D[3]& LD));
     assign connection[4] = (((Q[4]^Q[3]&Q[2]&Q[1]&Q[0])& UP&~DW&~LD)|(( Q[3]&Q[4]|Q[4]&Q[2]|Q[1]&Q[4]|Q[4]&Q[0]|~Q[4]&~Q[3]&~Q[2]&~Q[1]&~Q[0])&~UP&DW&~LD)|(D[4]& LD)); 
     assign UTC = Q[0]&~Q[1]&~Q[2]&Q[3]&~Q[4];
     assign DTC = ~Q[0]&~Q[1]&~Q[2]&~Q[3]&~Q[4];
     
endmodule
