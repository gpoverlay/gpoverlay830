# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for netbox"
ACCT_USER_ID=431
ACCT_USER_GROUPS=( netbox )
ACCT_USER_HOME=/var/lib/netbox

acct-user_add_deps
