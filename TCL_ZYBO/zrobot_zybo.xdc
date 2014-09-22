##****************     Switches     ******************
##IO_L19N_T3_VREF_35
set_property PACKAGE_PIN G15 [get_ports {gpio_rtl_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[0]}]

##IO_L24P_T3_34
set_property PACKAGE_PIN P15 [get_ports {gpio_rtl_tri_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[1]}]

##IO_L4N_T0_34
set_property PACKAGE_PIN W13 [get_ports {gpio_rtl_tri_io[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[2]}]

##IO_L9P_T1_DQS_34
set_property PACKAGE_PIN T16 [get_ports {gpio_rtl_tri_io[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_tri_io[3]}]


##********************   LEDs   ***********************
##IO_L23P_T3_35
set_property PACKAGE_PIN M14 [get_ports {gpio_rtl_0_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_0_tri_io[0]}]

##IO_L23N_T3_35
set_property PACKAGE_PIN M15 [get_ports {gpio_rtl_0_tri_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_0_tri_io[1]}]

##IO_0_35
set_property PACKAGE_PIN G14 [get_ports {gpio_rtl_0_tri_io[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_0_tri_io[2]}]

##IO_L3N_T0_DQS_AD1N_35
set_property PACKAGE_PIN D18 [get_ports {gpio_rtl_0_tri_io[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {gpio_rtl_0_tri_io[3]}]

##********************   Motors on JB   ***********************
###JB3_N
#set_property PACKAGE_PIN Y19 [get_ports {motor_dir1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_dir1}]

###JB1_N
#set_property PACKAGE_PIN U20 [get_ports {motor_pwm1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_pwm1}]

###JB1_P
#set_property PACKAGE_PIN T20 [get_ports {motor_dir2}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_dir2}]

###JB3_P
#set_property PACKAGE_PIN Y18 [get_ports {motor_pwm2}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_pwm2}]

##********************   Motors on JC   ***********************
##JC3_N
set_property PACKAGE_PIN Y14 [get_ports motorL_dir]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_dir]

##JC1_N
set_property PACKAGE_PIN W15 [get_ports motorL_pwm]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_pwm]

##JC1_P
set_property PACKAGE_PIN V15 [get_ports motorR_dir]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_dir]

##JC3_P
set_property PACKAGE_PIN W14 [get_ports motorR_pwm]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_pwm]


##********************   Speed Sensor on JC   ***********************
##JC2_N
#set_property PACKAGE_PIN R14 [get_ports {speed_in[0]}]
set_property PACKAGE_PIN T10 [get_ports motorL_phA]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_phA]

##JC4_N
#set_property PACKAGE_PIN U12 [get_ports {speed_in[1]}]
set_property PACKAGE_PIN U12 [get_ports motorL_phB]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorL_phB]

##JC2_P
#set_property PACKAGE_PIN P14 [get_ports {speed_in[2]}]
set_property PACKAGE_PIN T11 [get_ports motorR_phB]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_phB]

##JC4_P
#set_property PACKAGE_PIN T12 [get_ports {speed_in[3]}]
set_property PACKAGE_PIN T12 [get_ports motorR_phA]
#set_property IOSTANDARD LVCMOS33 [get_ports {speed_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports motorR_phA]


set_property PACKAGE_PIN W16 [get_ports trig]
set_property IOSTANDARD LVCMOS33 [get_ports trig]
set_property IOSTANDARD LVCMOS33 [get_ports {echo[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {echo[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {echo[0]}]
set_property PACKAGE_PIN J15 [get_ports {echo[2]}]
set_property PACKAGE_PIN V13 [get_ports {echo[1]}]
set_property PACKAGE_PIN V12 [get_ports {echo[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {optical_tri_i[0]}]
set_property PACKAGE_PIN U15 [get_ports {optical_tri_i[4]}]
set_property PACKAGE_PIN T15 [get_ports {optical_tri_i[3]}]
set_property PACKAGE_PIN T14 [get_ports {optical_tri_i[2]}]
set_property PACKAGE_PIN P14 [get_ports {optical_tri_i[1]}]
set_property PACKAGE_PIN U14 [get_ports {optical_tri_i[0]}]
