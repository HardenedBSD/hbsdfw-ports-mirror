# Created by: Giuseppe Pilichi aka Jacula Modyun <jacula@gmail.com>
# $FreeBSD$

PORTNAME=	tagsoup
PORTVERSION=	0.12.8
PORTREVISION=	4
CATEGORIES=	textproc haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Parsing and extracting information from HTML/XML documents

LICENSE=	BSD

USE_CABAL=	text

INSTALL_PORTDATA=	cd ${WRKSRC} && \
			  ${INSTALL_DATA} ${WRKSRC}/tagsoup.htm ${DATADIR}

NO_STAGE=	yes
.include "${.CURDIR}/../../lang/ghc/bsd.cabal.mk"
.include <bsd.port.mk>
