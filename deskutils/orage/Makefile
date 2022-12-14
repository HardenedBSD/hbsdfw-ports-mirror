# Created by: Matt Lancereau <matt@rimasec.net>
# $FreeBSD$

PORTNAME=	orage
PORTVERSION=	4.10.0
CATEGORIES=	deskutils xfce
MASTER_SITES=	${MASTER_SITE_XFCE}
MASTER_SITE_SUBDIR=src/apps/${PORTNAME}/${PORTVERSION:R}
DIST_SUBDIR=	xfce4

MAINTAINER=	xfce@FreeBSD.org
COMMENT=	Calendar application for the Xfce Desktop

LICENSE=	GPLv2

LIB_DEPENDS=	libpopt.so:${PORTSDIR}/devel/popt \
	libdbus-glib-1.so:${PORTSDIR}/devel/dbus-glib

GNU_CONFIGURE=	yes
INSTALLS_ICONS=	yes
USES=		pkgconfig gettext desktop-file-utils gmake
USE_BZIP2=	yes
USE_GNOME=	gtk20 intltool intlhack
USE_XFCE=	configenv libmenu panel
USE_XORG=	xext xrender xinerama xi xrandr xcursor xcomposite xdamage x11 \
		xfixes
LDFLAGS+=	-L${LOCALBASE}/lib
OPTIONS_DEFINE=	BDB ICAL NOTIFY
OPTIONS_DEFAULT=	NOTIFY

ICAL_DESC=	iCalendar support

CONFIGURE_ARGS=	--enable-dbus

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MBDB}
EXTRA_PATCHES+=	${FILESDIR}/extra-patch-configure
CONFIGURE_ARGS+=--with-bdb4=yes --with-bdb4_dir=${LOCALBASE}
USE_BDB=	yes
# Only Berkeley DB 4.x
INVALIDE_BDB_VER=	5
.else
CONFIGURE_ARGS+=--with-bdb4=no
.endif

.if ${PORT_OPTIONS:MICAL}
CONFIGURE_ARGS+=--enable-libical
LIB_DEPENDS+=	libical.so:${PORTSDIR}/devel/libical
CFLAGS+=	-I${LOCALBASE}/include/libical
PLIST_SUB+=	WITH_ICAL="@comment "
.else
CONFIGURE_ARGS+=--disable-libical
PLIST_SUB+=	WITH_ICAL=""
.endif

.if ${PORT_OPTIONS:MNOTIFY}
LIB_DEPENDS+=	libnotify.so:${PORTSDIR}/devel/libnotify
CONFIGURE_ARGS+=--enable-libnotify
.else
CONFIGURE_ARGS+=--disable-libnotify
.endif

post-patch:
.if ${PORT_OPTIONS:MBDB}
	@${REINPLACE_CMD} -e 's|%%BDB_INCLUDE_DIR%%|${BDB_INCLUDE_DIR}|g ; \
		s|%%BDB_LIB_DIR%%|${BDB_LIB_DIR}|g ; \
		s|%%BDB_LIB_NAME%%|${BDB_LIB_NAME}|g' ${WRKSRC}/configure
.endif
	@${REINPLACE_CMD} -e 's|echo aout|echo elf|g' ${WRKSRC}/configure
	@${REINPLACE_CMD} -e 's|(datadir)/orage/doc/C|(datadir)/doc/orage/C|' \
		${WRKSRC}/doc/C/Makefile.in \
		${WRKSRC}/doc/C/images/Makefile.in

.include <bsd.port.mk>
