# Created by: Timothy Beyer <beyert@cs.ucr.edu>
# $FreeBSD$

PORTNAME=	arss
PORTVERSION=	0.2.3
PORTREVISION=	1
CATEGORIES=	audio
MASTER_SITES=	SF
DISTNAME=	${PORTNAME}-${PORTVERSION}-src

MAINTAINER=	beyert@cs.ucr.edu
COMMENT=	Additive Image Synthesizer (convert audio to images, images to audio)

LIB_DEPENDS=	libfftw3.so:${PORTSDIR}/math/fftw3

WRKSRC=	${WRKDIR}/${DISTNAME}/src

NO_STAGE=	yes
USES=		cmake
USE_LDCONFIG=	${PREFIX}/lib
CFLAGS+=	-L${LOCALBASE}/lib -I${LOCALBASE}/include
CMAKE_C_FLAGS=	${CFLAGS}

PLIST_FILES=	bin/arss

.include <bsd.port.pre.mk>

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/arss ${PREFIX}/bin

.include <bsd.port.post.mk>
