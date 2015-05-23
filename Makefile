MODULES = $(wildcard exp*/*/ *homework*/*/)

.PHONY: all common modules

all: common modules

common:
	@echo Building common
	@$(MAKE) -C common/

modules:
	@$(foreach module, $(MODULES), echo Building module $(module);\
								   $(MAKE) -C $(module);)
