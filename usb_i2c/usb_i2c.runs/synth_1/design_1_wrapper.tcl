# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.cache/wt [current_project]
set_property parent.project_path C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
add_files C:/Users/John/Desktop/MQP/backups/coord1.coe
add_files C:/Users/John/Desktop/MQP/backups/coord2.coe
add_files C:/Users/John/Desktop/MQP/backups/vga_map.coe
add_files -quiet c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
set_property used_in_implementation false [get_files c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp]
add_files -quiet c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.dcp
set_property used_in_implementation false [get_files c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.dcp]
add_files -quiet c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1.dcp
set_property used_in_implementation false [get_files c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1.dcp]
add_files -quiet c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/blk_mem_gen_2/blk_mem_gen_2.dcp
set_property used_in_implementation false [get_files c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/ip/blk_mem_gen_2/blk_mem_gen_2.dcp]
add_files C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/design_1.bd
set_property used_in_implementation false [get_files -all c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_1/design_1_processing_system7_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_1/design_1_axi_gpio_0_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_1/design_1_axi_gpio_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_1/design_1_axi_gpio_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_1/design_1_rst_processing_system7_0_100M_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_1/design_1_rst_processing_system7_0_100M_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_1/design_1_rst_processing_system7_0_100M_1_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/design_1_ooc.xdc]
set_property is_locked true [get_files C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/bd/design_1/design_1.bd]

read_verilog -library xil_defaultlib {
  C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/new/rangefinder.v
  C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/imports/hdl/design_1_wrapper.v
}
read_vhdl -library xil_defaultlib C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/sources_1/new/vga_controller_640_60.vhd
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/constrs_1/new/mqp.xdc
set_property used_in_implementation false [get_files C:/Users/John/Documents/GitHub/MQP/usb_i2c/usb_i2c.srcs/constrs_1/new/mqp.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top design_1_wrapper -part xc7z020clg484-1


write_checkpoint -force -noxdef design_1_wrapper.dcp

catch { report_utilization -file design_1_wrapper_utilization_synth.rpt -pb design_1_wrapper_utilization_synth.pb }