`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2023 16:41:50
// Design Name: 
// Module Name: signal_selector_IIC
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


module signal_selector_IIC(
    input select_IIC_1,
    
    input   port_scl_i,
    output  port_scl_o,
    output  port_scl_t,
    input   port_sda_i,
    output  port_sda_o,
    output  port_sda_t,
   
    output IIC_0_scl_i,
    input  IIC_0_scl_o,
    input  IIC_0_scl_t,
    output IIC_0_sda_i,
    input  IIC_0_sda_o,
    input  IIC_0_sda_t,
   
    output IIC_1_scl_i,
    input  IIC_1_scl_o,
    input  IIC_1_scl_t,
    output IIC_1_sda_i,
    input  IIC_1_sda_o,
    input  IIC_1_sda_t
   
    );
    
    // supportive connection required

    wire s;
    assign s = select_IIC_1;
    wire ns;
    assign ns = ~select_IIC_1;
    
    // assign output value by referring to logic diagram
    
    assign port_scl_o = (s & IIC_0_scl_o) | (ns & IIC_1_scl_o);
    assign port_scl_t = (s & IIC_0_scl_t) | (ns & IIC_1_scl_t);
    assign port_sda_o = (s & IIC_0_sda_o) | (ns & IIC_1_sda_o);
    assign port_sda_t = (s & IIC_0_sda_t) | (ns & IIC_1_sda_t);
    
    assign IIC_0_scl_i = port_scl_i;
    assign IIC_1_scl_i = port_scl_i;
    assign IIC_0_sda_i = port_sda_i;
    assign IIC_1_sda_i = port_sda_i;
    
endmodule
