# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@0.7.20
	aho-corasick@1.0.1
	ammonia@3.3.0
	android_system_properties@0.1.5
	anstream@0.3.2
	anstyle-parse@0.2.0
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anstyle@1.0.0
	anyhow@1.0.71
	assert_cmd@2.0.11
	autocfg@1.1.0
	base64@0.13.1
	base64@0.21.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	block-buffer@0.10.4
	bstr@1.4.0
	bumpalo@3.12.2
	byteorder@1.4.3
	bytes@1.4.0
	cc@1.0.79
	cfg-if@1.0.0
	chrono@0.4.24
	clap@4.2.7
	clap_builder@4.2.7
	clap_complete@4.2.3
	clap_lex@0.4.1
	colorchoice@1.0.0
	core-foundation-sys@0.8.4
	cpufeatures@0.2.7
	crossbeam-channel@0.5.8
	crossbeam-utils@0.8.15
	crypto-common@0.1.6
	ctor@0.1.26
	diff@0.1.13
	difflib@0.4.0
	digest@0.10.6
	doc-comment@0.3.3
	either@1.8.1
	elasticlunr-rs@3.0.2
	env_logger@0.10.0
	errno-dragonfly@0.1.2
	errno@0.2.8
	errno@0.3.1
	fastrand@1.9.0
	filetime@0.2.21
	float-cmp@0.9.0
	fnv@1.0.7
	form_urlencoded@1.1.0
	fsevent-sys@4.1.0
	futf@0.1.5
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	generic-array@0.14.7
	getrandom@0.2.9
	globset@0.4.10
	h2@0.3.19
	handlebars@4.3.7
	hashbrown@0.12.3
	headers-core@0.2.0
	headers@0.3.8
	hermit-abi@0.2.6
	hermit-abi@0.3.1
	html5ever@0.26.0
	http-body@0.4.5
	http@0.2.9
	httparse@1.8.0
	httpdate@1.0.2
	humantime@2.1.0
	hyper@0.14.26
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.56
	idna@0.3.0
	ignore@0.4.20
	indexmap@1.9.3
	inotify-sys@0.1.5
	inotify@0.9.6
	instant@0.1.12
	io-lifetimes@1.0.10
	is-terminal@0.4.7
	itertools@0.10.5
	itoa@1.0.6
	js-sys@0.3.62
	kqueue-sys@1.0.3
	kqueue@1.0.7
	lazy_static@1.4.0
	libc@0.2.144
	linux-raw-sys@0.1.4
	linux-raw-sys@0.3.7
	lock_api@0.4.9
	log@0.4.17
	mac@0.1.1
	maplit@1.0.2
	markup5ever@0.11.0
	markup5ever_rcdom@0.2.0
	memchr@2.5.0
	mime@0.3.17
	mime_guess@2.0.4
	mio@0.8.5
	new_debug_unreachable@1.0.4
	normalize-line-endings@0.3.0
	notify-debouncer-mini@0.2.1
	notify@5.1.0
	num-integer@0.1.45
	num-traits@0.2.15
	num_cpus@1.15.0
	once_cell@1.17.1
	opener@0.5.2
	output_vt100@0.1.3
	parking_lot@0.12.1
	parking_lot_core@0.9.6
	percent-encoding@2.2.0
	pest@2.6.0
	pest_derive@2.6.0
	pest_generator@2.6.0
	pest_meta@2.6.0
	phf@0.10.1
	phf_codegen@0.10.0
	phf_generator@0.10.0
	phf_shared@0.10.0
	pin-project-internal@1.1.0
	pin-project-lite@0.2.9
	pin-project@1.1.0
	pin-utils@0.1.0
	ppv-lite86@0.2.17
	precomputed-hash@0.1.1
	predicates-core@1.0.6
	predicates-tree@1.0.9
	predicates@2.1.5
	predicates@3.0.3
	pretty_assertions@1.3.0
	proc-macro2@1.0.56
	pulldown-cmark@0.9.3
	quote@1.0.27
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.2.16
	regex-automata@0.1.10
	regex-syntax@0.7.1
	regex@1.8.1
	rustix@0.36.7
	rustix@0.37.19
	rustls-pemfile@1.0.2
	ryu@1.0.13
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.1.0
	select@0.6.0
	semver@1.0.17
	serde@1.0.163
	serde_derive@1.0.163
	serde_json@1.0.96
	serde_urlencoded@0.7.1
	sha1@0.10.5
	sha2@0.10.6
	shlex@1.1.0
	siphasher@0.3.10
	slab@0.4.8
	smallvec@1.10.0
	socket2@0.4.9
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	strsim@0.10.0
	syn@1.0.105
	syn@2.0.15
	tempfile@3.4.0
	tendril@0.4.3
	termcolor@1.2.0
	terminal_size@0.2.6
	termtree@0.4.1
	thiserror-impl@1.0.40
	thiserror@1.0.40
	thread_local@1.1.7
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-macros@2.1.0
	tokio-stream@0.1.14
	tokio-tungstenite@0.18.0
	tokio-util@0.7.8
	tokio@1.28.1
	toml@0.5.11
	topological-sort@0.2.2
	tower-service@0.3.2
	tracing-core@0.1.31
	tracing@0.1.37
	try-lock@0.2.4
	tungstenite@0.18.0
	typenum@1.16.0
	ucd-trie@0.1.5
	unicase@2.6.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.8
	unicode-normalization@0.1.22
	url@2.3.1
	utf-8@0.7.6
	utf8parse@0.2.1
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.3.3
	want@0.3.0
	warp@0.3.5
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.85
	wasm-bindgen-macro-support@0.2.85
	wasm-bindgen-macro@0.2.85
	wasm-bindgen-shared@0.2.85
	wasm-bindgen@0.2.85
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.42.0
	windows-sys@0.48.0
	windows-targets@0.48.0
	windows@0.48.0
	windows_aarch64_gnullvm@0.42.0
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.42.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.42.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.42.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.42.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.42.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.42.0
	windows_x86_64_msvc@0.48.0
	xml5ever@0.17.0
	yansi@0.5.1"
inherit cargo toolchain-funcs

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="
	https://github.com/rust-lang/mdBook/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	${CARGO_CRATE_URIS}"
S="${WORKDIR}/${P/b/B}"

# CC-BY-4.0/OFL-1.1: embeds fonts inside the executable
LICENSE="MPL-2.0 CC-BY-4.0 OFL-1.1"
LICENSE+="
	Apache-2.0 BSD ISC MIT Unicode-DFS-2016
	|| ( Artistic-2 CC0-1.0 )" # crates
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="doc"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	cargo_src_compile

	if use doc; then
		if tc-is-cross-compiler; then
			ewarn "html docs were skipped due to cross-compilation"
		else
			target/$(usex debug{,} release)/${PN} build -d html guide || die
		fi
	fi
}

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md
	use doc && ! tc-is-cross-compiler && dodoc -r guide/html
}