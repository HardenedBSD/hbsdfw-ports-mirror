# Created by: Nosov Artem <chip-set@mail.ru>
# $FreeBSD$

PORTNAME=	gcb
PORTVERSION=	0.2.8
PORTREVISION=	7
CATEGORIES=	x11
MASTER_SITES=	http://freebsd.flatrate.ru/distfiles/ \
		http://ccbsd9.csie.nctu.edu.tw/~cp76/gcb/

MAINTAINER=	chip-set@mail.ru
COMMENT=	A GTK+ tool for managing x11 cut-buffers

HAS_CONFIGURE=	yes
USES=		pkgconfig
USE_BZIP2=	yes
USE_GNOME=	gtk20

NO_STAGE=	yes
post-patch:
	@${REINPLACE_CMD} -e 's|#!/bin/bash|#!${SH}|' \
		${WRKSRC}/configure
	@${REINPLACE_CMD} -e 's|/usr/local|${PREFIX}|; \
		s|^\(CFLAGS\)=\(.*\)-g\ -O\(.*\)|\1+=\2 \3|' \
			${WRKSRC}/Makefile

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/${PORTNAME}.png ${PREFIX}/share/icons
	${INSTALL_DATA} ${FILESDIR}/${PORTNAME}.desktop \
		${PREFIX}/share/applications
	${INSTALL_DATA} ${WRKSRC}/${PORTNAME}.png ${PREFIX}/share/pixmaps

.include <bsd.port.mk>
