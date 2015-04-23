COMPILER = iverilog

sim: *.v ../../common/debounce.v
	@$(COMPILER) -Wall -o $@ $^
