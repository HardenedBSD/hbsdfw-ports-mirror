# Created by: Giuseppe Pilichi aka Jacula Modyun <jacula@gmail.com>
# $FreeBSD$

PORTNAME=	uuagc
PORTVERSION=	0.9.42.3
PORTREVISION=	2
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Attribute Grammar System of Universiteit Utrecht

LICENSE=	BSD

USE_CABAL=	haskell-src-exts>=1.11.1 mtl>=1.1.1.1 uuagc-cabal>=1.0.2.0 \
		uulib>=0.9.14

EXECUTABLE=	uuagc

NO_STAGE=	yes
.include "${.CURDIR}/../../lang/ghc/bsd.cabal.mk"
.include <bsd.port.mk>
