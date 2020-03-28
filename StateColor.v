`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: StateColor.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module StateColor(
       input  clkin,
       input  green,
       input  red,
       output stop
    );
       wire [1:0]STin;
       wire [1:0]STout;
       
       FDRE #(.INIT(1'b1)) IDLE    (.C(clkin), .R(1'b0), .CE(1'b1), .D(STin[0]), .Q(STout[0]));
       FDRE #(.INIT(1'b0)) Stop    (.C(clkin), .R(1'b0), .CE(1'b1), .D(STin[1]), .Q(STout[1]));
       
       assign STin[0]   = ((STout[0]&green&~red));
       assign STin[1]   = ((STout[0]&green&red)|(STout[1]&green&red));
       
       assign stop = STout[1];

endmodule
