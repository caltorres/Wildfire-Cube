`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: game_state_machine.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////


module game_state_machine(
      input  clk,
      input  btnall,
      input  btnC,
      input  collide,
      input  winner,
      output showtime,
      output showscore,
      output runtime,
      output flash_sel,
      output inc_score,
      output dec_score,
      output load_counter,
      output start_game
     
   );
      wire [3:0]STin;
      wire [3:0]STout;
      
      FDRE #(.INIT(1'b1)) idle    (.C(clk), .R(1'b0), .CE(1'b1), .D(STin[0]), .Q(STout[0]));
      FDRE #(.INIT(1'b0)) game    (.C(clk), .R(1'b0), .CE(1'b1), .D(STin[1]), .Q(STout[1]));
      FDRE #(.INIT(1'b0)) wins    (.C(clk), .R(1'b0), .CE(1'b1), .D(STin[2]), .Q(STout[2]));
      FDRE #(.INIT(1'b0)) losses  (.C(clk), .R(1'b0), .CE(1'b1), .D(STin[3]), .Q(STout[3]));
      
      
      assign STin[0]   = ((STout[0]&~btnall)|(STout[2]&btnC)|(STout[3]&btnC));
      assign STin[1]   = ((STout[0]&btnall)|(STout[1]&~collide&~winner));
                          
      assign STin[2]   = ((STout[1]&collide&~winner)|(STout[2]&~btnC));
      
      assign STin[3]   = ((STout[1]&~collide&winner)|(STout[3]&~btnC));
      
      
      assign showtime  = (STout[2]|STout[3]);
      assign showscore = (STout[0]);
      assign runtime = (STout[1]);
      assign flash_sel = (STout[2]);
      assign inc_score = (STout[1]&~collide&winner);
      assign dec_score = (STout[1]&collide&~winner);
      assign load_counter = (STout[0]);
      assign start_game = (STout[1]|STout[2]|STout[3]);
     
endmodule
