# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ipgui::add_page $IPINST -name "Page 0" -layout vertical]
	set Component_Name [ipgui::add_param $IPINST -parent $Page0 -name Component_Name]
	ipgui::add_static_text $IPINST -parent $Page0 -name C_S00_AXI_BASEADDR -text {C_S00_AXI_BASEADDR: 0xFFFFFFFF}
	ipgui::add_static_text $IPINST -parent $Page0 -name C_S00_AXI_HIGHADDR -text {C_S00_AXI_HIGHADDR: 0x00000000}
}


