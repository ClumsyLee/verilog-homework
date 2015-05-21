COMPILER = iverilog

sim: receiver.v sampler.v sender.v serial_transceiver.v serial_transceiver_tb.v ../../common/watchmaker.v
	@$(COMPILER) -Wall -o $@ $^
