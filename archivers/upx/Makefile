# Created by: Max Khon <fjoe@FreeBSD.org>
# $FreeBSD$

PORTNAME=	upx
PORTVERSION=	3.09
CATEGORIES=	archivers
MASTER_SITES=	http://upx.sourceforge.net/download/\
		SF/sevenzip/7-Zip/${LZMA_VER}:lzma
DISTFILES=	${PORTNAME}-${PORTVERSION}-src${EXTRACT_SUFX}\
		7z${LZMA_VER:S/.//g}${EXTRACT_SUFX}:lzma

MAINTAINER=	fjoe@FreeBSD.org
COMMENT=	The Ultimate Packer for eXecutables

LIB_DEPENDS=	libucl.so:${PORTSDIR}/archivers/ucl

NO_STAGE=	yes
LZMA_VER=	4.65
WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}-src
USE_BZIP2=	yes
USES=		gmake perl5
USE_PERL5=	build
MAKE_ENV=	UPX_UCLDIR=${LOCALBASE}\
		UPX_LZMADIR=${WRKDIR}\
		target=freebsd
NOT_FOR_ARCHS=	sparc64

PORTDOCS=	BUGS COPYING LICENSE NEWS PROJECTS README\
		README.1ST README.SRC THANKS TODO
MAN1=		upx.1
PLIST_FILES=	bin/upx

do-install:
	@${INSTALL_PROGRAM} ${WRKSRC}/src/upx.out ${PREFIX}/bin/upx
	@${INSTALL_MAN} ${WRKSRC}/doc/upx.1 ${MANPREFIX}/man/man1
.if !defined(NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
	@${INSTALL_DATA} ${PORTDOCS:S,^,${WRKSRC}/,} ${DOCSDIR}/
.endif

.include <bsd.port.mk>
