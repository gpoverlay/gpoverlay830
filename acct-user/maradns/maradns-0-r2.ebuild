# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

ACCT_USER_ID=99
ACCT_USER_GROUPS=( "${PN}" )

acct-user_add_deps
