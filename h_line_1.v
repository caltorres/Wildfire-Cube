`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: h_line_1.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module h_line_1(

   input clk,
   input [6:4]sw,
   input frame,
   input start_machine,
   input load_counter,
   input flash,
   input stop,
   output sha2,
   output h_line
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

   wire hline0;
   wire hline1;
   wire [7:0]length;
   wire [15:0]starting_value;
   
   
   assign length[0] = 1'b0;
   assign length[1] = 1'b0;
   assign length[2] = 1'b0;
   assign length[3] = 1'b0;
   assign length[4] = 1'b0;
   assign length[5] = sw[4];
   assign length[6] = sw[5];
   assign length[7] = sw[6];  
   
   assign starting_value = 10'd100;
   
   wire UTC_new_y;
   wire DTC_new_y;
   wire UTC_new_x;
   wire DTC_new_x;
   wire [15:0]next_y;
   wire up;
   wire down;
 
   Lines_Motion  state_machine_line_1 (.clkin(frame),.signal(start_machine),.UTC(UTC_new_y),.DTC(DTC_new_y),.count_up(up),.count_down(down));
   
   hline_move_1  line_1_motion_counter   (.clk(frame),.UP(up&stop),.DW(down&stop),.LD(load_counter),.sw(starting_value ),.Ycoordinate(next_y),.YcoordinateUTC(UTC_new_y),.DTC(DTC_new_y));
   
       assign hline0 = ((Ycoordinate >= 10'd78   )&(Ycoordinate <= 10'd86 )&(Xcoordinate > 10'd9)&(Xcoordinate <= next_y-10'd16));
       assign hline1 = ((Ycoordinate >= 10'd78   )&(Ycoordinate <= 10'd86 )&(Xcoordinate >=  length + next_y )&(Xcoordinate < 10'd630));
       assign h_line = (((hline0|hline1)&flash&~stop)|((hline0|hline1)&stop)); 
       
       wire sha1;
       wire sha3;
       
       assign sha1 = ((Ycoordinate > 10'd78  )&(Ycoordinate < 10'd86 )&(Xcoordinate > 10'd9)&(Xcoordinate <= next_y-10'd16));      
       assign sha3 = ((Ycoordinate > 10'd78  )&(Ycoordinate < 10'd86 )&(Xcoordinate >=  length + next_y )&(Xcoordinate < 10'd630));
       assign sha2 = hline0|hline1;
        
endmodule
