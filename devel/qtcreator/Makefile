# Created by: Kris Moore <kris@pcbsd.org>
# $FreeBSD$

PORTNAME=	qtcreator
DISTVERSION=	2.8.0
PORTREVISION=	2
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_QT:S/$/:qtcreator/} \
		${MASTER_SITE_QT}
MASTER_SITE_SUBDIR=	official_releases/qtcreator/${DISTVERSION:R}/${DISTVERSION}/:qtcreator \
			official_releases/qt/${QT4_VERSION:R}/${QT4_VERSION}
DISTNAME=	qt-creator-${DISTVERSION}-src
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}:qtcreator \
		${QT_DISTNAME}.tar.gz
DIST_SUBDIR=	KDE

MAINTAINER=	kde@FreeBSD.org
COMMENT=	C++ and QML IDE for Qt development

LIB_DEPENDS=	Imath:${PORTSDIR}/graphics/ilmbase \
		IlmImf:${PORTSDIR}/graphics/OpenEXR \
		jasper:${PORTSDIR}/graphics/jasper \
		jpeg:${PORTSDIR}/graphics/jpeg

USES=		qmake
USE_QT4=	moc_build rcc_build uic_build \
		linguist_build assistant_run qt3support \
		dbus designer gui help-tools_build network script \
		sql svg xml webkit qdoc3_build
MAKE_JOBS_UNSAFE=	yes
ALL_TARGET=	all docs
INSTALL_TARGET=	install install_docs
MAKE_ENV=	XDG_CONFIG_HOME=/dev/null
USE_LDCONFIG=	${PREFIX}/lib/${PORTNAME}

QMAKE_ARGS=	CONFIG+="configure" QTC_PREFIX=${PREFIX}
QMAKE_SOURCE_PATH=	${WRKSRC}

# Build Qt Quick Designer (requires update on every Qt update).
QT_DISTNAME=	qt-everywhere-opensource-src-${QT4_VERSION}
DO_NOT_EXTRACT=	config.profiles config.tests demos doc examples lib \
		mkspecs tools translations
.for dne in ${DO_NOT_EXTRACT}
EXTRACT_AFTER_ARGS+=	--exclude '${QT_DISTNAME}/${dne}'
.endfor
QMAKE_ARGS+=	QT_PRIVATE_HEADERS="${WRKDIR}/${QT_DISTNAME}/include"

CONFIGURE_WRKSRC=	${WRKDIR}/build
BUILD_WRKSRC=		${CONFIGURE_WRKSRC}
INSTALL_WRKSRC=		${CONFIGURE_WRKSRC}

DESKTOP_ENTRIES=	"Qt Creator" "${COMMENT}" "QtProject-qtcreator" \
			"${PREFIX}/bin/${PORTNAME}" "Development;Qt;" true

post-patch:
	${REINPLACE_CMD} -e 's|lrelease|lrelease-qt4|' \
		${WRKSRC}/share/qtcreator/translations/translations.pro
	${REINPLACE_CMD} -e 's|lupdate|lupdate-qt4|' \
		${WRKSRC}/share/qtcreator/translations/translations.pro
	${REINPLACE_CMD} -e 's|/usr/bin/gnuplot|${LOCALBASE}/gnuplot|' \
		${WRKSRC}/share/qtcreator/dumper/gbridge.py
	${REINPLACE_CMD} -e 's|/usr/bin/ant|${LOCALBASE}/ant|' \
		${WRKSRC}/src/plugins/android/androidsettingswidget.cpp

	${RM} ${WRKSRC}/share/qtcreator/dumper/gbridge.py.bak

pre-configure:
	${MKDIR} ${CONFIGURE_WRKSRC}

.include <bsd.port.mk>
