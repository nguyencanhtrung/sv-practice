## SystemVerilog for design practice

* Course syllabus: `course_syllabus.pdf`
* Lectures: `lectures.pdf`
* Labs: `labs.pdf`
* Book: `SystemVerilogForDeisgn_2nd.pdf`

The course merely focuses on RTL design aspect.

<strong>Hierarchy</strong>

* `lab*_` completed labs
* `lectures` includes examples showed in the lecture

### How to create vivado project for each lab

```
cd <folder>
make compile
```

`make` command lines:

```
make
    compile     create vivado project
    view        open vivado project
    clean       clean vivado project
```

### Labs' description

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
    ...
    ``` 

    Equivalent SV code

    ```
    // System Verilog
    typedef enum bit [7:0] {a = 8'h61, b,c,d,..} alphabet; 

    ```
* lab2
    * Using packed `struct` to encapsulate objects

    ```
    typedef struct packed {
        arith_operation arithmetic_op;
        logic_operation logical_op;
        logic [7:0] data1;
        logic [7:0] data2;
        logic [15:0] arith_result;
        logic [15:0] logic_result;
    } arith_logic_info;
    ```

* lab3
    * Using packed `union` in RTL design 

* lab 4
    * New features in SV: `always_ff`, `always_comb`, `always_latch` and how to use it in RTL design

* lab 5
    * Using functions, tasks and packages in RTL design

* lab 6
    * Using interface to pack signals
    * Interface modprobs