/* -------------------------------------------
* Author:   Nguyen Canh Trung
* Email:    nguyencanhtrung@me.com
* Date:     2023-09-07 08:59:12
* Filename: tasks
* Last Modified by:     Nguyen Canh Trung
* Last Modified time:   2023-09-07 08:59:12
* --------------------------------------------*/
`timescale 1ns / 1ps

`define test_ref

module task_counter;

`ifndef test_ref;
    integer counter;

    task count;
        input [31:0] inc_by;
        output [31:0] next_val;
        integer cnt;
        begin
            cnt = cnt + inc_by;
            next_val = cnt;
        end
    endtask

    initial 
        //shall print %t with scaled in ns (-9), with 2 precision digits, and would print the " ns" string
        $timeformat(-9, 2, " ns", 20); 

    initial count.cnt = 0;
    always #5 count(1, counter);

    always @(counter)
        $display("%5t: counter's value is now set to %0d", $time, counter);

    initial #30 $finish;

`endif

    // Pass by reference
    int a;
    initial begin
        #10 a = 10;
        #10 a = 20;
        #10 a = 30;
        #10 $finish;
    end

    task automatic pass_by_val(int x);
        forever begin
            @x $display("pass_by_val: %0d", x);
        end
    endtask

    task automatic pass_by_ref(ref int x);
        forever begin
           @x  $display("pass_by_ref: %0d", x);
        end
    endtask

    initial begin
        pass_by_val(a);
    end

    initial begin
        pass_by_ref(a);
    end
    
endmodule