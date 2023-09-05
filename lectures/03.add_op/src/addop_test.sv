`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 04:14:41 PM
// Design Name: 
// Module Name: addop_test
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


module addop_test();
    logic [3:0] A = 4'b1111;
    logic [3:0] B = 4'bxxz1;
    logic [3:0] C = 4'bxxz0;

    initial begin
        if (A ==? B)
            $display("A %b matches with B %b", A, B);
        if (A !=? C)
            $display("A %b does not match with C %b", A, C);
    end
endmodule
