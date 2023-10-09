PJSIP_DIR=pjproject-2.11.1

all: d-modem slmodemd

d-modem: d-modem.c
	$(CC) -o $@ $< `pkg-config --static --cflags --libs libpjproject`

slmodemd:
	$(MAKE) -C slmodemd

clean:
	rm -f d-modem.o d-modem
	$(MAKE) -C slmodemd clean

.PHONY: all clean slmodemd
