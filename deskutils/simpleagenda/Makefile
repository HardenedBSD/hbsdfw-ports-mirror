# $FreeBSD$

PORTNAME=	simpleagenda
PORTVERSION=	0.43
PORTREVISION=	0
CATEGORIES=	deskutils gnustep
MASTER_SITES=	http://coyote.octets.fr/pub/gnustep/
DISTNAME=	SimpleAgenda-${PORTVERSION}

MAINTAINER=	theraven@FreeBSD.org
COMMENT=	simple calendar and agenda application

LIB_DEPENDS+=	libical.so:${PORTSDIR}/devel/libical

LICENSE=	GPLv2

USE_GNUSTEP=	yes
USE_GNUSTEP_CONFIGURE=	yes
USE_GNUSTEP_BACK=	yes
USE_GNUSTEP_BUILD=	yes
USE_GNUSTEP_INSTALL=	yes

CPPFLAGS+=	-I${LOCALBASE}/include
CFLAGS+=	-I${LOCALBASE}/include

NO_STAGE=	yes
pre-configure:
	${REINPLACE_CMD} -e 's|SimpleAgenda|SimpleAgenda.m|' ${WRKSRC}/configure
	${REINPLACE_CMD} -e 's|-luuid||' ${WRKSRC}/GNUmakefile.preamble

.include <bsd.port.mk>
