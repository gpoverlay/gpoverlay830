# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.3-dev

EAPI=8

CRATES="
	adler-1.0.2
	adler32-1.2.0
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bitvec-1.0.1
	bytemuck-1.12.3
	byteorder-1.4.3
	cc-1.0.78
	cfg-if-1.0.0
	clap-3.2.23
	clap_lex-0.2.4
	color_quant-1.1.0
	crc-3.0.0
	crc-catalog-2.1.0
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.13
	crossbeam-utils-0.8.14
	either-1.8.0
	filetime-0.2.19
	flate2-1.0.25
	funty-2.0.0
	glob-0.3.0
	hashbrown-0.12.3
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	image-0.24.5
	indexmap-1.9.2
	iter-read-0.3.1
	itertools-0.10.5
	libc-0.2.139
	libdeflate-sys-0.11.0
	libdeflater-0.11.0
	log-0.4.17
	memoffset-0.7.1
	miniz_oxide-0.6.2
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.15.0
	once_cell-1.16.0
	os_str_bytes-6.4.1
	png-0.17.7
	radium-0.7.0
	rayon-1.6.1
	rayon-core-1.10.1
	redox_syscall-0.2.16
	rgb-0.8.34
	rustc-hash-1.1.0
	rustc_version-0.4.0
	scopeguard-1.1.0
	semver-1.0.16
	stderrlog-0.5.4
	strsim-0.10.0
	tap-1.0.1
	termcolor-1.1.3
	textwrap-0.16.0
	thread_local-1.1.4
	typed-arena-2.0.1
	wild-2.1.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.0
	windows_aarch64_msvc-0.42.0
	windows_i686_gnu-0.42.0
	windows_i686_msvc-0.42.0
	windows_x86_64_gnu-0.42.0
	windows_x86_64_gnullvm-0.42.0
	windows_x86_64_msvc-0.42.0
	wyz-0.5.1
	zopfli-0.7.1
"

inherit cargo flag-o-matic

DESCRIPTION="Multithreaded lossless PNG compression optimizer written in Rust"
HOMEPAGE="https://github.com/shssoichiro/oxipng"
SRC_URI="https://github.com/shssoichiro/oxipng/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

LICENSE="
	|| ( 0BSD Apache-2.0 MIT )
	Apache-2.0
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	MIT
	|| ( MIT Unlicense )
	ZLIB
"
SLOT="0"
KEYWORDS="amd64 arm64 ~riscv ~x86"

BDEPEND=">=virtual/rust-1.61.0"

QA_FLAGS_IGNORED="usr/bin/oxipng"

src_configure() {
	filter-lto # 860063 file format not recognized with cloudflare-zlib-sys
}

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md
}