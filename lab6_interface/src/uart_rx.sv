//-----------------------------------------------------------------------------
//  
//  Copyright (c) 2009 Xilinx Inc.
//
//  Project  : Programmable Wave Generator
//  Module   : uart_rx.sv
//  Parent   : wave_gen.sv and uart_led.sv
//  Children : uart_rx_ctl.sv uart_baud_gen.sv meta_harden.sv
//
//  Description: 
//     Top level of the UART receiver.
//     Brings together the metastability hardener for synchronizing the 
//     rxd pin, the baudrate generator for generating the proper x16 bit
//     enable, and the controller for the UART itself.
//     
//
//  Parameters:
//     BAUD_RATE : Baud rate - set to 57,600bps by default
//     CLOCK_RATE: Clock rate - set to 50MHz by default
//
//  Local Parameters:
//
//  Notes       : 
//
//  Multicycle and False Paths
//     The uart_baud_gen module generates a 1-in-N pulse (where N is
//     determined by the baud rate and the system clock frequency), which
//     enables all flip-flops in the uart_rx_ctl module. Therefore, all paths
//     within uart_rx_ctl are multicycle paths, as long as N > 2 (which it
//     will be for all reasonable combinations of Baud rate and system
//     frequency).
//

`timescale 1ns/1ps

module uart_rx (
  // Write side inputs
  ifc_signals  ifc,                 // Interface to master
  input        rxd_i,               // RS232 RXD pin - Directly from pad
  output       rxd_clk_rx,          // RXD pin after synchronization to clk_rx
  output       frm_err              // The STOP bit was not detected
);
//***************************************************************************
// Interface definitions
//***************************************************************************
// ifc_signals ifc_uart_ctl(
//                 .clk_rx     (ifc.clk_rx),
//                 .rst_clk_rx (ifc.rst_clk_rx)
//                 );

// assign ifc.rx_data = ifc_uart_ctl.rx_data;
// assign ifc.rx_data_rdy = ifc_uart_ctl.rx_data_rdy;

//***************************************************************************
// Parameter definitions
//***************************************************************************

  parameter BAUD_RATE    = 115_200;             // Baud rate
  parameter CLOCK_RATE   = 50_000_000;

//***************************************************************************
// Wire declarations
//***************************************************************************

  wire             baud_x16_en;  // 1-in-N enable for uart_rx_ctl FFs
  
//***************************************************************************
// Code
//***************************************************************************

  /* Synchronize the RXD pin to the clk_rx clock domain. Since RXD changes
  * very slowly wrt. the sampling clock, a simple metastability hardener is
  * sufficient */
  meta_harden meta_harden_rxd_i0 (
    .clk_dst      (ifc.clk_rx),
    .rst_dst      (ifc.rst_clk_rx), 
    .signal_src   (rxd_i),
    .signal_dst   (rxd_clk_rx)
  );

  uart_baud_gen #
  ( .BAUD_RATE  (BAUD_RATE),
    .CLOCK_RATE (CLOCK_RATE)
  ) uart_baud_gen_rx_i0 (
    .clk         (ifc.clk_rx),
    .rst         (ifc.rst_clk_rx),
    .baud_x16_en (baud_x16_en)
  );

  uart_rx_ctl uart_rx_ctl_i0 ( 
    // .ifc           (ifc_uart_ctl.master),
    .ifc           (ifc),
    .baud_x16_en   (baud_x16_en),  
    .rxd_clk_rx    (rxd_clk_rx),
    .frm_err       (frm_err)
  );
    
endmodule

