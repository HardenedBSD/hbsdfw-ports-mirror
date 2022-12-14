# Created by: Li-Lun Wang <llwang@infor.org>
# $FreeBSD$

PORTNAME=	hugo
PORTVERSION=	2.12
PORTREVISION=	12
CATEGORIES=	emulators
MASTER_SITES=	http://www.zeograd.com/download/

MAINTAINER=	portsw@FreeBSD.org
COMMENT=	A PC Engine (TurboGrafx 16) emulator

BUILD_DEPENDS=	${LOCALBASE}/include/argp.h:${PORTSDIR}/devel/argp-standalone

GNU_CONFIGURE=	yes
USES=		gmake pkgconfig
USE_SDL=	sdl
LDFLAGS+=	-L${LOCALBASE}/lib
CONFIGURE_ENV+=	SDL_CONFIG="${SDL_CONFIG}"

.if !defined(WITHOUT_NETPLAY)
USE_SDL+=	net
.else
CONFIGURE_ARGS+=	--enable-netplay=no
.endif

.if defined(WITHOUT_GUI)
CONFIGURE_ARGS+=	--enable-gui=no --disable-gtktest
.else
USE_GNOME=	gtk20
.endif

.if defined(WITH_OGG_SUPPORT)
LIB_DEPENDS+=	vorbis.4:${PORTSDIR}/audio/libvorbis
WITH_SDL_MIXER=	yes
CONFIGURE_ARGS+=	--with-ogg-support
.endif

.if defined(WITH_SDL_MIXER)
USE_SDL+=	mixer
CONFIGURE_ARGS+=	--with-sdl-mixer
.endif

MAKE_ENV+=	DOCSDIR="${DOCSDIR}"

.if defined(NOPORTDOCS)
MAKE_ENV+=	PORTDOCS=false
.else
MAKE_ENV+=	PORTDOCS=true
.endif

NO_STAGE=	yes
post-patch:
	@${REINPLACE_CMD} -e 's|sdl-config|${SDL_CONFIG}|' ${WRKSRC}/configure

.include <bsd.port.mk>
