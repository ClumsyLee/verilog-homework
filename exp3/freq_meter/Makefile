COMPILER = iverilog

sim: *.v ../../common/watchmaker.v ../../common/counter.v ../../common/led.v ../../common/bcd7.v
	@$(COMPILER) -Wall -o $@ $^
