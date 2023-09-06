`timescale 1ns / 1ps

module security_sv_tb;
  parameter per = 10.0;

  // inputs
  logic front_door;
  logic rear_door;
  logic window;
  logic clk;
  logic reset;
  logic [3:0] keypad = 4'b0011;

  // outputs
  logic alarm_siren;
  logic is_armed;
  logic is_wait_delay;

  function integer check_state (fn_exp_arm, fn_exp_wait, fn_exp_siren);

        if ((is_armed      !== fn_exp_arm) || 
            (is_wait_delay !== fn_exp_wait) || 
            (alarm_siren   !== fn_exp_siren)  )
        
             return 0;
        else
             return 1;
      
  endfunction
 
  task end_sim;
      begin
          $display("%t       : armed=%b, wait=%b, siren=%b",
          $realtime(), is_armed, is_wait_delay, alarm_siren); 
          $stop;
          $finish; // end the simulation on an error
      end
  endtask
 
 // instantiate the unit under test (uut)
  security_sv uut (
    .front_door(front_door), 
    .rear_door(rear_door), 
    .window(window), 
    .clk(clk), 
    .reset(reset), 
    .keypad(keypad), 
    .alarm_siren(alarm_siren), 
    .is_armed(is_armed),
    .is_wait_delay(is_wait_delay)
  );

  initial begin
    // initialize inputs
    clk = 0;
    reset = 0;
    front_door = 0;
    rear_door = 0;
    window = 0;
    keypad = 4'b0000;   
  end

  initial
    $timeformat(-9,2," ns", 12);
      
  always #(per/2) clk = ~clk;

  initial  
  begin
    $display("%t       starting test - asserting reset",$realtime());
    reset = 1'b1;
    #(10 * per) reset = 1'b0;
    $display("%t       deasserting reset",$realtime());
    #(1 * per);
    // test that reset took you to the disarmed state    
    if (!check_state(0,0,0))
       begin 
          $display("**ERROR: reset state is not disarmed");
          end_sim;
       end   
    // test that you stay disarmed
    #(10 * per) ;
    if (!check_state(0,0,0))
       begin 
          $display("**ERROR: did not remain in disarmed state");
          end_sim;
       end   
       
    #(10 * per) ;

    $display("%t       testing arming",$realtime());
    keypad = 4'b0011;
    #(1 * per);
    // test that arm code took you to the armed state
    if (!check_state(1,0,0))
       begin 
          $display("**ERROR: arming doesn't arm the alarm");
          end_sim;
       end     
    // test that we stay armed even if the code goes away
    keypad = 4'b0000;
    #(10 * per) ;
    if (!check_state(1,0,0))
       begin 
          $display("**ERROR: doesn't remain in the armed state");
          end_sim;
       end 
    $display("%t       testing disarming",$realtime());
    // check that disarming from the armed state works
    keypad = 4'b1100;
    #(1 * per) ;
    // test that disarm code took you to the disarmed state
    if (!check_state(0,0,0))
       begin 
          $display("**ERROR: disarming code doesn't disarm alarm");
          end_sim;
       end 
    // test that we stay disarmed
    keypad = 4'b0000;
    #(10 * per) ;
    if (!check_state(0,0,0))
       begin 
          $display("**ERROR: doesn't remain disarmed");
          end_sim;
       end 

    #(10 * per) ;

    $display("%t       testing arming, faulting and disarming before alarm",
      $realtime());
    keypad = 4'b0011;
    #(1 * per);
    // test that arm code took you to the armed state
    if (!check_state(1,0,0))
       begin 
          $display("**ERROR: arming code doesn't re-arm alarm");
          end_sim;
       end
    keypad = 4'b0000;
    front_door = 1; // fault the front door
    #(1 * per);
    if (!check_state(0,1,0))
      begin 
        $display("**ERROR: faulting a zone doesn't start wait");
        end_sim;
      end
    front_door = 0; // unfault it right away
    #(50 * per);
    if (!check_state(0,1,0))
      begin 
        $display("**ERROR: not still waiting after 50 clocks");
        end_sim;
      end 
    keypad = 4'b1100;
    #(1 * per) ;
    // test that disarm code took you to the disarmed state
    if (!check_state(0,0,0))
      begin 
        $display("**ERROR: disarming while waiting doesn't work");
        end_sim;
      end      
    keypad = 4'b0000;
    
    #(10 * per) ;
    $display("%t       testing arming, faulting and waiting for alarm",
      $realtime());
    keypad = 4'b0011;
    #(1 * per);
    // test that arm code took you to the armed state
    if (!check_state(1,0,0))
      begin 
         $display("**ERROR: arming code doesn't re-arm alarm");
         end_sim;
      end
    keypad = 4'b0000;
    rear_door = 1; // fault the rear door
    #(1 * per);
    if (!check_state(0,1,0))
      begin 
        $display("**ERROR: faulting a zone doesn't start wait");
        end_sim;
      end
    rear_door = 0; // unfault the rear door
    #(110 * per);
    if (!check_state(0,0,1))
      begin 
        $display("**ERROR: alarm siren didn't go off");
        end_sim;
      end
    keypad = 4'b1100;
    #(1 * per) ;
    // test that disarm code took you to the disarmed state
    if (!check_state(0,0,0))
       begin 
         $display("**ERROR: disarming while the alarm siren is on doesn't work");
         end_sim;
       end
    keypad = 4'b0000;

    #(10 * per) ;
    $display("%t       test passed", $realtime());
    $finish;

  end      
  
endmodule
