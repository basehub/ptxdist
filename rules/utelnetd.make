# $Id: utelnetd.make,v 1.1 2003/04/24 08:06:33 jst Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_UTELNETD))
PACKAGES += utelnetd
endif

#
# Paths and names 
#
UTELNETD			= utelnetd-0.1.6
UTELNETD_URL			= http://www.pengutronix.de/software/utelnetd/$(UTELNETD).tar.gz
UTELNETD_SOURCE			= $(SRCDIR)/$(UTELNETD).tar.gz
UTELNETD_DIR			= $(BUILDDIR)/$(UTELNETD)
UTELNETD_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

utelnetd_get: $(STATEDIR)/utelnetd.get

$(STATEDIR)/utelnetd.get: $(UTELNETD_SOURCE)
	touch $@

$(UTELNETD_SOURCE):
	@echo
	@echo ------------
	@echo target: utelnetd.get
	@echo ------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(UTELNETD_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

utelnetd_extract: $(STATEDIR)/utelnetd.extract

$(STATEDIR)/utelnetd.extract: $(STATEDIR)/utelnetd.get
	@echo
	@echo ----------------
	@echo target: utelnetd.extract
	@echo ----------------
	@echo
	$(UTELNETD_EXTRACT) $(UTELNETD_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

utelnetd_prepare: $(STATEDIR)/utelnetd.prepare

$(STATEDIR)/utelnetd.prepare: $(STATEDIR)/utelnetd.extract
	@echo
	@echo ----------------
	@echo target: utelnetd.prepare
	@echo ----------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

utelnetd_compile: $(STATEDIR)/utelnetd.compile

UTELNETD_ENVIRONMENT = 
UTELNETD_MAKEVARS    =
ifeq (y,$(PTXCONF_ARCH_ARM))
UTELNETD_ENVIRONMENT += PATH=$(PTXCONF_PREFIX)/bin:$$PATH
UTELNETD_MAKEVARS    += CROSS=arm-linux-
endif

$(STATEDIR)/utelnetd.compile: $(STATEDIR)/utelnetd.prepare 
	@echo
	@echo ----------------
	@echo target: utelnetd.compile
	@echo ----------------
	@echo
	$(UTELNETD_ENVIRONMENT) make -C $(UTELNETD_DIR) $(UTELNETD_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

utelnetd_install: $(STATEDIR)/utelnetd.install

$(STATEDIR)/utelnetd.install: $(STATEDIR)/utelnetd.compile
	@echo
	@echo ----------------
	@echo target: utelnetd.install
	@echo ----------------
	@echo
	install -d $(PTXCONF_PREFIX)/sbin/
	install $(UTELNETD_DIR)/utelnetd $(PTXCONF_PREFIX)/sbin/
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

utelnetd_targetinstall: $(STATEDIR)/utelnetd.targetinstall

$(STATEDIR)/utelnetd.targetinstall: $(STATEDIR)/utelnetd.install
	@echo
	@echo ---------------------- 
	@echo target: utelnetd.targetinstall
	@echo ----------------------
	@echo
	install -d $(ROOTDIR)/sbin/
	install $(UTELNETD_DIR)/utelnetd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/utelnetd
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

utelnetd_clean: 
	rm -rf $(STATEDIR)/utelnetd.* $(UTELNETD_DIR)

# vim: syntax=make
