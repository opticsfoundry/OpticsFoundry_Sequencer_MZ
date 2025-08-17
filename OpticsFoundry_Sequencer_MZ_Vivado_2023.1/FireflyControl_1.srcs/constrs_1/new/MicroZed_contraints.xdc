# ----------------------------------------------------------------------------
#     _____
#    /     \
#   /____   \____
#  / \===\   \==/
# /___\===\___\/  AVNET Design Resource Center
#      \======/         www.em.avnet.com/drc
#       \====/    
# ----------------------------------------------------------------------------
#
#  Created With Avnet UCF Generator V0.4.0
#     Date: Wednesday, November 27, 2013
#     Time: 2:10:18 PM
#
#  This design is the property of Avnet.  Publication of this
#  design is not authorized without written consent from Avnet.
#  
#  Please direct any questions or issues to the MicroZed Community Forums:
#     http://www.microzed.org
#
#  Disclaimer:
#     Avnet, Inc. makes no warranty for the use of this code or design.
#     This code is provided  "As Is". Avnet, Inc assumes no responsibility for
#     any errors, which may appear in this code, nor does it make a commitment
#     to update the information contained herein. Avnet, Inc specifically
#     disclaims any implied warranties of fitness for a particular purpose.
#                      Copyright(c) 2013 Avnet, Inc.
#                              All rights reserved.
#
# ----------------------------------------------------------------------------
#
#  Notes:
#
#  27 November 2013
#     IO standards based upon Bank 34, Bank 35 Vcco supply options of 1.8V,
#     2.5V, or 3.3V are possible based upon the Vadj jumper (J18) settings.  
#     By default, Vadj is expected to be set to 1.8V but if a different
#     voltage is used for a particular design, then the corresponding IO
#     standard within this UCF should also be updated to reflect the actual
#     Vadj jumper selection.
#
#     Net names are not allowed to contain hyphen characters '-' since this
#     is not a legal VHDL87 or Verilog character within an identifier.  
#     HDL net names are adjusted to contain no hyphen characters '-' but
#     rather use underscore '_' characters.  Comment net name with the hyphen
#     characters will remain in place since these are intended to match the
#     schematic net names in order to better enable schematic search.
#
#     In the following, the XDC constraint is matched to the origanal UCF
#     constraint, UCF commented out above, XDC equivalent placedbelow the UCF.
#
# ----------------------------------------------------------------------------
 
# Bank 13, Vcco = Vadj
# Set the bank voltage for bank 13.
set_property IOSTANDARD LVCMOS18 [get_ports -filter { IOBANK == 13 } ]

#NET BANK13_LVDS_0_N LOC = V7  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_0_N"
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_0_N}]
#NET BANK13_LVDS_0_P LOC = U7  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_0_P"
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_0_P}]
#NET BANK13_LVDS_1_N LOC = U10 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_1_N"
set_property -dict { PACKAGE_PIN U10    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_1_N}]
#NET BANK13_LVDS_1_P LOC = T9  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_1_P"
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_1_P}]
#NET BANK13_LVDS_2_N LOC = W8  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_2_N"
set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_2_N}]
#NET BANK13_LVDS_2_P LOC = V8  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_2_P"
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_2_P}]
#NET BANK13_LVDS_3_N LOC = U5  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_3_N"
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_3_N}]
#NET BANK13_LVDS_3_P LOC = T5  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_3_P"
set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_3_P}]
#NET BANK13_LVDS_4_N LOC = Y13 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_4_N"
set_property -dict { PACKAGE_PIN Y13    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_4_N}]
#NET BANK13_LVDS_4_P LOC = Y12 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_4_P"
set_property -dict { PACKAGE_PIN Y12    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_4_P}]
#NET BANK13_LVDS_5_N LOC = V10 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_5_N"
set_property -dict { PACKAGE_PIN V10    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_5_N}]
#NET BANK13_LVDS_5_P LOC = V11 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_5_P"
set_property -dict { PACKAGE_PIN V11    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_5_P}]
#NET BANK13_LVDS_6_N LOC = W6  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_6_N"
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_6_N}]
#NET BANK13_LVDS_6_P LOC = V6  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_6_P"
set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports {BANK13_LVDS_6_P}]
#NET BANK13_SE_0     LOC = V5  | IOSTANDARD = LVCMOS18;  # "BANK13_SE_0"
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports {BANK13_SE_0}]

# Bank 34, Vcco = Vadj
# Set the bank voltage for bank 34.
set_property IOSTANDARD LVCMOS18 [get_ports -filter { IOBANK == 34 } ]

#ToDo: this format to specify IOSTANDARD
#set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 }[get_ports { LEDC0BLUE  }]; #IO_L22N_T3_AD7N_35 Sch=led4_b

#NET JX1_LVDS_0_N    LOC = T10 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_0_N"
set_property -dict { PACKAGE_PIN T10    IOSTANDARD LVCMOS33 } [get_ports {ext_trigger_0}]
#NET JX1_LVDS_0_P    LOC = T11 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_0_P"
set_property -dict { PACKAGE_PIN T11    IOSTANDARD LVCMOS33 } [get_ports {ext_trigger_1}]
#NET JX1_LVDS_1_N    LOC = U12 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_1_N"
set_property -dict { PACKAGE_PIN U12    IOSTANDARD LVCMOS33 } [get_ports {ext_condition_0}]
#NET JX1_LVDS_1_P    LOC = T12 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_1_P"
set_property -dict { PACKAGE_PIN T12    IOSTANDARD LVCMOS33 } [get_ports {ext_condition_1}]
#NET JX1_LVDS_10_N   LOC = U15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_10_N"
set_property -dict { PACKAGE_PIN U15    IOSTANDARD LVCMOS33 } [get_ports {output_bus[0]}]
#NET JX1_LVDS_10_P   LOC = U14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_10_P"
set_property -dict { PACKAGE_PIN U14    IOSTANDARD LVCMOS33 } [get_ports {output_bus[1]}]
#NET JX1_LVDS_11_N   LOC = U19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_11_N"
set_property -dict { PACKAGE_PIN U19    IOSTANDARD LVCMOS33 } [get_ports {clock_or_strobe}]
#NET JX1_LVDS_11_P   LOC = U18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_11_P"
set_property -dict { PACKAGE_PIN U18    IOSTANDARD LVCMOS33 } [get_ports {ext_clock_0}]
#NET JX1_LVDS_12_N   LOC = P19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_12_N"
set_property -dict { PACKAGE_PIN P19    IOSTANDARD LVCMOS33 } [get_ports {output_bus[2]}]
#NET JX1_LVDS_12_P   LOC = N18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_12_P"
set_property -dict { PACKAGE_PIN N18    IOSTANDARD LVCMOS33 } [get_ports {ext_clock_1}]
#NET JX1_LVDS_13_N   LOC = P20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_13_N"
set_property -dict { PACKAGE_PIN P20    IOSTANDARD LVCMOS33 } [get_ports {output_bus[3]}]
#NET JX1_LVDS_13_P   LOC = N20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_13_P"
set_property -dict { PACKAGE_PIN N20    IOSTANDARD LVCMOS33 } [get_ports {output_bus[24]}]
#NET JX1_LVDS_14_N   LOC = U20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_14_N"
set_property -dict { PACKAGE_PIN U20    IOSTANDARD LVCMOS33 } [get_ports {output_bus[5]}]
#NET JX1_LVDS_14_P   LOC = T20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_14_P"
set_property -dict { PACKAGE_PIN T20    IOSTANDARD LVCMOS33 } [get_ports {output_bus[4]}]
#NET JX1_LVDS_15_N   LOC = W20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_15_N"
set_property -dict { PACKAGE_PIN W20    IOSTANDARD LVCMOS33 } [get_ports {output_bus[7]}]
#NET JX1_LVDS_15_P   LOC = V20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_15_P"
set_property -dict { PACKAGE_PIN V20    IOSTANDARD LVCMOS33 } [get_ports {output_bus[6]}]
#NET JX1_LVDS_16_N   LOC = Y19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_16_N"
set_property -dict { PACKAGE_PIN Y19    IOSTANDARD LVCMOS33 } [get_ports {output_bus[9]}]
#NET JX1_LVDS_16_P   LOC = Y18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_16_P"
set_property -dict { PACKAGE_PIN Y18    IOSTANDARD LVCMOS33 } [get_ports {output_bus[8]}]
#NET JX1_LVDS_17_N   LOC = W16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_17_N"
set_property -dict { PACKAGE_PIN W16    IOSTANDARD LVCMOS33 } [get_ports {output_bus[11]}]
#NET JX1_LVDS_17_P   LOC = V16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_17_P"
set_property -dict { PACKAGE_PIN V16    IOSTANDARD LVCMOS33 } [get_ports {output_bus[10]}]
#NET JX1_LVDS_18_N   LOC = R17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_18_N"
set_property -dict { PACKAGE_PIN R17    IOSTANDARD LVCMOS33 } [get_ports {output_bus[13]}]
#NET JX1_LVDS_18_P   LOC = R16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_18_P"
set_property -dict { PACKAGE_PIN R16    IOSTANDARD LVCMOS33 } [get_ports {output_bus[12]}]
#NET JX1_LVDS_19_N   LOC = R18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_19_N"
set_property -dict { PACKAGE_PIN R18    IOSTANDARD LVCMOS33 } [get_ports {output_bus[15]}]
#NET JX1_LVDS_19_P   LOC = T17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_19_P"
set_property -dict { PACKAGE_PIN T17    IOSTANDARD LVCMOS33 } [get_ports {output_bus[14]}]
#NET JX1_LVDS_2_N    LOC = V13 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_2_N"
set_property -dict { PACKAGE_PIN V13    IOSTANDARD LVCMOS33 } [get_ports {output_bus[25]}]
#NET JX1_LVDS_2_P    LOC = U13 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_2_P"
set_property -dict { PACKAGE_PIN U13    IOSTANDARD LVCMOS33 } [get_ports {output_bus[26]}]
#NET JX1_LVDS_20_N   LOC = V18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_20_N"
set_property -dict { PACKAGE_PIN V18    IOSTANDARD LVCMOS33 } [get_ports {output_bus[17]}]
#NET JX1_LVDS_20_P   LOC = V17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_20_P"
set_property -dict { PACKAGE_PIN V17    IOSTANDARD LVCMOS33 } [get_ports {output_bus[16]}]
#NET JX1_LVDS_21_N   LOC = W19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_21_N"
set_property -dict { PACKAGE_PIN W19    IOSTANDARD LVCMOS33 } [get_ports {output_bus[19]}]
#NET JX1_LVDS_21_P   LOC = W18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_21_P"
set_property -dict { PACKAGE_PIN W18    IOSTANDARD LVCMOS33 } [get_ports {output_bus[18]}]
#NET JX1_LVDS_22_N   LOC = P18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_22_N"
set_property -dict { PACKAGE_PIN P18    IOSTANDARD LVCMOS33 } [get_ports {output_bus[21]}]
#NET JX1_LVDS_22_P   LOC = N17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_22_P"
set_property -dict { PACKAGE_PIN N17    IOSTANDARD LVCMOS33 } [get_ports {output_bus[20]}]
#NET JX1_LVDS_23_N   LOC = P16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_23_N"
set_property -dict { PACKAGE_PIN P16    IOSTANDARD LVCMOS33 } [get_ports {output_bus[23]}]
#NET JX1_LVDS_23_P   LOC = P15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_23_P"
set_property -dict { PACKAGE_PIN P15    IOSTANDARD LVCMOS33 } [get_ports {output_bus[22]}]
#NET JX1_LVDS_3_N    LOC = W13 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_3_N"
set_property -dict { PACKAGE_PIN W13    IOSTANDARD LVCMOS33 } [get_ports {output_bus[27]}]
#NET JX1_LVDS_3_P    LOC = V12 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_3_P"
set_property -dict { PACKAGE_PIN V12    IOSTANDARD LVCMOS33 } [get_ports {JX1_LVDS_3_P}]
#NET JX1_LVDS_4_N    LOC = T15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_4_N"
set_property -dict { PACKAGE_PIN T15    IOSTANDARD LVCMOS33 } [get_ports {JX1_LVDS_4_N}]
#NET JX1_LVDS_4_P    LOC = T14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_4_P"
set_property -dict { PACKAGE_PIN T14    IOSTANDARD LVCMOS33 } [get_ports {JX1_LVDS_4_P}]
#NET JX1_LVDS_5_N    LOC = R14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_5_N"
set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports {JX1_LVDS_5_N}]
#NET JX1_LVDS_5_P    LOC = P14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_5_P"
set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports {SPI_select[0]}]
#NET JX1_LVDS_6_N    LOC = Y17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_6_N"
set_property -dict { PACKAGE_PIN Y17    IOSTANDARD LVCMOS33 } [get_ports {SPI_select[1]}]
#NET JX1_LVDS_6_P    LOC = Y16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_6_P"
set_property -dict { PACKAGE_PIN Y16    IOSTANDARD LVCMOS33 } [get_ports {SPI_select[2]}]
#NET JX1_LVDS_7_N    LOC = Y14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_7_N"
set_property -dict { PACKAGE_PIN Y14    IOSTANDARD LVCMOS33 } [get_ports {SPI_select[3]}]
#NET JX1_LVDS_7_P    LOC = W14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_7_P"
set_property -dict { PACKAGE_PIN W14    IOSTANDARD LVCMOS33 } [get_ports {SPI_0_SCLK}]
#NET JX1_LVDS_8_N    LOC = U17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_8_N"
set_property -dict { PACKAGE_PIN U17    IOSTANDARD LVCMOS33 } [get_ports {SPI_0_MOSI}]
#NET JX1_LVDS_8_P    LOC = T16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_8_P"
set_property -dict { PACKAGE_PIN T16    IOSTANDARD LVCMOS33 } [get_ports {SPI_0_MISO}]
#NET JX1_LVDS_9_N    LOC = W15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_9_N"
set_property -dict { PACKAGE_PIN W15    IOSTANDARD LVCMOS33 } [get_ports {SPI_1_SCLK}]
#NET JX1_LVDS_9_P    LOC = V15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_9_P"
set_property -dict { PACKAGE_PIN V15    IOSTANDARD LVCMOS33 } [get_ports {SPI_1_MOSI}]
#NET JX1_SE_0        LOC = R19 | IOSTANDARD = LVCMOS18;  # "JX1_SE_0"
set_property -dict { PACKAGE_PIN R19    IOSTANDARD LVCMOS33 } [get_ports {trigger_out}]
#NET JX1_SE_1        LOC = T19 | IOSTANDARD = LVCMOS18;  # "JX1_SE_1"
set_property -dict { PACKAGE_PIN T19    IOSTANDARD LVCMOS33 } [get_ports {SPI_1_MISO}]

# Bank 35, Vcco = Vadj
# Set the bank voltage for bank 35.
set_property IOSTANDARD LVCMOS18 [get_ports -filter { IOBANK == 35 } ]

#NET JX2_LVDS_0_N    LOC = B20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_0_N"
set_property -dict { PACKAGE_PIN B20    IOSTANDARD LVCMOS33 } [get_ports {LED_ext_clock_0_locked}]
#NET JX2_LVDS_0_P    LOC = C20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_0_P"
set_property -dict { PACKAGE_PIN C20    IOSTANDARD LVCMOS33 } [get_ports {LED_clock_locked}]
#NET JX2_LVDS_1_N    LOC = A20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_1_N"
set_property -dict { PACKAGE_PIN A20    IOSTANDARD LVCMOS33 } [get_ports {LED_running}]
#NET JX2_LVDS_1_P    LOC = B19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_1_P"
set_property -dict { PACKAGE_PIN B19    IOSTANDARD LVCMOS33 } [get_ports {core_options_LED_0}]
#NET JX2_LVDS_10_N   LOC = L17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_10_N"
set_property -dict { PACKAGE_PIN L17    IOSTANDARD LVCMOS33 } [get_ports {LED_0_RED}]
#NET JX2_LVDS_10_P   LOC = L16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_10_P"
set_property -dict { PACKAGE_PIN L16    IOSTANDARD LVCMOS33 } [get_ports {LED_0_GREEN}]
#NET JX2_LVDS_11_N   LOC = K18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_11_N"
set_property -dict { PACKAGE_PIN K18    IOSTANDARD LVCMOS33 } [get_ports {LED_0_BLUE}]
#NET JX2_LVDS_11_P   LOC = K17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_11_P"
set_property -dict { PACKAGE_PIN K17    IOSTANDARD LVCMOS33 } [get_ports {LED_select_ext_clock_locked}]
#NET JX2_LVDS_12_N   LOC = H17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_12_N"
set_property -dict { PACKAGE_PIN H17    IOSTANDARD LVCMOS33 } [get_ports {I2C_0_scl_io}]
#NET JX2_LVDS_12_P   LOC = H16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_12_P"
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports {I2C_0_sda_io}]
#NET JX2_LVDS_13_N   LOC = H18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_13_N"
set_property -dict { PACKAGE_PIN H18    IOSTANDARD LVCMOS33 } [get_ports {I2C_1_scl_io}]
#NET JX2_LVDS_13_P   LOC = J18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_13_P"
set_property -dict { PACKAGE_PIN J18    IOSTANDARD LVCMOS33 } [get_ports {I2C_1_sda_io}]
#NET JX2_LVDS_14_N   LOC = G18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_14_N"
set_property -dict { PACKAGE_PIN G18    IOSTANDARD LVCMOS33 } [get_ports {I2C_RESET}]
#NET JX2_LVDS_14_P   LOC = G17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_14_P"
set_property -dict { PACKAGE_PIN G17    IOSTANDARD LVCMOS33 } [get_ports {storing_data}]
#NET JX2_LVDS_15_N   LOC = F20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_15_N"
set_property -dict { PACKAGE_PIN F20    IOSTANDARD LVCMOS33 } [get_ports {interlock}]
#NET JX2_LVDS_15_P   LOC = F19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_15_P"
set_property -dict { PACKAGE_PIN F19    IOSTANDARD LVCMOS33 } [get_ports {uart_rtl_0_sin}]
#NET JX2_LVDS_16_N   LOC = G20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_16_N"
set_property -dict { PACKAGE_PIN G20    IOSTANDARD LVCMOS33 } [get_ports {uart_rtl_0_sout}]
#NET JX2_LVDS_16_P   LOC = G19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_16_P"
set_property -dict { PACKAGE_PIN G19    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_16_P}]
#NET JX2_LVDS_17_N   LOC = H20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_17_N"
set_property -dict { PACKAGE_PIN H20    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_17_N}]
#NET JX2_LVDS_17_P   LOC = J20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_17_P"
set_property -dict { PACKAGE_PIN J20    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_17_P}]
#NET JX2_LVDS_18_N   LOC = J14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_18_N"
set_property -dict { PACKAGE_PIN J14    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_18_N}]
#NET JX2_LVDS_18_P   LOC = K14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_18_P"
set_property -dict { PACKAGE_PIN K14    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_18_P}]
#NET JX2_LVDS_19_N   LOC = G15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_19_N"
set_property -dict { PACKAGE_PIN G15    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_19_N}]
#NET JX2_LVDS_19_P   LOC = H15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_19_P"
set_property -dict { PACKAGE_PIN H15    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_19_P}]
#NET JX2_LVDS_2_N    LOC = D18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_2_N"
set_property -dict { PACKAGE_PIN D18    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_2_N}]
#NET JX2_LVDS_2_P    LOC = E17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_2_P"
set_property -dict { PACKAGE_PIN E17    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_2_P}]
#NET JX2_LVDS_20_N   LOC = N16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_20_N"
set_property -dict { PACKAGE_PIN N16    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_20_N}]
#NET JX2_LVDS_20_P   LOC = N15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_20_P"
set_property -dict { PACKAGE_PIN N15    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_20_P}]
#NET JX2_LVDS_21_N   LOC = L15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_21_N"
set_property -dict { PACKAGE_PIN L15    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_21_N}]
#NET JX2_LVDS_21_P   LOC = L14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_21_P"
set_property -dict { PACKAGE_PIN L14    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_21_P}]
#NET JX2_LVDS_22_N   LOC = M15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_22_N"
set_property -dict { PACKAGE_PIN M15    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_22_N}]
#NET JX2_LVDS_22_P   LOC = M14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_22_P"
set_property -dict { PACKAGE_PIN M14    IOSTANDARD LVCMOS33 } [get_ports {JX2_LVDS_22_P}]
#NET JX2_LVDS_23_N   LOC = J16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_23_N"
set_property -dict { PACKAGE_PIN J16    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[0]}]
#NET JX2_LVDS_23_P   LOC = K16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_23_P"
set_property -dict { PACKAGE_PIN K16    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[1]}]
#NET JX2_LVDS_3_N    LOC = D20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_3_N"
set_property -dict { PACKAGE_PIN D20    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[2]}]
#NET JX2_LVDS_3_P    LOC = D19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_3_P"
set_property -dict { PACKAGE_PIN D19    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[3]}]
#NET JX2_LVDS_4_N    LOC = E19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_4_N"
set_property -dict { PACKAGE_PIN E19    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[4]}]
#NET JX2_LVDS_4_P    LOC = E18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_4_P"
set_property -dict { PACKAGE_PIN E18    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[5]}]
#NET JX2_LVDS_5_N    LOC = F17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_5_N"
set_property -dict { PACKAGE_PIN F17    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[6]}]
#NET JX2_LVDS_5_P    LOC = F16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_5_P"
set_property -dict { PACKAGE_PIN F16    IOSTANDARD LVCMOS33 } [get_ports {core_dig_out[7]}]
#NET JX2_LVDS_6_N    LOC = L20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_6_N"
set_property -dict { PACKAGE_PIN L20    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[0]}]
#NET JX2_LVDS_6_P    LOC = L19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_6_P"
set_property -dict { PACKAGE_PIN L19    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[1]}]
#NET JX2_LVDS_7_N    LOC = M20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_7_N"
set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[2]}]
#NET JX2_LVDS_7_P    LOC = M19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_7_P"
set_property -dict { PACKAGE_PIN M19    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[3]}]
#NET JX2_LVDS_8_N    LOC = M18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_8_N"
set_property -dict { PACKAGE_PIN M18    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[4]}]
#NET JX2_LVDS_8_P    LOC = M17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_8_P"
set_property -dict { PACKAGE_PIN M17    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[5]}]
#NET JX2_LVDS_9_N    LOC = J19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_9_N"
set_property -dict { PACKAGE_PIN J19    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[6]}]
#NET JX2_LVDS_9_P    LOC = K19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_9_P"
set_property -dict { PACKAGE_PIN K19    IOSTANDARD LVCMOS33 } [get_ports {core_dig_in[7]}]
#NET JX2_SE_0        LOC = G14 | IOSTANDARD = LVCMOS18;  # "JX2_SE_0"
set_property -dict { PACKAGE_PIN G14    IOSTANDARD LVCMOS33 } [get_ports {JX2_SE_0}]
#NET JX2_SE_1        LOC = J15 | IOSTANDARD = LVCMOS18;  # "JX2_SE_1"
set_property -dict { PACKAGE_PIN J15    IOSTANDARD LVCMOS33 } [get_ports {JX2_SE_1}]



#PMOD, only accessible through MIO

#set_property -dict { PACKAGE_PIN E8    IOSTANDARD LVCMOS33 } [get_ports {output_bus[0]}] #PMOD_D0
#set_property -dict { PACKAGE_PIN E9    IOSTANDARD LVCMOS33 } [get_ports {output_bus[1]}] #PMOD_D1
#set_property -dict { PACKAGE_PIN C6    IOSTANDARD LVCMOS33 } [get_ports {output_bus[2]}] #PMOD_D2
#set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports {output_bus[3]}] #PMOD_D3
#set_property -dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports {output_bus[4]}] #PMOD_D4
#set_property -dict { PACKAGE_PIN B5    IOSTANDARD LVCMOS33 } [get_ports {output_bus[5]}] #PMOD_D5
#set_property -dict { PACKAGE_PIN C5    IOSTANDARD LVCMOS33 } [get_ports {clock_or_strobe}] #PMOD_D6
#set_property -dict { PACKAGE_PIN C8    IOSTANDARD LVCMOS33 } [get_ports {LED_running}] #PMOD_D7
