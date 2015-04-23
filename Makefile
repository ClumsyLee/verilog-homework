MODULES = $(wildcard exp*/*/)

.PHONY: all
all:
	@$(foreach module, $(MODULES), echo Building module $(module);\
								   $(MAKE) -C $(module);)
