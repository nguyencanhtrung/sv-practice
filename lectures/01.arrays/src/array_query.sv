`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2023 04:26:58 PM
// Design Name: 
// Module Name: array_query
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


module array_query();
    logic [0:3] [7:0] packed_array;
    logic [3:0] [2:1] unpacked_array [1:5] [2:8];
    
    int ii;
    
    initial begin
        packed_array = 32'h01234567;

        
        #1 $display("%h", packed_array);
        
        packed_array[3-:2] = packed_array[0+:2];
        #1 $display("%h", packed_array);
        
        $display("%s", {32{"="}});
        $display("#dimensions = %d", $dimensions(packed_array));
        $display("left bound = %d", $left(packed_array));
        $display("right bound = %d", $right(packed_array));
        $display("low bound = %d", $low(packed_array));
        $display("high bound = %d", $high(packed_array));
        $display("size = %d", $size(packed_array, 2));
        $display("increase = %s", $increment(packed_array) == 1 ? "true" : "false" );
        
//        for (integer ii = 0; ii < $size(unpacked_array, 1); ii++) begin:
//            unpacked_array[ii] = 8'h01;
//        end
        
        
        #1 $display("#unpacked dimensions = %d", $unpacked_dimensions(unpacked_array));
        $finish;
    end   
endmodule
