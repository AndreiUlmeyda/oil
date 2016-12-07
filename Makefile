BINDIR ?= /usr/bin
LIBDIR ?= /usr/lib/oil

.PHONY: install uninstall

install:
	install -Dm755 oil $(DESTDIR)$(BINDIR)/oil
	install -Dm755 json-to-line.jq $(DESTDIR)$(LIBDIR)/json-to-line.jq
	install -Dm755 format-columns.awk $(DESTDIR)$(LIBDIR)/format-columns.awk

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/oil
	rm -f $(DESTDIR)$(LIBDIR)/json-to-line.jq
	rm -f $(DESTDIR)$(LIBDIR)/format-columns.awk