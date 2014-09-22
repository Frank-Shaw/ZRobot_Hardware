`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 		Panqing Niu
// 
// Create Date:    14:23:51 01/21/2014 
// Design Name: 
// Module Name:    PWM_Generator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PWM_Generator
#(parameter 
      CLK_FREQUENCY = 8'd100,    //input clock frequency in MHz
      PWM_PERIOD			 = 16'd20000     //PWM period set, in uS, maximum value is 32767
)
(
    input in_rst,             //reset signal
    input in_clk,				// 1 usec input clock
    input [15:0] pwm_thres,	// 14-bit pwm threshold, for motor 51~2501 is valid
    output reg pwm_out,			// pwm signal output
    output reg out_reg_period_start   //PWM wave period start signals
    );
localparam
      TIMER_1US_CONTER = CLK_FREQUENCY / 2 - 1,
      PWM_PERIOD_CONTER = PWM_PERIOD - 1;

reg [8 - 1 : 0]  timer_cnter;
reg                  timer_1us;
    
//20ms clk counter///////////////
reg [15:0] count;  // 0~19999
initial count = 0;

//1uS timer
always@(posedge in_clk) begin
   if(in_rst == 1) begin
      timer_cnter <= 0;
      timer_1us <= 0;
      out_reg_period_start <= 0;
   end
   else begin
      if(timer_cnter >= TIMER_1US_CONTER) begin
         timer_1us <= ~timer_1us;
         timer_cnter <= 0;
      end
      else begin
         timer_cnter <= timer_cnter + 1;
         if((count == 0) && (timer_cnter == 0) && (timer_1us == 1)) begin
            out_reg_period_start <= 1;
         end
         else begin
            out_reg_period_start <= 0;
         end
      end
   end
end

always@(posedge timer_1us) begin
	if(count >= PWM_PERIOD_CONTER) begin
		count <= 0;
   end
	else begin
		count <= count + 1;
   end
end 

//PWM generate///////////////////
always@(*) begin
	if(count < pwm_thres)  
		pwm_out <=1;
	else
		pwm_out <=0;
end

endmodule
