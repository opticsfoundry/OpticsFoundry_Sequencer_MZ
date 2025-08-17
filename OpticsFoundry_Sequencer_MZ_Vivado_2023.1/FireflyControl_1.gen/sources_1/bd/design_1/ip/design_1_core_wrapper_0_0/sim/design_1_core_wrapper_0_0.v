// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:core_wrapper:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_core_wrapper_0_0 (
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

input wire [63 : 0] command;
output wire [15 : 0] address;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
input wire reset;
output wire int_out;
input wire int_clear;
output wire [27 : 0] bus_data;
output wire [15 : 0] address_latched;
output wire [12 : 0] address_extension_latched;
output wire [47 : 0] wait_cycles_latched;
output wire [12 : 0] input_buf_mem_address;
output wire [31 : 0] input_buf_mem_data;
output wire input_buf_mem_write;
input wire start;
input wire pause;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clock, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_0_1_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clock CLK" *)
input wire clock;
input wire trigger_0;
input wire trigger_1;
input wire trigger_PS;
output wire trigger_out;
input wire condition_0;
input wire condition_1;
input wire condition_PS;
input wire latch_current_state;
output wire bus_clock_or_strobe;
output wire I2C_SCL;
output wire I2C_SDA;
output wire I2C_SELECT_0;
output wire I2C_SELECT_1;
input wire SPI_IN_0;
input wire SPI_IN_1;
output wire SPI_OUT;
output wire SPI_SCK;
output wire SPI_SELECT_0;
output wire SPI_SELECT_1;
output wire [3 : 0] SPI_chip_select;
output wire error_detected;
output wire [15 : 0] last_DMA_memory_margin;
output wire [47 : 0] periodic_trigger_count;
output wire waiting_for_periodic_trigger;
output wire warning_missed_periodic_trigger;
output wire running;
output wire [31 : 0] options;
output wire [47 : 0] clock_cycles_this_run;
input wire [7 : 0] core_dig_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME secondary_PS_PL_interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 secondary_PS_PL_interrupt INTERRUPT" *)
output wire secondary_PS_PL_interrupt;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_secondary_PS_PL_interrupt, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_secondary_PS_PL_interrupt RST" *)
input wire reset_secondary_PS_PL_interrupt;
output wire [6 : 0] adc_register_address;
output wire adc_enable;
output wire adc_conversion_start;
input wire [15 : 0] adc_result_in;
output wire adc_write_enable;
output wire [15 : 0] adc_programming_out;
input wire adc_ready;
input wire [4 : 0] adc_channel;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME input_mem_PS_PL_interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 input_mem_PS_PL_interrupt INTERRUPT" *)
output wire input_mem_PS_PL_interrupt;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_input_mem_PS_PL_interrupt, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_input_mem_PS_PL_interrupt RST" *)
input wire reset_input_mem_PS_PL_interrupt;
output wire [15 : 0] PL_to_PS_command;
output wire periodic_trigger_signal;

  core_wrapper inst (
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
    .bus_clock_or_strobe(bus_clock_or_strobe),
    .I2C_SCL(I2C_SCL),
    .I2C_SDA(I2C_SDA),
    .I2C_SELECT_0(I2C_SELECT_0),
    .I2C_SELECT_1(I2C_SELECT_1),
    .SPI_IN_0(SPI_IN_0),
    .SPI_IN_1(SPI_IN_1),
    .SPI_OUT(SPI_OUT),
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
    .adc_register_address(adc_register_address),
    .adc_enable(adc_enable),
    .adc_conversion_start(adc_conversion_start),
    .adc_result_in(adc_result_in),
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
