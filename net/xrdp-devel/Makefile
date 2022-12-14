# Created by: alepulver
# $FreeBSD$

PORTNAME=	xrdp
PORTVERSION=	0.7.0.b20130912
PORTREVISION=	1
PORTEPOCH=	1
CATEGORIES=	net
MASTER_SITES=	GH
PKGNAMESUFFIX=	-devel
DIST_SUBDIR?=	${PORTNAME}

MAINTAINER=	meta+ports@vmeta.jp
COMMENT=	Open source Remote Desktop Protocol (RDP) server

LICENSE=	GPLv2

USES=		pkgconfig
USE_XORG=	x11 xfixes
USE_AUTOTOOLS=	autoconf:env automake:env libtool
GNU_CONFIGURE=	yes
USE_RC_SUBR=	xrdp
USE_LDCONFIG=	${STAGEDIR}${PREFIX}/lib/xrdp
USE_GITHUB=	yes
GH_ACCOUNT=	FreeRDP
GH_PROJECT=	xrdp
GH_COMMIT=	64e2291
GH_TAGNAME=	${GH_COMMIT}

CONFIGURE_ARGS=	--localstatedir=/var \
		--enable-jpeg
LDFLAGS+=	-L${LOCALBASE}/lib
CPPFLAGS+=	-I${LOCALBASE}/include
CONFLICTS=	xrdp-[0-9]*
LIB_DEPENDS+=	jpeg:${PORTSDIR}/graphics/jpeg
# xrdp v0.7 is not compatible with current net/freerdp (1.0.2)
#BUILD_DEPENDS+=	freerdp>=1.0.2:${PORTSDIR}/net/freerdp
#CONFIGURE_ARGS+=	--enable-freerdp1

OPTIONS_DEFINE=	DEBUG SOUND
OPTIONS_DEFAULT=	TIGERVNC JP106
OPTIONS_MULTI=	KEYMAP
OPTIONS_MULTI_KEYMAP= JP106
OPTIONS_RADIO=	XVNC
OPTIONS_RADIO_XVNC=	REALVNC TIGERVNC TIGHTVNC TRIDIAVNC
REALVNC_DESC=	Use RealVNC
TIGERVNC_DESC=	Use TigerVNC (recommended)
TIGHTVNC_DESC=	Use TightVNC
TRIDIAVNC_DESC=	Use TridiaVNC
SOUND_DESC=	Enable sound support via pulseaudio (experimental)
JP106_DESC=	Install Japanese JP106 keymap

.include <bsd.port.options.mk>

# Which Xserver to use
.if ${PORT_OPTIONS:MREALVNC}
RUN_DEPENDS=	Xvnc:${PORTSDIR}/net/vnc
.endif
.if ${PORT_OPTIONS:MTIGERVNC}
RUN_DEPENDS=	Xvnc:${PORTSDIR}/net/tigervnc
.endif
.if ${PORT_OPTIONS:MTIGHTVNC}
RUN_DEPENDS=	Xvnc:${PORTSDIR}/net/tightvnc
.endif
.if ${PORT_OPTIONS:MTRIDIAVNC}
RUN_DEPENDS=	Xvnc:${PORTSDIR}/net/tridiavnc
.endif

.if ${PORT_OPTIONS:MDEBUG}
CONFIGURE_ARGS+=	--enable-xrdpdebug
CFLAGS+=	-DXRDP_DEBUG
.endif

.if ${PORT_OPTIONS:MJP106}
KEYMAP_FILES+=	km-0411.ini km-e0010411.ini \
		km-e0200411.ini km-e0210411.ini
PLIST_SUB+=	JP106=""
.else
PLIST_SUB+=	JP106="@comment "
.endif

.if ${PORT_OPTIONS:MSOUND}
BUILD_DEPENDS+=	${LOCALBASE}/include/pulse/simple.h:${PORTSDIR}/audio/pulseaudio \
		${LOCALBASE}/include/pulse/error.h:${PORTSDIR}/audio/pulseaudio
CONFIGURE_ARGS+=	--enable-simplesound
.endif

SUB_FILES=	pkg-message

post-patch:
.for f in sesman/sesman.ini sesman/startwm.sh xrdp/rsakeys.ini xrdp/xrdp.ini
	@${MV} ${WRKSRC}/$f ${WRKSRC}/$f.sample
.endfor

pre-configure:
	@cd ${WRKSRC} && ./bootstrap

post-install:
.for f in sesman.ini startwm.sh xrdp.ini
	@if [ ! -f ${STAGEDIR}${PREFIX}/etc/xrdp/$f ]; then \
		${CP} -p ${STAGEDIR}${PREFIX}/etc/xrdp/$f.sample ${STAGEDIR}${PREFIX}/etc/xrdp/$f ; \
	fi
.endfor
.for f in ${KEYMAP_FILES}
	${INSTALL_DATA} ${FILESDIR}/$f ${STAGEDIR}${PREFIX}/etc/xrdp
.endfor

.include <bsd.port.mk>
