`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2016 05:05:11 PM
// Design Name: 
// Module Name: arith_logic
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
    
package arith_logic_pkg;
    // User defined enumerated data type declaration
    typedef enum logic[1:0] {add=0, sub, mul, div} arith_operation;
    typedef enum logic[1:0] {nand_op=0, nor_op, not_op, xor_op} logic_operation;
    
    // User defined Packed Structure declaration 
    typedef struct packed 	{	arith_operation arithmetic_op;
								logic_operation logical_op;
                                logic [7:0] data1;
								byte data2;
							} arith_logic_info;
							
    // User defined Unpacked Structure declaration 	                                                                                                       
	typedef	struct    	{	// User defined Packed Union declaration                                 
							union packed 	{	logic [15:0] arith_result;					
												logic [15:0] logic_result;
											} result;                                                  
						} arith_logic_result;

    function [15:0] addition;
        input [7:0] a, b;
        addition = a + b;
    endfunction

    function [15:0] subtraction;
        input [7:0] a, b;
        subtraction = a - b;
    endfunction

    task mutiplication;
        input [7:0] a, b;
        output [15:0] res;
        res = a * b;
    endtask

    task division;
        input [7:0] a, b;
        output [15:0] res;
        res = a / b;
    endtask
endpackage


