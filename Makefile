PJSIP_DIR=pjproject-2.11.1
PKG_CONFIG_PATH=pjsip.install/lib/pkgconfig

all: d-modem slmodemd

$(PKG_CONFIG_PATH)/libpjproject.pc:
	(cd $(PJSIP_DIR); [ -f ./config.status ] || ./configure --prefix=`pwd`/../pjsip.install --disable-video)
	$(MAKE) -C $(PJSIP_DIR) && \
	$(MAKE) -C $(PJSIP_DIR) install

d-modem: d-modem.c dmodem2.c $(PKG_CONFIG_PATH)/libpjproject.pc
	$(CC) -g -o $@ $< `PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)" pkg-config --static --cflags --libs libpjproject`
	$(CC) -g -o dmodem2 dmodem2.c `PKG_CONFIG_PATH="$(PKG_CONFIG_PATH)" pkg-config --static --cflags --libs libpjproject`
slmodemd:
	$(MAKE) -C slmodemd

clean:
	rm -f d-modem.o d-modem
	$(MAKE) -C slmodemd clean

realclean: clean
	$(MAKE) -C $(PJSIP_DIR) realclean
	rm -rf pjsip.install/*
	

.PHONY: all clean realclean slmodemd
