LCC = $(GBDK_HOME)bin/lcc

ifdef GBC
	LCCFLAGS += -Wa-l -Wl-yp0x143=0x80
endif

ifdef GBDK_DEBUG
	LCCFLAGS += -debug -v
endif

PROJECTNAME = dungeoner

ifdef GBC
	BINS = $(PROJECTNAME).gbc
else
	BINS = $(PROJECTNAME).gb
endif

CSOURCES = $(wildcard src/*.c)
ASMSOURCES = $(wildcard src/*.s)

all: build

run: build
	mgba-qt -8 $(BINS)

build: $(BINS)

$(BINS): $(CSOURCES) $(ASMSOURCES)
	$(LCC) $(LCCFLAGS) -o $@ $(CSOURCES) $(ASMSOURCES)

clean:
	rm -f *.o *.lst *.map *.gb *.ihx *.sym *.cdb *.adb *.asm *.noi *.rst *.gba *.gbc