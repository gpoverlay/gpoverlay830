# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="A user for net-analyzer/netperf"

ACCT_USER_GROUPS=( "netperf" )
ACCT_USER_ID="168"

acct-user_add_deps
