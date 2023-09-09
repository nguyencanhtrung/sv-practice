//-----------------------------------------------------------------------------
//  
//  Copyright (c) 2009 Xilinx Inc.
//
//  Project  : Programmable Wave Generator
//  Module   : uart_led.sv
//  Parent   : None
//  Children : uart_rx.sv led_ctl.sv 
//
//  Description: 
//     Ties the UART receiver to the LED controller
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


module uart_led (
  // Write side inputs
  input            clk_rx,          // Clock input
  input            rst_clk_rx,      // Active HIGH reset
  input            rxd_i,           // RS232 RXD pin 
  output     [7:0] led_o            // 8 LED outputs
);

//***************************************************************************
// Interface definitions
//***************************************************************************
ifc_signals ifc(
                .clk_rx(clk_rx),
                .rst_clk_rx(rst_clk_rx)
                );



//***************************************************************************
// Parameter definitions
//***************************************************************************

  parameter BAUD_RATE           = 115_200;
  parameter CLOCK_RATE          = 125_000_000;

//***************************************************************************
// Wire definitions
//***************************************************************************
  
  // wire [7:0]  rx_data;		    // Data output of uart_rx
  // wire 		    rx_data_rdy;    // Data output of uart_rx

 uart_rx #(
    .CLOCK_RATE   (CLOCK_RATE),
    .BAUD_RATE    (BAUD_RATE) 
  ) uart_rx_i0 (
  // .clk_rx			  (clk_rx),
	// .rst_clk_rx		(rst_clk_rx),
	// .rx_data		    (rx_data),
	// .rx_data_rdy  	(rx_data_rdy),
    .ifc            (ifc.master),
    .rxd_i          (rxd_i),
    .rxd_clk_rx     (),    
    .frm_err        ()
  );

  led_ctl led_ctl_i0 (
  // .clk_rx			(clk_rx),
	// .rst_clk_rx		(rst_clk_rx),
	// .rx_data		(rx_data),
	// .rx_data_rdy  	(rx_data_rdy),
    .ifc            (ifc.slave),
    .led_o          (led_o)
  );

endmodule

