# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_E2FSPROGS) += e2fsprogs

#
# Paths and names
#
E2FSPROGS_VERSION	:= 1.40.8
E2FSPROGS		:= e2fsprogs-$(E2FSPROGS_VERSION)
E2FSPROGS_SUFFIX	:= tar.gz
E2FSPROGS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/e2fsprogs/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_SOURCE	:= $(SRCDIR)/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_DIR		:= $(BUILDDIR)/$(E2FSPROGS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(E2FSPROGS_SOURCE):
	@$(call targetinfo)
	@$(call get, E2FSPROGS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

e2fsprogs_prepare: $(STATEDIR)/e2fsprogs.prepare

E2FSPROGS_PATH	:=  PATH=$(CROSS_PATH)
E2FSPROGS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
E2FSPROGS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-root-prefix="" \
	--disable-nls

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/e2fsprogs.install:
	@$(call targetinfo)
	@$(call install, E2FSPROGS,,,install-libs)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/e2fsprogs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, e2fsprogs)
	@$(call install_fixup,e2fsprogs,PACKAGE,e2fsprogs)
	@$(call install_fixup,e2fsprogs,PRIORITY,optional)
	@$(call install_fixup,e2fsprogs,VERSION,$(E2FSPROGS_VERSION))
	@$(call install_fixup,e2fsprogs,SECTION,base)
	@$(call install_fixup,e2fsprogs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,e2fsprogs,DEPENDS,)
	@$(call install_fixup,e2fsprogs,DESCRIPTION,missing)

ifdef PTXCONF_E2FSPROGS_MKFS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, $(E2FSPROGS_DIR)/misc/mke2fs, /sbin/mke2fs)
ifdef PTXCONF_E2FSPROGS_MKFS_EXT2
	@$(call install_link, e2fsprogs, /sbin/mke2fs, /sbin/mkfs.ext2)
endif
endif
ifdef PTXCONF_E2FSPROGS_E2FSCK
	@$(call install_copy, e2fsprogs, 0, 0, 0755, $(E2FSPROGS_DIR)/e2fsck/e2fsck, /sbin/e2fsck)
ifdef PTXCONF_E2FSPROGS_E2FSCK_EXT2
	@$(call install_link, e2fsprogs, /sbin/e2fsck, /sbin/fsck.ext2)
endif
endif
ifdef PTXCONF_E2FSPROGS_TUNE2FS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, $(E2FSPROGS_DIR)/misc/tune2fs, /sbin/tune2fs)
	@$(call install_link, e2fsprogs, /sbin/tune2fs, /sbin/findfs)
	@$(call install_link, e2fsprogs, /sbin/tune2fs, /sbin/e2label)
endif

	@$(call install_finish,e2fsprogs)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

e2fsprogs_clean:
	rm -rf $(STATEDIR)/e2fsprogs.*
	rm -rf $(PKGDIR)/e2fsprogs_*
	rm -rf $(E2FSPROGS_DIR)

# vim: syntax=make
