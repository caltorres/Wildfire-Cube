`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UC Santa Cruz.
// Engineer: Carlos Torres.
// 
// Create Date: 11/23/2018 08:44:22 PM.
// Design Name: Wild Cube.
// Module Name: Top_Level.
// Project Name: Wild Cube.
// Target Devices: Basys 3 FPGA.
// Tool Versions: Vivado 2018.3.
//////////////////////////////////////////////////////////////////////////////////

module Top_Level(
    input clkin,
    input btnR,
    input btnL,
    input btnD,
    input btnU,
    input btnC,
    input [15:0]sw,
    output [3:0]an,
    output [6:0]seg,
    output [3:0]vgaRed,
    output [3:0]vgaBlue,
    output [3:0]vgaGreen,
    output Hsync,
    output Vsync
    );
    
    wire clk;
    wire digsel;
    wire [15:0]Xcoordinate;
    wire [15:0]Ycoordinate;
    wire wall;
    wire slug;
    wire frame;
    wire signalED;
    wire [3:0]horizontal;
    wire [3:0]vertical;
    wire hlines;
    wire vlines;
    wire vline;
    wire stop;
    wire [15:0]s;
    wire stop1;
    wire stop2;
    wire stop3;
    wire stop4;
    wire stop5;
    wire stop6;
    wire stop7;
    wire stop8;
    wire stop9;
    wire stop10;
    wire stop11;
    wire stop12;
    wire stop13;
    wire stop14;
    wire pre_winner;
    wire winner;
    wire sha;
    wire flash;
    
    lab7_clks   not_so_slow   (.clkin(clkin), .greset(sw[0])           ,.clk(clk)                ,.digsel(digsel));
    HVsync MainHVsyncs        (.clk(clk)    , .Xcoordinate(Xcoordinate),.Ycoordinate(Ycoordinate),.Hsyncsignal(Hsync),.Vsyncsignal(Vsync),.frame(frame)); 
    
    BlueBoders     BlueWalls  (.clk(clk),.Walls(wall));
    
    wire up;
    wire down;
    wire left;
    wire right;
    
    assign up = ((btnU&~stop1&~btnD&~btnL&~btnR)|
                 (btnU&~stop2&~btnD&~btnL&~btnR)|
                 (btnU&~stop3&~btnD&~btnL&~btnR)|
                 (btnU&~stop4&~btnD&~btnL&~btnR)|
                 (btnU&~stop5&~btnD&~btnL&~btnR)|
                 (btnU&~stop6&~btnD&~btnL&~btnR)|
                 (btnU&~stop7&~btnD&~btnL&~btnR)|
                 (btnU&~stop7&~btnD&~btnL&~btnR));
              
    assign down = ((btnD&~stop1&~btnU&~btnL&~btnR)|
                  (btnD&~stop2&~btnU&~btnL&~btnR)|
                  (btnD&~stop3&~btnU&~btnL&~btnR)|
                  (btnD&~stop4&~btnU&~btnL&~btnR)|
                  (btnD&~stop5&~btnU&~btnL&~btnR)|
                  (btnD&~stop6&~btnU&~btnL&~btnR)|
                  (btnD&~stop7&~btnU&~btnL&~btnR)|
                  (btnD&~stop8&~btnU&~btnL&~btnR));
    
    assign left = ((btnL&~stop1&~btnR&~btnD&~btnU)|
                   (btnL&~stop2&~btnR&~btnD&~btnU)|
                   (btnL&~stop3&~btnR&~btnD&~btnU)|
                   (btnL&~stop4&~btnR&~btnD&~btnU)|
                   (btnL&~stop5&~btnR&~btnD&~btnU)|
                   (btnL&~stop6&~btnR&~btnD&~btnU)|
                   (btnL&~stop7&~btnR&~btnD&~btnU)|
                   (btnL&~stop8&~btnR&~btnD&~btnU));
    
    
    assign right = ((btnR&~stop1&~btnL&~btnD&~btnU)|
                    (btnR&~stop2&~btnL&~btnD&~btnU)|
                    (btnR&~stop3&~btnL&~btnD&~btnU)|
                    (btnR&~stop4&~btnL&~btnD&~btnU)|
                    (btnR&~stop5&~btnL&~btnD&~btnU)|
                    (btnR&~stop6&~btnL&~btnD&~btnU)|
                    (btnR&~stop7&~btnL&~btnD&~btnU)|
                    (btnR&~stop8&~btnL&~btnD&~btnU));

    wire stops = (stop1|stop2|stop3|stop4|stop5|stop6|stop7|stop8|stop9|stop10|stop11|stop12|stop13|stop14);
                                     
    GreenSlug Sammy (
              .clk(clk),
              .btnD(btnD),
              .btnU(btnU),
              .btnR(btnR),
              .btnL(btnL),
              .btnC(btnC),
              .stops(stops),
              .frame(frame),
              .Slug(slug),
              .sha(sha),
              .winner(winner)
    ); 
  
    wire showtime;
    wire runtime;
    wire flash_sel;
    wire load_counter;
    wire inc_score;
    wire start_game;
    wire collide;
    wire sha2;
    wire game_not_on;
    wire btnall;
    wire showscore;
    wire dec_score;
 
    assign collide = sha&sha2;
   
    assign btnall = btnU | btnD | btnL |btnR;
  
    game_state_machine slug_cross (
                .clk(clk),
                .btnall(btnall),
                .btnC(btnC),
                .collide(stops),
                .winner(winner),
                .showtime(showtime),
                .showscore(showscore),
                .runtime(runtime),
                .flash_sel(flash_sel),
                .inc_score(inc_score),
                .dec_score(dec_score),
                .load_counter(load_counter),
                .start_game(start_game)
    );
  
    wire [15:0]x1;
    wire [2:0]graps;
    assign graps[0] = sw[4];
    assign graps[1] = sw[5];
    assign graps[2] = sw[6];
    
    V_Lines        Vlines     (.clk(clk), .v_lines(vlines));
    H_Lines        HLines     (.clk(clk), .h_lines(hlines));
    
    //This is the beginning of creating every single verticle line;
    
    V_Line1 Vline1 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop1),
                .sha2(sha2),
                .v_line(vline)
    ); 
                          
    wire line_2_shadow;
    wire v_collide_2;
    wire v_line_2_output;
    
    assign v_collide_2 = sha&line_2_shadow;
    
    vline_2 v_line_2 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop2),
                .sha2(line_2_shadow),
                .v_line(v_line_2_output)
    ); 

    wire line_3_shadow;
    wire v_collide_3;
    wire v_line_3_output;
                     
    assign v_collide_3 = sha&line_3_shadow;                  
                           
    vline_3 v_line_3 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop3),
                .sha2(line_3_shadow),
                .v_line(v_line_3_output)
    ); 
    
    wire line_4_shadow;
    wire v_collide_4;
    wire v_line_4_output;
      
    assign v_collide_4 = sha&line_4_shadow;   
                           
    vline_4 v_line_4 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop4),
                .sha2(line_4_shadow),
                .v_line(v_line_4_output)
     ); 
                         
     wire line_5_shadow;
     wire v_collide_5;
     wire v_line_5_output;
                      
     assign v_collide_5 = sha&line_5_shadow;                 
                                                    
     vline_5 v_line_5 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop5),
                .sha2(line_5_shadow),
                .v_line(v_line_5_output)
     ); 
                                            
     wire line_6_shadow;
     wire v_collide_6;
     wire v_line_6_output;
                     
     assign v_collide_6 = sha&line_6_shadow;                 
                                                    
     vline_6 v_line_6 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop6),
                .sha2(line_6_shadow),
                .v_line(v_line_6_output)
     );
                           
     wire line_7_shadow;
     wire v_collide_7;
     wire v_line_7_output;
                 
     assign v_collide_7 = sha&line_7_shadow;             
                                                     
     vline_7 v_line_7 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop7),
                .sha2(line_7_shadow),
                .v_line(v_line_7_output)
    ); 
                           
    wire hline_1_shadow;
    wire h_collide_1;
    wire h_line_1_output;                       
                           
    assign h_collide_1 = sha&hline_1_shadow;  
    
    h_line_1  h_line_01 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop8),
                .sha2(hline_1_shadow),
                .h_line(h_line_1_output)
     ); 
    
     wire hline_2_shadow;
     wire h_collide_2;
     wire h_line_2_output;                       
                                                                                 
     assign h_collide_2 = sha&hline_2_shadow;  
                               
     h_line_2  h_line_02 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop9),
                .sha2(hline_2_shadow),
                .h_line(h_line_2_output)
     ); 
        
     wire hline_3_shadow;
     wire h_collide_3;
     wire h_line_3_output;                       
                                                                                  
     assign h_collide_3 = sha&hline_3_shadow;  
                                
     h_line_3 h_line_03 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop10),
                .sha2(hline_3_shadow),
                .h_line(h_line_3_output)
     ); 
    
     wire hline_4_shadow;
     wire h_collide_4;
     wire h_line_4_output;                       
                                                          
     assign h_collide_4 = sha&hline_4_shadow;  
        
     h_line_4 h_line_04 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop11),
                .sha2(hline_4_shadow),
                .h_line(h_line_4_output)
    ); 
    
    wire hline_5_shadow; 
    wire h_collide_5; 
    wire h_line_5_output;                        
                                                          
    assign h_collide_5 = sha&hline_5_shadow;   
        
    h_line_5 h_line_05 ( 
                .clk(clk), 
                .sw(graps), 
                .frame(frame), 
                .start_machine(start_game), 
                .load_counter(load_counter), 
                .flash(flash), 
                .stop(~stop12), 
                .sha2(hline_5_shadow), 
                .h_line(h_line_5_output)
     );  
    
     wire hline_6_shadow;
     wire h_collide_6;
     wire h_line_6_output;                       
                                                          
     assign h_collide_6 = sha&hline_6_shadow;  
        
     h_line_6 h_line_06 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop13),
                .sha2(hline_6_shadow),
                .h_line(h_line_6_output)
     ); 
    
     wire hline_7_shadow;
     wire h_collide_7;
     wire h_line_7_output;                       
                                                                                      
     assign h_collide_7 = sha&hline_7_shadow;  
                                    
     h_line_7 h_line_07 (
                .clk(clk),
                .sw(graps),
                .frame(frame),
                .start_machine(start_game),
                .load_counter(load_counter),
                .flash(flash),
                .stop(~stop14),
                .sha2(hline_7_shadow),
                .h_line(h_line_7_output)
    ); 
    
    wire verticle_obsticles;
    wire verticle_obsticles2;
    wire horizontal_obsticles;
   
    mul2_1 solid_verticle_lines_or_gaps_line1 (
                .in0(vlines),
                .in1(vline|v_line_2_output|v_line_3_output|v_line_4_output|v_line_5_output|v_line_6_output|v_line_7_output),
                .sel(start_game),
                .o(verticle_obsticles)
    );

    mul2_1 solid_horizontal_lines_or_gaps_lines (
                .in0(hlines),
                .in1(h_line_1_output|h_line_2_output|h_line_3_output|h_line_4_output|h_line_5_output|h_line_6_output|h_line_7_output),
                .sel(start_game),
                .o(horizontal_obsticles)
    );          
       
    wire flash_UTC;  
    Flash_clocksignal Flash_Counter (.clk(clk),.UP(frame),.reset(flash_UTC), .XcoordinateUTC(flash_UTC));
       
       
       
    FlashCounter  line_flash (.clkin(clk) ,.advance(flash_UTC),.Q(flash));
    wire [3:0]flashbus;
    
    assign flashbus[0] = flash;
    assign flashbus[1] = flash;
    assign flashbus[2] = flash;
    assign flashbus[3] = flash;
    
    wire [3:0]collide_1;
    
    assign collide_1[0] = stop1;
    assign collide_1[1] = stop1;
    assign collide_1[2] = stop1;
    assign collide_1[3] = stop1;
    
    wire [3:0]collide_2;
        
    assign collide_2[0] = stop2;
    assign collide_2[1] = stop2;
    assign collide_2[2] = stop2;
    assign collide_2[3] = stop2;
        
    wire [3:0]collide_3;
            
    assign collide_3[0] = stop3;
    assign collide_3[1] = stop3;
    assign collide_3[2] = stop3;
    assign collide_3[3] = stop3;
   
    wire [3:0]collide_4;
                
    assign collide_4[0] = stop4;
    assign collide_4[1] = stop4;
    assign collide_4[2] = stop4;
    assign collide_4[3] = stop4;
                
    wire [3:0]collide_5;
                    
    assign collide_5[0] = stop5;
    assign collide_5[1] = stop5;
    assign collide_5[2] = stop5;
    assign collide_5[3] = stop5;
            
    wire [3:0]collide_6;
                        
    assign collide_6[0] = stop6;
    assign collide_6[1] = stop6;
    assign collide_6[2] = stop6;
    assign collide_6[3] = stop6;
                                    
    wire [3:0]collide_7;
                            
    assign collide_7[0] = stop7;
    assign collide_7[1] = stop7;
    assign collide_7[2] = stop7;
    assign collide_7[3] = stop7;
                                              
    assign vgaGreen = (({4{slug}}&flashbus&{4{stops}})|({4{slug}}&{4{~stops}}));
                        
    assign horizontal[0] = horizontal_obsticles;
    assign horizontal[1] = 1'b0;
    assign horizontal[2] = horizontal_obsticles;
    assign horizontal[3] = 1'b0;
    
    assign vertical[0] = verticle_obsticles;
    assign vertical[1] = 1'b0;
    assign vertical[2] = verticle_obsticles;
    assign vertical[3] = 1'b0;
    
    wire [3:0]red_colors;
    
    assign red_colors = (horizontal[0]&vertical[0]) ? 4'b1111 : (horizontal[0]|vertical[0]) ? 4'b1001 : 4'b0000 ;
    
    assign  vgaRed = (red_colors);

    FDRE #(.INIT(1'b0)) stop_v_line_1   (.C(clk), .R(btnC), .CE(1'b1), .D(collide|stop1),     .Q(stop1));
    FDRE #(.INIT(1'b0)) stop_v_line_2   (.C(clk), .R(btnC), .CE(1'b1), .D(v_collide_2|stop2), .Q(stop2));
    FDRE #(.INIT(1'b0)) stop_v_line_3   (.C(clk), .R(btnC), .CE(1'b1), .D(v_collide_3|stop3), .Q(stop3));
    FDRE #(.INIT(1'b0)) stop_v_line_4   (.C(clk), .R(btnC), .CE(1'b1), .D(v_collide_4|stop4), .Q(stop4));
    FDRE #(.INIT(1'b0)) stop_v_line_5   (.C(clk), .R(btnC), .CE(1'b1), .D(v_collide_5|stop5), .Q(stop5));
    FDRE #(.INIT(1'b0)) stop_v_line_6   (.C(clk), .R(btnC), .CE(1'b1), .D(v_collide_6|stop6), .Q(stop6));
    FDRE #(.INIT(1'b0)) stop_v_line_7   (.C(clk), .R(btnC), .CE(1'b1), .D(v_collide_7|stop7), .Q(stop7));
    
    FDRE #(.INIT(1'b0)) stop_h_line_1   (.C(clk), .R(btnC), .CE(1'b1), .D(h_collide_1|stop8),  .Q(stop8));
    FDRE #(.INIT(1'b0)) stop_h_line_2   (.C(clk), .R(btnC), .CE(1'b1), .D(h_collide_2|stop9),  .Q(stop9));
    FDRE #(.INIT(1'b0)) stop_h_line_3   (.C(clk), .R(btnC), .CE(1'b1), .D(h_collide_3|stop10), .Q(stop10));
    FDRE #(.INIT(1'b0)) stop_h_line_4   (.C(clk), .R(btnC), .CE(1'b1), .D(h_collide_4|stop11), .Q(stop11));
    FDRE #(.INIT(1'b0)) stop_h_line_5   (.C(clk), .R(btnC), .CE(1'b1), .D(h_collide_5|stop12), .Q(stop12));
    FDRE #(.INIT(1'b0)) stop_h_line_6   (.C(clk), .R(btnC), .CE(1'b1), .D(h_collide_6|stop13), .Q(stop13));
    FDRE #(.INIT(1'b0)) stop_h_line_7   (.C(clk), .R(btnC), .CE(1'b1), .D(h_collide_7|stop14), .Q(stop14));
    
    wire [3:0] greenslug;
    wire [3:0] greenslug_flash; 
    wire [3:0] bluewalls;
    wire [3:0] bluewalls_flash;
    wire [3:0] red_vertical_line1;
    wire [3:0] red_vertical_line1_flash;
    wire [3:0]color_green;
    wire [3:0]color_blue;
    
    assign bluewalls = {4{wall}};
    assign bluewalls_flash = ({4{wall}})&(flashbus);
    assign red_vertical_line1 = red_colors;
    assign red_vertical_line1_flash = vgaRed&(flashbus);
   
    mux2_1x4  winner_on  (.in0(bluewalls),.in1(bluewalls_flash),.sel(winner),.o(color_blue));
  
    assign vgaBlue = color_blue;
    
    // The following code is for the time counter and the scores
    wire [3:0]winner_score_output;
    wire [3:0]loser_score_output;
    wire [3:0]ring_counter_output;
    wire [15:0]selector_input;
    wire [3:0]selector_output;
    
    wire [4:0]second_initial_value;
    wire [4:0]minute_initial_value;
    
    wire [4:0]second_out_time_dig1;
    wire [4:0]second_out_time_dig2;
    
    wire [4:0]minute_out_time_dig1;
    wire [4:0]minute_out_time_dig2;
    
    wire UTC_second_counter_dig1;
    wire UTC_second_counter_dig2;
    
    wire UTC_minute_counter_dig1;
    wire UTC_minute_counter_dig2;
    
    wire [3:0]an_time;
    wire [3:0]an_time_flash;
    wire [3:0]an_output;
    
    Counter4L winner_score (
                .clkin(clk),
                .UP(inc_score),
                .Q(winner_score_output)
    );
    Counter4L losser_score (
                .clkin(clk),
                .UP(dec_score),
                .Q(loser_score_output)
    );                       
    Ring_Counter main_ring_counter (
                .clkin(clk),
                .advance(digsel),
                .Q(ring_counter_output)
    );        
    selector mainselector (
                .sel(ring_counter_output),
                .N(selector_input),
                .H(selector_output)
    );                                        
    hex7seg mainSeg7 (
                .e(1'b1),
                .n(selector_output),
                .seg(seg)
    ); 
   
    second_counter second_counter_segment_digit1 (
                .clk(flash),
                .UP(runtime),
                .reset(UTC_second_counter_dig1),
                .LD(load_counter),
                .D(second_initial_value),
                .Q(second_out_time_dig1),
                .UTC(UTC_second_counter_dig1)
    );
    second_counter_digit2 second_counter_segment_digit2 (
                .clkin(flash),
                .UP(UTC_second_counter_dig1),
                .reset(UTC_second_counter_dig2),
                .LD(load_counter),
                .D(second_initial_value),
                .Q(second_out_time_dig2),
                .UTC(UTC_second_counter_dig2)
    );                          
    minute_counter_digit1 minute_counter_segment_digit1 (
                .clkin(flash),
                .UP(UTC_second_counter_dig2),
                .reset(UTC_minute_counter_dig1),
                .LD(load_counter),
                .D(minute_initial_value),
                .Q(minute_out_time_dig1),
                .UTC(UTC_minute_counter_dig1)
    );     
    minute_counter_digit2 minute_counter_segment_digit2 (
                .clkin(flash),
                .UP(UTC_minute_counter_dig1),
                .reset(UTC_minute_counter_dig2),
                .LD(load_counter),
                .D(minute_initial_value),
                .Q(minute_out_time_dig2),
                .UTC(UTC_minute_counter_dig2)
    );                                                        
                                
    assign second_initial_value = 10'd0;
    assign minute_initial_value = 10'd0; 
                   
    assign selector_input[0]  = ((second_out_time_dig1[0]&~showscore)|(winner_score_output[0]&showscore));    
    assign selector_input[1]  = ((second_out_time_dig1[1]&~showscore)|(winner_score_output[1]&showscore));    
    assign selector_input[2]  = ((second_out_time_dig1[2]&~showscore)|(winner_score_output[2]&showscore));              
    assign selector_input[3]  = ((second_out_time_dig1[3]&~showscore)|(winner_score_output[3]&showscore)) ; 
    
    assign selector_input[4]  = (second_out_time_dig2[0]&~showscore);
    assign selector_input[5]  = (second_out_time_dig2[1]&~showscore);
    assign selector_input[6]  = (second_out_time_dig2[2]&~showscore);
    assign selector_input[7]  = (second_out_time_dig2[3]&~showscore);
    
    assign selector_input[8]  = (minute_out_time_dig1[0]&~showscore);
    assign selector_input[9]  = (minute_out_time_dig1[1]&~showscore);
    assign selector_input[10] = (minute_out_time_dig1[2]&~showscore);
    assign selector_input[11] = (minute_out_time_dig1[3]&~showscore);
    
    assign selector_input[12] = (minute_out_time_dig2[0]&~showscore)|(loser_score_output[0]&showscore);
    assign selector_input[13] = (minute_out_time_dig2[1]&~showscore)|(loser_score_output[1]&showscore);
    assign selector_input[14] = (minute_out_time_dig2[2]&~showscore)|(loser_score_output[2]&showscore);
    assign selector_input[15] = (minute_out_time_dig2[3]&~showscore)|(loser_score_output[3]&showscore);                 
    
    wire stoptime;
    
    assign stoptime = (stop1|stop2|stop3|stop4|stop5|stop6|stop7|stop8|stop9|stop10|stop11|stop12|stop13|stop14);
    
    assign an_time[0] = ~(ring_counter_output[0]&(~showscore&~winner&~stoptime|~showscore&stoptime&flash|~showscore&winner&flash|showscore));                                    
    assign an_time[1] = ~(ring_counter_output[1]&(~showscore&~winner&~stoptime|~showscore&stoptime&flash|~showscore&winner&flash|showscore));                                                              
    assign an_time[2] = ~(ring_counter_output[2]&(~showscore&~winner&~stoptime|~showscore&stoptime&flash|~showscore&winner&flash|showscore));                                                            
    assign an_time[3] = ~(ring_counter_output[3]&(~showscore&~winner&~stoptime|~showscore&stoptime&flash|~showscore&winner&flash|showscore));
    
    assign an_time_flash[0] = ~(ring_counter_output[0]&~showscore);
    assign an_time_flash[1] = ~(ring_counter_output[1]&~showscore);                        
    assign an_time_flash[2] = ~(ring_counter_output[2]&~showscore);                        
    assign an_time_flash[3] = ~(ring_counter_output[3]&~showscore);
    
    // mux2_1x4  anodes_flash_off_or_on  (.in0(an_time),.in1(an_time_flash),.sel(winner|stop2),.o(an_output));
    
    assign an[0] = an_time[0];
    assign an[1] = an_time[1];
    assign an[2] = an_time[2];
    assign an[3] = an_time[3];
      
endmodule
