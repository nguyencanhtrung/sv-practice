`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 09:50:26 AM
// Design Name: 
// Module Name: struct_test
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
   typedef struct {
      int x;
      int y;
      logic[7:0] z;
   } my_struct;
   
   typedef logic[3:0] nibble;

module struct_test();

   my_struct s1;
   int k = 1;

   // test structre assignments
   initial begin
      #1 s1 = '{123, 4, 8'h04};           // by place
      #1 $display(s1.x, s1.y, s1.z);
      #1 s1 = '{x:456, y:7, z:8'h05};     // by name
      #1 $display(s1.x, s1.y, s1.z);
      // #1 s1 = '{int:789, logic:8'h06};   // by type
      // #1 $display(s1.x, s1.y, s1.z);
      #1 s1 = '{x:4560, default:0};       // by default
      #1 $display(s1.x, s1.y, s1.z);
   end
   
   struct {
      logic [7:0] a;
      int b;
      bit signed [31:0] c;
      nibble d,e,f;
   } s2;


    // Simulators consider bit signed [31:0] = int  (be carefull in the future struct assignment)
   initial begin
      s2 = '{int:1, a:2, e:5, nibble:3, default:0};
      #1 $display("s2.a=%d, s2.b=%d, s2.c=%d, s2.d=%d, s2.e=%d, s2.f=%d", s2.a, s2.b, s2.c, s2.d, s2.e, s2.f);
   end
   
endmodule
