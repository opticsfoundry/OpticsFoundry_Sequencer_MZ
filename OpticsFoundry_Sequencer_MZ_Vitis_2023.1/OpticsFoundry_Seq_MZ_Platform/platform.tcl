# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\AQuRA\OpticsFoundry_Sequencer_MZ\OpticsFoundry_Sequencer_MZ_Vitis_2023.1\OpticsFoundry_Seq_MZ_Platform\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\AQuRA\OpticsFoundry_Sequencer_MZ\OpticsFoundry_Sequencer_MZ_Vitis_2023.1\OpticsFoundry_Seq_MZ_Platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {OpticsFoundry_Seq_MZ_Platform}\
-hw {C:\AQuRA\OpticsFoundry_Sequencer_MZ\OpticsFoundry_Sequencer_MZ_Vivado_2023.1\design_1_wrapper.xsa}\
-out {C:/AQuRA/OpticsFoundry_Sequencer_MZ/OpticsFoundry_Sequencer_MZ_Vitis_2023.1}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {lwip_echo_server}
platform generate -domains 
platform active {OpticsFoundry_Seq_MZ_Platform}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
bsp reload
bsp config mem_size "524288"
bsp config memp_n_pbuf "1024"
bsp config memp_n_tcp_pcb "32"
bsp config memp_n_tcp_seg "1024"
bsp config memp_n_udp_pcb "4"
bsp config pbuf_pool_size "16384"
bsp config tcp_snd_buf "65535"
bsp config tcp_wnd "65535"
bsp config n_rx_descriptors "512"
bsp config n_tx_descriptors "512"
bsp write
bsp reload
catch {bsp regenerate}
platform generate
bsp reload
platform generate
platform generate -domains standalone_ps7_cortexa9_0 
platform clean
platform generate
platform clean
platform generate
platform generate -domains standalone_ps7_cortexa9_0 
platform clean
platform clean
platform clean
platform generate
platform generate -domains standalone_ps7_cortexa9_0 
platform generate -domains standalone_ps7_cortexa9_0 
platform clean
platform clean
platform clean
platform generate
platform active {OpticsFoundry_Seq_MZ_Platform}
bsp reload
bsp config dhcp_does_arp_check "false"
bsp config lwip_dhcp "false"
bsp write
bsp reload
catch {bsp regenerate}
bsp reload
bsp reload
bsp write
platform generate -domains standalone_ps7_cortexa9_0 
bsp config dhcp_does_arp_check "false"
bsp config dhcp_does_arp_check "false"
bsp reload
bsp config dhcp_does_arp_check "true"
bsp config lwip_dhcp "true"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_ps7_cortexa9_0 
platform generate
platform active {OpticsFoundry_Seq_MZ_Platform}
bsp reload
bsp write
platform generate -domains 
platform active {OpticsFoundry_Seq_MZ_Platform}
platform config -updatehw {C:/AQuRA/OpticsFoundry_Sequencer_MZ/OpticsFoundry_Sequencer_MZ_Vivado_2023.1/design_1_wrapper.xsa}
