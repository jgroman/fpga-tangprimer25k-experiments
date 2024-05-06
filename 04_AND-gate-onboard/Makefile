# HDL type. Can be overridden from CLI: `make ... TOPLEVEL_LANG=vhdl`
TOPLEVEL_LANG?=verilog
export TOPLEVEL_LANG

PROJECT_NAME := $(notdir $(CURDIR))_$(TOPLEVEL_LANG)
PROJECT_NUM := $(shell echo $(PROJECT_NAME) | cut -d "_" -f 1)
PROJECT_DIR := $(CURDIR)/$(TOPLEVEL_LANG)

$(info =======================================================================)
$(info TOPLEVEL_LANG: $(TOPLEVEL_LANG) (Default: verilog, to use VHDL run: `make target TOPLEVEL_LANG=vhdl`))
$(info PROJECT_NAME: $(PROJECT_NAME))
$(info PROJECT_DIR: $(PROJECT_DIR))
$(info =======================================================================)
$(info )

GOWIN_PROGRAMMER_CLI_PATH := ~/sipeed/gowin/Programmer/bin/programmer_cli
GOWIN_IDE_BIN_DIR := ~/sipeed/gowin/IDE/bin
GOWIN_DEVICE := GW5A-25A
GOWIN_CABLE_INDEX := 1
GOWIN_FS_FILE := $(PROJECT_DIR)/impl/pnr/$(PROJECT_NUM)@$(TOPLEVEL_LANG).fs
GOWIN_OP_SRAM_PGM := 2
GOWIN_OP_FLASH_ERASE := 52
GOWIN_OP_FLASH_PGM := 53

DUMP_DIR := $(CURDIR)/logs
COCOTB_TEST_DIR := $(CURDIR)/test

# Gowin Programmer CLI
#
# - Programming SRAM
#
# sudo usb_modeswitch -v 0x0403 -p 0x6010 --detach-only
# sudo $(GOWIN_PROGRAMMER_CLI_PATH) --device $(GOWIN_DEVICE) --run $(GOWIN_OP_SRAM_PGM) --cable-index $(GOWIN_CABLE_INDEX) --fsFile $(GOWIN_FS_FILE)
# sudo modprobe ftdi_sio
#
# - Programming flash
#
# sudo usb_modeswitch -v 0x0403 -p 0x6010 --detach-only
# sudo $(GOWIN_PROGRAMMER_CLI_PATH) --device $(GOWIN_DEVICE) --run $(GOWIN_OP_FLASH_PGM) --cable-index $(GOWIN_CABLE_INDEX) --fsFile $(GOWIN_FS_FILE)
# sudo modprobe ftdi_sio
#
# - Erasing flash
#
# sudo usb_modeswitch -v 0x0403 -p 0x6010 --detach-only
# sudo $(GOWIN_PROGRAMMER_CLI_PATH) --device $(GOWIN_DEVICE) --run $(GOWIN_OP_FLASH_ERASE) --cable-index $(GOWIN_CABLE_INDEX) --fsFile $(GOWIN_FS_FILE)
# sudo modprobe ftdi_sio


.PHONY: all
all: sram

.PHONY: help
help: ## This help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-25s %s\n", $$1, $$2}'
	@$(MAKE) -C $(CURDIR)/test help

.PHONY: sram
sram: ## Program FS file to SRAM (default)
	sudo openFPGALoader --board tangprimer25k $(GOWIN_FS_FILE)

.PHONY: flash
flash: ## Program FS file to FLASH
	sudo openFPGALoader --board tangprimer25k --write-flash $(GOWIN_FS_FILE)

.PHONY: erase
erase: ## Bulk erase FLASH
	sudo openFPGALoader --board tangprimer25k --bulk-erase

.PHONY: clean
clean: ## Remove artefacts
	rm -f -r $(DUMP_DIR)
	rm -f -r $(COCOTB_TEST_DIR)/__pycache__
	rm -f -r $(COCOTB_TEST_DIR)/sim_build
	rm -f -r $(COCOTB_TEST_DIR)/*.o
	rm -f -r $(COCOTB_TEST_DIR)/results.xml
	rm -f -r $(COCOTB_TEST_DIR)/top
	@$(MAKE) -C $(COCOTB_TEST_DIR) clean

.PHONY: test
test: ## Run cocotb 'sim' target
	rm -f -r $(DUMP_DIR)
	mkdir $(DUMP_DIR)
	@$(MAKE) -C $(COCOTB_TEST_DIR)

.PHONY: sim
sim: test ## Run cocotb 'sim' target

# This includes LD_PRELOAD to run latest IDE on Fedora
# LD_PRELOAD fixes "undefined symbol: FT_Done_MM_Var" error
.PHONY: ide
ide: ## Start Gowin IDE
	@(LD_PRELOAD=/usr/lib64/libfreetype.so $(GOWIN_IDE_BIN_DIR)/gw_ide &)
