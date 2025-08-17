`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2023 19:40:34
// Design Name: 
// Module Name: core_wrapper
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


module core_wrapper(
    command,
    address,
    reset,
    int_out,
    int_clear,
    bus_data,
    address_latched,
    address_extension_latched,
    wait_cycles_latched,
    input_buf_mem_address,
    input_buf_mem_data,
    input_buf_mem_write,
    start,
    pause,
    clock,
    trigger_0,
    trigger_1,
    trigger_PS,
    trigger_out,
    condition_0,
    condition_1,
    condition_PS,
    latch_current_state,
    bus_clock_or_strobe,
    I2C_SCL,
    I2C_SDA,
    I2C_SELECT_0,
    I2C_SELECT_1,
    SPI_IN_0,
    SPI_IN_1,
    SPI_OUT,
    SPI_SCK,
    SPI_SELECT_0,
    SPI_SELECT_1,
    SPI_chip_select,
    error_detected,
    last_DMA_memory_margin,
    periodic_trigger_count,
    waiting_for_periodic_trigger,
    warning_missed_periodic_trigger,
    running,
    options,
    clock_cycles_this_run,
    core_dig_in,
    secondary_PS_PL_interrupt,
    reset_secondary_PS_PL_interrupt,
    adc_register_address,
    adc_enable,
    adc_conversion_start,
    adc_result_in,
    adc_write_enable,
    adc_programming_out,
    adc_ready,
    adc_channel,
    input_mem_PS_PL_interrupt,
    reset_input_mem_PS_PL_interrupt,
    PL_to_PS_command,
    periodic_trigger_signal
    );
    
    
input [63:0] command;
output [15:0] address;
input reset;
output int_out;
input int_clear;
output [27:0] bus_data;
output [15:0] address_latched;
output [12:0] address_extension_latched;
output [47:0] wait_cycles_latched;
output [12:0] input_buf_mem_address;
output [31:0] input_buf_mem_data;
output input_buf_mem_write;
output [47:0] clock_cycles_this_run;
input start;
input pause;
input clock;
input trigger_0;
input trigger_1;
input trigger_PS;
output trigger_out;
input condition_0;
input condition_1;
input condition_PS;
input latch_current_state;
input SPI_IN_0;
input SPI_IN_1;
output SPI_OUT;
output bus_clock_or_strobe;
output I2C_SCL;
output I2C_SDA;
output I2C_SELECT_0;
output I2C_SELECT_1;
output [3:0] SPI_chip_select;
output SPI_SCK;
output SPI_SELECT_0;
output SPI_SELECT_1;
output error_detected;
output [15:0] last_DMA_memory_margin;
output [47:0] periodic_trigger_count;
output waiting_for_periodic_trigger;
output warning_missed_periodic_trigger;
output running;
output [31:0] options;
input [7:0] core_dig_in;
output secondary_PS_PL_interrupt;
input reset_secondary_PS_PL_interrupt;

output adc_conversion_start;
input [15:0] adc_result_in;
output adc_enable;
output [6:0] adc_register_address;
output adc_write_enable;
output [15:0] adc_programming_out;
input adc_ready;
input [4:0] adc_channel;

output input_mem_PS_PL_interrupt;
input reset_input_mem_PS_PL_interrupt;
output [15:0] PL_to_PS_command; 
output periodic_trigger_signal;

core core_inst (
    .command(command),
    .address(address),
    .reset(reset),
    .int_out(int_out),
    .int_clear(int_clear),
    .bus_data(bus_data),
    .address_latched(address_latched),
    .address_extension_latched(address_extension_latched),
    .wait_cycles_latched(wait_cycles_latched),
    .input_buf_mem_address(input_buf_mem_address),
    .input_buf_mem_data(input_buf_mem_data),
    .input_buf_mem_write(input_buf_mem_write),
    .start(start),
    .pause(pause),
    .clock(clock),
    .trigger_0(trigger_0),
    .trigger_1(trigger_1),
    .trigger_PS(trigger_PS),
    .trigger_out(trigger_out),
    .condition_0(condition_0),
    .condition_1(condition_1),
    .condition_PS(condition_PS),
    .latch_current_state(latch_current_state),
    .SPI_IN_0(SPI_IN_0),
    .SPI_IN_1(SPI_IN_1),
    .SPI_OUT(SPI_OUT),
    .bus_clock_or_strobe(bus_clock_or_strobe),
    .I2C_SCL(I2C_SCL),
    .I2C_SDA(I2C_SDA),
    .I2C_SELECT_0(I2C_SELECT_0),
    .I2C_SELECT_1(I2C_SELECT_1),
    .SPI_SCK(SPI_SCK),
    .SPI_SELECT_0(SPI_SELECT_0),
    .SPI_SELECT_1(SPI_SELECT_1),
    .SPI_chip_select(SPI_chip_select),
    .error_detected(error_detected),
    .last_DMA_memory_margin(last_DMA_memory_margin),
    .periodic_trigger_count(periodic_trigger_count),
    .waiting_for_periodic_trigger(waiting_for_periodic_trigger),
    .warning_missed_periodic_trigger(warning_missed_periodic_trigger),
    .running(running),
    .options(options),
    .clock_cycles_this_run(clock_cycles_this_run),
    .core_dig_in(core_dig_in),
    .secondary_PS_PL_interrupt(secondary_PS_PL_interrupt),
    .reset_secondary_PS_PL_interrupt(reset_secondary_PS_PL_interrupt),
    
    .adc_conversion_start(adc_conversion_start),
    .adc_enable(adc_enable),
    .adc_result_in(adc_result_in),
    .adc_register_address(adc_register_address),
    .adc_write_enable(adc_write_enable),
    .adc_programming_out(adc_programming_out),
    .adc_ready(adc_ready),
    .adc_channel(adc_channel),
    
    .input_mem_PS_PL_interrupt(input_mem_PS_PL_interrupt),
    .reset_input_mem_PS_PL_interrupt(reset_input_mem_PS_PL_interrupt),
    .PL_to_PS_command(PL_to_PS_command),
    .periodic_trigger_signal(periodic_trigger_signal)
    );
    
endmodule
