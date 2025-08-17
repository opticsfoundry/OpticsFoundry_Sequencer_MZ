//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1.1 (win64) Build 3900603 Fri Jun 16 19:31:24 MDT 2023
//Date        : Wed Sep 13 23:21:34 2023
//Host        : LAPTOP-K0ND8AG7 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    I2C_0_scl_io,
    I2C_0_sda_io,
    I2C_1_scl_io,
    I2C_1_sda_io,
    I2C_RESET,
    LED_0_BLUE,
    LED_0_GREEN,
    LED_0_RED,
    LED_clock_locked,
    LED_ext_clock_0_locked,
    LED_select_ext_clock_locked,
    LED_running,
    SPI_0_MISO,
    SPI_0_MOSI,
    SPI_0_SCLK,
    SPI_1_MISO,
    SPI_1_MOSI,
    SPI_1_SCLK,
    SPI_select,
    clock_or_strobe,
    core_options_LED_0,
    ext_clock_0,
    ext_clock_1,
    ext_condition_0,
    ext_condition_1,
    ext_trigger_0,
    ext_trigger_1,
    output_bus,
    trigger_out,
    core_dig_in,
    core_dig_out);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  inout I2C_0_scl_io;
  inout I2C_0_sda_io;
  inout I2C_1_scl_io;
  inout I2C_1_sda_io;
  output [0:0]I2C_RESET;
  output [0:0]LED_0_BLUE;
  output [0:0]LED_0_GREEN;
  output [0:0]LED_0_RED;
  output LED_clock_locked;
  output LED_ext_clock_0_locked;
  output LED_select_ext_clock_locked;
  output LED_running;
  input SPI_0_MISO;
  output SPI_0_MOSI;
  output SPI_0_SCLK;
  input SPI_1_MISO;
  output SPI_1_MOSI;
  output SPI_1_SCLK;
  output [3:0]SPI_select;
  output clock_or_strobe;
  output [0:0]core_options_LED_0;
  input ext_clock_0;
  input ext_clock_1;
  input ext_condition_0;
  input ext_condition_1;
  input ext_trigger_0;
  input ext_trigger_1;
  output [27:0]output_bus;
  output trigger_out;
  input [7:0] core_dig_in;
  output [7:0] core_dig_out;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire I2C_0_scl_io;
  wire I2C_0_sda_io;
  wire I2C_1_scl_io;
  wire I2C_1_sda_io;
  wire I2C_0_scl_i;
  wire I2C_0_scl_o;
  wire I2C_0_scl_t;
  wire I2C_0_sda_i;
  wire I2C_1_scl_i;
  wire I2C_1_scl_o;
  wire I2C_1_scl_t;
  wire I2C_1_sda_i;
  wire I2C_1_sda_o;
  wire I2C_1_sda_t;
  wire [0:0]I2C_RESET;
  wire IIC_0_sda_o;
  wire IIC_0_sda_t;
  wire [0:0]LED_0_BLUE;
  wire [0:0]LED_0_GREEN;
  wire [0:0]LED_0_RED;
  wire LED_clock_locked;
  wire LED_ext_clock_0_locked;
  wire LED_select_ext_clock_locked;
  wire LED_running;
  wire SPI_0_MISO;
  wire SPI_0_MOSI;
  wire SPI_0_SCLK;
  wire SPI_1_MISO;
  wire SPI_1_MOSI;
  wire SPI_1_SCLK;
  wire [3:0]SPI_select;
  wire clock_or_strobe;
  wire [0:0]core_options_LED_0;
  wire ext_clock_0;
  wire ext_clock_1;
  wire ext_condition_0;
  wire ext_condition_1;
  wire ext_trigger_0;
  wire ext_trigger_1;
  wire [27:0]output_bus;
  wire trigger_out;
  wire [7:0] core_dig_in;
  wire [7:0] core_dig_out;


IOBUF I2C_0_scl_iobuf
       (.I(I2C_0_scl_o),
        .IO(I2C_0_scl_io),
        .O(I2C_0_scl_i),
        .T(I2C_0_scl_t));

  IOBUF I2C_0_sda_iobuf
       (.I(I2C_0_sda_o),
        .IO(I2C_0_sda_io),
        .O(I2C_0_sda_i),
        .T(I2C_0_sda_t));
        
  IOBUF I2C_1_scl_iobuf
       (.I(I2C_1_scl_o),
        .IO(I2C_1_scl_io),
        .O(I2C_1_scl_i),
        .T(I2C_1_scl_t));

  IOBUF I2C_1_sda_iobuf
       (.I(I2C_1_sda_o),
        .IO(I2C_1_sda_io),
        .O(I2C_1_sda_i),
        .T(I2C_1_sda_t));


  design_1 design_1_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .I2C_0_scl_i(I2C_0_scl_i),
        .I2C_0_scl_o(I2C_0_scl_o),
        .I2C_0_scl_t(I2C_0_scl_t),
        .I2C_0_sda_i(I2C_0_sda_i),
        .I2C_1_scl_i(I2C_1_scl_i),
        .I2C_1_scl_o(I2C_1_scl_o),
        .I2C_1_scl_t(I2C_1_scl_t),
        .I2C_1_sda_i(I2C_1_sda_i),
        .I2C_1_sda_o(I2C_1_sda_o),
        .I2C_1_sda_t(I2C_1_sda_t),
        .I2C_RESET(I2C_RESET),
        .IIC_0_sda_o(IIC_0_sda_o),
        .IIC_0_sda_t(IIC_0_sda_t),
        .LED_0_BLUE(LED_0_BLUE),
        .LED_0_GREEN(LED_0_GREEN),
        .LED_0_RED(LED_0_RED),
        .LED_clock_locked(LED_clock_locked),
        .LED_ext_clock_0_locked(LED_ext_clock_0_locked),
        .LED_select_ext_clock_locked(LED_select_ext_clock_locked),
        .LED_running(LED_running),
        .SPI_0_MISO(SPI_0_MISO),
        .SPI_0_MOSI(SPI_0_MOSI),
        .SPI_0_SCLK(SPI_0_SCLK),
        .SPI_1_MISO(SPI_1_MISO),
        .SPI_1_MOSI(SPI_1_MOSI),
        .SPI_1_SCLK(SPI_1_SCLK),
        .SPI_select(SPI_select),
        .clock_or_strobe(clock_or_strobe),
        .core_options_LED_0(core_options_LED_0),
        .ext_clock_0(ext_clock_0),
        .ext_clock_1(ext_clock_1),
        .ext_condition_0(ext_condition_0),
        .ext_condition_1(ext_condition_1),
        .ext_trigger_0(ext_trigger_0),
        .ext_trigger_1(ext_trigger_1),
        .output_bus(output_bus),
        .trigger_out(trigger_out),
        .core_dig_in(core_dig_in),
        .core_dig_out(core_dig_out)
        );
endmodule
