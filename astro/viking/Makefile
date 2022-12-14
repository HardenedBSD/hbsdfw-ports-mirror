# Created by: David Le Brun <david@trucs.org>
# $FreeBSD$

PORTNAME=	viking
PORTVERSION=	1.5
CATEGORIES=	astro
MASTER_SITES=	SF/${PORTNAME}/

MAINTAINER=	nemysis@FreeBSD.org
COMMENT=	Program to manage GPS data (tracks, waypoints, etc.)

LICENSE=	GPLv2

BUILD_DEPENDS=	p5-XML-Parser>=0:${PORTSDIR}/textproc/p5-XML-Parser
LIB_DEPENDS=	libpthread-stubs.so:${PORTSDIR}/devel/libpthread-stubs \
		libpcre.so:${PORTSDIR}/devel/pcre \
		libcurl.so:${PORTSDIR}/ftp/curl \
		libpng15.so:${PORTSDIR}/graphics/png \
		libfreetype.so:${PORTSDIR}/print/freetype2 \
		libexpat.so:${PORTSDIR}/textproc/expat2 \
		libfontconfig.so:${PORTSDIR}/x11-fonts/fontconfig
RUN_DEPENDS=	gpsbabel:${PORTSDIR}/astro/gpsbabel

USE_BZIP2=	yes
USES=		gmake iconv desktop-file-utils perl5 pkgconfig
USE_XORG=	pixman x11 xau xcb xcomposite xcursor xdamage xdmcp xext \
		xfixes xi xinerama xrandr xrender
USE_GNOME=	cairo gnomedocutils gtk20
USE_PERL5=	run
GNU_CONFIGURE=	yes
INSTALLS_ICONS=	yes
INSTALLS_OMF=	yes

CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib -pthread

PORTDOCS=	AUTHORS ChangeLog NEWS README TODO

OPTIONS_DEFINE=		DOCS NLS GEOTAG GPSD
OPTIONS_DEFAULT=	GEOTAG GPSD
GEOTAG_DESC=	Geotag support
GPSD_DESC=	Realtime GPS tracking

OPTIONS_SUB=	yes

NLS_CONFIGURE_ENABLE=	nls
NLS_USES=		gettext

GEOTAG_LIB_DEPENDS=	libexif.so:${PORTSDIR}/graphics/libexif
GEOTAG_CONFIGURE_ENABLE=geotag

GPSD_LIB_DEPENDS=	libgpsd.so:${PORTSDIR}/astro/gpsd
GPSD_CONFIGURE_ENABLE=	realtime-gps-tracking

post-patch:
	@${REINPLACE_CMD} -e '/^AM_CFLAGS/s| -g | |' ${WRKSRC}/src/Makefile.in
	@${REINPLACE_CMD} -e 's|Science;|Education;Science;|' ${WRKSRC}/src/viking.desktop.in

post-install:
	${LN} -sf ${PREFIX}/share/icons/hicolor/48x48/apps/${PORTNAME}.png \
		${STAGEDIR}${PREFIX}/share/pixmaps/

	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${PORTDOCS:S|^|${WRKSRC}/|} ${STAGEDIR}${DOCSDIR}

.include <bsd.port.mk>
