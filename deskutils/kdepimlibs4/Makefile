# Created by: arved
# $FreeBSD$

PORTNAME=	kdepimlibs
PORTVERSION=	${KDE4_VERSION}
PORTREVISION=	1
CATEGORIES=	deskutils kde ipv6
MASTER_SITES=	${MASTER_SITE_KDE}
MASTER_SITE_SUBDIR=	${KDE4_BRANCH}/${PORTVERSION}/src
DIST_SUBDIR=	KDE/${PORTVERSION}

MAINTAINER=	kde@FreeBSD.org
COMMENT=	Libraries for KDE-PIM applications

LIB_DEPENDS=	libgpgme.so:${PORTSDIR}/security/gpgme \
		libsasl2.so:${PORTSDIR}/security/cyrus-sasl2 \
		libboost_thread.so:${PORTSDIR}/devel/boost-libs \
		libical.so:${PORTSDIR}/devel/libical \
		libuuid.so:${PORTSDIR}/misc/e2fsprogs-libuuid \
		libprison.so:${PORTSDIR}/graphics/prison \
		libqjson.so:${PORTSDIR}/devel/qjson

BUILD_DEPENDS=	xsltproc:${PORTSDIR}/textproc/libxslt

USE_XZ=		yes
USE_KDE4=	kdelibs akonadi kdeprefix kdehier \
		automoc4 nepomuk-core ontologies sharedmime soprano
USES=		cmake:outsource
USE_OPENLDAP=	yes
USE_QT4=	corelib dbus declarative designer_build gui network sql xml \
		qmake_build moc_build rcc_build uic_build
USE_LDCONFIG=	yes

NO_STAGE=	yes
post-patch:
	${REINPLACE_CMD} -e 's|/usr/local|${LOCALBASE}|g' \
		${PATCH_WRKSRC}/cmake/modules/*.cmake
	${REINPLACE_CMD} -e 's|%%KDE4_PREFIX%%|${KDE4_PREFIX}|g' \
		${PATCH_WRKSRC}/cmake/modules/FindQGpgme.cmake
# Prevent updating MIME during build.
	${REINPLACE_CMD} -e '/^update_xdg_mimetypes/ d' \
		${PATCH_WRKSRC}/CMakeLists.txt

.include <bsd.port.mk>
