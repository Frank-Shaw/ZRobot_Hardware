

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "Motor_Ctrl" "NUM_INSTANCES" "DEVICE_ID"  "C_Motor_S_AXI_BASEADDR" "C_Motor_S_AXI_HIGHADDR"
}
