set_property PACKAGE_PIN W10 [get_ports motorL_dir]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_dir]

##JC1_N
set_property PACKAGE_PIN W11 [get_ports motorL_pwm]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_pwm]

##JC1_P
set_property PACKAGE_PIN W12 [get_ports motorR_dir]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_dir]

##JC3_P
set_property PACKAGE_PIN V12 [get_ports motorR_pwm]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_pwm]


##********************   Speed Sensor on JC   ***********************
##JC2_N
#set_property PACKAGE_PIN R14 [get_ports {speed_in[0]}]
set_property PACKAGE_PIN W8 [get_ports motorL_phA]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_phA]

##JC4_N
#set_property PACKAGE_PIN U12 [get_ports {speed_in[1]}]
set_property PACKAGE_PIN V8 [get_ports motorL_phB]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_phB]

##JC2_P
#set_property PACKAGE_PIN P14 [get_ports {speed_in[2]}]
set_property PACKAGE_PIN V10 [get_ports motorR_phB]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_phB]

##JC4_P
#set_property PACKAGE_PIN T12 [get_ports {speed_in[3]}]
set_property PACKAGE_PIN V9 [get_ports motorR_phA]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_phA]


set_property PACKAGE_PIN W7 [get_ports trig]
set_property IOSTANDARD LVCMOS33 [get_ports trig]
set_property IOSTANDARD LVCMOS33 [get_ports {echo[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {echo[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {echo[0]}]
set_property PACKAGE_PIN V5 [get_ports {echo[2]}]
set_property PACKAGE_PIN W6 [get_ports {echo[1]}]
set_property PACKAGE_PIN V7 [get_ports {echo[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[0]}]
set_property PACKAGE_PIN T6 [get_ports {optical_tri_i[4]}]
set_property PACKAGE_PIN AB6 [get_ports {optical_tri_i[3]}]
set_property PACKAGE_PIN AB7 [get_ports {optical_tri_i[2]}]
set_property PACKAGE_PIN Y4 [get_ports {optical_tri_i[1]}]
set_property PACKAGE_PIN R6 [get_ports {optical_tri_i[0]}]
