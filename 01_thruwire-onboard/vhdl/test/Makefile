# Makefile for testing using cocotb

# defaults
SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl
SRC_DIR = $(PWD)/../src

VHDL_SOURCES += $(SRC_DIR)/top.vhd
# use VERILOG_SOURCES for Verilog files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = top

# MODULE is the basename of the Python test file
MODULE = test_top

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
