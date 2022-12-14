# Created by: nork@FreeBSD.org
# $FreeBSD$

PORTNAME=	kqemu
PORTVERSION=	1.3.0.p11
PORTREVISION=	12
CATEGORIES=	emulators
MASTER_SITES=	http://bellard.org/qemu/ \
		http://qemu.org/ \
		${MASTER_SITE_LOCAL}
MASTER_SITE_SUBDIR=	nox
PKGNAMESUFFIX=	-kmod
DISTNAME=	${PORTNAME}-${PORTVERSION:C/.p/pre/}
DIST_SUBDIR=	kqemu

MAINTAINER=	nox@FreeBSD.org
COMMENT=	Kernel Accelerator for QEMU CPU Emulator

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/COPYING

ONLY_FOR_ARCHS=	i386 amd64
HAS_CONFIGURE=	yes
USE_GMAKE=	yes
USE_GCC=	any
CONFIGURE_ARGS+=	--prefix=${PREFIX} --cc=${CC}
CONFLICTS=	kqemu-kmod-devel-[0-9]*

USE_RC_SUBR=	kqemu

NO_STAGE=	yes

USES=		kmod
.include <bsd.port.pre.mk>

PORTDOCS=	kqemu-doc.html kqemu-tech.html
PLIST_FILES=	"include/kqemu/kqemu.h"
PLIST_FILES+=	"@dirrm include/kqemu"
PLIST_FILES+=	"@cwd /"
PLIST_FILES+=	${KMODDIR:C,^/,,}/kqemu.ko
PLIST_FILES+=	"@cwd"

MAKEFILE=	Makefile.freebsd

MAKE_ARGS+=	LDFLAGS=${LDFLAGS:S/^-Wl,//}

.if ${ARCH} == "amd64"
GMAKE_ARGS+=	ARCH=x86_64
.endif

CFLAGS+=	${DEBUG_FLAGS}

post-patch:
	@${REINPLACE_CMD} -e '/CC=/s,gcc,${CC},' ${WRKSRC}/common/Makefile

do-build:
	@(cd ${BUILD_WRKSRC}; ${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${MAKEFILE} beforedepend && ${LN} -sfh @/sys sys)
	@(cd ${BUILD_WRKSRC}/common; ${SETENV} ${MAKE_ENV} ${GMAKE} ${MAKE_FLAGS} Makefile ${GMAKE_ARGS} ${ALL_TARGET})
	@(cd ${BUILD_WRKSRC}; ${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${ALL_TARGET})

do-install:
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${MAKE} ${MAKE_FLAGS} ${MAKEFILE} ${INSTALL_TARGET})
	${MKDIR} ${PREFIX}/include/kqemu
	${INSTALL_DATA} ${WRKSRC}/kqemu.h ${PREFIX}/include/kqemu
.if ${PORT_OPTIONS:MDOCS}
	${MKDIR} ${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/kqemu-doc.html ${WRKSRC}/kqemu-tech.html \
		${DOCSDIR}
.endif

.include <bsd.port.post.mk>
