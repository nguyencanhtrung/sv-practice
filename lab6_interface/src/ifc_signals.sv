//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 04:18:32 PM
// Design Name: 
// Module Name: ifc_signals
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


interface ifc_signals(
    input logic clk_rx,
    input logic rst_clk_rx
);

logic [7:0] rx_data;
logic       rx_data_rdy;

modport master(
    input clk_rx,
    input rst_clk_rx,
    output rx_data,
    output rx_data_rdy
);

modport slave(
    input clk_rx,
    input rst_clk_rx,
    input rx_data,
    input rx_data_rdy
);

endinterface
