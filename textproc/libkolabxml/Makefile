# $FreeBSD$

PORTNAME=	libkolabxml
PORTVERSION=	0.8.4
PORTREVISION=	1
CATEGORIES=	textproc
MASTER_SITES=	http://mirror.kolabsys.com/pub/releases/

MAINTAINER=	kde@FreeBSD.org
COMMENT=	Kolab XML Format Schema Definitions Library

# The XSD schemas in schemas/ are AL2-licensed, and some files are
# in public domain. The library itself and the installed headers are
# considered LGPL3-licensed, though.
LICENSE=	LGPL3

BUILD_DEPENDS=	xsdcxx:${PORTSDIR}/devel/xsd
LIB_DEPENDS=	libboost_system.so:${PORTSDIR}/devel/boost-libs \
		libcurl.so:${PORTSDIR}/ftp/curl \
		libxerces-c.so.3:${PORTSDIR}/textproc/xerces-c3

# TODO: Conditionally enable the bindings based on OPTIONs.
CMAKE_ARGS=	-DBUILD_TESTS:BOOL=OFF \
		-DCSHARP_BINDINGS:BOOL=OFF \
		-DDIST_ONLY:BOOL=OFF \
		-DJAVA_BINDINGS:BOOL=OFF \
		-DPHP_BINDINGS:BOOL=OFF \
		-DPYTHON_BINDINGS:BOOL=OFF
USES=		cmake:outsource
USE_LDCONFIG=	yes

PLIST_SUB=	SHLIB_VER=${PORTVERSION}

NO_STAGE=	yes
.include <bsd.port.mk>
