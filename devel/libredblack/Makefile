# Created by: smace@FreeBSD.org
# $FreeBSD$

PORTNAME=	libredblack
PORTVERSION=	1.3
PORTREVISION=	1
CATEGORIES=	devel
MASTER_SITES=	SF

MAINTAINER=	rodrigo@bebik.net
COMMENT=	Library that provides the red-black balanced tree algorithm

LICENSE=	GPLv2

USE_AUTOTOOLS=	libtool
GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes

.if defined(WITHOUT_PYTHON)
CONFIGURE_ARGS+=	--without-rbgen
PLIST_SUB+=	PYTHON="@comment "
.else
USE_PYTHON=	yes
CONFIGURE_ARGS+=	--with-python=${PYTHON_CMD}
PLIST_SUB+=	PYTHON=""
.endif

post-patch:
	@${REINPLACE_CMD} -e \
		's|^CFLAGS =.*$$|CFLAGS = @CFLAGS@|g' ${WRKSRC}/Makefile.in
	@${REINPLACE_CMD} -e \
		's|implemented.*Various||g' ${WRKSRC}/rbgen.in

post-install:
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libredblack.so

.include <bsd.port.mk>
