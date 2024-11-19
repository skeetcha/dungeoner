LCC = $(GBDK_HOME)bin/lcc

ifdef GBC
	LCCFLAGS += -Wa-l -Wm-yC
else
	#LCCFLAGS += -Wm-yc
endif

ifdef GBDK_DEBUG
	LCCFLAGS += -debug -v
endif

PROJECTNAME = dungeoner

SRCDIR = src
OBJDIR = obj
RESDIR = res

ifdef GBC
	BINS = $(OBJDIR)/$(PROJECTNAME).gbc
else
	BINS = $(OBJDIR)/$(PROJECTNAME).gb
endif

CSOURCES = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c))) $(foreach dir,$(RESDIR),$(notdir $(wildcard $(dir)/*.c)))
ASMSOURCES = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.s))) $(foreach dir,$(RESDIR),$(notdir $(wildcard $(dir)/*.s)))
OBJS = $(CSOURCES:%.c=$(OBJDIR)/%.o) $(ASMSOURCES:%.s=$(OBJDIR)/%.o)

all: prepare $(BINS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

$(OBJDIR)/%.o: $(RESDIR)/%.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

$(OBJDIR)/%.o: $(SRC)/%.s
	$(LCC) $(LCCFLAGS) -c -o $@ $<

$(OBJDIR)/%.o: $(RESDIR)/%.s
	$(LCC) $(LCCFLAGS) -c -o $@ $<

$(BINS): $(OBJS)
	$(LCC) $(LCCFLAGS) -o $(BINS) $(OBJS)

prepare: $(SRCDIR) $(OBJDIR) $(RESDIR) $(BINDIR)

$(SRCDIR):
	mkdir -p $@

$(OBJDIR):
	mkdir -p $@

$(RESDIR):
	mkdir -p $@

$(BINDIR):
	mkdir -p $@

clean:
	rm -f $(OBJDIR)/*.*

run: $(BINS)
	wine $(BGB) $(BINS)