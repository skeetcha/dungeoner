.SUFFIXES: # Suppress a lot of useless default rules, which also provides a nice speedup.

# Recursive `wildcard` function.
rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

# Program contsants.
RM_RF := rm -rf
MKDIR_P := mkdir -p
ifeq ($(strip $(shell which rm)),)
#	Windows *really* tries its hardest to be Special!
	RM_RF := -rmdir /s /q
	MKDIR_P := -mkdir
endif

RGBDS	?=
ASM		:= $(RGBDS)rgbasm
LINK	:= $(RGBDS)rgblink
FIX		:= $(RGBDS)rgbfix
GFX		:= $(RGBDS)rgbgfx

ROM = bin/$(ROMNAME).$(ROMEXT)

# Argument constants
INCDIRS = src/ include/
WARNINGS = all extra
ASMFLAGS = -p $(PADVALUE) $(addprefix -I,$(INCDIRS)) $(addprefix -W,$(WARNINGS))
LINKFLAGS = -p $(PADVALUE)
FIXFLAGS = -p $(PADVALUE) -i "$(GAMEID)" -k "$(LICENSEE)" -l $(OLDLIC) -m $(MBC) -n $(VERSION) -r $(SRAMSIZE) -t $(TITLE)

SRCS = $(call rwildcard,src,*.asm)

include project.mk

all: $(ROM)
.PHONY: all

clean:
	$(RM_RF) bin obj assets
.PHONY: clean

rebuild:
	$(MAKE) clean
	$(MAKE) all
.PHONY: rebuild

VPATH := src

bin/%.$(ROMEXT): $(patsubst src/%.asm,obj/%.o,$(SRCS))
	@$(MKDIR_P) "$(@D)"
	$(ASM) $(ASMFLAGS) -o obj/build_date.o src/assets/build_date.asm
	$(LINK) $(LINKFLAGS) -m bin/$*.map -n bin/$*.sym -o $@ $^ \
	&& $(FIX) -v $(FIXFLAGS) $@

obj/%.mk: src/%.asm
	@$(MKDIR_P) "$(@D)"
	$(ASM) $(ASMFLAGS) -M $@ -MG -MP -MQ $(@:.mk=.o) -MQ $@ -o $(@:.mk=.o) $<

obj/%.o: obj/%.mk
	@touch $@

ifeq ($(filter clean,$(MAKECMDGOALS)),)
include $(patsubst src/%.asm,obj/%.mk,$(SRCS))
endif