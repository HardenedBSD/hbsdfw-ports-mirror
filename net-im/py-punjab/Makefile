# Created by: jodocus <jodocus@jodocus.org>
# $FreeBSD$

PORTNAME=	punjab
PORTVERSION=	0.14
PORTREVISION=	1
CATEGORIES=	net-im python
MASTER_SITES=	http://code.stanziq.com/punjab/releases/
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	HTTP XMPP client interface

USE_PYTHON=	2.5+
USE_PYDISTUTILS=yes
USES=		twisted:words,web,conch,names

PORTDOCS=	README.txt INSTALL.txt PKG-INFO

USE_RC_SUBR=	punjab

SUB_FILES=	pkg-message punjab.tac
SUB_LIST+=	"PYTHON_CMD=${PYTHON_CMD}"

NO_STAGE=	yes
.include <bsd.port.pre.mk>

post-install:
	@${INSTALL} -d ${WWWDIR}
	@cd ${WRKSRC}/html && ${COPYTREE_SHARE} . ${WWWDIR}
	@${INSTALL} ${WRKDIR}/punjab.tac ${PREFIX}/libexec/
	@${CAT} ${PKGMESSAGE}

.if !defined(NOPORTDOCS)
	@${INSTALL} -d ${DOCSDIR}
	@cd ${WRKSRC} && ${INSTALL_DATA} ${PORTDOCS} ${DOCSDIR}
.endif

.include <bsd.port.post.mk>
