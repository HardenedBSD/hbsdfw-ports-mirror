# $FreeBSD$

PORTNAME=	strigidaemon
PORTVERSION=	${STRIGI_VERSION}
CATEGORIES=	deskutils
MASTER_SITES=	${STRIGI_MASTER_SITES}

MAINTAINER=	kde@FreeBSD.org
COMMENT=	Strigi desktop search: daemon

LIB_DEPENDS=	libdbus-1.so:${PORTSDIR}/devel/dbus \
		libstreams.so:${PORTSDIR}/deskutils/libstreams \
		libstreamanalyzer.so:${PORTSDIR}/deskutils/libstreamanalyzer

USES=		pkgconfig
USE_FAM=	yes
USE_GNOME=	libxml2
USE_LDCONFIG=	yes

.include <${.CURDIR}/../strigi/Makefile.common>
.include <bsd.port.mk>
