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