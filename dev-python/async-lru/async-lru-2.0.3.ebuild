# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

DESCRIPTION="Simple lru_cache for asyncio"
HOMEPAGE="
	https://github.com/aio-libs/async-lru/
	https://pypi.org/project/async-lru/
"
SRC_URI="
	https://github.com/aio-libs/async-lru/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.0.0[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	sed -e 's:--cache-clear::' \
		-e 's:--no-cov-on-fail --cov=async_lru --cov-report=term --cov-report=html::' \
		-i setup.cfg || die

	distutils-r1_src_prepare
}
