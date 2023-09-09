`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2012 07:45:45 PM
// Design Name: 
// Module Name: top
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

`timescale 1ns/1ps


module top (
  // Write side inputs
  input            clk_pin_p,      // Clock input (from pin)
  input            clk_pin_n,      //   - differential pair
  input            rst_pin,        // Active HIGH reset (from pin)
  input            rxd_pin,        // RS232 RXD pin - directly from pin
  output     [7:0] led_pins         // 8 LED outputs
  );


    wire             clk_rx;
   
    IBUFGDS IBUFG_clk_i0   ( .I  (clk_pin_p),   
                         .IB (clk_pin_n),
                         .O  (clk_rx)
                       );

  // Metastability harden the rst - this is an asynchronous input to the
  // system (from a pushbutton), and is used in synchronous logic. Therefore
  // it must first be synchronized to the clock domain (clk_rx in this case)
  // prior to being used. A simple metastability hardener is appropriate here.
  meta_harden meta_harden_rst_i0 (
    .clk_dst      (clk_rx),
    .rst_dst      (1'b0),    // No reset on the hardener for reset!
    .signal_src   (rst_pin),
    .signal_dst   (rst_clk_rx)
  );

  uart_led uart_led_i0(
        .clk_rx (clk_rx),
        .rst_clk_rx (rst_clk_rx),
        .rxd_i (rxd_pin),
        .led_o (led_pins)
    );

endmodule
