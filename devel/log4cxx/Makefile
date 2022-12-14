# Created by: Thaddeus Covert <tcovert@grimmy.sahuagin.net>
# $FreeBSD$

PORTNAME=	log4cxx
PORTVERSION=	0.10.0
PORTREVISION=	5
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_APACHE}
MASTER_SITE_SUBDIR=	logging/${PORTNAME}/${PORTVERSION}
DISTNAME=	apache-${PORTNAME}-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	C++ port of the Log4j project

LICENSE=	AL2

LIB_DEPENDS=	apr-1:${PORTSDIR}/devel/apr1

GNU_CONFIGURE=	yes
USE_AUTOTOOLS=	automake:env autoconf:env libtool:env
USES=		pathfix
USE_LDCONFIG=	yes
MAKE_JOBS_UNSAFE=	yes

OPTIONS_DEFINE=	BOOST DOXYGEN

BOOST_BUILD_DEPENDS=	${LOCALBASE}/include/boost/regex.hpp:${PORTSDIR}/devel/boost-libs

DOXYGEN_CONFIGURE_OFF=	--disable-doxygen
DOXYGEN_BUILD_DEPENDS=	${LOCALBASE}/bin/doxygen:${PORTSDIR}/devel/doxygen

.include <bsd.port.options.mk>

post-configure:
	@${REINPLACE_CMD} -e 's|-dpR|-pr|' \
		-e '/^htmldest/ s|$$(pkgdatadir)|${DOCSDIR}|' \
		${WRKSRC}/src/site/doxy/Makefile

post-install:
.if ${PORT_OPTIONS:MDOXYGEN}
	@cd ${STAGEDIR}${PREFIX} && \
	${FIND} ${DOCSDIR:S|${PREFIX}/||} ! -type d >> ${TMPPLIST} && \
	${FIND} ${DOCSDIR:S|${PREFIX}/||} -type d | ${SORT} -r | \
	${SED} 's|^|@dirrm |' >> ${TMPPLIST}
.endif

.include <bsd.port.mk>
