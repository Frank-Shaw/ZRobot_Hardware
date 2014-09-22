
`timescale 1 ns / 1 ps

	module Motor_Ctrl_v1_1 #
	(
		// Users to add parameters here
        parameter [7 : 0] CLK_FREQUENCY           = 8'd100,           //input clock frequency in MHz
        parameter [15 : 0] PWM_PERIOD                  = 16'd2016,      //PWM period set, in uS, maximum value is 32767
        parameter [15 : 0] SPEED_CTRL_PERIOD   = 16'd25,    //speed control period,   means  the number of PWM period
                                                            //control period is (SPEED_CTRL_PERIOD * PWM_PERIOD) uS

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface Motor_S_AXI
		parameter integer C_Motor_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_Motor_S_AXI_ADDR_WIDTH	= 6
	)
	(
		// Users to add ports here
        input wire in_phA,
        input wire in_phB,
        
        output wire out_w_PWMdir,
        output wire out_w_PWM,

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface Motor_S_AXI
		input wire  motor_s_axi_aclk,
		input wire  motor_s_axi_aresetn,
		input wire [C_Motor_S_AXI_ADDR_WIDTH-1 : 0] motor_s_axi_awaddr,
		input wire [2 : 0] motor_s_axi_awprot,
		input wire  motor_s_axi_awvalid,
		output wire  motor_s_axi_awready,
		input wire [C_Motor_S_AXI_DATA_WIDTH-1 : 0] motor_s_axi_wdata,
		input wire [(C_Motor_S_AXI_DATA_WIDTH/8)-1 : 0] motor_s_axi_wstrb,
		input wire  motor_s_axi_wvalid,
		output wire  motor_s_axi_wready,
		output wire [1 : 0] motor_s_axi_bresp,
		output wire  motor_s_axi_bvalid,
		input wire  motor_s_axi_bready,
		input wire [C_Motor_S_AXI_ADDR_WIDTH-1 : 0] motor_s_axi_araddr,
		input wire [2 : 0] motor_s_axi_arprot,
		input wire  motor_s_axi_arvalid,
		output wire  motor_s_axi_arready,
		output wire [C_Motor_S_AXI_DATA_WIDTH-1 : 0] motor_s_axi_rdata,
		output wire [1 : 0] motor_s_axi_rresp,
		output wire  motor_s_axi_rvalid,
		input wire  motor_s_axi_rready
	);
// Instantiation of Axi Bus Interface Motor_S_AXI
	Motor_Ctrl_v1_1_Motor_S_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_Motor_S_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_Motor_S_AXI_ADDR_WIDTH),
                        
                .CLK_FREQUENCY            (CLK_FREQUENCY),           //input clock frequency in MHz
                .PWM_PERIOD                   (PWM_PERIOD),      //PWM period set, in uS, maximum value is 32767
                .SPEED_CTRL_PERIOD    (SPEED_CTRL_PERIOD)    //speed control period,   means  the number of PWM period

	) Motor_Ctrl_v1_1_Motor_S_AXI_inst (
		
         .in_phA                         (in_phA), 
         .in_phB                         (in_phB), 
         .out_w_PWMdir           (out_w_PWMdir), 
         .out_w_PWM               (out_w_PWM),

         
		.S_AXI_ACLK(motor_s_axi_aclk),
		.S_AXI_ARESETN(motor_s_axi_aresetn),
		.S_AXI_AWADDR(motor_s_axi_awaddr),
		.S_AXI_AWPROT(motor_s_axi_awprot),
		.S_AXI_AWVALID(motor_s_axi_awvalid),
		.S_AXI_AWREADY(motor_s_axi_awready),
		.S_AXI_WDATA(motor_s_axi_wdata),
		.S_AXI_WSTRB(motor_s_axi_wstrb),
		.S_AXI_WVALID(motor_s_axi_wvalid),
		.S_AXI_WREADY(motor_s_axi_wready),
		.S_AXI_BRESP(motor_s_axi_bresp),
		.S_AXI_BVALID(motor_s_axi_bvalid),
		.S_AXI_BREADY(motor_s_axi_bready),
		.S_AXI_ARADDR(motor_s_axi_araddr),
		.S_AXI_ARPROT(motor_s_axi_arprot),
		.S_AXI_ARVALID(motor_s_axi_arvalid),
		.S_AXI_ARREADY(motor_s_axi_arready),
		.S_AXI_RDATA(motor_s_axi_rdata),
		.S_AXI_RRESP(motor_s_axi_rresp),
		.S_AXI_RVALID(motor_s_axi_rvalid),
		.S_AXI_RREADY(motor_s_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
