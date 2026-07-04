# ==================================================
# Simple Makefile for Serial Adder TB
# ==================================================

TOP      = serial_adder_tb
RTL_DIR  = ../rtl
TB_DIR   = ../tb

COV_DIR  = coverage
MERGED   = $(COV_DIR)/merged.ucdb
HTMLDIR  = $(COV_DIR)/html_report

#TEST ?=
SEED ?=

TEST ?=
.PHONY: compile run clean merge report regress

# --------------------------------------------------
# Compile RTL + TB
# --------------------------------------------------
compile:
	if [ ! -d work ]; then vlib work; fi
	vmap work work
	vlog -cover bcst $(RTL_DIR)/seradd.v
	vlog -sv $(TB_DIR)/serial_adder_tb.v

# --------------------------------------------------
# make run TEST=test1
# --------------------------------------------------

run:
	mkdir -p coverage
	vsim -c -coverage -assertdebug -voptargs=+acc \
	-onfinish stop $(TOP) \
	+$(TEST) \
	+SEED=$(SEED) \
	-do "run -all; \
	coverage save -assert -directive -cvg -codeAll coverage/$(TEST).ucdb; \
	quit"

# --------------------------------------------------
# Merge all UCDB files
# --------------------------------------------------

merge:
	vcover merge $(MERGED) $(filter-out $(MERGED),$(wildcard $(COV_DIR)/*.ucdb))

# --------------------------------------------------
# Generate HTML report
# --------------------------------------------------

report:
	mkdir -p $(HTMLDIR)
	vcover report \
	-html \
	-output $(HTMLDIR) \
	-details \
	-assert \
	-directive \
	-cvg \
	-code bcefst \
	-threshL 50 \
	-threshH 90 \
	$(MERGED)

# --------------------------------------------------
# Run full regression (manual loop)
# --------------------------------------------------

regress:
	for t in $(TEST); do \
		$(MAKE) run TEST=$$t; \
	done
	$(MAKE) merge
	$(MAKE) report
# --------------------------------------------------
# Clean
# --------------------------------------------------

clean:
	rm -rf work transcript vsim.wlf coverage modelsim.ini coverage
