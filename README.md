OpticsFoundry Sequencer for MicroZed 7020

Clone this repository into the path
C:\AQuRA\

With Vitis 2023.1, open the folder 
C:\AQuRA\OpticsFoundry_Sequencer_MZ\OpticsFoundry_Sequencer_MZ_Vitis_2023.1
An empty workspace should appear. To import the projects, select
File -> Import -> Import projects from Git -> Existing local repository -> OpticsFoundry_Sequencer_MZ -> Import existing Eclipse projects -> OpticsFoundry_Sequencer_MZ_Vitis_2023.1 -> Finish

Right click "OpticsFoundry_Seq...App" (not "..App_system")
Select "Properties"
Select "C/C++ Build -> Settings"
Select "ARM v7 gcc linker -> Inferred Options -> Software Platform"
Put the following under "Software Platform Inferred Flags":
-Wl,--start-group,-lxil,-lgcc,-lc,-lm,--end-group
-Wl,--start-group,-lxil,-llwip4,-lgcc,-lc,-lm,--end-group

Right click on "Assistant" OpticsFoundry_Seq_MZ_App -> Debug and select it.

Right click on projects in "Explorer" and select "Build all", or just "Build", then "Create Boot Image".
Right click on "Assistant" OpticsFoundry_Seq_MZ_App -> Release and select it.
Right click on projects in "Explorer" and select "Build all", or just "Build", then "Create Boot Image".

Connect JTAG cable to MicroZed, select "Explorer" -> "Program Flash"


Use OpticsFoundry_Control_AQuRA or OpticsFoundry_ControlLight to use it.


If you want to recreate the bitstream, use Vivado 2023.1.
