# Created by: chris@officialunix.com
# $FreeBSD$

PORTNAME=	smasher
PORTVERSION=	1.1.6
PORTREVISION=	3
CATEGORIES=	audio
MASTER_SITES=	SF
DISTNAME=	${PORTNAME}-${PORTVERSION}-source

MAINTAINER=	c.petrik.sosa@gmail.com
COMMENT=	Cross platform audio loop slicer

LIB_DEPENDS=	libsndfile.so:${PORTSDIR}/audio/libsndfile \
		libmad.so:${PORTSDIR}/audio/libmad \
		libcsound64.so:${PORTSDIR}/audio/csound

GNU_CONFIGURE=	yes
USES=		gmake pkgconfig
NO_STAGE=	yes
USE_WX=		yes
WX_CONF_ARGS=	absolute

WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

post-patch:
	@${REINPLACE_CMD} -e 's|/usr/share/pixmaps|${PREFIX}/share/pixmaps|g' \
		-e 's|/usr/share/applications|${DESKTOPDIR}|g' \
		${WRKSRC}/src/Makefile.in

.include <bsd.port.mk>
