module print_ascii_verilog;
  
	`define a 8'h61
	`define b 8'h62
	`define c 8'h63
	`define d 8'h64
	`define e 8'h65
	`define f 8'h66
	`define g 8'h67
	`define h 8'h68
	`define i 8'h69
	`define j 8'h6A
	`define k 8'h6B
	`define l 8'h6C
	`define m 8'h6D
	`define n 8'h6E
	`define o 8'h6F
	`define p 8'h70
	`define q 8'h71
	`define r 8'h72
	`define s 8'h73
	`define t 8'h74
	`define u 8'h75
	`define v 8'h76
	`define w 8'h77
	`define x 8'h78
	`define y 8'h79
	`define z 8'h7A
	
  reg [7:0] word [0:4];
		
	integer cnt;
	reg [7:0] lcd_bus;
  
  initial 
    begin 
      	word[0] = `h;
      	word[1] = `e;
	     word[2] = `l;
	     word[3] = `l;
	     word[4] = `o;      
      for(cnt=0; cnt<5; cnt=cnt+1) 
	     begin
	       lcd_bus = word[cnt];
	       $display ("ASCII value of word[%d] = %h", cnt, lcd_bus);
	     end 
    end 
    
endmodule
