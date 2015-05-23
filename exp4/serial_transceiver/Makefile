COMPILER = iverilog

sim: receiver.v sampler.v sender.v hex_led.v serial_transceiver.v serial_transceiver_tb.v ../../common/watchmaker.v ../../common/bcd7.v
	@$(COMPILER) -Wall -o $@ $^
