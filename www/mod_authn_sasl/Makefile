# Created by: Joerg Pulz <Joerg.Pulz@frm2.tum.de>
# $FreeBSD$

PORTNAME=	mod_authn_sasl
PORTVERSION=	1.2
PORTREVISION=	1
CATEGORIES=	www
MASTER_SITES=	SF
MASTER_SITE_SUBDIR=mod-authn-sasl/mod-authn-sasl/${PORTVERSION}

MAINTAINER=	apache@FreeBSD.org
COMMENT=	Allows user authentication based on libsasl2 mechanisms on apache 2.2

LICENSE=	AL2

LIB_DEPENDS=	libsasl2.so:${PORTSDIR}/security/cyrus-sasl2

OPTIONS_DEFINE=	SASLAUTHD
SASLAUTHD_DESC=	cyrus-sasl2-saslauthd support

SASLAUTHD_RUN_DEPENDS=	saslauthd:${PORTSDIR}/security/cyrus-sasl2-saslauthd
.include <bsd.port.options.mk>

USE_BZIP2=	yes
USE_APACHE=	22
AP_FAST_BUILD=	yes
AP_GENPLIST=	yes
AP_LIB=		${LOCALBASE}/lib -lsasl2

PORTDOCS1=	AUTHORS LICENSE
PORTDOCS=	*

post-install:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${PORTDOCS1:S|^|${WRKSRC}/|} ${STAGEDIR}${DOCSDIR}/
	@(cd ${WRKSRC} && ${COPYTREE_SHARE} doc ${STAGEDIR}${DOCSDIR} \
		"! ( -name *\.in -o -name *\.am )" )

.include <bsd.port.mk>
