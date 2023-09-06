`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 04:14:41 PM
// Design Name: 
// Module Name: addop_test
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


module addop_test();

    // Wildcard equality operators
    logic [3:0] A = 4'b1111;
    logic [3:0] B = 4'bxxz1;
    logic [3:0] C = 4'bxxz0;

    initial begin
        if (A ==? B)
            $display("A %b matches with B %b", A, B);
        if (A !=? C)
            $display("A %b does not match with C %b", A, C);
    end
    


    // Inside operator
    int a;
    initial begin
        a = 32;
        #1 a = 4;
        #1 a = 5;
        #1 a = 4;
    end

    always @(*) begin
        if (a inside{[1:8]})
            $display("a = %d is inside 1..8", a);
        else if (a inside {2, 4, 8, 16, 32})
            $display("a = %d is inside {2, 4, 8, 16, 32}", a);
    end

    // Streaming operators (pack and unpack)
    bit [4:0] x = 5'b10100;

    initial begin
        $display("x = %b", x);
        $display("<<{x} = %b", {<<{x}});
        $display(">>{x} = %b", {>>{x}});
        $display("<<2{x} = %b", {<<2{x}});

        $display("<<{8'b1000_1010} = %b", {<<{8'b1000_1010}});      // bit reverse
        $display("<<4{6'b10_0010} = %b", {<<4{6'b10_0010}});        // 001010
        $display("<<5{6'b10_0010} = %b", {<<5{6'b10_0010}});        // 000101
        $display(">>5{6'b10_0010} = %b", {>>5{6'b10_0010}});        // 100010
    end

endmodule
