# $FreeBSD$

PORTREVISION=	0
CATEGORIES=	devel python
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	avilla@FreeBSD.org
COMMENT=	Python bindings for libplist

LIB_DEPENDS=	plist:${PORTSDIR}/${MASTER_PORT}
BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}setuptools>0:${PORTSDIR}/devel/py-setuptools \
		cython:${PORTSDIR}/lang/cython \
		swig2.0:${PORTSDIR}/devel/swig20

USE_PYTHON=	yes
SLAVE_PORT=	yes
MASTERDIR=	${.CURDIR:H:H}/devel/libplist
# Required to reference installed libplist.
CFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

PLIST=		${.CURDIR}/pkg-plist
FILESDIR=	${.CURDIR}/files

NO_STAGE=	yes
post-patch:
	@${CP} ${FILESDIR}/CMakeLists.txt ${WRKSRC}
	@${REINPLACE_CMD} -e 's,/usr/local,${LOCALBASE},' \
		${WRKSRC}/CMakeLists.txt

.include "${MASTERDIR}/Makefile"
