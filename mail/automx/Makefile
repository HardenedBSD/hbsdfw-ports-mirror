# $FreeBSD$

PORTNAME=	automx
PORTVERSION=	0.9
PORTREVISION=	1
CATEGORIES=	mail
MASTER_SITES=	http://www.automx.org/download/

MAINTAINER=	crees@FreeBSD.org
COMMENT=	Handles mail account profile requests from mail clients

LICENSE=	GPLv3

RUN_DEPENDS=	${LOCALBASE}/${APACHEMODDIR}/mod_wsgi.so:${PORTSDIR}/www/mod_wsgi2 \
		${PYTHON_PKGNAMEPREFIX}lxml>=0:${PORTSDIR}/devel/py-lxml \
		bash:${PORTSDIR}/shells/bash \
		wget:${PORTSDIR}/ftp/wget

USE_APACHE_RUN=	22+
USE_PYTHON=	2.6+
NO_BUILD=	yes
PORTDATA=	*
PORTDOCS=	*

MAN1=		${PORTNAME}-test.1
MAN5=		${PORTNAME}.conf.5 ${PORTNAME}_ldap.5 ${PORTNAME}_sql.5

PKGMESSAGE=	${WRKDIR}/pkg-message

NO_STAGE=	yes
.include <bsd.port.options.mk>

post-patch:
	${REINPLACE_CMD} -e '1s,/bin/bash,${LOCALBASE}/bin/bash,' \
		${WRKSRC}/src/automx-test
# Generate pkg-message from INSTALL file; include lines from Section 5 onwards
	line=$$(${SED} -ne '/^5. Web Server/=' ${WRKSRC}/INSTALL) && \
		${SED} -ne "$$line,\$$p" ${WRKSRC}/INSTALL > ${PKGMESSAGE}

do-install:
	${MKDIR} ${DATADIR}
	(cd ${WRKSRC}/src && ${COPYTREE_SHARE} ${PORTNAME} ${PYTHONPREFIX_SITELIBDIR})
	${INSTALL_DATA} ${WRKSRC}/src/automx_wsgi.py ${DATADIR}
	${INSTALL_SCRIPT} ${WRKSRC}/src/automx-test ${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/src/automx.conf \
		${PREFIX}/etc/automx.conf.sample
.for s in 1 5
.  for m in ${MAN$s}
	${INSTALL_MAN} ${WRKSRC}/doc/man/man$s/$m ${MAN$sPREFIX}/man/man$s
.  endfor
.endfor
.if ${PORT_OPTIONS:MDOCS}
	${MKDIR} ${DOCSDIR}
	(cd ${WRKSRC}/doc && ${COPYTREE_SHARE} "[^m]*" ${DOCSDIR})
.endif

post-install:
	[ -f ${PREFIX}/etc/${PORTNAME}.conf ] || \
	    ${CP} -p ${PREFIX}/etc/${PORTNAME}.conf.sample \
		${PREFIX}/etc/${PORTNAME}.conf
	@${CAT} ${PKGMESSAGE}

.include <bsd.port.mk>
