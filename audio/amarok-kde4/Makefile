# Created by: Markus Brueffer <markus@FreeBSD.org>
# $FreeBSD$

PORTNAME=	amarok
PORTVERSION=	2.7.0
PORTREVISION=	4
CATEGORIES=	audio kde
MASTER_SITES=	${MASTER_SITE_KDE}
MASTER_SITE_SUBDIR=	stable/${PORTNAME}/${PORTVERSION}/src

MAINTAINER=	kde@FreeBSD.org
COMMENT=	KDE music player

LIB_DEPENDS=	libtag.so:${PORTSDIR}/audio/taglib \
		libtag-extras.so:${PORTSDIR}/audio/taglib-extras \
		liblastfm.so:${PORTSDIR}/audio/liblastfm \
		libofa.so:${PORTSDIR}/audio/libofa \
		libavcodec.so:${PORTSDIR}/multimedia/ffmpeg \
		libqjson.so:${PORTSDIR}/devel/qjson \
		libqca.so:${PORTSDIR}/devel/qca \
		libdbus-1.so:${PORTSDIR}/devel/dbus
BUILD_DEPENDS=	${LOCALBASE}/lib/qt4/plugins/script/libqtscript_core.so.1.0.0:${PORTSDIR}/devel/qtscriptgenerator
RUN_DEPENDS=	${LOCALBASE}/lib/qt4/plugins/script/libqtscript_core.so.1.0.0:${PORTSDIR}/devel/qtscriptgenerator \
		${KDE4_PREFIX}/lib/kde4/kio_upnp_ms.so:${PORTSDIR}/net/kio-upnp-ms

LATEST_LINK=	${PORTNAME}-kde4

USE_KDE4=	kdehier kdelibs kdeprefix libkcddb libkcompactdisc \
		nepomuk-core runtime automoc4 sharedmime strigi
USE_MYSQL=	embedded
USE_QT4=	dbus designer gui network opengl \
		phonon script sql svg webkit xml \
		qmake_build moc_build rcc_build uic_build
USE_XORG=	x11
USE_BZIP2=	yes
NO_STAGE=	yes
USES=		cmake pkgconfig
USE_LDCONFIG=	yes

OPTIONS_DEFINE=	AMAZON IPOD MP3TUNES MTP
OPTIONS_DEFAULT=IPOD MP3TUNES MTP

AMAZON_DESC=	Amazon MP3 store support via clamz
IPOD_DESC=	Apple iPod support
MP3TUNES_DESC=	MP3tunes support

.include <bsd.port.options.mk>

.if ${ARCH} == "sparc64"
BROKEN=		does not build on sparc64 (GCC-related error)
.endif

.if ${PORT_OPTIONS:MAMAZON}
RUN_DEPENDS+=	clamz:${PORTSDIR}/net/clamz
.endif

.if ${PORT_OPTIONS:MIPOD}
LIB_DEPENDS+=	libgpod.so:${PORTSDIR}/audio/libgpod
USE_GNOME+=	gdkpixbuf2 glib20
PLIST_SUB+=	IPOD=""
.else
CMAKE_ARGS+=	-DWITH_IPOD:BOOL=Off
PLIST_SUB+=	IPOD="@comment "
.endif

.if ${PORT_OPTIONS:MMP3TUNES}
LIB_DEPENDS+=	libloudmouth-1.so:${PORTSDIR}/net-im/loudmouth \
		libcurl.so:${PORTSDIR}/ftp/curl
USE_GNOME+=	glib20 libxml2
PLIST_SUB+=	MP3TUNES=""
.else
CMAKE_ARGS+=	-DWITH_MP3tunes:BOOL=Off
PLIST_SUB+=	MP3TUNES="@comment "
.endif

.if ${PORT_OPTIONS:MMTP}
LIB_DEPENDS+=	libmtp.so:${PORTSDIR}/audio/libmtp
PLIST_SUB+=	MTP=""
.else
CMAKE_ARGS+=	-DWITH_Mtp:BOOL=Off
PLIST_SUB+=	MTP="@comment "
.endif

.if ${PORT_OPTIONS:MNLS}
USES+=		gettext
PLIST_SUB+=	NLS=""
.else
CMAKE_ARGS+=	-DBUILD_po:BOOL=Off
PLIST_SUB+=	NLS="@comment "
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|/usr/local|${LOCALBASE}|' \
		${WRKSRC}/cmake/modules/FindMySQLAmarok.cmake
	@${REINPLACE_CMD} -e 's|/usr/include|${LOCALBASE}/include|' \
		${WRKSRC}/cmake/modules/FindLoudmouth.cmake
# Avoid installing MIME types prior to install stage.
	@${REINPLACE_CMD} -e '/XDG.*EXECUTABLE/ d' \
		${WRKSRC}/utilities/amzdownloader/CMakeLists.txt

post-install:
	${INSTALL_DATA} ${WRKSRC}/utilities/amzdownloader/amzdownloader.xml \
		${PREFIX}/share/mime/packages
	${INSTALL_SCRIPT} ${WRKSRC}/utilities/amzdownloader/amzdownloader.desktop \
		${PREFIX}/share/applications/kde4

.include <bsd.port.mk>
