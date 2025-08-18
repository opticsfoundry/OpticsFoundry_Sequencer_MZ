# OpticsFoundry Sequencer for MicroZed 7020

## Introduction

The OpticsFoundry control system uses a Zynq 7020 based System on Module to create commands sent over parallel, SPI, and I2C bus to analog and digital in/outputs and direct digital synthesizers (AD9854, AD9858, AD9958). This repository contains the Vivado and Vitis projects needed to recreate the OpticsFoundry sequencer firmware for the MicroZed 7020. [Z-turn Board V2](https://github.com/opticsfoundry/OF_Sequencer_Zturn) and [PYNQ](https://github.com/opticsfoundry/OF_Sequencer_PYNQ) versions are also available.

This project was inspired by [JQI AutomatioN for Experiments (JANE)](https://github.com/JQIamo/jane), see alse [Rev. Sci. Instrum. 92, 055107 (2021)](https://pubs.aip.org/aip/rsi/article-abstract/92/5/055107/1021868/Programmable-system-on-chip-for-controlling-an).

## Cloning

Clone this repository into the path
C:\AQuRA\

For Vitis, it's easier to use this specific path than trying to adjust the project to a different one.

## To create the MicroZed firmware

With Vitis 2023.1 (and not another Vitis version), open the folder 

C:\AQuRA\OpticsFoundry_Sequencer_MZ\OpticsFoundry_Sequencer_MZ_Vitis_2023.1

An empty workspace should appear. To import the project(s), select

File -> Import -> Import projects from Git -> Existing local repository -> OpticsFoundry_Sequencer_MZ -> Import existing Eclipse projects -> OpticsFoundry_Sequencer_MZ_Vitis_2023.1 -> Finish

Right click "OpticsFoundry_Seq...App" (not "..App_system")

Select "Properties"

Select "C/C++ Build -> Settings"

Select "ARM v7 gcc linker -> Inferred Options -> Software Platform"

Put the following under "Software Platform Inferred Flags":

-Wl,--start-group,-lxil,-lgcc,-lc,-lm,--end-group

-Wl,--start-group,-lxil,-llwip4,-lgcc,-lc,-lm,--end-group

To recreate and flash the firmware do the following:

Right click on "Assistant" OpticsFoundry_Seq_MZ_App -> Debug and select it.

Right click on projects in "Explorer" and select "Build all", or just "Build", then "Create Boot Image".

Right click on "Assistant" OpticsFoundry_Seq_MZ_App -> Release and select it.

Right click on projects in "Explorer" and select "Build all", or just "Build", then "Create Boot Image".

Connect JTAG cable to the MicroZed (e.g. the Digilent JTAG-HS3), select "Explorer" -> "Program Flash"

Use OpticsFoundry_Control_AQuRA or OpticsFoundry_ControlLight to test the sequencer.


## Modifying the C code of the MicroZed firmware

This code is based on the Vitis example "lwIP echo server". Most of the sequencer specific code is contained in firefly.c.

To change the IP configuration (MAC address, DHCP or static IP) follow the instructions in

C:\AQuRA\OpticsFoundry_Sequencer_MZ\OpticsFoundry_Sequencer_MZ_Vitis_2023.1\OpticsFoundry_Seq_MZ_App\src\main.c.

Project specific TCP/IP communication code is contained in echo.c. An interpreter for a very simple programing language running on the ARM core of the MircroZed is implemented using the code in the OpticsFoundryCPUCommandSequencer folder.


## To create the FPGA bitstream

Use Vivado 2023.1 (and not another Vivado version) to open project 

C:\AQuRA\OpticsFoundry_Sequencer_MZ\OpticsFoundry_Sequencer_MZ_Vivado_2023.1\FireflyControl_1.xpr

Update all IP.

Under "Flow Navigator", click on "Generate Bitstream".

Ignore the two "BD 41-237" warnings.

After creating the bitstream (which takes about 15 minutes), export it using

File -> Export -> Export Hardware -> "Include Bitstream"-> Finish

To include this bitstream in the MicroZed firmware, in Vitis, in "Explorer" right click on 

OpticsFoundry_Seq_MZ_Platform 

select "Update Hardware Specifications" and select the file you just exported, i.e. usually

C:/AQuRA/OpticsFoundry_Sequencer_MZ/OpticsFoundry_Sequencer_MZ_Vivado_2023.1/design_1_wrapper.xsa

Then, as explained above, rebuild the firmware, create boot image, and program flash.

## Modifying the FPGA design

Open the project and then "Open Block Design". After the project has fully loaded, you can access the source files in the Block Design window under "Sources -> Design Sources". 

The main part of the code is contained in the file core.sv (under core_wrapper -> core_inst: core). It shouldn't be too difficult to understand the design by reading this file. It might be informative to read it to understand the sequences that OpticsFoundry_Control and OpticsFoundry_ControlLight send to the sequencer. (You can inspect an ASCII file dump of those sequences by enabling the "Debug FPGA buffer" option in the "System debug options" menu of OpticsFoundry_Control).

The pinout to the MicroZed header is defined under "Constraints -> constr_1 -> MicroZed_constraints.xdc".

