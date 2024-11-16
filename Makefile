include .env
export

LCC = $(GBDK_HOME)bin/lcc

ifdef GBDK_DEBUG
	LCCFLAGS += -debug -v
endif

PROJECTNAME = dungeoner

BINS = $(PROJECTNAME).gb
CSOURCES = $(wildcard src/*.c)
ASMSOURCES = $(wildcard src/*.s)

all: $(BINS)

$(BINS): $(CSOURCES) $(ASMSOURCES)
	$(LCC) $(LCCFLAGS) -o $@ $(CSOURCES) $(ASMSOURCES)

clean:
	rm -rf *.o *.lst *.map *.gb *.ihx *.sym *.cdb *.adb *.asm *.noi *.rst

test:
	mgba $(BINS) -8