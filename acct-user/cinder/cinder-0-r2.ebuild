# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for the openstack cinder service"
ACCT_USER_ID=442
ACCT_USER_HOME=/var/lib/cinder
ACCT_USER_HOME_PERMS=0770
ACCT_USER_GROUPS=( cinder )

acct-user_add_deps
