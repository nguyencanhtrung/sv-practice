`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2016 06:00:00 PM
// Design Name: 
// Module Name: tb_arith_logic
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

module tb_arith_logic;

    // Inputs
    logic arith_logic_sel;
	logic [7:0] ip_data1, ip_data2;
	logic [1:0] operation;

    // Output
	logic [15:0] data_out;
                
    // instantiate the unit under test (uut)
    arith_logic inst (  .arith_logic_sel(arith_logic_sel),           
						.operation(operation),
						.ip_data1(ip_data1),   
						.ip_data2(ip_data2),   
						.data_out(data_out)
					 );
					 
    initial 
    begin
        // initialize inputs
        arith_logic_sel = 0;
		operation = 2'b00;
        ip_data1 = 0;
        ip_data2 = 0;
    end
    
    initial 
    begin
        arith_logic_sel = 0;
		ip_data1 = 8'd20;
        ip_data2 = 8'd10;
		
		operation = 2'b00;		
		
        #10;
		operation = 2'b01;
                
        #10;
		operation = 2'b10;
                
        #10;
		operation = 2'b11;    
        
        #10;
        arith_logic_sel = 1;
		ip_data1 = 8'd60;
        ip_data2 = 8'd15;
		
		operation = 2'b00;		
		        
        #10;
		operation = 2'b01;
                
        #10;
		operation = 2'b10;
                
        #10;
		operation = 2'b11;
    end    
endmodule
