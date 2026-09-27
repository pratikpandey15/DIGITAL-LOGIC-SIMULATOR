IVERILOG ?= iverilog
VVP ?= vvp
PYTHON ?= python

.PHONY: test test-gates test-combinational test-arithmetic test-sequential test-fsm test-memory clean help

help:
	@echo "Available targets:"
	@echo "  make test               Run the full automated test suite if iverilog is installed."
	@echo "  make test-gates         Run gate-level testbenches."
	@echo "  make test-combinational Run combinational logic testbenches."
	@echo "  make test-arithmetic    Run arithmetic testbenches."
	@echo "  make test-sequential   Run sequential logic testbenches."
	@echo "  make test-fsm          Run FSM testbenches."
	@echo "  make test-memory       Run memory testbenches."
	@echo "  make clean             Remove generated simulation artifacts."

test:
	$(PYTHON) scripts/run_all_tests.py

test-gates:
	$(PYTHON) scripts/run_simulation.py --category gates

test-combinational:
	$(PYTHON) scripts/run_simulation.py --category combinational

test-arithmetic:
	$(PYTHON) scripts/run_simulation.py --category arithmetic

test-sequential:
	$(PYTHON) scripts/run_simulation.py --category sequential

test-fsm:
	$(PYTHON) scripts/run_simulation.py --category fsm

test-memory:
	$(PYTHON) scripts/run_simulation.py --category memory

clean:
	rm -f *.vvp *.out *.log *.tmp *.bak
	rm -f results/*.log
	rm -f simulations/**/*.vcd 2>/dev/null || true
	rm -f waveforms/**/*.vcd 2>/dev/null || true
