# Created by: krion
# $FreeBSD$

PORTNAME=	xterm
PORTVERSION=	300
CATEGORIES=	x11
MASTER_SITES=	ftp://invisible-island.net/xterm/:src1 \
		CRITICAL:src1 CRITICAL:src2
EXTRACT_SUFX=	.tgz
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}:src1 \
		bsd-xterm-icons-${ICONVERSION}${EXTRACT_SUFX}:src2

MAINTAINER=	ehaupt@FreeBSD.org
COMMENT=	Terminal emulator for the X Window System

CONFLICTS=	x11iraf-[0-9]*

USE_XORG=	xaw xft
WANT_GNOME=	desktopfileutils
GNU_CONFIGURE=	yes

CONFIGURE_ENV+=	LIBS="-L${LOCALBASE}/lib"
CONFIGURE_ARGS+=	--with-utempter --enable-narrowproto

CPPFLAGS+=	-I${LOCALBASE}/include

ICONVERSION=	1

OPTIONS_DEFINE=	WCHAR LUIT DECTERM PCRE GNOME DABBREV 256COLOR SIXEL

DABBREV_DESC=	Enable support for dabbrev-expand
DECTERM_DESC=	Enable DECterm Locator support
LUIT_DESC=	Use LUIT for locale convertion from/to UTF-8
SIXEL_DESC=	Enable Sixel graphics support
WCHAR_DESC=	Enable wide-character support
256COLOR_DESC=	Enable 256-color support

OPTIONS_DEFAULT=WCHAR LUIT 256COLOR

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:M256COLOR}
CONFIGURE_ARGS+=	--enable-256-color
.endif

.if ${PORT_OPTIONS:MLUIT}
CONFIGURE_ARGS+=	--enable-luit
BUILD_DEPENDS=	luit:${PORTSDIR}/x11/luit
.endif

.if ${PORT_OPTIONS:MWCHAR}
CONFIGURE_ARGS+=	--enable-wide-chars
.endif

.if ${PORT_OPTIONS:MDECTERM}
CONFIGURE_ARGS+=	--enable-dec-locator
.endif

.if ${PORT_OPTIONS:MPCRE}
CONFIGURE_ARGS+=	--with-pcre
LIB_DEPENDS=		pcre:${PORTSDIR}/devel/pcre
.endif

.if ${PORT_OPTIONS:MDABBREV}
CONFIGURE_ARGS+=	--enable-dabbrev
.endif

.if ${PORT_OPTIONS:MSIXEL}
CONFIGURE_ARGS+=	--enable-sixel-graphics
.endif

.if ${PORT_OPTIONS:MGNOME}
USE_GNOME=	desktopfileutils
PLIST_SUB+=	GNOME=""
.else
PLIST_SUB+=	GNOME="@comment "
.endif

.include <bsd.port.pre.mk>

.if ${OSVERSION} < 900004
LIB_DEPENDS+=	utempter:${PORTSDIR}/sysutils/libutempter
.endif

post-extract:
	@${CP} ${WRKDIR}/bsd-xterm-icons-1/*.png ${WRKDIR}/bsd-xterm-icons-1/*.xpm \
		${WRKSRC}/icons/

post-install:
.for f in koi8rxterm resize uxterm xterm
	@${CHMOD} ${BINMODE} ${STAGEDIR}${PREFIX}/bin/${f}
.endfor
	@${INSTALL_DATA} ${WRKSRC}/xterm.desktop ${STAGEDIR}${PREFIX}/share/applications/
.if ${PORT_OPTIONS:MGNOME}
	@-update-desktop-database
.endif

.if ${PORT_OPTIONS:MWCHAR}
	@${CAT} ${PKGMESSAGE}
.endif

.include <bsd.port.post.mk>
