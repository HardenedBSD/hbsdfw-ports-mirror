# Created by: Choe, Cheng-Dae
# $FreeBSD$

PORTNAME=	freeimagepy
PORTVERSION=	2.0.1
CATEGORIES=	graphics python
MASTER_SITES=	SF/${PORTNAME}/FreeImagePy/V${PORTVERSION}
PKGNAMEPREFIX=  ${PYTHON_PKGNAMEPREFIX}
DISTNAME=	FreeImagePy_w_dll-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	A FreeImage library python wrapper

LIB_DEPENDS=	freeimage.3:${PORTSDIR}/graphics/freeimage

WRKSRC=		${WRKDIR}/FreeImagePy-${PORTVERSION}
USE_BZIP2=	yes
USE_PYTHON=	yes
USE_PYDISTUTILS=yes
PYDISTUTILS_PKGNAME=	FreeImagePy
PYDISTUTILS_PKGVERSION=	2.0.0

NO_STAGE=	yes
.include <bsd.port.mk>
