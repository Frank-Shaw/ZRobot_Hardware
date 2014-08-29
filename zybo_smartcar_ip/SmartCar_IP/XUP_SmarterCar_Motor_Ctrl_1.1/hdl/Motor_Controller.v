`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:27 07/31/2014 
// Design Name: 
// Module Name:    Motor_Controller 
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
module Motor_Controller
#(
parameter
      CLK_FREQUENCY = 8'd100,           //input clock frequency in MHz
      PWM_PERIOD			 = 16'd2016,      //PWM period set, in uS, maximum value is 32767
		SPEED_CTRL_PERIOD = 16'd25,    //speed control period,   means  the number of PWM period
		                                                             //control period is (SPEED_CTRL_PERIOD * PWM_PERIOD) uS
localparam
		WIDTH = 8'd16,
	   INT_WIDTH = 8'd32
)
(
    input in_rst_n,         //reset signal
    input in_clk,				// input clock
	 
	 input in_module_en, //module enable
	 input in_fwd_dir,  //if in_fwd_dir == 1 out_w_PWMdir = pid_out_sign
	                               //else out_w_PWMdir = ~pid_out_sign
	 input in_PID_passby,
	 
	 input in_phA,         //motor encoder signals
	 input in_phB,         //motor encoder signals
	 
	 input [WIDTH - 1 : 0] in_speed_set,
	 output reg [WIDTH - 1 : 0] out_cur_speed,
	 
	 input [WIDTH - 1 : 0] in_kp_param,
	 input [WIDTH - 1 : 0] in_ki_param,
	 input [WIDTH - 1 : 0] in_pid_out_max,
	 input [WIDTH - 1 : 0] in_pid_out_min,
	 input [31 : 0] in_pid_ui_limit,
	 
	 output reg out_reg_PWMdir,
	 output out_w_PWM    //motor control PWM wave
    );
localparam
    STATE0 = 2'd0,
    STATE1 = 2'd1,
    STATE2 = 2'd2,
    STATE3 = 2'd3
	 ;
reg [1 : 0] reg_calc_state;
reg reg_encoder_clr_n;

reg reg_pid_start;

wire w_pid_done;
reg [WIDTH - 1 : 0] reg_err;
wire [WIDTH - 1 : 0] w_pid_out;
wire [7 : 0] w_pid_out_sign;

reg [WIDTH - 1 : 0] reg_pwm_thres;

wire w_pwm_period_start;
wire [WIDTH - 1 : 0] w_encoder_cnter;

reg reg_speed_period_end;
reg [15 : 0] reg_speed_ctrl_period_cnter;

always@(posedge in_clk) begin
    if(in_rst_n == 0) begin
	     reg_calc_state         <= STATE0;
		  reg_encoder_clr_n  <= 0;
		  reg_pid_start <= 0;
		  out_reg_PWMdir <= 0;
		  out_cur_speed <= 0;
		  reg_pwm_thres <= 0;
	 end
	 else begin
	     case(reg_calc_state)
		      STATE0: begin
				    if(in_module_en == 1) begin
					     reg_calc_state  <= STATE1;
						  reg_encoder_clr_n <= 1;
				    end
					 else begin
					     reg_pwm_thres <= 0;
					 end
				end
				STATE1: begin
				    reg_calc_state  <= STATE2;
				    reg_encoder_clr_n <= 0;
					 out_cur_speed <= w_encoder_cnter;
					 reg_err <= in_speed_set - ((in_PID_passby == 0) ? w_encoder_cnter : 16'd0);
					 reg_pid_start <= 1;
				end
				STATE2: begin
				    reg_encoder_clr_n <= 1;
					 if(w_pid_done == 1) begin
				        reg_calc_state  <= STATE3;
						  reg_pid_start <= 0;
						  if(in_fwd_dir == 1) begin
						      out_reg_PWMdir <= w_pid_out_sign[0];
						  end
						  else begin
						      out_reg_PWMdir <= ~w_pid_out_sign[0];
						  end
						  reg_pwm_thres <= ((in_PID_passby == 0) ? {w_pid_out[10 : 0], 5'd0} : w_pid_out[15 : 0]);
					 end 
				end
				STATE3: begin
				    if(reg_speed_period_end == 1) begin
				        reg_calc_state  <= STATE0;
					 end
				end
		  endcase
	 end
end

always@(posedge in_clk) begin
    if(in_rst_n == 0) begin
		  reg_speed_ctrl_period_cnter <= 1;
    end
	 else begin
	     if(w_pwm_period_start == 1) begin
		      if( reg_speed_ctrl_period_cnter >= SPEED_CTRL_PERIOD) begin
					 reg_speed_ctrl_period_cnter <= 1;
				end
		      else begin
				    reg_speed_ctrl_period_cnter <= reg_speed_ctrl_period_cnter + 1;
			    end
		  end
	 end
end

always@(posedge in_clk) begin
    if(in_rst_n == 0) begin
	     reg_speed_period_end <= 0;
    end
	 else begin
	     if((w_pwm_period_start == 1)  && ( reg_speed_ctrl_period_cnter >= SPEED_CTRL_PERIOD)) begin
		      reg_speed_period_end <= 1;
		  end
		  else begin
		      reg_speed_period_end <= 0;
		  end
	 end
end

// Instantiate the module
PWM_Generator
#(
    .CLK_FREQUENCY   (CLK_FREQUENCY),
    .PWM_PERIOD           (PWM_PERIOD)
)
 PWM_Generator_inst0
 (
    .in_rst			                     (~ in_rst_n), 
    .in_clk			                  (in_clk), 
    .pwm_thres		               (reg_pwm_thres), 
    .pwm_out			               (out_w_PWM), 
    .out_reg_period_start    (w_pwm_period_start)
    );

encoder
#(
    .DUAL_CH_EN(1'b1)
) encoder_inst0 (
    .clk       (in_clk), 
    .rst_n    (in_rst_n), 
    .clr        (reg_encoder_clr_n), 
    .phA     (in_phA), 
    .phB     (in_phB), 
    .dir       (dir), 
    .cnter   (w_encoder_cnter), 
    .upOf   (upOf), 
    .downOf(downOf)
    );
	 
pid_ctrl pid_ctrl_inst0 (
    .ap_clk		(in_clk), 
    .ap_rst		(~in_rst_n), 
    .ap_start   (reg_pid_start), 
    .ap_done  (w_pid_done), 
    .ap_idle    (), 
    .ap_ready (), 
	 
    .io_port_err_in                        (reg_err), 
	 
    .io_port_kp_parameter           ((in_PID_passby == 0) ? in_kp_param : 16'd256), 
    .io_port_ki_parameter            ((in_PID_passby == 0) ? in_ki_param : 16'd0), 
	 
    .io_port_out_max                   ((in_PID_passby == 0) ? in_pid_out_max : PWM_PERIOD), 
    .io_port_out_min                    ((in_PID_passby == 0) ? in_pid_out_min : (0 - PWM_PERIOD)), 
    .io_port_ui_limit                     ((in_PID_passby == 0) ? in_pid_ui_limit : 16'd0), 
	 
    .io_port_set_ui_temp_en        (8'd0), 
    .io_port_set_ui_temp              (), 
	 
    .io_port_out                                (), 
    .io_port_out_ap_vld(), 
    .io_port_out_sign                         (w_pid_out_sign),    //if   io_port_out < 0 ,  io_port_out_sign = 1
    .io_port_out_sign_ap_vld(), 
    .io_port_usign_out                     (w_pid_out), 
    .io_port_usign_out_ap_vld()
    );


endmodule
