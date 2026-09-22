GHDL ?= ghdl
GHDL_STD := 08
SCHEMATIC_SOURCE ?= ../../src/schematic.vhd
BUILD_DIR := build

.PHONY: all clean
all:
	mkdir -p "$(BUILD_DIR)"
	cd "$(BUILD_DIR)" && $(GHDL) -a --std=$(GHDL_STD) "$(abspath $(SCHEMATIC_SOURCE))" "$(CURDIR)/src/incrementer.vhd" "$(CURDIR)/supertests/increment.vhd"
	cd "$(BUILD_DIR)" && $(GHDL) -e --std=$(GHDL_STD) increment_supertests

clean:
	$(RM) -r -- "$(BUILD_DIR)"
