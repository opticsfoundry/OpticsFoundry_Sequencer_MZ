`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2023 16:22:50
// Design Name: 
// Module Name: stop_watch
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


module stop_watch(
    clock,
    reset,
    running,
    counter
    );
    
input clock;
input reset;
input running;    
output reg [47:0] counter;
    
always @(posedge clock, posedge reset)
begin
  if (reset) begin
     counter <= 0;
  end else begin
    if (running) counter <= counter +1;
  end
end    
    
endmodule
