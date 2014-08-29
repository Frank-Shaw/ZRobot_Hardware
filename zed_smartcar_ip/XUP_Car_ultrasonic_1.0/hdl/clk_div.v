`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2014 01:37:22 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div #(parameter period_num = 2)(         //最大时常42.94s
    input wire clk_in,
    input wire rstn_in,
    output wire clk_out,
    output reg rstn_out
    );
    
    reg [31:0]time_cnt;     
    
    always@(posedge clk_in) begin
        if(~rstn_in) begin
            time_cnt <= 0;
            rstn_out <= 1'b0;
        end
        else begin
            if(time_cnt == period_num / 2)
                rstn_out <= 1'b1;
            if(time_cnt == period_num - 1)
                time_cnt <= 0;
            else
                time_cnt <= time_cnt + 1;
        end
    end
    
    assign clk_out = (time_cnt < period_num / 2) ? 1'b0 : 1'b1;
    
endmodule
