# $FreeBSD$

PORTNAME=	resourcet
PORTVERSION=	0.4.7.1
PORTREVISION=	2
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Deterministic allocation and freeing of scarce resources

LICENSE=	BSD

USE_CABAL=	lifted-base>=0.1 mmorph monad-control>=0.3.1 mtl>=2.0 \
		transformers>=0.2.2 transformers-base>=0.4.1

NO_STAGE=	yes
.include "${.CURDIR}/../../lang/ghc/bsd.cabal.mk"
.include <bsd.port.mk>
