# Created by: Antoine Brodin <antoine@FreeBSD.org>
# $FreeBSD$

PORTNAME=	libolecf
DISTVERSION=	alpha-20131108
CATEGORIES=	devel
MASTER_SITES=	https://googledrive.com/host/0B3fBvzttpiiSS0hEb0pjU2h6a2c/ \
		LOCAL/antoine

MAINTAINER=	antoine@FreeBSD.org
COMMENT=	Library and tools to access the OLE 2 Compound File (OLECF) format

LICENSE=	LGPL3

GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-python --with-libintl-prefix=${LOCALBASE} ${ICONV_CONFIGURE_ARG}
USES=		fuse gettext iconv pathfix pkgconfig
USE_PYTHON=	-2.7
USE_LDCONFIG=	yes
WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION:E}

PORTDOCS=	AUTHORS ChangeLog

OPTIONS_DEFINE=	DOCS

.include <bsd.port.options.mk>

post-install:
.if ${PORT_OPTIONS:MDOCS}
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${PORTDOCS:S,^,${WRKSRC}/,} ${STAGEDIR}${DOCSDIR}
.endif

.include <bsd.port.mk>
