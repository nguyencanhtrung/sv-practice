/* -------------------------------------------
* Author:   Nguyen Canh Trung
* Email:    nguyencanhtrung@me.com
* Date:     2023-09-07 08:59:05
* Filename: functions
* Last Modified by:     Nguyen Canh Trung
* Last Modified time:   2023-09-07 08:59:05
* --------------------------------------------*/
module ram #(
    parameter WIDTH = 32,
    parameter DEPTH = 256)
    (
    input clk,
    input [log2i(DEPTH)-1:0] addr,
    input [WIDTH-1:0] data_in,
    input write,
    input enable,
    output reg[WIDTH-1:0] data_out
    );

    // synthesis translate_off

    // Function example
    function [7:0] reverse_nibble;
        input [7:0] inp_byte;
        logic [3:0] temp1;
        logic [3:0] temp2;

        // 1st method: Traditional way
        for (int idx = 0; idx < 4; idx++) begin
            temp1[idx] = inp_byte[idx];
            temp2[idx] = inp_byte[idx+4];
        end

        // 2nd method: Streaming operator
        // return {<<4{inp_byte}};
        // return {temp1, temp2};           // return style
        reverse_nibble = {temp1, temp2};    // non-return style

    endfunction

    logic [7:0] given_byte;
    logic [7:0] new_byte;

    initial begin
        given_byte = 8'b1100_1010;
        new_byte = reverse_nibble(given_byte);
        $display("%b has been reverse as %b", given_byte, new_byte );
    end

    // Static function
    // By default a function is static
    // ARE NOT SYNTHESIZABLE
    function int cumulative_sum (input int n);
        int sum;
        sum += n;
        return sum;
    endfunction

    initial begin
        for(int i = 0; i < 10; i++) begin
            $display("Cumulative sum of %0d is %0d", i, cumulative_sum(i));
        end
    end

    // Automatic function
    function automatic int cumulative_sum_auto (input int n);
        int sum;
        sum += n;
        return sum;
    endfunction

    initial begin 
        for(int i = 0; i < 10; i++) begin
            $display("Cumulative sum auto of %0d is %0d", i, cumulative_sum_auto(i));
        end
    end

    // Passing argument by reference example
    int data[];

    initial begin
        init_array(data);   // fill with 1 by default
        for (int i=0; i < data.size(); i++) begin
            $display("data[%0d] = %0d", i, data[i]);
        end

        init_array(data,2);
        for (int i=0; i < data.size(); i++) begin
            $display("data[%0d] = %0d", i, data[i]);
        end
    end

    function automatic void init_array(ref int arr[], input int fill_with = 1);
        arr = new[5];
        for (int i=0; i < arr.size(); i++) begin
            arr[i] = fill_with;
            $display("arr[%0d] = %0d", i, arr[i]);
        end
    endfunction


    // synthesis translate_on

    // Constant function
    // Defined localy in the module calling it
    // All arguments must be constant
    // Evaluated at elaboration time
    // No return value style
    function integer log2i(input[31:0] value);
    begin
        value = value - 1;
        for(log2i = 0; value > 0; log2i = log2i + 1) begin
            value = value >> 1;
        end

        $display("You will never see this print!!!");
    end
    endfunction


    // Function with return value (equivalent but longer coding style)
    // function integer log2i(input[31:0] value);
    // begin
    //     integer result;
    //     value = value - 1;
    //     for(result = 0; value > 0; result = result + 1) begin
    //         value = value >> 1;
    //     end
    //     return result;
    //     $display("You will never see this print!!!");
    // end
    // endfunction


    // Memory implementation
    logic [WIDTH-1:0] mem [DEPTH-1:0];

    always_ff @(posedge clk) begin
        if (enable) begin
            if (write) begin
                mem[addr] <= data_in;
            end
            data_out <= mem[addr];
        end
    end

endmodule