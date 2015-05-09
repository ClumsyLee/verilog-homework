COMPILER = iverilog

sim: *.v ../../common/bcd7.v ../../common/debounce.v
	@$(COMPILER) -Wall -o $@ $^
