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

SHELL := /bin/bash
PRJ_NAME = labs

#—————————————————————————–
#SIM directory
SIM_DIR = .

SCRIPTS_DIR = $(SIM_DIR)/create_proj.tcl

COMPILER = vivado
#—————————————————————————–
#Tool output
#—————————————————————————–
default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

compile: # Create vivado project, synthesize design and generate post-synthesis functional model
	$(COMPILER) -mode tcl -source $(SCRIPTS_DIR)

view : # Open vivado project
	$(COMPILER) *.xpr
	
clean : # Clean project
	rm -rf $(PRJ_NAME)* .Xil vivado*