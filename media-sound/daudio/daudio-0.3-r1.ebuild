# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Distributed audio on the local network"
HOMEPAGE="https://daudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
# -sparc: 0.3: static audio on local daemon. No audio when client connects to amd64 daemon
KEYWORDS="amd64 ~ppc -sparc x86"

DEPEND=">=media-libs/libmad-0.15.0b-r1"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-makefile.patch"
	"${FILESDIR}/${P}-qa-implicit-declarations.patch"
	"${FILESDIR}/${P}-musl-stdint.patch"
)

src_prepare() {
	# fix #570582 by restoring pre-GCC5 inline semantics
	append-cflags -std=gnu89

	tc-export CC
	default
}

src_compile() {
	emake -C client
	emake -C server
	emake -C streamer
}

src_install() {
	dobin client/daudioc server/daudiod streamer/dstreamer
	newinitd "${FILESDIR}"/daudio.rc daudio
	dodoc doc/*
}
