include project.mk

SRCDIR 		   = src
OBJDIR 		   = obj
BINDIR 		   = bin
LIBDIR         = libs
RESDIR 		   = $(SRCDIR)/resources
ASMDIR 		   = $(SRCDIR)/main
RESSPRITES     = $(RESDIR)/sprites
RESBACKGROUNDS = $(RESDIR)/backgrounds
GENDIR		   = $(SRCDIR)/generated
GENSPRITES	   = $(GENDIR)/sprites
GENBACKGROUNDS = $(GENDIR)/backgrounds
BINS		   = $(BINDIR)/$(ROMNAME).$(ROMEXT)

RGBDS	?=
ASM		:= $(RGBDS)rgbasm
LINK	:= $(RGBDS)rgblink
FIX		:= $(RGBDS)rgbfix
GFX		:= $(RGBDS)rgbgfx

INCLUDEDIRS = include/
WARNINGS = all extra
ASMFLAGS := -p $(PADVALUE) $(addprefix -I,$(INCLUDEDIRS)) $(addprefix -W,$(WARNINGS))
LINKFLAGS := -p $(PADVALUE)
FIXFLAGS := -p $(PADVALUE) -i "$(GAMEID)" -k "$(LICENSEE)" -l $(OLDLIC) -m $(MBC) -n $(VERSION) -r $(SRAMSIZE) -t $(TITLE) -v

# https://stackoverflow.com/a/18258352
# Make does not offer a recursive wild card function, so here's one:
rwildcard = $(foreach d,\
	$(wildcard $(1:=/*)), \
	$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d) \
)

# https://stackoverflow.com/a/16151140
# This makes it so every entry in a space-delimited list appears only once
unique = $(if $1,\
	$(firstword $1) $(call unique,$(filter-out $(firstword $1),$1)) \
)

ASMSOURCES_COLLECTED = $(call rwildcard,$(ASMDIR),*.asm) $(call rwildcard,$(LIBDIR),*.asm)
OBJS = $(patsubst %.asm,$(OBJDIR)/%.o,$(notdir $(ASMSOURCES_COLLECTED))) $(OBJDIR)/build_date.o

all: $(BINS)

NEEDED_GRAPHICS = \
	$(GENBACKGROUNDS)/title.tilemap

$(GENSPRITES)/%.2bpp: $(RESSPRITES)/%.png | $(GENSPRITES)
	$(GFX) -c '#fff,#cfcfcf,#686868,#000;' --columns -o $@ $<

$(GENBACKGROUNDS)/%.tilemap: $(RESBACKGROUNDS)/%.png | $(GENBACKGROUNDS)
	$(GFX) -c '#000,#545654,#9fa29f,#fff;' \
		--tilemap $@ \
		--unique-tiles \
		-o $(GENBACKGROUNDS)/$*.2bpp \
		$<

ASMSOURCES_DIRS = $(patsubst %,%%.asm,\
	$(call unique,$(dir $(ASMSOURCES_COLLECTED))) \
)

define object-from-asm
$(OBJDIR)/%.o: $1 | $(OBJDIR) $(NEEDED_GRAPHICS)
	$$(ASM) $$(ASMFLAGS) -o $$@ $$<
endef

$(foreach i, $(ASMSOURCES_DIRS), $(eval $(call object-from-asm,$i)))

$(BINS): $(OBJS) | $(BINDIR)
	$(LINK) $(LINKFLAGS) -m $(@:.gb=.map) -n $(@:.gb=.sym) -o $@ $^
	$(FIX) $(FIXFLAGS) $@

$(OBJDIR)/build_date.o: $(SRCDIR)/assets/build_date.asm | $(OBJDIR)
	$(ASM) $(ASMFLAGS) -o $@ $^

define ensure-directory
$1:
	mkdir -p $$@
endef

PREPARE_DIRECTORIES = $(OBJDIR) $(GENSPRITES) $(GENBACKGROUNDS) $(BINDIR)

$(foreach i, $(PREPARE_DIRECTORIES), $(eval $(call ensure-directory,$i)))

clean:
	rm -rfv $(PREPARE_DIRECTORIES)

.PHONY: clean all test