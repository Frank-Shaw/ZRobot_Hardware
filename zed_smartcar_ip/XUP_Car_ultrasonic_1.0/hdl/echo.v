`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2014 10:02:32 AM
// Design Name: 
// Module Name: echo
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


module ultrasonic_echo(
    input wire clk,
    input wire rstn,
    input wire trig_start,
    input wire echo,
    output reg echo_done,
    output reg [9:0] echo_value
    );
    
    
    reg [9:0]echo_cnt;
    reg echo_pre = 1'b0;
    
    always@(posedge clk) begin
        if(~rstn || trig_start) begin
            echo_cnt <= 0;
            echo_value <= 0;
            echo_done <= 1'b0;
        end
        else begin
            echo_pre <= echo;
            case({echo_pre,echo})
                2'b01,2'b11 : 
                    begin
                        if(echo_cnt == 10'h3ff)begin
                            echo_value <= echo_cnt;
                            echo_done <= 1'b1;
                        end
                        else begin
                            echo_cnt <= echo_cnt + 1;
                            echo_done <= 1'b0;
                        end
                    end
                2'b10 :
                    begin
                        echo_value <= echo_cnt;
                        echo_done <= 1'b1;
                    end
            endcase
        end
    end

    
endmodule
