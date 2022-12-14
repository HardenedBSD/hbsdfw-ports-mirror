# Created by: Roman Shterenzon <roman@xpert.com>
# $FreeBSD$

PORTNAME=	zinf
PORTVERSION=	2.2.5
PORTREVISION=	19
CATEGORIES=	audio ipv6
MASTER_SITES=	SF

MAINTAINER=	ports@FreeBSD.org
COMMENT=	GTK-based MP3 player

LIB_DEPENDS=	libid3-3.8.so:${PORTSDIR}/audio/id3lib \
		libgdbm.so:${PORTSDIR}/databases/gdbm

USES=		pathfix pkgconfig gettext gmake perl5
USE_GNOME=	gtk20 lthack
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-ipv6 \
		--disable-arts

CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib ${PTHREAD_LIBS}

OPTIONS_DEFINE=	ESOUND VORBIS
OPTIONS_DEFAULT=VORBIS
OPTIONS_SUB=	yes

ESOUND_CONFIGURE_OFF=	--disable-esd
ESOUND_USE=		GNOME=esound

VORBIS_CONFIGURE_OFF=	--disable-vorbis
VORBIS_LIB_DEPENDS=	libvorbis.so:${PORTSDIR}/audio/libvorbis

.include <bsd.port.pre.mk>

.if ${ARCH} == "i386"
BUILD_DEPENDS+=	nasm:${PORTSDIR}/devel/nasm
CPPFLAGS+=	"-D_M_IX86"
.else
CONFIGURE_ARGS+=	--disable-x86opts
.endif

.if ${ARCH} == "alpha"
CPPFLAGS+=	"-D_M_ALPHA"
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|echo aout|echo elf|' ${WRKSRC}/configure
	@${REINPLACE_CMD} -e 's|Player::||' ${WRKSRC}/base/include/player.h

post-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/etc/sdr/plugins
	${INSTALL_DATA} ${FILESDIR}/sdr2.plugin.S100.audio.rtp.mpa.zinf \
		${STAGEDIR}${PREFIX}/etc/sdr/plugins

.include <bsd.port.post.mk>
