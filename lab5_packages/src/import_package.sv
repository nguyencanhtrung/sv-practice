`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2016 12:43:58 PM
// Design Name: 
// Module Name: import_package
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

// Importing package into this module


module import_package (	input logic arith_logic_sel,                    // Selects between arith or logic operations
						input logic [1:0] operation,					// Selects which arith or logic operations is to be done
						input logic [7:0] ip_data1, ip_data2,			// Two data inputs
						output logic [15:0] data_out);					// Output of the selected operation
    
    always @ (*)
    begin          
		
		arith_logic_info arith_data, logic_data;	// Creating two objects arith_data and logic_data
		arith_logic_result final_result;			// Creating an object of structure arith_logic_result

		if (arith_logic_sel==0)
		// Selecting Arithmetic operation		
        begin
			arith_data.arithmetic_op = arith_operation'(operation);
			arith_data.logical_op = logic_operation'(0);
			
			arith_data.data1 = ip_data1;
			arith_data.data2 = ip_data2;		
			
            case (arith_data.arithmetic_op) 		// Accessing enum data type through arith_data input
            // As per the value of enum, do the arithmatic operations
            // Accesing the Packed Structure for two datas and storing the result in an Packed Union 

            // Using two functions for addition and subtraction
                add :  
                sub :  
                
            // Using two tasks for multiplication and division
                mul : 
				div :
            endcase
			data_out = final_result.result.arith_result;						
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
                nand_op : final_result.result.logic_result = ~((logic_data.data1) & (logic_data.data2));          
                nor_op  : final_result.result.logic_result = ~((logic_data.data1) | (logic_data.data2));
                not_op  : final_result.result.logic_result = ~ (logic_data.data1);
                xor_op  : final_result.result.logic_result =  ((logic_data.data1) ^ (logic_data.data2));
            endcase
			data_out = final_result.result.logic_result;			
        end            
    end
                  
endmodule