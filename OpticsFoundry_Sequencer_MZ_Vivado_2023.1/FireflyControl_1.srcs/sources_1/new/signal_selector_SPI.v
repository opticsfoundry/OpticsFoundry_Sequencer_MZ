`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2023 16:41:50
// Design Name: 
// Module Name: signal_selector_SPI
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


module signal_selector_SPI(
    input select_SPI_1,
    
    input   port_MISO,
    output  port_MOSI,
    output  port_SCLK,
   
    output SPI_0_MISO,
    input  SPI_0_MOSI,
    input  SPI_0_SCLK,
    
    output SPI_1_MISO,
    input  SPI_1_MOSI,
    input  SPI_1_SCLK
    
    );
    
    // supportive connection required

    wire s;
    assign s = select_SPI_1;
    wire ns;
    assign ns = ~select_SPI_1;
    
    // assign output value by referring to logic diagram
    
    assign port_MOSI = (ns & SPI_0_MOSI) | (s & SPI_1_MOSI);
    assign port_SCLK = (ns & SPI_0_SCLK) | (s & SPI_1_SCLK);
    
    assign SPI_0_MISO = port_MISO;
    assign SPI_1_MISO = port_MISO;
    
endmodule
