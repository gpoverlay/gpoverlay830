# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of useful BSD APIs"
HOMEPAGE="https://github.com/troglobit/libite"
SRC_URI="https://github.com/troglobit/libite/releases/download/v${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
	rm "${ED}"/usr/share/doc/${PF}/LICENSE || die
}
