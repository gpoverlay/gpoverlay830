# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Header-file-only, JSON parser serializer in C++"
HOMEPAGE="https://github.com/kazuho/picojson"
SRC_URI="https://github.com/kazuho/picojson/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	:
}

src_test() {
	tc-export CXX
	emake test
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
	dodoc README.mkdn Changes
}
