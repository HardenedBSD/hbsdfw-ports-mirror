# Created by: GreenDog <fiziologus@gmail.com>
# $FreeBSD$

PORTNAME=	lua
PORTVERSION=	5.2.3
CATEGORIES=	lang
MASTER_SITES=	http://www.lua.org/ftp/
PKGNAMESUFFIX=	52

MAINTAINER=	lua@FreeBSD.org
COMMENT=	Small, compilable scripting language providing easy access to C code

LICENSE=	MIT

LUA_VER=	5.2
USES=		pkgconfig readline
USE_LDCONFIG=	yes

# Overriding __MAKE_CONF makes sure that we don't re-parse
# /etc/make.conf during do-build, which would jeopardize the build
# if, for instance, the user set CFLAGS=mumble
# NOTE: /etc/make.conf is read BEFORE Makefile, so we already
# have its settings when we get here.
# See http://wiki.freebsd.org/MatthiasAndree/LuaLessonsLearnt
MAKE_ARGS=	__MAKE_CONF=${NONEXISTENT}
# liblua.so requires libm, so make sure it has an explicit dependency
# so that applications need not second-guess lua's dependencies.
LDFLAGS+=	-lm -pthread
BUILD_WRKSRC=	${WRKSRC}/src
MAKE_ARGS+=	MYCFLAGS="${CFLAGS} -DLUA_USE_LINUX" \
		MYLDFLAGS="${LDFLAGS} -Wl,-E -lreadline" \
		CC="${CC}" \
		LUA_T=lua52 \
		LUAC_T=luac52 \
		LUA_A=liblua-${LUA_VER}.a \
		LUA_SO=liblua-${LUA_VER}.so \
		TO_BIN="lua52 luac52" \
		TO_LIB="liblua-${LUA_VER}.a liblua-${LUA_VER}.so" \
		INSTALL_TOP=${STAGEDIR}${PREFIX} \
		INSTALL_INC=${STAGEDIR}${PREFIX}/include/lua52 \
		INSTALL_EXEC="${INSTALL_PROGRAM}"

.include <bsd.port.options.mk>

.if ${ARCH} == "amd64" || ${ARCH} == "powerpc"
CFLAGS+=	-fPIC
.endif

post-patch:
	@${REINPLACE_CMD} -e 's,rand *(,random(,g' \
		${WRKSRC}/src/lmathlib.c
	@${REINPLACE_CMD} -e "/LUA_ROOT/s|/usr/local|${LUA_PREFIX}|" \
		${WRKSRC}/src/luaconf.h

post-install:
	@${MV} ${STAGEDIR}${PREFIX}/man/man1/lua.1 \
		${STAGEDIR}${PREFIX}/man/man1/lua52.1
	@${MV} ${STAGEDIR}${PREFIX}/man/man1/luac.1 \
		${STAGEDIR}${PREFIX}/man/man1/luac52.1

.include <bsd.port.mk>
