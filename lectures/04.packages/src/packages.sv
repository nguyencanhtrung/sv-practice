/* -------------------------------------------
* Author:   Nguyen Canh Trung
* Email:    nguyencanhtrung@me.com
* Date:     2023-09-07 08:59:19
* Filename: packages
* Last Modified by:     Nguyen Canh Trung
* Last Modified time:   2023-09-07 08:59:19
* --------------------------------------------*/
package my_package;
    typedef enum {RED, GREEN, BLUE} color_t;
    typedef struct {
        int field_a;
        color_t c;
    } MyStruct;
endpackage

module my_module;
import my_package::*;
    MyStruct s;
    initial begin
        s.field_a = 1;
        s.c = RED;

        #1 $display("s.field_a = %d, s.c = %s", s.field_a, s.c.name());
    end
endmodule