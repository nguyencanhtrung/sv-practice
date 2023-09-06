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
    
 
// User defined enumerated data type declaration
typedef enum logic[1:0] {add=0, sub, mul, div} arith_operation;
typedef enum logic[1:0] {nand_op=0, nor_op, not_op, xor_op} logic_operation;

// Creating one Packed and one Unpacked Structure here
typedef struct packed {
    arith_operation arithmetic_op;
    logic_operation logical_op;
    logic [7:0] data1;
    logic [7:0] data2;
    logic [15:0] arith_result;
    logic [15:0] logic_result;
} arith_logic_info;


module arith_logic (    input logic arith_logic_sel,                // Selects between arith or logic operations
						input logic [1:0] operation,                // Selects which arith or logic operations is to be done
						input logic [7:0] ip_data1, ip_data2,       // Two data inputs
						output logic [15:0] data_out);              // Output of the selected operation
    
    always @ (*)
    begin          
		
		arith_logic_info arith_data, logic_data;	// Creating two objects arith_data and logic_data
		
        if (arith_logic_sel==0)
		// Selecting Arithmetic operation		
        begin
			//Read the input data
			arith_data.arithmetic_op = arith_operation'(operation);
			arith_data.logical_op = logic_operation'(0);
			arith_data.data1 = ip_data1;
			arith_data.data2 = ip_data2;
		
            case (arith_data.arithmetic_op) 		// Accessing enum data type through arith_data input
            // As per the value of enum, do the arithmatic operations
            // Accesing the Packed Structure for two datas and storing the result in an Packed Union 
                add : arith_data.arith_result = arith_data.data1 + arith_data.data2;                 
                sub : arith_data.arith_result = arith_data.data1 - arith_data.data2;
                mul : arith_data.arith_result = arith_data.data1 * arith_data.data2;
                div : arith_data.arith_result = arith_data.data1 / arith_data.data2;
            endcase
			data_out = arith_data.arith_result; //Write the result to the output			
        end

        else
		// Selecting Logical operation		
        begin
			logic_data.arithmetic_op = arith_operation'(0);
			logic_data.logical_op = logic_operation'(operation);

			logic_data.data1 = ip_data1;
			logic_data.data2 = ip_data2;
		
            case (logic_data.logical_op)        // Accessing enum data type through logic_data input
            // As per the value of enum, do the logic operations
            // Accesing the Packed Structure for two datas and storing the result in an Packed Union 
                nand_op : logic_data.logic_result = ~((logic_data.data1) & (logic_data.data2));          
                nor_op  : logic_data.logic_result = ~((logic_data.data1) | (logic_data.data2));
                not_op  : logic_data.logic_result = ~ (logic_data.data1);
                xor_op  : logic_data.logic_result =  ((logic_data.data1) ^ (logic_data.data2));
            endcase
			data_out = logic_data.logic_result;
        end            
    end 
                  
endmodule