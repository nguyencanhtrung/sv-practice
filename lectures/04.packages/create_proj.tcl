# ------------------------------------------
# Author:   Nguyen Canh Trung
# Email:    trungnc@soc.one
# Date:     2023-09-07 08:54:37
# Filename: create_proj
# Last Modified by:   Nguyen Canh Trung
# Last Modified time: 2023-09-07 09:00:45
# ------------------------------------------
set proj_repo .

create_project lectures /home/tesla/workspace/05.Soc/10.studies/08.sv/lectures/04.packages -part xcu200-fsgd2104-2-e
set_property board_part xilinx.com:au200:part0:1.3 [current_project]

set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse {
                                    /home/tesla/workspace/05.Soc/10.studies/08.sv/lectures/04.packages/src/tasks.sv \
                                    /home/tesla/workspace/05.Soc/10.studies/08.sv/lectures/04.packages/src/packages.sv \
                                    /home/tesla/workspace/05.Soc/10.studies/08.sv/lectures/04.packages/src/functions.sv \
                                    }

move_files [get_files  /home/tesla/workspace/05.Soc/10.studies/08.sv/lectures/04.packages/src/functions.sv]
# update_compile_order -fileset sources_1
# synth_design -rtl -rtl_skip_mlo -name rtl_1
