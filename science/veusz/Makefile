# Created by: Stas Timokhin <devel@stasyan.com>
# $FreeBSD$

PORTNAME=	veusz
PORTVERSION=	1.17.1
PORTREVISION=	1
CATEGORIES=	science kde
MASTER_SITES=	http://download.gna.org/veusz/

MAINTAINER=	devel@stasyan.com
COMMENT=	Scientific plotting package

LICENSE=	GPLv2

RUN_DEPENDS=	${PYNUMPY} \
		${PYTHON_PKGNAMEPREFIX}qt4-gui>=0:${PORTSDIR}/x11-toolkits/py-qt4-gui \
		${PYTHON_PKGNAMEPREFIX}qt4-svg>0:${PORTSDIR}/graphics/py-qt4-svg
BUILD_DEPENDS=	${RUN_DEPENDS}

USE_PYTHON=	yes
USE_PYDISTUTILS=	yes
INSTALLS_EGGINFO=	yes

NO_STAGE=	yes

post-patch:
	@${REINPLACE_CMD} \
		-e 's,distutils\.command\.install ,setuptools\.command\.install ,' \
		${WRKSRC}/setup.py

.include <bsd.port.mk>
