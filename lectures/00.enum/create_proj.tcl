# ---------------------------------------------------------------------------
#            ___  _    __         =        __    ___     __                --   
#           / ._\| |  / /         =       / /   /   |   / . \              --         
#           \ __ | | / /          =      / /   / /| |  / /_ /              --
#         ____. \| |/ /           =     / /__ / /_| | / /_ \               --
#        /______/|___/            =    /____//_/  |_|/_____/               --
#                               =====                                      --
#                                ===                                       --
# ------------------------------  =  ----------------------------------------
#  Copyright © 2023, 2024 - Nguyen Canh Trung
#  (nguyencanhtrung 'at' me 'dot' com)
# 
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  the rights to use, copy, modify, merge, publish, distribute, sublicense,
#  and/or sell copies of the Software, and to permit persons to whom the
#  Software is furnished to do so, subject to the following conditions:
# 
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
# 
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#  DEALINGS IN THE SOFTWARE.
# 
#  DEPENDENCIES: none

set current_path [file dirname [ file normalize [ info script ] ] ]
puts $current_path

set src_files [list \
    [file normalize "${current_path}/src/enum_2.sv"] \
]


create_project lectures . -part xcu200-fsgd2104-2-e
set_property board_part xilinx.com:au200:part0:1.3 [current_project]


set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $src_files


exit
