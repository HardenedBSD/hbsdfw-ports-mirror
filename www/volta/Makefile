# Created by: mahlon
# $FreeBSD$

PORTNAME=	volta
PORTVERSION=	0.2.0
PORTREVISION=	1
CATEGORIES=	www
MASTER_SITES=	http://dl.dropbox.com/u/7234177/Releases/ \
		http://projects.martini.nu/volta/chrome/site/
EXTRACT_SUFX=	.tgz

MAINTAINER=	mahlon@martini.nu
COMMENT=	A high performance, low resource URI rewriter for Squid

LICENSE=	BSD
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libcdb.so:${PORTSDIR}/databases/tinycdb

USES=		pkgconfig
USE_GMAKE=	yes
USE_LUA=	5.1
ALL_TARGET=	${PORTNAME}
NO_INSTALL=	yes

CFLAGS+=	-I${PREFIX}/include
LDFLAGS+=	-L${PREFIX}/lib

PLIST_FILES=	bin/volta
PORTDOCS=	README INSTALL LICENSE ChangeLog
SUB_FILES=	pkg-message

NO_STAGE=	yes
post-install:
.if !defined(NOPORTDOCS)
	${MKDIR} ${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/README ${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/INSTALL ${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/LICENSE ${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/ChangeLog ${DOCSDIR}
.endif
	${INSTALL_PROGRAM} ${WRKSRC}/volta ${PREFIX}/bin
	@${ECHO_CMD} ""
	@${CAT} ${PKGMESSAGE}
	@${ECHO_CMD} ""

.include <bsd.port.mk>
