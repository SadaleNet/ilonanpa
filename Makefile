DEVICE=stm8s001j3

PROGRAM=ilonanpa
SOURCEDIR=src
BINDIR=bin

SOURCES=$(wildcard $(SOURCEDIR)/*.c)
OBJECTS=$(subst $(SOURCEDIR)/,$(BINDIR)/,$(SOURCES:.c=.rel))

CC = sdcc
PROGRAMMER = stlinkv2

CFLAGS = --Werror --std-sdcc99 -mstm8 $(DEFINES)
LDFLAGS = -lstm8 -mstm8

.PHONY: all default clean flash

.DEFAULT_GOAL := all

$(BINDIR)/$(PROGRAM).ihx: $(OBJECTS)
	mkdir -p $(BINDIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) --out-fmt-ihx -o $@

$(BINDIR)/$(PROGRAM).elf: $(OBJECTS)
	mkdir -p $(BINDIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) --out-fmt-elf -o $@

$(BINDIR)/%.rel: $(SOURCEDIR)/%.c
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

all: $(BINDIR)/$(PROGRAM).ihx $(BINDIR)/$(PROGRAM).elf

clean:
	rm -Rf $(BINDIR)

flash-opt-bytes:
	stm8flash -c $(PROGRAMMER) -p $(DEVICE) -s opt -w optbytes.bin

flash: $(BINDIR)/$(PROGRAM).ihx
	stm8flash -c $(PROGRAMMER) -p $(DEVICE) -w $(BINDIR)/$(PROGRAM).ihx

