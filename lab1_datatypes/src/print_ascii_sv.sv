module print_ascii_sv;
  
    typedef enum bit [7:0] {a = 8'h61, b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z} alphabet; 
    alphabet [0:4] word;
	logic [7:0] lcd_bus;
  
  initial 
    begin 
      	word[0] = h;
      	word[1] = e;
	     word[2] = l;
	     word[3] = l;
	     word[4] = o;      
      for(bit[2:0] cnt=0; cnt<5; cnt=cnt+1) 
	     begin
	       lcd_bus = word[cnt];
	       $display ("ASCII value of word[%d] = %h", cnt, lcd_bus);
	     end 
    end 
    
endmodule
