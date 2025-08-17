`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2023 16:45:43
// Design Name: 
// Module Name: demux_selector_2_to_4
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


module demux_selector_2_to_4(
    input a0,
    input a1,
    input x0,
    input x1,
    input x2,
    input x3,
    output y
    );
    
    
    // supportive wires
    wire na0,na1;
    assign na0 = ~a0;
    assign na1 = ~a1;
    
    //demux 2 to 4
    wire y0, y1, y2, y3;
    assign y0 = na0 & na1;
    assign y1 = a0 & na1;
    assign y2 = na0 & a1;
    assign y3 = a0 & a1;
    
    //gate the four input signals x0..3 with y0..3 and send results through 4 input or gate 
    assign y = (y0 & x0) | (y1 & x1) | (y2 & x2) | (y3 & x3); 
    
    
endmodule
