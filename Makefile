BINDIR ?= /usr/local/bin
LIBDIR ?= /usr/local/lib/oil

.PHONY: install uninstall

install:
	install -Dm755 src/oil $(DESTDIR)$(BINDIR)/oil
	install -Dm755 src/json-to-line.jq $(DESTDIR)$(LIBDIR)/json-to-line.jq
	install -Dm755 src/format-columns.awk $(DESTDIR)$(LIBDIR)/format-columns.awk

uninstall:
	rm -f src/oil $(DESTDIR)$(BINDIR)/oil
	rm -rf $(DESTDIR)$(LIBDIR)
