# Created by: Shen Chuan-Hsing <statue@freebsd.sinica.edu.tw>
# $FreeBSD$

PORTNAME=	fcitx
PORTVERSION=	4.2.6.1
CATEGORIES=	chinese x11
PORTREVISION=	2
MASTER_SITES=	${MASTER_SITE_GOOGLE_CODE}
DISTFILES=	${DISTNAME}${EXTRACT_SUFX} \
		pinyin.tar.gz table.tar.gz en_dict-${_DICT_VER}.tar.gz
DIST_SUBDIR=	${PORTNAME}
EXTRACT_ONLY=	${DISTNAME}${EXTRACT_SUFX}

MAINTAINER=	lichray@gmail.com
COMMENT=	A Flexible Input Method Framework

LICENSE=	GPLv2

BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/iso-codes.pc:${PORTSDIR}/misc/iso-codes
LIB_DEPENDS=	libexecinfo.so:${PORTSDIR}/devel/libexecinfo \
		libdbus-1.so:${PORTSDIR}/devel/dbus \
		libicuuc.so:${PORTSDIR}/devel/icu
RUN_DEPENDS=	xdg-open:${PORTSDIR}/devel/xdg-utils

MAN1=		createPYMB.1 fcitx-remote.1 fcitx.1 mb2org.1 mb2txt.1 \
		readPYBase.1 readPYMB.1 scel2org.1 txt2mb.1
SUB_FILES=	pkg-message
SUB_LIST+=	PORTSDIR=${PORTSDIR}

CONFLICTS=	zh-scim-fcitx-3.*

USE_XZ=		yes
USE_GNOME=	pango intltool libxml2 introspection
USE_XORG=	x11 xext xkbfile
USE_LDCONFIG=	yes
USES=		cmake gettext iconv pathfix pkgconfig
INSTALLS_ICONS=	yes
LDFLAGS+=	-L${LOCALBASE}/lib ${ICONV_LIB}

OPTIONS_DEFINE=	GTK2 GTK3 QT4 OPENCC TPUNC
OPTIONS_DEFAULT=GTK2

GTK2_DESC=	Enable Gtk2 IM module
GTK3_DESC=	Enable Gtk3 IM module
QT4_DESC=	Enable Qt4 IM module
OPENCC_DESC=	Enable OpenCC for Chinese Transform
TPUNC_DESC=	Use traditional quotation marks

NO_STAGE=	yes
.include <bsd.port.options.mk>

CMAKE_ARGS+=	-DENABLE_XDGAUTOSTART=OFF -DFORCE_ENCHANT=ON

.if ${PORT_OPTIONS:MGTK2}
USE_GNOME+=	gtk20
PLIST_SUB+=	GTK2=""
SUB_LIST+=	GTK2_IM=fcitx
.else
CMAKE_ARGS+=	-DENABLE_GTK2_IM_MODULE=OFF
PLIST_SUB+=	GTK2="@comment "
SUB_LIST+=	GTK2_IM=xim
.endif

.if ${PORT_OPTIONS:MGTK3}
USE_GNOME+=	gtk30
CMAKE_ARGS+=	-DENABLE_GTK3_IM_MODULE=ON
PLIST_SUB+=	GTK3=""
SUB_LIST+=	GTK3_IM=fcitx
.else
PLIST_SUB+=	GTK3="@comment "
SUB_LIST+=	GTK3_IM=xim
.endif

.if ${PORT_OPTIONS:MQT4}
USE_QT4=	qmake_build moc_build rcc_build uic_build dbus gui inputmethods
CMAKE_ARGS+=	-DENABLE_QT_IM_MODULE=ON
PLIST_SUB+=	QT4=""
.else
PLIST_SUB+=	QT4="@comment "
.endif

.if ${PORT_OPTIONS:MOPENCC}
LIB_DEPENDS+=	libopencc.so:${PORTSDIR}/chinese/opencc
.else
CMAKE_ARGS+=	-DENABLE_OPENCC=OFF
.endif

.if ${PORT_OPTIONS:MTPUNC}
EXTRA_PATCHES+=	${FILESDIR}/tpunc-data_punc.mb.zh_CN
.endif

.if defined(WITH_DEBUG)
CMAKE_ARGS+=	-DENABLE_DEBUG=ON
.endif

.if defined(NOPORTDOCS)
EXTRA_PATCHES+=	${FILESDIR}/nodocs-doc_CMakeLists.txt
.endif

.if defined(NOPORTDATA)
IGNORE=		code tables are required, undefine NOPORTDATA
.endif

_DICT_VER=	20120815

post-patch:
	@${CP} ${_DISTDIR}/pinyin.tar.gz ${WRKSRC}/data
	@${CP} ${_DISTDIR}/table.tar.gz ${WRKSRC}/data/table
	@${CP} ${_DISTDIR}/en_dict-${_DICT_VER}.tar.gz ${WRKSRC}/data
.if ${OSVERSION} < 800067
# getline() is GNU extension which FreeBSD only recently adopted
EXTRA_PATCHES+=	${FILESDIR}/getline-src_lib_fcitx-utils_utils.c \
		${FILESDIR}/getline-src_lib_fcitx-utils_utils.h
.endif

post-install:
.if ${PORT_OPTIONS:MGTK2}
	-${LOCALBASE}/bin/gtk-query-immodules-2.0 > ${LOCALBASE}/etc/gtk-2.0/gtk.immodules
.endif
.if ${PORT_OPTIONS:MGTK3}
	-${LOCALBASE}/bin/gtk-query-immodules-3.0 > ${LOCALBASE}/lib/gtk-3.0/${GTK3_VERSION}/immodules.cache
.endif
	@${ECHO_CMD}
	@${CAT} ${PKGMESSAGE}
	@${ECHO_CMD}

.include <bsd.port.mk>
