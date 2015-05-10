COMPILER = iverilog

.PHONY: all
all: two_one_mux four_one_mux

two_one_mux: two_one_mux.v two_one_mux_tb.v
	@$(COMPILER) -Wall -o $@ $^

four_one_mux: four_one_mux.v four_one_mux_tb.v two_one_mux.v
	@$(COMPILER) -Wall -o $@ $^
