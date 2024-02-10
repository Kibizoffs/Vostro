COMPILER_OPTIONS=
SOURCES=$(wildcard *.pas)

all: vostro clean

vostro: $(SOURCES)
	-fpc $(COMPILER_OPTIONS) vostro.pas

clean:
	rm -f *.o *.ppu

distclean: clean
	rm -f vostro
