# Created by: Sunry Chen <sunrychen@gmail.com>
# $FreeBSD$

PORTNAME=	xmorse
PORTVERSION=	20041125
PORTREVISION=	7
CATEGORIES=	comms hamradio
MASTER_SITES=	http://c2.com/morse/files/SourceCode/ \
		http://www.525183.com/freebsd/xmorse/ \
		http://www.chinatinco.com/freebsd/xmorse/ \
		http://525183.serverbox.org/freebsd/xmorse/
DISTNAME=	m${PORTVERSION}
EXTRACT_SUFX=	.tgz

MAINTAINER=	sunrychen@gmail.com
COMMENT=	Fully automatic Morse code teaching machine

LIB_DEPENDS=	libfltk.so:${PORTSDIR}/x11-toolkits/fltk

USE_SDL=	sdl

PLIST_FILES=	bin/xmorse
NO_WRKSUBDIR=	yes

NO_STAGE=	yes
.include <bsd.port.mk>
