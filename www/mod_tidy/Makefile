# Created by: Clement Laforet <sheepkiller@cultdeadsheep.org>
# $FreeBSD$

PORTNAME=	mod_tidy
PORTVERSION=	0.5.5
PORTREVISION=	1
CATEGORIES=	www
MASTER_SITES=	http://mod-tidy.sourceforge.net/src/
DIST_SUBDIR=	apache2

MAINTAINER=	apache@FreeBSD.org
COMMENT=	Validates the HTML output of your apache2 webserver

LICENSE=	AL2 MIT
LICENSE_COMB=	multi

LIB_DEPENDS=	libtidy.so:${PORTSDIR}/www/tidy-lib

WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}/src
USE_APACHE=	22+
AP_FAST_BUILD=	yes
AP_GENPLIST=	yes
AP_INC+=	${LOCALBASE}/include/tidy
AP_LIB+=	${LOCALBASE}/lib -ltidy

.include <bsd.port.mk>
