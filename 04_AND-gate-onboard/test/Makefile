# Makefile for testing using cocotb

ifeq ($(TOPLEVEL_LANG),verilog)
	SIM = icarus
    VERILOG_SOURCES = $(PWD)/../verilog/src/top.v
else ifeq ($(TOPLEVEL_LANG),vhdl)
	SIM = ghdl
    VHDL_SOURCES = $(PWD)/../vhdl/src/top.vhd
else
    $(error A valid value (verilog or vhdl) was not provided for TOPLEVEL_LANG=$(TOPLEVEL_LANG))
endif

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = top

# MODULE is the basename of the Python test file
MODULE = test_top

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
