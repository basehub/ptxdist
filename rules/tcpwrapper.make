# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCPWRAPPER) += tcpwrapper

#
# Paths and names 
#
TCPWRAPPER_VERSION		= 7.6
TCPWRAPPER			= tcp_wrappers_$(TCPWRAPPER_VERSION)
TCPWRAPPER_URL			= ftp://ftp.porcupine.org/pub/security/$(TCPWRAPPER).tar.gz
TCPWRAPPER_SOURCE		= $(SRCDIR)/$(TCPWRAPPER).tar.gz
TCPWRAPPER_DIR			= $(BUILDDIR)/$(TCPWRAPPER)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tcpwrapper_get: $(STATEDIR)/tcpwrapper.get

$(STATEDIR)/tcpwrapper.get: $(tcpwrapper_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TCPWRAPPER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TCPWRAPPER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tcpwrapper_extract: $(STATEDIR)/tcpwrapper.extract

$(STATEDIR)/tcpwrapper.extract: $(tcpwrapper_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TCPWRAPPER_DIR))
	@$(call extract, $(TCPWRAPPER_SOURCE))
	@$(call patchin, $(TCPWRAPPER))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tcpwrapper_prepare: $(STATEDIR)/tcpwrapper.prepare

$(STATEDIR)/tcpwrapper.prepare: $(tcpwrapper_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tcpwrapper_compile: $(STATEDIR)/tcpwrapper.compile

TCPWRAPPER_ENV	= $(CROSS_ENV)
TCPWRAPPER_PATH	= PATH=$(CROSS_PATH)

$(STATEDIR)/tcpwrapper.compile: $(tcpwrapper_compile_deps_default)
	@$(call targetinfo, $@)
	$(TCPWRAPPER_PATH) $(TCPWRAPPER_ENV) \
		make -C $(TCPWRAPPER_DIR) linux 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tcpwrapper_install: $(STATEDIR)/tcpwrapper.install

$(STATEDIR)/tcpwrapper.install: $(tcpwrapper_install_deps_default)
	@$(call targetinfo, $@)
	install -d $(CROSS_LIB_DIR)/lib
	install $(TCPWRAPPER_DIR)/libwrap.a $(CROSS_LIB_DIR)/lib
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tcpwrapper_targetinstall: $(STATEDIR)/tcpwrapper.targetinstall

$(STATEDIR)/tcpwrapper.targetinstall: $(tcpwrapper_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, tcpwrapper)
	@$(call install_fixup, tcpwrapper,PACKAGE,tcpwrapper)
	@$(call install_fixup, tcpwrapper,PRIORITY,optional)
	@$(call install_fixup, tcpwrapper,VERSION,$(TCPWRAPPER_VERSION))
	@$(call install_fixup, tcpwrapper,SECTION,base)
	@$(call install_fixup, tcpwrapper,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, tcpwrapper,DEPENDS,)
	@$(call install_fixup, tcpwrapper,DESCRIPTION,missing)

ifdef PTXCONF_TCPWRAPPER_INSTALL_TCPD
	@$(call install_copy, tcpwrapper, 0, 0, 0755, $(TCPWRAPPER_DIR)/tcpd, /usr/sbin/tcpd)
endif
	@$(call install_finish, tcpwrapper)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcpwrapper_clean: 
	rm -rf $(STATEDIR)/tcpwrapper.* 
	rm -rf $(IMAGEDIR)/tcpwrapper_* 
	rm -rf $(TCPWRAPPER_DIR)

# vim: syntax=make
