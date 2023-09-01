`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2012 02:51:21 PM
// Design Name: 
// Module Name: security_verilo
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


module security_verilog(
    input front_door,
    input rear_door,
    input window,
    input clk,
    input reset,
    input [3:0] keypad,
    output reg alarm_siren,
    output reg is_armed,
    output reg is_wait_delay
    );

 // set the delay value (the number of clocks between a faulted zone and the
 // alarm going off)
 parameter        delay_val    = 100;

 // Variables used for counting 100 (delay_val) clock cycles
 wire start_count;
 wire count_done;
 reg [6:0] delay_cntr = 0 ; // Max value of delay_cntr is delay_val (i.e., d'100 or b'1100100)

 localparam       disarmed   =  2'd0,
                  armed      =  2'd1,
                  wait_delay =  2'd2,
                  alarm      =  2'd3;
            
 reg [1:0] curr_state, next_state ;

 wire [2:0] sensors ; // used to combine inputs
 assign sensors = { front_door, rear_door, window } ;
 
 //  procedural block for incrementing the state machine
 always @ ( posedge clk )
   if (reset)
     curr_state <= disarmed ;
   else 
     curr_state <= next_state ;
          

 // procedural block to determine the next state
 always @ ( curr_state, sensors, keypad, count_done ) begin
       
   case ( curr_state )
     disarmed: begin
       if ( keypad == 4'b0011 )
         next_state <= armed;
       else
         next_state <= curr_state ;
     end
                   
     armed: begin
       if ( sensors != 3'b000 )
         next_state <= wait_delay;
       else if ( keypad == 4'b1100)
         next_state <= disarmed;
       else
         next_state <= curr_state ;                       
     end

     wait_delay: begin                  
       if (count_done == 1'b1)                             
         next_state <= alarm;
       else if ( keypad == 4'b1100 )
         next_state <= disarmed ;
       else
         next_state <= curr_state ;                 
     end
              
     alarm: begin
       if ( keypad == 4'b1100 )
         next_state <= disarmed;
       else
         next_state <= curr_state ;
     end

   endcase
 end  

 // procedural block to generate the state machine output values
	always @ ( posedge clk ) begin
		if (reset) begin
			is_armed      <= 1'b0 ;
			is_wait_delay <= 1'b0 ;
			alarm_siren   <= 1'b0 ;
		end
		else
		begin
			is_armed      <= ( next_state == armed );
			is_wait_delay <= ( next_state == wait_delay );
			alarm_siren   <= ( next_state == alarm ) ;
		end
	end

	assign start_count = (( curr_state == armed) && (sensors != 3'b000));
	
 // Implement the delay counter.
 // Loads delay_cntr with delay_val-1 when start_count is high, then counts down to 0 and stops. 
 // The condition delay_cntr = 0 triggers the next state transition in the main state machine
       
	always @ ( posedge clk) begin  
	if (reset) 
		delay_cntr <= 0;
	else if (start_count) 
		delay_cntr <= delay_val - 1'b1; 
	else if (curr_state != wait_delay) 
		delay_cntr <= 0;
	else if (delay_cntr != 0)
		delay_cntr <= delay_cntr - 1'b1;
	end  

	assign count_done = (delay_cntr == 0);

endmodule

