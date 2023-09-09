# ------------------------------------------
# Author:   Nguyen Canh Trung
# Email:    trungnc@soc.one
# Date:     2023-09-07 08:54:37
# Filename: create_proj
# Last Modified by:   Nguyen Canh Trung
# Last Modified time: 2023-09-09 13:31:01
# ------------------------------------------
set current_path [file dirname [ file normalize [ info script ] ] ]
puts $current_path

create_project labs . -part xcku040-ffva1156-2-e
set_property board_part xilinx.com:kcu105:part0:1.7 [current_project]

add_files -fileset sources_1 -norecurse [glob ./src/*.sv]
set_property top arith_logic [current_fileset]

exit
