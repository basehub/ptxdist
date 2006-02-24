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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86DRI) += xorg-proto-xf86dri

#
# Paths and names
#
XORG_PROTO_XF86DRI_VERSION	:= 2.0.3
XORG_PROTO_XF86DRI		:= xf86driproto-X11R7.0-$(XORG_PROTO_XF86DRI_VERSION)
XORG_PROTO_XF86DRI_SUFFIX	:= tar.bz2
XORG_PROTO_XF86DRI_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/proto/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX)
XORG_PROTO_XF86DRI_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX)
XORG_PROTO_XF86DRI_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86DRI)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_get: $(STATEDIR)/xorg-proto-xf86dri.get

$(STATEDIR)/xorg-proto-xf86dri.get: $(xorg-proto-xf86dri_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XF86DRI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_PROTO_XF86DRI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_extract: $(STATEDIR)/xorg-proto-xf86dri.extract

$(STATEDIR)/xorg-proto-xf86dri.extract: $(xorg-proto-xf86dri_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86DRI_DIR))
	@$(call extract, $(XORG_PROTO_XF86DRI_SOURCE))
	@$(call patchin, $(XORG_PROTO_XF86DRI))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_prepare: $(STATEDIR)/xorg-proto-xf86dri.prepare

XORG_PROTO_XF86DRI_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XF86DRI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86DRI_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xf86dri.prepare: $(xorg-proto-xf86dri_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86DRI_DIR)/config.cache)
	cd $(XORG_PROTO_XF86DRI_DIR) && \
		$(XORG_PROTO_XF86DRI_PATH) $(XORG_PROTO_XF86DRI_ENV) \
		./configure $(XORG_PROTO_XF86DRI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_compile: $(STATEDIR)/xorg-proto-xf86dri.compile

$(STATEDIR)/xorg-proto-xf86dri.compile: $(xorg-proto-xf86dri_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XF86DRI_DIR) && $(XORG_PROTO_XF86DRI_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_install: $(STATEDIR)/xorg-proto-xf86dri.install

$(STATEDIR)/xorg-proto-xf86dri.install: $(xorg-proto-xf86dri_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XF86DRI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_targetinstall: $(STATEDIR)/xorg-proto-xf86dri.targetinstall

$(STATEDIR)/xorg-proto-xf86dri.targetinstall: $(xorg-proto-xf86dri_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-proto-xf86dri)
	@$(call install_fixup, xorg-proto-xf86dri,PACKAGE,xorg-proto-xf86dri)
	@$(call install_fixup, xorg-proto-xf86dri,PRIORITY,optional)
	@$(call install_fixup, xorg-proto-xf86dri,VERSION,$(XORG_PROTO_XF86DRI_VERSION))
	@$(call install_fixup, xorg-proto-xf86dri,SECTION,base)
	@$(call install_fixup, xorg-proto-xf86dri,AUTHOR,"Erwin Rol <erwin\@erwinrol.com>")
	@$(call install_fixup, xorg-proto-xf86dri,DEPENDS,)
	@$(call install_fixup, xorg-proto-xf86dri,DESCRIPTION,missing)

	@$(call install_finish, xorg-proto-xf86dri)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_clean:
	rm -rf $(STATEDIR)/xorg-proto-xf86dri.*
	rm -rf $(IMAGEDIR)/xorg-proto-xf86dri_*
	rm -rf $(XORG_PROTO_XF86DRI_DIR)

# vim: syntax=make

