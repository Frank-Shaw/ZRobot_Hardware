

/***************************** Include Files *******************************/
#include "servo.h"
#include "xstatus.h"

/************************** Function Definitions ***************************/

int Servo_Initialize(Servo *InstancePtr,u32 EffectiveAddr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);

	InstancePtr -> BaseAddress = EffectiveAddr;
	InstancePtr -> IsReady = XIL_COMPONENT_IS_READY;
	return XST_SUCCESS;
}

void Servo_SetPWMDuty(Servo *InstancePtr,unsigned Servo_Channel,u32 PWM_Duty)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(Servo_Channel > 0 && Servo_Channel < 5);

	SERVO_mWriteReg(InstancePtr -> BaseAddress,4 * (Servo_Channel - 1),PWM_Duty);
}

u32 Servo_GetPWMDuty(Servo *InstancePtr,unsigned Servo_Channel)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertNonvoid(Servo_Channel > 0 && Servo_Channel < 5);

	return SERVO_mReadReg(InstancePtr -> BaseAddress,4 * (Servo_Channel - 1));
}
