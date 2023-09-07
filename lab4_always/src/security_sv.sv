`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2014 05:29:18 PM
// Design Name: 
// Module Name: security_sv
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
module security_sv(
    input front_door,
    input rear_door,
    input window,
    input clk,
    input reset,
    input [3:0] keypad,
    output logic alarm_siren, // replace all reg and wire with logic
    output logic is_armed,
    output logic is_wait_delay
    );

 // set the delay value (the number of clocks between a faulted zone and the
 // alarm going off)
 parameter        delay_val    = 100;

 // Variables used for counting 100 (delay_val) clock cycles
 logic start_count;
 logic count_done; 
 logic [6:0] delay_cntr = 0 ; // Max value of delay_cntr is delay_val (i.e., d'100 or b'1100100)

 // Enumerated types provide a means for defining a variable that has a
 //  restricted set of legal values. The values are represented with labels
 // instead of digital logic values.

 enum logic[31:0] {disarmed, armed, wait_delay, alarm} curr_state, next_state;
 
 logic [2:0] sensors ; // used to combine inputs
 always_comb sensors = { front_door, rear_door, window };


 // procedural block for incrementing the state machine
//  always @ ( posedge clk )
 always_ff @ ( posedge clk ) begin
   if (reset)
     curr_state <= disarmed ;
   else 
     curr_state <= next_state ;
   end   

 // procedural block to determine the next state
//  always @ ( curr_state, sensors, keypad, count_done ) begin
always_comb begin
   unique case ( curr_state )
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
	// always @ ( posedge clk ) begin
  always_ff @ ( posedge clk ) begin
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

	
	always_comb start_count = (( curr_state == armed) && (sensors != 3'b000));

 // Implement the delay counter.
 // Loads delay_cntr with delay_val-1 when start_count is high, then counts down to 0 and stops. 
 // The condition delay_cntr = 0 triggers the next state transition in the main state machine
       
	// always @ ( posedge clk) begin
  always_ff @ ( posedge clk) begin  
  // always_comb begin
    if (reset) 
      delay_cntr <= 0;
    else if (start_count) 
      delay_cntr <= delay_val - 1'b1; 
    else if (curr_state != wait_delay) 
      delay_cntr <= 0;
    else if (delay_cntr != 0)
      delay_cntr <= delay_cntr - 1'b1;
	end  

	always_comb count_done = (delay_cntr == 0);

endmodule


