# Created by: SimaMoto,RyoTa <liangtai.s4@gmail.com>
# $FreeBSD$

PORTNAME=	libbs2b
PORTVERSION=	3.1.0
PORTREVISION=	2
CATEGORIES=	audio
MASTER_SITES=	SF/bs2b/bs2b/${PORTVERSION}

MAINTAINER=	liangtai.s4@gmail.com
COMMENT=	Bauer Stereophonic-to-Binaural DSP

LIB_DEPENDS+=	libsndfile.so:${PORTSDIR}/audio/libsndfile \
		libogg.so:${PORTSDIR}/audio/libogg \
		libFLAC.so:${PORTSDIR}/audio/flac \
		libvorbis.so:${PORTSDIR}/audio/libvorbis

USES=		gmake pkgconfig
NO_STAGE=	yes
USE_BZIP2=	yes
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS+=	CFLAGS=`pkg-config --cflags sndfile` \
	LDFLAGS=`pkg-config --libs-only-L sndfile`

pre-configure:
	${REINPLACE_CMD} -e 's@^\(pkgconfigdir = \).*@\1$${prefix}/libdata/pkgconfig@' \
	${WRKSRC}/Makefile.am ${WRKSRC}/Makefile.in

.include <bsd.port.mk>
