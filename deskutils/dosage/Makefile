# Created by: Antoine Brodin <antoine@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dosage
PORTVERSION=	2.8
CATEGORIES=	deskutils python
MASTER_SITES=	http://wummel.github.io/dosage/dist/

MAINTAINER=	antoine@FreeBSD.org
COMMENT=	Application to keep a local mirror of web comics

LICENSE=	MIT

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}requests>0:${PORTSDIR}/www/py-requests

USE_PYTHON=	yes
USE_PYDISTUTILS=yes
PYDISTUTILS_AUTOPLIST=yes

post-patch:
	@${REINPLACE_CMD} 's|share/man/man1|man/man1|' ${WRKSRC}/setup.py

.include <bsd.port.mk>
