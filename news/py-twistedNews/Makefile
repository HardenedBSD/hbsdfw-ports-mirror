# Created by: Neal Nelson <neal@nelson.name>
# $FreeBSD$

PORTNAME=	twistedNews
PORTVERSION=	13.2.0
CATEGORIES=	news devel python
MASTER_SITES=	http://twistedmatrix.com/Releases/News/${PORTVERSION:R}/ \
		LOCAL/sunpoet
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	TwistedNews-${PORTVERSION}

MAINTAINER=	python@FreeBSD.org
COMMENT=	NNTP protocol implementation with client and server

LICENSE=	MIT

BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}twistedCore>=${PORTVERSION}:${PORTSDIR}/devel/py-twistedCore
RUN_DEPENDS:=	${BUILD_DEPENDS}

USE_BZIP2=	yes
USE_PYTHON=	-2.7
USE_PYDISTUTILS=yes
PYDISTUTILS_PKGNAME=	${PORTNAME:S/twisted/Twisted_/}

.include <bsd.port.mk>
