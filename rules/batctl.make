# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BATCTL) += batctl

#
# Paths and names
#
BATCTL_VERSION	:= 2016.2
BATCTL_MD5		:= 50f42d06611afae58ccfcde502f94c1a
BATCTL		:= batctl-$(BATCTL_VERSION)
BATCTL_SUFFIX	:= tar.gz
BATCTL_URL		:= http://downloads.open-mesh.org/batman/stable/sources/batctl/$(BATCTL).$(BATCTL_SUFFIX)
BATCTL_SOURCE	:= $(SRCDIR)/$(BATCTL).$(BATCTL_SUFFIX)
BATCTL_DIR		:= $(BUILDDIR)/$(BATCTL)
BATCTL_LICENSE	:= unknown


BATCTL_CONF_TOOL	:= NO
BATCTL_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/batctl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, batctl)
	@$(call install_fixup, batctl,PRIORITY,optional)
	@$(call install_fixup, batctl,SECTION,base)
	@$(call install_fixup, batctl,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, batctl,DESCRIPTION,missing)

	@$(call install_copy, batctl, 0, 0, 0755, $(BATCTL_DIR)/batctl, /usr/bin/batctl)

	@$(call install_finish, batctl)

	@$(call touch)

# vim: syntax=make
