# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_PROTO_WINDOWSWM) += xorg-proto-windowswm

#
# Paths and names
#
XORG_PROTO_WINDOWSWM_VERSION 	:= 1.0.3
XORG_PROTO_WINDOWSWM		:= windowswmproto-X11R7.0-$(XORG_PROTO_WINDOWSWM_VERSION)
XORG_PROTO_WINDOWSWM_SUFFIX	:= tar.bz2
XORG_PROTO_WINDOWSWM_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/proto/$(XORG_PROTO_WINDOWSWM).$(XORG_PROTO_WINDOWSWM_SUFFIX)
XORG_PROTO_WINDOWSWM_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_WINDOWSWM).$(XORG_PROTO_WINDOWSWM_SUFFIX)
XORG_PROTO_WINDOWSWM_DIR	:= $(BUILDDIR)/$(XORG_PROTO_WINDOWSWM)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-windowswm_get: $(STATEDIR)/xorg-proto-windowswm.get

$(STATEDIR)/xorg-proto-windowswm.get: $(xorg-proto-windowswm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_WINDOWSWM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_PROTO_WINDOWSWM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-windowswm_extract: $(STATEDIR)/xorg-proto-windowswm.extract

$(STATEDIR)/xorg-proto-windowswm.extract: $(xorg-proto-windowswm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_WINDOWSWM_DIR))
	@$(call extract, $(XORG_PROTO_WINDOWSWM_SOURCE))
	@$(call patchin, $(XORG_PROTO_WINDOWSWM))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-windowswm_prepare: $(STATEDIR)/xorg-proto-windowswm.prepare

XORG_PROTO_WINDOWSWM_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_WINDOWSWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_WINDOWSWM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-windowswm.prepare: $(xorg-proto-windowswm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_WINDOWSWM_DIR)/config.cache)
	cd $(XORG_PROTO_WINDOWSWM_DIR) && \
		$(XORG_PROTO_WINDOWSWM_PATH) $(XORG_PROTO_WINDOWSWM_ENV) \
		./configure $(XORG_PROTO_WINDOWSWM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-windowswm_compile: $(STATEDIR)/xorg-proto-windowswm.compile

$(STATEDIR)/xorg-proto-windowswm.compile: $(xorg-proto-windowswm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_WINDOWSWM_DIR) && $(XORG_PROTO_WINDOWSWM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-windowswm_install: $(STATEDIR)/xorg-proto-windowswm.install

$(STATEDIR)/xorg-proto-windowswm.install: $(xorg-proto-windowswm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_WINDOWSWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-windowswm_targetinstall: $(STATEDIR)/xorg-proto-windowswm.targetinstall

$(STATEDIR)/xorg-proto-windowswm.targetinstall: $(xorg-proto-windowswm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-proto-windowswm)
	@$(call install_fixup, xorg-proto-windowswm,PACKAGE,xorg-proto-windowswm)
	@$(call install_fixup, xorg-proto-windowswm,PRIORITY,optional)
	@$(call install_fixup, xorg-proto-windowswm,VERSION,$(XORG_PROTO_WINDOWSWM_VERSION))
	@$(call install_fixup, xorg-proto-windowswm,SECTION,base)
	@$(call install_fixup, xorg-proto-windowswm,AUTHOR,"Erwin Rol <erwin\@erwinrol.com>")
	@$(call install_fixup, xorg-proto-windowswm,DEPENDS,)
	@$(call install_fixup, xorg-proto-windowswm,DESCRIPTION,missing)

	@$(call install_finish, xorg-proto-windowswm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-windowswm_clean:
	rm -rf $(STATEDIR)/xorg-proto-windowswm.*
	rm -rf $(IMAGEDIR)/xorg-proto-windowswm_*
	rm -rf $(XORG_PROTO_WINDOWSWM_DIR)

# vim: syntax=make

