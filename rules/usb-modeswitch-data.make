# -*-makefile-*-
#
# Copyright (C) 2016 by Ladislav Michl <ladis@linux-mips.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_USB_MODESWITCH_DATA) += usb-modeswitch-data

#
# Paths and names
#
USB_MODESWITCH_DATA_VERSION	:= 20160112
USB_MODESWITCH_DATA_MD5		:= 040d11138fc0a61b980d704ac3b4547f
USB_MODESWITCH_DATA		:= usb-modeswitch-data-$(USB_MODESWITCH_DATA_VERSION)
USB_MODESWITCH_DATA_SUFFIX	:= tar.bz2
USB_MODESWITCH_DATA_URL		:= http://www.draisberghof.de/usb_modeswitch/$(USB_MODESWITCH_DATA).$(USB_MODESWITCH_DATA_SUFFIX)
USB_MODESWITCH_DATA_SOURCE	:= $(SRCDIR)/$(USB_MODESWITCH_DATA).$(USB_MODESWITCH_DATA_SUFFIX)
USB_MODESWITCH_DATA_DIR		:= $(BUILDDIR)/$(USB_MODESWITCH_DATA)
USB_MODESWITCH_DATA_LICENSE	:= GPL-2.0


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

USB_MODESWITCH_DATA_CONF_TOOL	:= NO
USB_MODESWITCH_DATA_MAKE_ENV	:= $(CROSS_ENV)
USB_MODESWITCH_DATA_INSTALL_OPT	:= db-install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------
$(STATEDIR)/usb-modeswitch-data.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usb-modeswitch-data)
	@$(call install_fixup, usb-modeswitch-data,PRIORITY,optional)
	@$(call install_fixup, usb-modeswitch-data,SECTION,base)
	@$(call install_fixup, usb-modeswitch-data,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, usb-modeswitch-data,DESCRIPTION,missing)

	@$(call install_copy, usb-modeswitch-data, 0, 0, 0644, -, \
		 /lib/udev/rules.d/40-usb_modeswitch.rules)

	@$(call install_tree, usb-modeswitch-data, 0, 0, -, \
		/usr/share/usb_modeswitch)

	@$(call install_finish, usb-modeswitch-data)

	@$(call touch)

# vim: syntax=make
