pixmapsdir = @uim_pixmapsdir@

if M17NLIB
bin_SCRIPTS = uim-m17nlib-relink-icons
endif

SVGS = unknown.svg
# dark background
SVGS += unknown_dark_background.svg

# input methods
SVGS += direct.svg
# dark background
SVGS += direct_dark_background.svg

# input modes
SVGS += direct_input.svg on.svg off.svg

# dark background
SVGS += direct_input_dark_background.svg \
        on_dark_background.svg \
        off_dark_background.svg

# Tools
SVGS += im_switcher.svg uim-dict.svg

# input method substitutions
IM_SUBST_SVGS = xvni.svg xtelex.svg viqr.svg ipa-x-sampa.svg scim.svg \
	xvni-ipa.svg xtelex-ipa.svg

GENERATED_SVGS = $(IM_SUBST_SVGS)
SVGS += im_subst.svg $(GENERATED_SVGS)

IM_SUBST_PNGS = xvni.png xtelex.png viqr.png ipa-x-sampa.png scim.png \
	xvni-ipa.png xtelex-ipa.png

SVG_PNGS = unknown.png \
           direct.png \
           direct_input.png on.png off.png \
           im_switcher.png uim-dict.png $(IM_SUBST_PNGS) \
           unknown_dark_background.png \
           direct_dark_background.png \
           direct_input_dark_background.png \
           on_dark_background.png \
           off_dark_background.png

NATIVE_PNGS = null.png uim-icon64.png uim-icon48.png uim-gray.png

SCIM_PNGS =

SCIM_ORIGINATED_PNGS =
if ANTHY_UTF8
SCIM_ORIGINATED_PNGS += anthy-utf8.png
endif

GENERATED_PNGS = $(SVG_PNGS) $(SCIM_ORIGINATED_PNGS) uim-icon.png

PNGS = $(NATIVE_PNGS) $(GENERATED_PNGS)

EXTRA_DIST = COPYING.BSDL COPYING.LGPL LIST indication-id.txt $(SCIM_PNGS)

dist_pixmaps_DATA = $(SVGS) $(PNGS)

MAINTAINERCLEANFILES = $(GENERATED_PNGS) $(GENERATED_SVGS)

if MAINTAINER_MODE
anthy.png: scim-anthy.png
	cp $< $@
anthy-utf8.png: scim-anthy.png
	cp $< $@
canna.png: scim-canna.png
	cp $< $@
prime.png: scim-prime.png
	cp $< $@

uim-icon.png: uim-icon48.png
	cp $< $@

$(IM_SUBST_SVGS): im_subst.svg
	cp $< $@

trycode.svg: tcode.svg
	cp $< $@

trycode_dark_background.svg: tcode_dark_background.svg
	cp $< $@

.svg.png:
	if test -n "$(RSVG)"; then		 \
	    $(RSVG) -w 48 -h 48 -f png $< -o $@; \
	fi
endif

clean-svgpng:
	rm -f $(SVG_PNGS)
clean-gensvg:
	rm -f $(GENERATED_SVGS)
clean-genpng:
	rm -f $(GENERATED_PNGS)

# rsvg-convert(1) is required to make a distribution, but does not for build
# and install from a tarball distribution.
dist-hook:
	@test -n "$(RSVG)" \
	    || (echo 'rsvg-convert(1) not found: install it'; exit 1)

install-data-hook:
if M17NLIB
	DESTDIR="$(DESTDIR)" $(SH) $(builddir)/uim-m17nlib-relink-icons
endif
