# $FreeBSD$

PORTNAME=	pixz
PORTVERSION=	1.0.2
CATEGORIES=	archivers
MASTER_SITES=	SF/pixz
EXTRACT_SUFX=	.tgz

MAINTAINER=	hrs@FreeBSD.org
COMMENT=	Parallel, indexing version of XZ

LICENSE=	BSD
LICENSE_FILE=	${WRKSRC}/LICENSE

SUB_FILES=	Makefile
PLIST_FILES=	bin/${PORTNAME} man/man1/pixz.1.gz
MAKE_ENV+=	PTHREAD_LIBS=${PTHREAD_LIBS}

.include <bsd.port.pre.mk>

.if ${OSVERSION} < 800505 || (${OSVERSION} >= 900000 && ${OSVERSION} < 900012)
LIB_DEPENDS+=	liblzma.so:${PORTSDIR}/archivers/xz
CFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib
.endif

post-extract: apply-slist
	${INSTALL_DATA} ${WRKDIR}/Makefile ${WRKSRC}
	${INSTALL_DATA} ${FILESDIR}/${PORTNAME}.1 ${WRKSRC}

.include <bsd.port.post.mk>
