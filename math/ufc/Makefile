# Created by: Jason Bacon <jwbacon@tds.net>
# $FreeBSD$

PORTNAME=	ufc
PORTVERSION=	${MMVERSION}.0
CATEGORIES=	math python
MASTER_SITES=	http://launchpad.net/${PORTNAME}/${MMVERSION}.x/${PORTVERSION}/+download/

MAINTAINER=	jwbacon@tds.net
COMMENT=	Unified framework for finite element assembly

BUILD_DEPENDS=	swig2.0:${PORTSDIR}/devel/swig20
LIB_DEPENDS=	libboost_math_c99.so:${PORTSDIR}/devel/boost-libs

# LICENSE=	public domain

USES=		cmake
USE_PYTHON=	-2.7
PYDISTUTILS_PKGNAME=	ufc

CMAKE_ARGS+=	-DUFC_PKGCONFIG_DIR=${PREFIX}/libdata/pkgconfig

FETCH_ARGS=	-F

MMVERSION=	2.2

NO_STAGE=	yes
post-patch:
	${REINPLACE_CMD} -e 's|lib/pkgconfig|libdata/pkgconfig|g' \
		${WRKSRC}/CMakeLists.txt
	${REINPLACE_CMD} -i '' -e 's|os.path.join(os.path.sep, "usr")|os.path.normpath("${PREFIX}")|' ${WRKSRC}/src/utils/python/ufc_utils/build.py

.include <bsd.port.mk>
