# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="A user for net-vpn/networkmanager-openconnect"

ACCT_USER_GROUPS=( "nm-openconnect" )
ACCT_USER_ID="142"

acct-user_add_deps
