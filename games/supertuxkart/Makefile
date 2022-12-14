# Created by: Dmitry Marakasov <amdmi3@amdmi3.ru>
# $FreeBSD$

PORTNAME=	supertuxkart
PORTVERSION=	0.8.1
CATEGORIES=	games
MASTER_SITES=	SF/supertuxkart/SuperTuxKart/${PORTVERSION}
EXTRACT_SUFX=	-src.tar.bz2

MAINTAINER=	amdmi3@FreeBSD.org
COMMENT=	Free 3D kart racing game

LICENSE=	GPLv3

LIB_DEPENDS=	libvorbisfile.so:${PORTSDIR}/audio/libvorbis \
		libogg.so:${PORTSDIR}/audio/libogg \
		libcurl.so:${PORTSDIR}/ftp/curl

USE_BZIP2=	yes
USE_GL=		gl glu glut
USE_OPENAL=	al alut
USES=		cmake gettext gmake pkgconfig
USE_SDL=	sdl
USE_DOS2UNIX=	lib/irrlicht/source/Irrlicht/Makefile
CMAKE_ARGS=	-DUSE_WIIUSE=NO

WRKSRC=		${WRKDIR}/SuperTuxKart-${PORTVERSION}

PORTDATA=	*

CXXFLAGS+=	-DNO_IRR_COMPILE_WITH_JOYSTICK_EVENTS_ \
		-D__FREE_BSD_

OPTIONS_DEFINE=	FRIBIDI
OPTIONS_DEFAULT=FRIBIDI

FRIBIDI_CMAKE_ON=	-DUSE_FRIBIDI=YES
FRIBIDI_CMAKE_OFF=	-DUSE_FRIBIDI=NO
FRIBIDI_LIB_DEPENDS=	libfribidi.so:${PORTSDIR}/converters/fribidi

.include <bsd.port.options.mk>

.if ${ARCH} == "powerpc"
BROKEN=		Does not configure on powerpc
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|/usr/X11R6/include|${LOCALBASE}/include|' \
		${WRKSRC}/lib/irrlicht/CMakeLists.txt

.include <bsd.port.mk>
