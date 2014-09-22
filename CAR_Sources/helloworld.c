/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xil_io.h"

#include "car.h"

Motor motor;
Speed speed;


int main()
{
	u32 sw;
	int speed_L, speed_R;

	int speed_set = -3000;

    init_platform();
    //initialize GPIO direction
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + 0x04, 0x0F); //gpio_trl as input
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + 0x0C, 0x0);  //gpio_rtl_0 as output

    Motor_Initialize(&motor,XPAR_MOTOR_0_S00_AXI_BASEADDR);
    Motor_SetSpeed(&motor, LEFT, 0);
    Motor_SetSpeed(&motor, RIGHT, 0);
    print("Motor Initialization Done\n\r");

    Speed_Initialize(&speed, XPAR_SPEED_0_S00_AXI_BASEADDR);

    while(1)
    {
    	sw = Xil_In32(XPAR_AXI_GPIO_0_BASEADDR);
    	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR + 0x08, sw);
    	xil_printf("sw=0x%x\t",sw);

    	speed_L = Speed_GetMotorSpeed(&speed, LEFT);
    	speed_R = Speed_GetMotorSpeed(&speed, RIGHT);
    	xil_printf("PWM_Duty : %d,\t Speed_L : %d,\t Speed_R : %d\t",speed_set, speed_L, speed_R);

    	print("\n\r");

    	if(speed_set < 3000 )
    	{
    		speed_set += 100;
    	}
    	else
    	{
    		speed_set = -3000;
    	}
    	Motor_SetSpeed(&motor,LEFT,speed_set);
    	Motor_SetSpeed(&motor, RIGHT, (speed_set));
    	sleep(1);
    }

    return 0;
}
