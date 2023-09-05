`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2023 02:16:40 PM
// Design Name: 
// Module Name: enum_2
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


typedef enum bit[3:0] {IDLE, GO, WORK[12], STOP, DONE} state_t;

module test_enum;
  state_t state;
  
  always #5 state <= state.prev();
  
  initial begin
    $monitor("State now is to %02d {%s}", state, state.name());
  end

endmodule
