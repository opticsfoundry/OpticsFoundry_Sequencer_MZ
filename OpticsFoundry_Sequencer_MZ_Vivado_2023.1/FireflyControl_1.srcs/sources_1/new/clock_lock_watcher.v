`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2023 10:30:47
// Design Name: 
// Module Name: clock_lock_watcher
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


module clock_lock_watcher(
    input lock_0,
    input lock_1,
    input lock_2,
    input reset,
    input clock,
    output reg [2:0] ok = 0
    );
    
always @(posedge clock, posedge reset)
begin
    if (reset) begin
        ok <= 3'b111;
    end else begin
        if (lock_0 == 0) ok[0:0] <= 0;
        else ;
        if (lock_1 == 0) ok[1:1] <= 0;
        else ;
        if (lock_2 == 0) ok[2:2] <= 0;
        else ;
    end
end
    
endmodule
