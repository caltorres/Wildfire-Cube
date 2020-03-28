`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: vline_7.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module vline_7 (
   input clk,
   input [6:4]sw,
   input frame,
   input start_machine,
   input load_counter,
   //input crash,
   //input btnU,
   input flash,
   input stop,
   output sha2,
   output v_line
   //output [15:0]x1
   
   
   
   ); 
   
   wire DW; 
   wire UP;
   wire LD;
   //wire [15:0]sw;
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
   
   assign starting_value = 10'd250;
   
   wire UTC_new_y;
   wire DTC_new_y;
   wire UTC_new_x;
   wire DTC_new_x;
   wire [15:0]next_y;
   wire up;
   wire down;

   Lines_Motion state_machine_line_7 (.clkin(frame),.signal(start_machine),.UTC(UTC_new_y),.DTC(DTC_new_y),.count_up(up),.count_down(down));
   
   vline_move_7  line_7_motion_counter    (.clk(frame),.UP(up&stop),.DW(down&stop),.LD(load_counter),.sw(starting_value ),.Ycoordinate(next_y),.YcoordinateUTC(UTC_new_y),.DTC(DTC_new_y));
   

	assign vline0 = ((Xcoordinate >= 10'd458   )&(Xcoordinate <= 10'd466 )&(Ycoordinate > 10'd9)&(Ycoordinate <= next_y-10'd16));
    assign vline1 = ((Xcoordinate >= 10'd458  )&(Xcoordinate <= 10'd466)&(Ycoordinate >=  length + next_y )&(Ycoordinate < 10'd471));
    assign v_line = (((vline0|vline1)&flash&~stop)|((vline0|vline1)&stop)); 
       
    wire sha1;
    wire sha3;
       
    assign sha1 = ((Xcoordinate >= 10'd458  )&(Xcoordinate <= 10'd466)&(Ycoordinate > 10'd9)&(Ycoordinate <= next_y-10'd16));
    assign sha3 = ((Xcoordinate >= 10'd458  )&(Xcoordinate <= 10'd466 )&(Ycoordinate >=   length + next_y )&(Ycoordinate < 10'd471));
    assign sha2 = vline0|vline1;
        
endmodule