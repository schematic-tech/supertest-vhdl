GHDL ?= ghdl
GHDL_STD := 08
PYTHON ?= python3
BUILD_DIR ?= build

SOURCE_DIR := $(CURDIR)/src
TEST_DIR := $(CURDIR)/tests

.PHONY: all test clean

all: test

test:
	mkdir -p "$(BUILD_DIR)"
	cd "$(BUILD_DIR)" && $(GHDL) -a --std=$(GHDL_STD) "$(SOURCE_DIR)/schematic.vhd"
	cd "$(BUILD_DIR)" && $(GHDL) -a --std=$(GHDL_STD) "$(TEST_DIR)/authoring.vhd"
	cd "$(BUILD_DIR)" && $(GHDL) -e --std=$(GHDL_STD) authoring
	GHDL="$(GHDL)" BUILD_DIR="$(BUILD_DIR)" $(PYTHON) tests/test_authoring.py -v

clean:
	$(RM) -r -- "$(BUILD_DIR)"
