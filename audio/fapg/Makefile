# Created by: chinsan <chinsan.tw@gmail.com>
# $FreeBSD$

PORTNAME=	fapg
PORTVERSION=	0.41
CATEGORIES=	audio
MASTER_SITES=	http://royale.zerezo.com/${PORTNAME}/

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Fast Audio Playlist Generator

LIB_DEPENDS=	liburiparser.so:${PORTSDIR}/net/uriparser

MAKE_ARGS+=	CC="${CC}"
NO_STAGE=	yes

MAN1=		fapg.1

do-build:
	@cd ${WRKSRC} && ${MAKE} ${PORTNAME}

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/fapg.1 ${MAN1PREFIX}/man/man1

post-install:
.if !defined(NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
.for file in COPYING README
	${INSTALL_DATA} ${WRKSRC}/${file} ${DOCSDIR}
.endfor
.endif

.include <bsd.port.mk>
