# ------------------------------------------
# Author:   Nguyen Canh Trung
# Email:    trungnc@soc.one
# Date:     2023-09-07 08:54:37
# Filename: create_proj
# Last Modified by:   Nguyen Canh Trung
# Last Modified time: 2023-09-08 16:15:09
# ------------------------------------------
set current_path [file dirname [ file normalize [ info script ] ] ]
puts $current_path

set src_files [list \
    [glob "${current_path}/src/*.sv"] \
]


create_project labs . -part xcku040-ffva1156-2-e
set_property board_part xilinx.com:kcu105:part0:1.7 [current_project]

add_files -fileset sources_1 -norecurse [glob ./src/*.sv]
add_files -fileset constrs_1 -norecurse $current_path/src/uart_led.xdc

exit
