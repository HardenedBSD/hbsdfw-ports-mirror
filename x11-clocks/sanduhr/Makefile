# Created by: Maxim Sobolev <sobomax@FreeBSD.org>
# $FreeBSD$

PORTNAME=	sanduhr
PORTVERSION=	1.93
PORTREVISION=	8
CATEGORIES=	x11-clocks gnome
MASTER_SITES=	http://seehuhn.de/media/programs/

MAINTAINER=	ports@FreeBSD.org
COMMENT=	An alarm clock for GNOME desktop designed as a sand-glass

USES=		gmake pkgconfig
USE_GNOME=	gnomehack gnomeprefix libgnomeui
INSTALLS_OMF=	yes
GNU_CONFIGURE=	yes
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

MAN1=		sanduhr.1

NO_STAGE=	yes
.include <bsd.port.mk>
