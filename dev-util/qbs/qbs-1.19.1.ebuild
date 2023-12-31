# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils toolchain-funcs

MY_P=${PN}-src-${PV}

DESCRIPTION="Modern build tool for software projects"
HOMEPAGE="https://doc.qt.io/qbs/"
SRC_URI="https://download.qt.io/official_releases/${PN}/${PV}/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="|| ( LGPL-2.1 LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples gui test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtcore:5=
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5
	dev-qt/qtxml:5
	gui? (
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
"
DEPEND="${RDEPEND}
	test? (
		dev-qt/linguist-tools:5
		dev-qt/qtdbus:5
		dev-qt/qtdeclarative:5
		dev-qt/qttest:5
	)
"
BDEPEND="
	dev-qt/qtcore:5
	doc? (
		dev-qt/qdoc:5
		dev-qt/qthelp:5
	)
"

src_prepare() {
	default

	if ! use examples; then
		sed -i -e '/INSTALLS +=/ s:examples::' static.pro || die
	fi

	if ! use gui; then
		sed -i -e '/SUBDIRS += config-ui/ d' src/app/app.pro || die
	fi

	echo "SUBDIRS = $(usev test auto)" >> tests/tests.pro

	# skip several tests that fail and/or have additional deps
	local SKIP_TESTS_ARGS=(
		# requires zip and jar
		-e 's/findArchiver(binaryName,.*/"";/'
		# requires nodejs, bug 527652
		-e 's/p\.value("nodejs\./true||&/'
		# requires nodejs and typescript
		-e 's/\(p\.value\|m_qbsStderr\.contains\)("typescript\./true||&/'
	)
	sed -i tests/auto/blackbox/tst_blackbox.cpp "${SKIP_TESTS_ARGS[@]}" || die
	sed -i -re '/blackbox-(android|apple|java)\.pro/ d' tests/auto/auto.pro || die
}

src_configure() {
	local myqmakeargs=(
		qbs.pro # bug 523218
		-recursive
		CONFIG+=qbs_disable_rpath
		CONFIG+=qbs_enable_project_file_updates
		$(usev test 'CONFIG+=qbs_enable_unit_tests')
		QBS_INSTALL_PREFIX="${EPREFIX}/usr"
		QBS_LIBRARY_DIRNAME="$(get_libdir)"
	)
	eqmake5 "${myqmakeargs[@]}"
}

src_test() {
	einfo "Setting up test environment in ${T}"

	export HOME=${T}
	export LD_LIBRARY_PATH=${S}/$(get_libdir)
	export QBS_AUTOTEST_PROFILE=testProfile

	"${S}"/bin/qbs-setup-toolchains "$(tc-getCC)" testToolchain || die
	"${S}"/bin/qbs-setup-qt "$(qt5_get_bindir)/qmake" ${QBS_AUTOTEST_PROFILE} || die
	"${S}"/bin/qbs-config profiles.${QBS_AUTOTEST_PROFILE}.qbs.targetPlatform linux || die

	einfo "Running autotests"

	# simply exporting LD_LIBRARY_PATH doesn't work
	# we have to use a custom testrunner script
	local testrunner=${WORKDIR}/gentoo-testrunner
	cat <<-EOF > "${testrunner}"
	#!/bin/sh
	export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}\${LD_LIBRARY_PATH:+:}\${LD_LIBRARY_PATH}"
	exec "\$@"
	EOF
	chmod +x "${testrunner}"

	emake TESTRUNNER="'${testrunner}'" check
}

src_install() {
	emake -j1 INSTALL_ROOT="${D}" install

	dodoc -r changelogs CONTRIBUTING.md README.md

	# install documentation
	if use doc; then
		emake docs
		dodoc -r doc/qbs/html
		dodoc doc/qbs.qch
		docompress -x /usr/share/doc/${PF}/qbs.qch
	fi
}
