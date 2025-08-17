`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2023 16:24:26
// Design Name: 
// Module Name: stop_watch_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stop_watch_wrapper(
    clock,
    reset,
    running,
    counter
    );
    
    
input clock;
input reset;
input running;
output [47:0] counter;


stop_watch stop_watch_inst (
    .clock(clock),
    .reset(reset),
    .running(running),
    .counter(counter)
    );
    
endmodule
