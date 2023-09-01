## Labs for SystemVerilog introduction

It shows the advance of SV compared to verilog in design RTL.

* lab1
    * Using 4-state data type `logic` in System Verilog to replace `wire` and `reg` in verilog
    * Using `enum` to modeling FSM state
    * Using `enum` to initialize variables when the values held by the variables need to be incremented by 1 sequentially

    ```
    // Verilog

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
    ``` 

    ```
    // System Verilog
    typedef enum bit [7:0] {a = 8'h61, b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z} alphabet; 

    ```
