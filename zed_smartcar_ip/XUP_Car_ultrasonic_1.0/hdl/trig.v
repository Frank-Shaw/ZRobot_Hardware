`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2014 03:23:03 PM
// Design Name: 
// Module Name: trig
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


module ultrasonic_trig(
    input clk,       //以1us计时
    input rstn,       //复位
    input trig_start,   //置位后触发trig信号，然后被硬件清零
    output reg triging, //触发后triging变为1，同时传递清零信号
    output reg trig         //trig引脚
    );
    
    reg [3:0] trig_clk_cnt;
    
    always@(posedge clk) begin
        if(~rstn) begin
            trig <= 1'b0;
            triging <= 1'b0;
            trig_clk_cnt <= 0;   
        end
        else begin
            if(trig_start && ~triging) begin
                trig <= 1'b1;
                triging <= 1'b1;
            end
            if(triging) begin
                if(trig_clk_cnt == 10) begin
                    trig_clk_cnt <= 0;
                    triging <= 1'b0;
                    trig <= 1'b0;
                end
                else
                    trig_clk_cnt <= trig_clk_cnt + 1;
            end
        end
    end
    
endmodule
