`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:03 03/05/2012 
// Design Name: 
// Module Name:    encoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//    DUAL_CH_EN = 1,when phA and phB is ok,
//    if any one does not have sig,DUAL_CH_EN = 0
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module encoder
   #(
   DUAL_CH_EN = 1'b1
   )
   (
	clk,
	rst_n,
	clr,	//Synchronous clear; 
	
	phA,
	phB,
	
	dir,
	cnter,  
	upOf,
   downOf
	);
   
   localparam
      State0 = 2'b00,
      State1 = 2'b01,
      State2 = 2'b11,
      State3 = 2'b10;
	
	input clk, rst_n, clr;  //system clock in
	input phA, phB;	//encoder signal in
	
	output reg dir;			//encoder rotate direction
		
	output  reg [15:0] cnter;			//encoder rotate speed

	reg [1:0] phADelayed, phBDelayed;	//[0] used for the inputs synchronous to clk
													//[1] used for Quadrature decoding logic
	output upOf;
   output downOf;
   
   reg [1 : 0] state;
	wire cntEn;	
	
	/*******************get 4*decoder pluse************************/												
	always@(posedge clk)
		begin
		phADelayed <= {phADelayed[0], phA};//phA_out};
		phBDelayed <= {phBDelayed[0], phB};//phB_out};
		end
	assign cntEn = (phADelayed[1] ^ phADelayed[0] ^
	                phBDelayed[1] ^ phBDelayed[0]);

   /************** 4*decoder pluse counter ****************/	
   always@(posedge clk or negedge rst_n) begin
		if(~rst_n)
			cnter <= 16'h00000;
      else begin
         case({clr,cntEn})
            2'b00: begin
               cnter <= 0;
            end
            2'b01: begin
               if(dir == 0) begin
                  cnter <= 1;
               end
               else begin
                  cnter <= 16'hFFFF;
               end
            end
            2'b10: begin
               cnter <= cnter;
            end
            2'b11: begin
               if(dir == 0) begin
                  if(upOf == 1)
                     cnter <= cnter;
                  else
                     cnter <= cnter + 1;
               end
               else begin
                  if(downOf == 1)            
                     cnter <= cnter;            
                  else            
                     cnter <= cnter - 1;            
               end
            end
         endcase
      end
   end
   
	/*************** 4*decoder pluse counter overflow output logic**********/
   assign upOf = (cnter == 16'h7fff) ? 1 : 0;
   assign downOf = (cnter == 16'h8001) ? 1 : 0;
		
	/********************dir output logic**************************/
   always@(posedge clk or negedge rst_n) begin
      if(rst_n == 0) begin
         state <= State0;
         dir <= 0;
      end
      else if(rst_n == 1)begin
         if(1 == DUAL_CH_EN) begin
            case(state)
               State0: begin
                  if((phA == 1) && (phB == 0)) begin
                     state <= State1;
                     dir   <= 1;
                  end
                  else if((phA == 0) && (phB == 1)) begin
                     state <= State3;
                     dir   <= 0;
                  end
                  else begin
                     state <= state;
                     dir   <= dir;
                  end
               end
               State1: begin
                  if((phA == 1) && (phB == 1)) begin
                     state <= State2;
                     dir   <= 1;
                  end
                  else if((phA == 0) && (phB == 0)) begin
                     state <= State0;
                     dir   <= 0;
                  end
                  else begin
                     state <= state;
                     dir   <= dir;
                  end
               end
               State2: begin
                  if((phA == 0) && (phB == 1)) begin
                     state <= State3;
                     dir   <= 1;
                  end
                  else if((phA == 1) && (phB == 0)) begin
                     state <= State1;
                     dir   <= 0;
                  end
                  else begin
                     state <= state;
                     dir   <= dir;
                  end
               end
               State3: begin
                  if((phA == 0) && (phB == 0)) begin
                     state <= State0;
                     dir   <= 1;
                  end
                  else if((phA == 1) && (phB == 1)) begin
                     state <= State2;
                     dir   <= 0;
                  end
                  else begin
                     state <= state;
                     dir   <= dir;
                  end
               end
            endcase
         end
         else begin
            dir <= dir;
         end
      end
      else begin
         state <= state;
         dir <= dir;
      end
   end
      
endmodule
