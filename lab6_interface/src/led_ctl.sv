//-----------------------------------------------------------------------------
//  
//  Copyright (c) 2009 Xilinx Inc.
//
//  Project  : Programmable Wave Generator
//  Module   : led_ctl.sv
//  Parent   : uart_led.sv
//  Children : None
//
//  Description: 
//     LED output generator
//
//  Parameters:
//     None
//
//  Local Parameters:
//
//  Notes       : 
//
//  Multicycle and False Paths
//    None
//

`timescale 1ns/1ps

module led_ctl (
  // Write side inputs
  // input			clk_rx,		  // Clock input
  // input			rst_clk_rx,   // Active HIGH reset - synchronous to clk_rx
  // input [7:0]	rx_data,      // 8 bit data output
  // input			rx_data_rdy,  // Ready signal for rx_data
   ifc_signals        ifc, // Interface signals

  output logic [7:0]  led_o         // The LED outputs
);

//***************************************************************************
// Logic declarations
//***************************************************************************

  logic             old_rx_data_rdy;
  logic  [7:0]      char_data;
  logic             clk_rx;
  logic             rst_clk_rx;
  logic [7:0]       rx_data;
  logic             rx_data_rdy;

  assign clk_rx       = ifc.clk_rx;
  assign rst_clk_rx   = ifc.rst_clk_rx;
  assign rx_data      = ifc.rx_data;
  assign rx_data_rdy  = ifc.rx_data_rdy;

//***************************************************************************
// Code
//***************************************************************************

  always_ff @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      old_rx_data_rdy <= 1'b0;
      char_data       <= 8'b0;
      led_o           <= 8'b0;
    end
    else
    begin
      // Capture the value of rx_data_rdy for edge detection
      old_rx_data_rdy <= rx_data_rdy;

      // If rising edge of rx_data_rdy, capture rx_data
      if (rx_data_rdy && !old_rx_data_rdy)
        begin
            char_data <= rx_data;  
        end
            
        led_o <= char_data;
      
    end // if !rst
  end // always_ff

endmodule

