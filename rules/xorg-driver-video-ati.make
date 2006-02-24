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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_ATI) += xorg-driver-video-ati

#
# Paths and names
#
XORG_DRIVER_VIDEO_ATI_VERSION	:= 6.5.7.3
XORG_DRIVER_VIDEO_ATI		:= xf86-video-ati-X11R7.0-$(XORG_DRIVER_VIDEO_ATI_VERSION)
XORG_DRIVER_VIDEO_ATI_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_ATI_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/driver//$(XORG_DRIVER_VIDEO_ATI).$(XORG_DRIVER_VIDEO_ATI_SUFFIX)
XORG_DRIVER_VIDEO_ATI_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_ATI).$(XORG_DRIVER_VIDEO_ATI_SUFFIX)
XORG_DRIVER_VIDEO_ATI_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_ATI)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-video-ati_get: $(STATEDIR)/xorg-driver-video-ati.get

$(STATEDIR)/xorg-driver-video-ati.get: $(xorg-driver-video-ati_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_ATI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_DRIVER_VIDEO_ATI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-ati_extract: $(STATEDIR)/xorg-driver-video-ati.extract

$(STATEDIR)/xorg-driver-video-ati.extract: $(xorg-driver-video-ati_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_ATI_DIR))
	@$(call extract, $(XORG_DRIVER_VIDEO_ATI_SOURCE))
	@$(call patchin, $(XORG_DRIVER_VIDEO_ATI))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-ati_prepare: $(STATEDIR)/xorg-driver-video-ati.prepare

XORG_DRIVER_VIDEO_ATI_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_ATI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_ATI_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_XORG_DRIVER_VIDEO_ATI_DRI
XORG_DRIVER_VIDEO_ATI_AUTOCONF += --enable-dri
else
XORG_DRIVER_VIDEO_ATI_AUTOCONF += --disable-dri
endif

$(STATEDIR)/xorg-driver-video-ati.prepare: $(xorg-driver-video-ati_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_ATI_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_ATI_DIR) && \
		$(XORG_DRIVER_VIDEO_ATI_PATH) $(XORG_DRIVER_VIDEO_ATI_ENV) \
		./configure $(XORG_DRIVER_VIDEO_ATI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-ati_compile: $(STATEDIR)/xorg-driver-video-ati.compile

$(STATEDIR)/xorg-driver-video-ati.compile: $(xorg-driver-video-ati_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_ATI_DIR) && $(XORG_DRIVER_VIDEO_ATI_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-ati_install: $(STATEDIR)/xorg-driver-video-ati.install

$(STATEDIR)/xorg-driver-video-ati.install: $(xorg-driver-video-ati_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_VIDEO_ATI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-ati_targetinstall: $(STATEDIR)/xorg-driver-video-ati.targetinstall

$(STATEDIR)/xorg-driver-video-ati.targetinstall: $(xorg-driver-video-ati_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-ati)
	@$(call install_fixup, xorg-driver-video-ati,PACKAGE,xorg-driver-video-ati)
	@$(call install_fixup, xorg-driver-video-ati,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-ati,VERSION,$(XORG_DRIVER_VIDEO_ATI_VERSION))
	@$(call install_fixup, xorg-driver-video-ati,SECTION,base)
	@$(call install_fixup, xorg-driver-video-ati,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-ati,DEPENDS,)
	@$(call install_fixup, xorg-driver-video-ati,DESCRIPTION,missing)

#FIXME

	@$(call install_finish, xorg-driver-video-ati)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-ati_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-ati.*
	rm -rf $(IMAGEDIR)/xorg-driver-video-ati_*
	rm -rf $(XORG_DRIVER_VIDEO_ATI_DIR)

# vim: syntax=make
