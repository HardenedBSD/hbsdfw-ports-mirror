# Created by: Greg Larkin <glarkin@FreeBSD.org>
# $FreeBSD$

PORTNAME=	customfieldadmin
PORTVERSION=	0.2.2.6485
PORTREVISION=	2
PORTEPOCH=	1
CATEGORIES=	www devel python
MASTER_SITES=	http://www.sourcehosting.net/freebsd/distfiles/ \
		LOCAL/glarkin
PKGNAMEPREFIX=	trac-
DISTNAME=	${PORTNAME}plugin-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Web interface to administer Trac ticket custom fields

RUN_DEPENDS+=	tracd:${PORTSDIR}/www/trac

USE_ZIP=	yes

WRKSRC=		${WRKDIR}/${PORTNAME}plugin/0.11
USE_PYTHON=	2.5+
USE_PYDISTUTILS=	easy_install
PYDISTUTILS_PKGNAME=    TracCustomFieldAdmin
PYDISTUTILS_PKGVERSION= ${PORTVERSION:R}
PLIST_SUB+=	EGGVERSION=${PORTVERSION:R} PYTHONVERSION=${PYTHON_VER}
PYDISTUTILS_NOEGGINFO=	yes

NO_STAGE=	yes
post-install:
	@${CAT} ${PKGMESSAGE}

.include <bsd.port.mk>
