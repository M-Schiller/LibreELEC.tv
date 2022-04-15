# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="binutils-or1k"
PKG_VERSION="2.37"
PKG_SHA256="820d9724f020a3e69cb337893a0b63c2db161dadcb0e06fc11dc29eb1e84a32c"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/binutils/"
PKG_URL="https://ftp.gnu.org/gnu/binutils/binutils-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_LONGDESC="A GNU collection of binary utilities for OpenRISC 1000."

PKG_CONFIGURE_OPTS_HOST="--target=or1k-none-elf \
                         --with-sysroot=${SYSROOT_PREFIX} \
                         --with-lib-path=${SYSROOT_PREFIX}/lib:${SYSROOT_PREFIX}/usr/lib \
                         --without-ppl \
                         --enable-static \
                         --without-cloog \
                         --disable-werror \
                         --disable-multilib \
                         --disable-libada \
                         --disable-libssp \
                         --enable-version-specific-runtime-libs \
                         --enable-plugins \
                         --enable-gold \
                         --enable-ld=default \
                         --enable-lto \
                         --disable-nls"

pre_configure_host() {
  unset CPPFLAGS
  unset CFLAGS
  unset CXXFLAGS
  unset LDFLAGS
}

make_host() {
  make configure-host
  make
}

makeinstall_host() {
  cp -v ../include/libiberty.h ${SYSROOT_PREFIX}/usr/include
  make -C bfd install # fix parallel build with libctf requiring bfd
  make install
}