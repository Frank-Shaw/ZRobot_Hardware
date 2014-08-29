`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2014 11:26:33 AM
// Design Name: 
// Module Name: pwm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm(
    input wire clk,
    input wire rstn,
    input wire [31:0] pwm_period,
    input wire [31:0] pwm_duty,
    output wire pwm_out
    );
    
    reg [31:0] cnt;
    
    always@(posedge clk)begin
        if(~rstn || cnt == pwm_period - 1)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
    
    assign pwm_out = pwm_duty > cnt ? 1'b1 : 1'b0;
endmodule
